Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5356A1A0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 14:30:26 +1100 (AEDT)
Message-ID: <1423539025.19657.9.camel@ellerman.id.au>
Subject: Re: [PATCH 1/1] powerpc: fix missing L2 cache size in
 /sys/devices/system/cpu
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 10 Feb 2015 14:30:25 +1100
In-Reply-To: <1423527151.4924.64.camel@kernel.crashing.org>
References: <20150209221421.GA22286@cumulusnetworks.com>
 <1423524827.19657.1.camel@ellerman.id.au>
 <20150209234351.GC22286@cumulusnetworks.com>
 <1423527151.4924.64.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Dave Olson <olson@cumulusnetworks.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-02-10 at 11:12 +1100, Benjamin Herrenschmidt wrote:
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
> 
> It may be universal for embedded machines using DTS in the kernel tree
> but it's definitely not true of any Mac or server machine (from which
> there is no DTS in the kernel as we get the DT from the firmware).

Right.

$ grep machine /proc/cpuinfo 
machine		: PowerNV 8247-22L

$ lsprop /proc/device-tree/cpus/l2-cache@20000020
name             "l2-cache"
status           "okay"
reg              20000020 (536870944)
phandle          00000005
linux,phandle    00000005
l2-cache         00000006
i-cache-size     00080000 (524288)
i-cache-sets     00000008
device_type      "cache"
d-cache-size     00080000 (524288)
d-cache-sets     00000008
cache-unified   


cheers
