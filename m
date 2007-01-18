Return-Path: <Tom.Ziomek@motorola.com>
Received: from mail125.messagelabs.com (mail125.messagelabs.com
	[85.158.136.35]) by ozlabs.org (Postfix) with SMTP id 61995DDEE2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Jan 2007 09:25:26 +1100 (EST)
Received: from il06exr01.mot.com (il06exr01.mot.com [129.188.137.131])
	by motgate8.mot.com (8.12.11/Motorola) with ESMTP id l0IMPMca008396
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Jan 2007 15:25:22 -0700 (MST)
Received: from de01exm60.ds.mot.com (de01exm60.am.mot.com [10.176.8.105])
	by il06exr01.mot.com (8.13.5/8.13.0) with ESMTP id l0IMPLqP015955
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Jan 2007 16:25:21 -0600 (CST)
Date: Thu, 18 Jan 2007 16:25:21 -0600 (Central Standard Time)
From: T Ziomek <ctz001@email.mot.com>
To: Wade Maxfield <wmaxfield@gmail.com>
Subject: Re: General fx60 notes, Question regarding forcing EDK to locate
	program code at an address
In-Reply-To: <45a1b53e0701181416p20e597aarb5a32efbdfcf0a6f@mail.gmail.com>
Message-ID: <Pine.WNT.4.61.0701181621290.2536@holyoke.labs.mot.com>
References: <45a1b53e0701181416p20e597aarb5a32efbdfcf0a6f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: ppc <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 18 Jan 2007, Wade Maxfield wrote:
  . . .
> The memtest.elf file is stuck in the ppc405_0 directory because that is
> where it started, and the gui won't let us change it without rebuilding the
> project.
> We are loading two .elf files so that we have the program counter set to
> the internal (Block Ram) memory test/boot loader after the .elf files are
> finished loading.  This lets us look at our ddr ram memory and prove the
> linux load made it there.  The first .elf file loads, then the second one,
> then the pc is set to the start address of the second .elf file.  Since the
> second .elf file loads into block ram, it is doing nothing, as that is
> determined by the bitstream in the fpga fabric.  There may be easier ways to
> do this.

I'm not sure how the above relates to your question...

> MY QUESTION:
>
> What I would like to do is create a .elf file with the Xilinx EDK and
> force it to be located at a particular address (0x400000 for example).
> I've looked and looked, but obviously I've not looked at the right
> places.
> Does anyone know how to do this with the Xilinx EDK?

You should be able to just use a custom linker script (a.k.a. linker com-
mand file) rather than the default.  You can base this custom file on the
default version and just specify the address you want.

The linker script syntax is not all that obvious, but the GNU 'ld' docu-
mentation it pretty well.

N.B.  My personal preference is to not use the EDK; I find it just makes
       it difficult to understand what is actually happening.  But then I
       like the command line...

Tom
-- 
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |
