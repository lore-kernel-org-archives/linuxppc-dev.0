Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93EC01A020A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 11:12:46 +1100 (AEDT)
Message-ID: <1423527151.4924.64.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/1] powerpc: fix missing L2 cache size in
 /sys/devices/system/cpu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Olson <olson@cumulusnetworks.com>
Date: Tue, 10 Feb 2015 11:12:31 +1100
In-Reply-To: <20150209234351.GC22286@cumulusnetworks.com>
References: <20150209221421.GA22286@cumulusnetworks.com>
 <1423524827.19657.1.camel@ellerman.id.au>
 <20150209234351.GC22286@cumulusnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-02-09 at 15:43 -0800, Dave Olson wrote:
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > On Mon, 2015-02-09 at 14:14 -0800, Dave Olson wrote:
> > > From: Dave Olson <olson@cumulusnetworks.com>
> > > 
> > > Fix missing L2 cache size in /sys/devices/system/cpu/cpu0/cache/index2/size
> > > This bug appears to be introduced in 2.6.29 by 93197a36a9c16a85fb24cf5a8639f7bf9af838a3.
> > > The missing entry caused lscpu to error out on e500v2 devices, and probably others
> > >  error: cannot open /sys/devices/system/cpu/cpu0/cache/index2/size: No such file or directory
> > > The DTS files we see use cache-size for the unified L2 cache size, not d-cache-size
> > 
> > Can you convince me that this is not going to break other machines that have
> > "d-cache-size" but not "cache-size"?
> 
> I'm unable to find any dts file that uses d-cache-size for the L2
> unified cache.  All in the powerpc tree in arch/powerpc/boot/dts/*
> are using cache-size in the L2 description for the cache size.
> 
> As best as I can tell from looking around, this is universal.

It may be universal for embedded machines using DTS in the kernel tree
but it's definitely not true of any Mac or server machine (from which
there is no DTS in the kernel as we get the DT from the firmware).

Ben.
