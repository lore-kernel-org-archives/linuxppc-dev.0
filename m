Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5S6n5S7gzDqCc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 08:18:04 +1000 (AEST)
Message-ID: <1463091454.3237.19.camel@kernel.crashing.org>
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Lamparter <chunkeey@googlemail.com>, Arnd Bergmann
 <arnd@arndb.de>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>, linux-mips@linux-mips.org,
 johnyoun@synopsys.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 a.seppala@gmail.com, linuxppc-dev@lists.ozlabs.org
Date: Fri, 13 May 2016 08:17:34 +1000
In-Reply-To: <7745292.ZB3149zIk7@debian64>
References: <4231696.iL6nGs74X8@debian64>
 <1462833472.20290.129.camel@kernel.crashing.org>
 <5347627.S9K7mIusOJ@wuerfel> <7745292.ZB3149zIk7@debian64>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-05-12 at 11:58 +0200, Christian Lamparter wrote:
> 
> > http://www.linuxplumbersconf.org/2012/wp-content/uploads/2012/09/2012-lpc-ref-big-little-endian-herrenschmidt.odp
> > 
> > but there are at least two more twists that you completely missed here:
> > 
> > - Some architectures (e.g. ARMv5 "BE32" mode in IXP4xx, surely some others)
> >   do not implement big-endian mode by wiring up the data lines between the
> >   bus and the CPU differently between big- and little-endian mode like
> >   powerpc and armv7 "BE8" do, but instead they swizzle the *address* lines
> >   on 8-bit and 16-bit addresses. The effect of that is that normal RAM
> >   accesses work as expected both ways, and devices that are accessed using
> >   32-bit MMIO ops never need any byteswap (you actually get "native
> >   endian") while MMIO with 8 and 16 bit width does something completely
> >   unexpected and touches the wrong register. Having an explicit byteswap
> >   on the PCI host bridge gets you the expected addresses again for 8-bit
> >   cycles but it also means that readl()/writel() again need to swap the
> >   data.

Right. Old PowerPC did that too and it's completely stupid. Thankfully
most vendors grew a clue since then and this practice has slowly fallen
into oblivion.

> > - Some other architectures (e.g. Broadcom MIPS) apparently are even fancier
> >   and use a strapping pin on the SoC flips the endianess of the CPU core
> >   at the same time as all the peripheral MMIO registers, with the intention
> >   of never requiring any byte swaps. I believe they are implemented careful
> >   enough to actually get this right, but it confuses the heck out of
> >   Linux drivers that don't expect this.

Right. Drivers like that will need an explicit test in the accessors.

Cheers,
Ben.
