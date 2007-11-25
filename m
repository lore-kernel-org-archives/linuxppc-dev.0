Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8EC7ADDE33
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 07:20:17 +1100 (EST)
Subject: Re: Access to PCI Expansion ROMs on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910711250530r454c01ecoe8867a7f492b8704@mail.gmail.com>
References: <20071125015707.GO3174@curie-int.orbis-terrarum.net>
	<9e4733910711241813r3412d459l95fb3b84cbee1d8a@mail.gmail.com>
	<20071125111535.GB14557@curie-int.orbis-terrarum.net>
	<20071125114919.GC14557@curie-int.orbis-terrarum.net>
	<9e4733910711250530r454c01ecoe8867a7f492b8704@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 26 Nov 2007 07:20:00 +1100
Message-Id: <1196022000.7195.70.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-11-25 at 08:30 -0500, Jon Smirl wrote:
> 
> > The two cards with x86 firmware return 0xFF for those two readb()
> > instructions, while the X1900 with OF returns 0x00 for the readb().
> >
> > Could one of the more knowledgeable folk for PPC intricacies suggest
> why
> > those readb calls are returning the wrong data?
> 
> I don't know PPC at this low of level but it may be a problem with non
> word-aligned access to memory. I thought readb() was supposed to work
> on all archs and alignment issues are handled inside readb(). Also,
> the readw() may have an endian bug.

Ugh ? Read be reads -bytes- ! Can you tell me how the hell can a byte
access be non-aligned ?


> BenH, has source code for an x86 emulator that will run on PPC. That
> will let you run the ROMs. The original plan was for the kernel to
> generate a uevent that would have triggered the x86 emulator to run.
> 
> Progress along that path was blocked by the X developers. The X server
> contains code for enabling the PCI ROM and reading it from user space.
> I wanted to move this code out of X and into the kernel.
> 
> Because the path was blocked things like the PCI ROM API were never
> throughly tested. It works most of the time but the occasional problem
> is still turning up. Once we identify the PPC problem we can fix it in
> the kernel.

Nobody blocked anything, you are free to develop an emulator triggered
by a uevent, nobody prevented you from doing so.

Now, regarding that user problem, this it totally unrelated as it's a
"mac" card.

It's possible that it's one of these radeons that disable ROM access via
a register in which case a quirk is needed to re-enable it.

Ben.
