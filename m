Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EB52C67A00
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Mar 2006 07:07:16 +1100 (EST)
Message-ID: <4408A1D3.8010506@ovro.caltech.edu>
Date: Fri, 03 Mar 2006 12:06:43 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Linux on PPC
References: <DCEAAC0833DD314AB0B58112AD99B93B8595AC@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B8595AC@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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


>>Right, thats I made sure to say; Physical Memory Map.
>>
>>For example, on the Artesyn manual on their PrPMC they give a
>>physical memory map, and in the Yosemite board, there is a
>>physical memory map. I know many of the memory areas can be
>>redefined in hardware to have a different memory location, but
>>its still a physical address.
>>
> 
> Still not right. Even the physical memory is software settable. What
> matters is what chip-select things are hooked up to, and then map those
> chip selects correctly (size, base address, access with and so on)

Hi Rune,

Thanks for responding.

Thats what I meant with 'redefined in hardware'. But yes, redefined
up to the limit of the wiring on the board of course (chip-selects
and bus widths). That's where having the board schematic is
invaluable.

But ok, I'm pretty sure I get the point, and hopefully the
original poster understands a bit more too.

Given a board that you expect to run Linux on, I would imagine
you would select hardware settings consistent with making
Linux happy, i.e., defining 'in software' (the bootloader)
the physical address map (eg. like the Embedded Planet reference
manual for the 440EP Yosemite board), and then setup U-Boot and
Linux to program the TLBs to translate to those same addresses.

When looking at the Yosemite board, I booted U-Boot and compared
device dcr settings to the recommended ones in the EP manual. Then
when I booted Linux, I took a look and found that on the whole, Linux
didn't touch too much of the things setup by U-Boot, i.e., the
responsibility for setting up the Linux environment was mainly
the job of the bootloader.

So, if I had a board with a custom bootloader, I would be
concerned that the bootloader might not know enough about
Linux, to setup the hardware correctly.

Does that sound right?

Dave
