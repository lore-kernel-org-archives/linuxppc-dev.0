Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B201E67A3D
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Mar 2006 13:09:40 +1100 (EST)
To: David Hawkins <dwh@ovro.caltech.edu>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Linux on PPC 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 03 Mar 2006 12:06:43 PST."
	<4408A1D3.8010506@ovro.caltech.edu>
Date: Sat, 04 Mar 2006 03:09:38 +0100
Sender: wd@denx.de
Message-Id: <20060304020938.00774352627@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <4408A1D3.8010506@ovro.caltech.edu> you wrote:
> 
> > Still not right. Even the physical memory is software settable. What
> > matters is what chip-select things are hooked up to, and then map those
> > chip selects correctly (size, base address, access with and so on)
> 
> Thats what I meant with 'redefined in hardware'. But yes, redefined
> up to the limit of the wiring on the board of course (chip-selects
> and bus widths). That's where having the board schematic is
> invaluable.

You don't get it. You can map - for example - your flash to  physical
address  0x0000 or 0x04000000 or 0x40000000 or 0xFFF00000 as you like
- without any changes to the hardware, and  without  using  the  MMU.
Mind: that's all *physical* addresses.

> manual for the 440EP Yosemite board), and then setup U-Boot and
> Linux to program the TLBs to translate to those same addresses.

No. U-Boot does not use the MMU.

> when I booted Linux, I took a look and found that on the whole, Linux
> didn't touch too much of the things setup by U-Boot, i.e., the
> responsibility for setting up the Linux environment was mainly
> the job of the bootloader.

Wrong  again.  Linux  completely  re-initializes  the  whole   memory
management.

> So, if I had a board with a custom bootloader, I would be
> concerned that the bootloader might not know enough about
> Linux, to setup the hardware correctly.
> 
> Does that sound right?

No, it's wrong.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Language shapes the way we think, and determines what we  can  think
about."                                                 - B. L. Whorf
