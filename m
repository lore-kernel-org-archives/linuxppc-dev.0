Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CA5FB2C02B1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 May 2013 03:14:15 +1000 (EST)
Date: Fri, 24 May 2013 18:13:00 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 2/2] net: mv643xx_eth: proper initialization for
 Kirkwood SoCs
Message-ID: <20130524171300.GD18614@n2100.arm.linux.org.uk>
References: <1369253042-15082-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130522201607.GA18823@obsidianresearch.com>
 <20130523160111.GP31290@titan.lakedaemon.net>
 <20130523171112.GB31281@obsidianresearch.com>
 <20130523172339.GQ31290@titan.lakedaemon.net>
 <20130523175357.GB2821@obsidianresearch.com>
 <20130523184028.GU31290@titan.lakedaemon.net> <519E9ADA.3040204@gmail.com>
 <CACRpkdbsicPkPAiaQCOg2mQF2Ce2dg_K=BKqqx=FCdAH7Y+QBg@mail.gmail.com>
 <20130524170125.GX31290@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130524170125.GX31290@titan.lakedaemon.net>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Miller <davem@davemloft.net>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 Lennert Buytenhek <buytenh@wantstofly.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 24, 2013 at 01:01:25PM -0400, Jason Cooper wrote:
> On Fri, May 24, 2013 at 01:03:25PM +0200, Linus Walleij wrote:
> > IMO: if you want to go down that road, what you really want is not
> > ever more expressible device trees, but real open firmware,
> > or ACPI or UEFI that can interpret and run bytecode as some
> > "bios" for you. With DT coming from OF maybe this is a natural
> > progression of things, but one has to realize when we reach the
> > point where what we really want is a bios. Then your time is
> > likely better spent with Tianocore or something than with the
> > kernel.
> 
> shudder.  I like embedded systems because the *don't* have a bios.

Then you're into scenarios like I have with my laptop, where - those
of you who check the nightly build results will have noticed - one
of my serial ports doesn't always exist.  That's because the ACPI data
in the BIOS is *wrong*.  It reports that it has been enabled when it
hasn't, and the disassembled byte code is at fault here.

The fix?  God knows.  As far as I'm concerned as a user, or even as an
OS developer, it's unfixable without getting the ACPI data structures
changed, and that's not something I can do.

Do you really want that on ARM?  Given the fiasco with the location of
the registers, are you sure you want to place more trust in that
direction?  Does it give you a warm fuzzy feeling to know that you
might have to work out some way to patch vendor supplied bytecode?
