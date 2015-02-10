Return-Path: <olson@cumulusnetworks.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A8811A01B2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 19:00:12 +1100 (AEDT)
Received: by mail-pa0-f48.google.com with SMTP id eu11so17709437pac.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 00:00:10 -0800 (PST)
Date: Tue, 10 Feb 2015 00:00:02 -0800
From: Dave Olson <olson@cumulusnetworks.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/1] powerpc: fix missing L2 cache size in
 /sys/devices/system/cpu
Message-ID: <20150210080002.GA23291@cumulusnetworks.com>
References: <20150209221421.GA22286@cumulusnetworks.com>
 <1423524827.19657.1.camel@ellerman.id.au>
 <20150209234351.GC22286@cumulusnetworks.com>
 <1423527151.4924.64.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423527151.4924.64.camel@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Mon, 2015-02-09 at 15:43 -0800, Dave Olson wrote:
> > Michael Ellerman <mpe@ellerman.id.au> wrote:
> > 
> > > On Mon, 2015-02-09 at 14:14 -0800, Dave Olson wrote:
> > > > From: Dave Olson <olson@cumulusnetworks.com>
> > > > 
> > > > Fix missing L2 cache size in /sys/devices/system/cpu/cpu0/cache/index2/size
> > > > This bug appears to be introduced in 2.6.29 by 93197a36a9c16a85fb24cf5a8639f7bf9af838a3.
> > > > The missing entry caused lscpu to error out on e500v2 devices, and probably others
> > > >  error: cannot open /sys/devices/system/cpu/cpu0/cache/index2/size: No such file or directory
> > > > The DTS files we see use cache-size for the unified L2 cache size, not d-cache-size
> > > 
> > > Can you convince me that this is not going to break other machines that have
> > > "d-cache-size" but not "cache-size"?
> > 
> > I'm unable to find any dts file that uses d-cache-size for the L2
> > unified cache.  All in the powerpc tree in arch/powerpc/boot/dts/*
> > are using cache-size in the L2 description for the cache size.
> > 
> > As best as I can tell from looking around, this is universal.
> 
> It may be universal for embedded machines using DTS in the kernel tree
> but it's definitely not true of any Mac or server machine (from which
> there is no DTS in the kernel as we get the DT from the firmware).

OK, now that I understand that's the case, I'll have to go back and
re-do the patch to handle both cache-size and d-cache-size for the
L2 cache (using whichever is present).

I don't have any power Macs to use for testing, would one of you be
willing and able to verify the patch on a power Mac?

The patch below fixes my problem, and I don't think it will break
platforms like the PowerPC Mac that use d-cache-size
=====
diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
index a3c684b..0d1f879 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -200,6 +200,10 @@ static int cache_size(const struct cache *cache, unsigned int *ret)
 	propname = cache_type_info[cache->type].size_prop;
 
 	cache_size = of_get_property(cache->ofnode, propname, NULL);
+	if (!cache_size && cache->type == CACHE_TYPE_UNIFIED) {
+        /* most embedded systems with L2 use "cache-size", allow that also */
+        cache_size = of_get_property(cache->ofnode, "cache-size", NULL);
+    }
 	if (!cache_size)
 		return -ENODEV;
 
=====

Thanks,

Dave Olson
olson@cumulusnetworks.com
