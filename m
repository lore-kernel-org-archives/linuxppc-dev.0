Return-Path: <chunkeey@googlemail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r57jG6rsTzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 19:58:25 +1000 (AEST)
Received: by mail-wm0-x243.google.com with SMTP id r12so14969797wme.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 02:58:25 -0700 (PDT)
From: Christian Lamparter <chunkeey@googlemail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>, linux-mips@linux-mips.org,
 johnyoun@synopsys.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, a.seppala@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
Date: Thu, 12 May 2016 11:58:18 +0200
Message-ID: <7745292.ZB3149zIk7@debian64>
In-Reply-To: <5347627.S9K7mIusOJ@wuerfel>
References: <4231696.iL6nGs74X8@debian64>
 <1462833472.20290.129.camel@kernel.crashing.org> <5347627.S9K7mIusOJ@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, May 10, 2016 09:23:59 AM Arnd Bergmann wrote:
> On Tuesday 10 May 2016 08:37:52 Benjamin Herrenschmidt wrote:
> > On Mon, 2016-05-09 at 17:08 +0200, Arnd Bergmann wrote:
> > > 
> > > Unfortunately, I don't see any way this could be done in MIPS specific
> > > code: There is typically a byteswap between the internal bus and the PCI
> > > bus on big-endian MIPS systems, so the PCI MMIO ends up being little-endian,
> > 
> > Ugh ... not exactly, re-watch my talk on the matter :-) While there is
> > a specific lane wiring to preserve byte addresss, in the end it's the
> > end device itself that is either BE or LE. Regardless of any "bus
> > endianness".
> 
> I found your slides on
> 
> http://www.linuxplumbersconf.org/2012/wp-content/uploads/2012/09/2012-lpc-ref-big-little-endian-herrenschmidt.odp
> 
> but there are at least two more twists that you completely missed here:
> 
> - Some architectures (e.g. ARMv5 "BE32" mode in IXP4xx, surely some others)
>   do not implement big-endian mode by wiring up the data lines between the
>   bus and the CPU differently between big- and little-endian mode like
>   powerpc and armv7 "BE8" do, but instead they swizzle the *address* lines
>   on 8-bit and 16-bit addresses. The effect of that is that normal RAM
>   accesses work as expected both ways, and devices that are accessed using
>   32-bit MMIO ops never need any byteswap (you actually get "native
>   endian") while MMIO with 8 and 16 bit width does something completely
>   unexpected and touches the wrong register. Having an explicit byteswap
>   on the PCI host bridge gets you the expected addresses again for 8-bit
>   cycles but it also means that readl()/writel() again need to swap the
>   data.
> 
> - Some other architectures (e.g. Broadcom MIPS) apparently are even fancier
>   and use a strapping pin on the SoC flips the endianess of the CPU core
>   at the same time as all the peripheral MMIO registers, with the intention
>   of never requiring any byte swaps. I believe they are implemented careful
>   enough to actually get this right, but it confuses the heck out of
>   Linux drivers that don't expect this.
> 
> > > which matches the expected behavior of readl/writel. However, drivers
> > > for non-PCI devices often use the same readl/writel accessors because
> > > that is how it's done on ARMv6/ARMv7.
> > 
> > Even then, you can have on-SoC (non-PCI) devices that also have a
> > different endianness from the main CPU. How does it work on ARM for
> > example ? The device endianness should be fixed, regardless of the
> > endianness of the core, no ?
> 
> ARMv6/v7 is uses BE8 mode like powerpc: each peripheral is fixed-endian
> and you have to know what it is. Only Freescale managed to put identical
> IP blocks on various (powerpc-derived) SoCs and have a subset of them
> treat the access as little-endian while others remain big-endian, so all
> those drivers now require runtime detection.
> 
> > > Doing it hardcoded by architecture is just the simplest way to deal
> > > with it, working on the assumption that nothing actually needs the
> > > runtime detection that Ben suggested. 
> > 
> > No, it's not an archicture problem. It's a problem specific to that one
> > SoC that the device was synthetized to be a certain endian while it was
> > synthetized differently on another SoC... that also happens to be a
> > different architecture. But doesn't have to.
> > 
> > For example, we had in the past cases of both LE and BE EHCI
> > implementations on the same architecture (PowerPC).
> 
> I understand this, but from what I see in this history of this particular
> driver, all ARM and PowerPC implementations chose to use LE registers for
> DWC2 because the normal approach for these is to not mess with endianess,
> while presumably all MIPS users of the same block wired up the endian-select
> line of the IP block to match that of the CPU core, again because it's
> what you are expected to do on a MIPS based SoC.
> 
> So hardcoding it per architecture would make an assumption based on
> the mindset of the SoC designers rather than strict technical differences,
> and that can fail as soon as someone does things differently on any of
> them (see the Freescale example), but I still think it's the easiest
> workaround for backporting to stable kernels. A revert of the original
> patch would be even easier, but that would break the one big-endian
> MIPS machine we know about.
> 
> > > Detecting the endianess of the
> > > device is probably the best future-proof solution, but it's also
> > > considerably more work to do in the driver, and comes with a
> > > tiny runtime overhead.
> > 
> > The runtime overhead is probably non-measurable compared with the cost
> > of the actual MMIOs.
> 
> Right. The code size increase is probably measurable (but still small),
> the runtime overhead is not.

Ok, so no rebuts or complains have been posted.

I've tested the patch you made in: https://lkml.org/lkml/2016/5/9/354
and it works: 

Tested-by: Christian Lamparter <chunkeey@googlemail.com>

So, how do we go from here? There is are two small issues with the
original patch (#ifdef DWC2_LOG_WRITES got converted to lower case:
#ifdef dwc2_log_writes) and I guess a proper subject would be nice.  

Arnd, can you please respin and post it (cc'd stable as well)?
So this is can be picked up? Or what's your plan?

Regards,
Christian
