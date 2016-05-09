Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3QlV30t7zDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 01:09:24 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@au1.ibm.com, linux-mips@linux-mips.org,
 Christian Lamparter <chunkeey@googlemail.com>, linux-usb@vger.kernel.org,
 johnyoun@synopsys.com, gregkh@linuxfoundation.org, a.seppala@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
Date: Mon, 09 May 2016 17:08:48 +0200
Message-ID: <4908563.V9YuKsSrTJ@wuerfel>
In-Reply-To: <8737prikg9.fsf@intel.com>
References: <4231696.iL6nGs74X8@debian64> <4162108.qmr2GZCaDN@wuerfel>
 <8737prikg9.fsf@intel.com>
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

On Monday 09 May 2016 13:39:50 Felipe Balbi wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Monday 09 May 2016 10:23:22 Benjamin Herrenschmidt wrote:
> >> On Sun, 2016-05-08 at 13:44 +0200, Christian Lamparter wrote:
> >
> > The patch that caused the problem had multiple issues:
> >
> > - it broke big-endian ARM kernels: any machine that was working
> >   correctly with a little-endian kernel is no longer using byteswaps
> >   on big-endian kernels, which clearly breaks them.
> > - On PowerPC the same thing must be true: if it was working before,
> >   using big-endian kernels is now broken. Unlike ARM, 32-bit PowerPC
> >   usually uses big-endian kernels, so they are likely all broken.
> > - The barrier for dwc2_writel is on the wrong side of the __raw_writel(),
> >   so the MMIO no longer synchronizes with DMA operations.
> > - On architectures that require specific CPU instructions for MMIO
> >   access, using the __raw_ variant may turn this into a pointer
> >   dereference that does not have the same effect as the readl/writel.
> >
> > I think we can simply make this set of accessors architecture-dependent
> > (MIPS vs. the rest of the world) to revert ARM and PowerPC back to
> > the working version.
> 
> and patch all drivers similarly? Shouldn't arch/mips itself deal with it
> and hide it from drivers ?
> 

Unfortunately, I don't see any way this could be done in MIPS specific
code: There is typically a byteswap between the internal bus and the PCI
bus on big-endian MIPS systems, so the PCI MMIO ends up being little-endian,
which matches the expected behavior of readl/writel. However, drivers
for non-PCI devices often use the same readl/writel accessors because
that is how it's done on ARMv6/ARMv7.

Doing it hardcoded by architecture is just the simplest way to deal
with it, working on the assumption that nothing actually needs the
runtime detection that Ben suggested. Detecting the endianess of the
device is probably the best future-proof solution, but it's also
considerably more work to do in the driver, and comes with a
tiny runtime overhead.

	Arnd
