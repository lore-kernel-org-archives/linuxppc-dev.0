Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C6B8767B94
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jul 2006 05:20:38 +1000 (EST)
Subject: Re: [Fwd: Re: [Ilugc] help regarding powerpc and vga card]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: sudheer <urwithsudheer@gmail.com>
In-Reply-To: <44B77452.1070106@gmail.com>
References: <44B77452.1070106@gmail.com>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 05:20:32 +1000
Message-Id: <1152904832.23037.99.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Sivasankar Chander <siva.ilugc@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>         >>     All PCI VGA cards for use on x86 PCs have a ROMscan
>         BIOS
>         >> extension on them. This initializes the card after POST -
>         basically,
>         >> the motherboard BIOS transfers control to the BIOS on the
>         >> PCI VGA card, which then initializes itself. If control is
>         not
>         >> transfered to the VGA BIOS on the card, the VGA controller
>         >> stays isolated and will not respond to PCI device
>         enumeration,
>         >> etc. 
>         >
>         I have a doubt here. How does the processor know that the card
>         sitting 
>         here is a vga card
>         and control should be transfered to initialize it.  I think it
>         can know 
>         that it is a vga card only by reading the config space .
>         And bios is necesary for vga card to work in its normal way.
>         Is it 
>         necesary for bios to be initialised to get detected.
>         Please correct me if i am wrong.

You are not wrong (though your mailer sucks). The initial poster seems
to be a bit confused.

All PCI video cards (VGA or not) shall respond to PCI config spaces
normally. They can be enumerated, and if they carry a BIOS image (or any
other firmware support like an Open Firmware F-Code driver), it should
be accessible via the standard PCI expansion ROM BAR.

There is no such thing as "the VGA controller stays isolated" or
whatever sort of crap. However, it is true that the video card needs to
be initialized to be able to actually output anything useful, and
depending on the chip, it's generically a complex procedure involving
setting up all sorts of PLLs, initializing the card's memory controller
and performing the appropriate SDRAM init sequence, initializing the
various external chips like TMDS transmitters on the card etc etc... 

That is normally done by the card's firmware which generally sits in the
card's PCI expansion ROM (not always though, it's getting common
nowadays on x86 laptops for example to have the video card's BIOS mixes
with the main BIOS to save a flash chip). The most common type of
firmware is indeed an x86 video BIOS, which can run on non-x86 platforms
through an emulator like x86emu (a common practice, works fairly well
afaik).

Note that what that BIOS does it to poke the card's registers, which are
accessible via the card's normal PCI BARs :) At least most of the time.
Some cards do indeed require some use of the legacy VGA registers for
initialization, which means issuing IO cycles on the bus to fixed VGA
addresses, but that's pretty much irrelevant.
