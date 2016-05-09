Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3Z4C3NQ2zDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 06:39:21 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: John Youn <John.Youn@synopsys.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "benh@au1.ibm.com" <benh@au1.ibm.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 Christian Lamparter <chunkeey@googlemail.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "a.seppala@gmail.com" <a.seppala@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
Date: Mon, 09 May 2016 22:38:57 +0200
Message-ID: <18362907.sI27LBpJPE@wuerfel>
In-Reply-To: <5730F198.2080105@synopsys.com>
References: <4231696.iL6nGs74X8@debian64> <4162108.qmr2GZCaDN@wuerfel>
 <5730F198.2080105@synopsys.com>
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

On Monday 09 May 2016 13:22:48 John Youn wrote:
> On 5/9/2016 3:36 AM, Arnd Bergmann wrote:
> > On Monday 09 May 2016 10:23:22 Benjamin Herrenschmidt wrote:
> >> On Sun, 2016-05-08 at 13:44 +0200, Christian Lamparter wrote:
> >>> On Sunday, May 08, 2016 08:40:55 PM Benjamin Herrenschmidt wrote:
> >>>>
> >>>> On Sun, 2016-05-08 at 00:54 +0200, Christian Lamparter via Linuxppc-dev 
> >>>> wrote:
> >>>>>
> >>>>> I've been looking in getting the MyBook Live Duo's USB OTG port
> >>>>> to function. The SoC is a APM82181. Which has a PowerPC 464 core
> >>>>> and related to the supported canyonlands architecture in
> >>>>> arch/powerpc/.
> >>>>>
> >>>>> Currently in -next the dwc2 module doesn't load: 
> >>>> Smells like the APM implementation is little endian. You might need to
> >>>> use a flag to indicate what endian to use instead and set it
> >>>> appropriately based on some DT properties.
> >>> I tried. As per common-properties[0], I added little-endian; but it has no
> >>> effect. I looked in dwc2_driver_probe and found no way of specifying the
> >>> endian of the device. It all comes down to the dwc2_readl & dwc2_writel
> >>> accessors. These - sadly - have been hardwired to use __raw_readl and
> >>> __raw_writel. So, it's always "native-endian". While common-properties
> >>> says little-endian should be preferred.
> >>
> >> Right, I meant, you should produce a patch adding a runtime test inside
> >> those functions based on a device-tree property, a bit like we do for
> >> some of the HCDs like OHCI, EHCI etc...
> >>
> >>
> > 
> > The patch that caused the problem had multiple issues:
> > 
> > - it broke big-endian ARM kernels: any machine that was working
> >   correctly with a little-endian kernel is no longer using byteswaps
> >   on big-endian kernels, which clearly breaks them.
> 
> 
> I'm a bit confused about how this is supposed to work. My
> understanding was that the readl() and writel() are defined as little
> endian. So byte-swapping was performed if the architecture is big
> endian. And the raw versions never swapped, always using the "native"
> endianness.
> 
> dwc2 is always treating the result of readl/writel as if it was read
> in native endian. So it needs to read the registers in big-endian on
> big-endian systems.

The hardware has no idea of what endianess the CPU uses at any
given time, it's fixed by the SoC design, so there is no such
thing as "native" endianess for a random IP block.

The readl/writel accessors accomodate for that by swapping the
data on big-endian kernels, because most SoC designers tend to
pick little-endian device registers by default.

> This was the premise on which this patch was made.
> 
> So for big endian systems, isn't what we want is to read in big-endian
> without any byteswapping to little-endian? But your saying this breaks
> big-endian ARM systems as well. Am I missing something?

The systems are not a particular endianess, only the current state
of the CPU is, and that may change independent of the way the
hardware block got synthesized. We don't support swapping endianess
at runtime in Linux, but the system normally doesn't care what we
run.

The normal behavior is for the register contents to be read as
little-endian, and then swapped on big-endian kernel builds to
match what the kernel expects.

MIPS is a special case here, because the endianess of the CPU
core is fixed in hardware (or using a strapping pin) and is often
tied to the endianess of all the IP blocks. There are a couple
of other architectures like this (e.g. ARM ixp4xx, but none of the
modern ARM systems).

	Arnd
