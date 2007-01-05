Return-Path: <christophe.alayrac@cresitt.com>
Received: from postfix1-g20.free.fr (postfix1-g20.free.fr [212.27.60.42])
	by ozlabs.org (Postfix) with ESMTP id 7244BDDE10
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Jan 2007 03:15:19 +1100 (EST)
Received: from smtp8-g19.free.fr (smtp8-g19.free.fr [212.27.42.65])
	by postfix1-g20.free.fr (Postfix) with ESMTP id A9E2D74F585
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Jan 2007 17:15:17 +0100 (CET)
Subject: Re: System Ace booting (or not) question
From: alayrac christophe <christophe.alayrac@cresitt.com>
To: Wade Maxfield <wmaxfield@gmail.com>
In-Reply-To: <45a1b53e0701050720w3e8118aan2edb280ec61c7d5f@mail.gmail.com>
References: <45a1b53e0701050720w3e8118aan2edb280ec61c7d5f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 05 Jan 2007 18:14:50 +0100
Message-Id: <1168017290.15530.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc <linuxppc-embedded@ozlabs.org>
Reply-To: christophe.alayrac@cresitt.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

High Wade,

Does systemace comes out with a bus error? (Red led on ML403 board)?

If yes may be its because the memory map of your design did not fit with
ML403 ones and that SystemaAce try to load kernel image in a non ram
place.

you may have to specify the code start address to the genace.tcl script
to generate properly the ace file. (it should be something like
start_address 0xYOURADDR in the opt file)

Have you tried to download the kernel image through JTAG?

You can also try to compile a standalone code in DDR space (not BRAM as
describe in your email) an try to make an ace file with it.

regards 

Chris

Le vendredi 05 janvier 2007 à 09:20 -0600, Wade Maxfield a écrit :
> 
>   I'm very new to System Ace, and this is probably a stupid question.
> 
>   We were able, with the Monta Vista Linux to get a system.ace with a
> zImage.elf linux file to boot on an ml403 board.  The system ace chip
> seemed to copy the zImage.elf into DDR ram, and the system booted.  No
> block ram used.
> 
>    We created a board with an xf60 and a system ace chip on it and
> created a system.ace file.  The xilinx loads, but the zImage.elf does
> not copy into ddr ram.  We ran the testfatfs code and read from and
> wrote to the compact flash on the system ace chip, verifying the files
> through a compact flash adaptor on a pc. 
> 
>    We created a memory test using the ppc and were able (after some
> wiring changes and other headaches) to prove the ddr ram works.  There
> is enough of it to support linux (64 meg), and testing all 64 million
> locations with various fixed and incrementing patterns proves it
> works. 
> 
>    However, we could not get the external ram to load up with the
> linux zImage.elf file. When this failed, we created a system.ace file
> with two elf's in it, one for linux, one for a memory read/write
> tester in block ram. 
> 
>   It appears the system ace chip loads the info into block ram just
> fine, and our memory test executes.  However, our ddr ram has nothing
> in it.  We reversed the order of the elf files, and that still did not
> help. 
> 
>   Do we need a helper CPLD on this board to accomplish what the ML403
> accomplishes?  Or do we need to do a boot loader in code?  If we need
> to do a boot loader, how come the Monta Vista linux doesn't need one
> on the ml403 board?  I've been googling and scouring the Xilinx site,
> but I've achieved nothing but a few less hairs on my head. 
> 
>   I've already asked Monta Vista this question, and they quoted
> verbatim the page from the xilinx manual, which is a generic answer to
> the specific question.  Even if the xilinx manual is the answer, we
> aren't seeing the results the manual implies we will see. 
> 
>   Can someone give me a clue?
> 
> thanks,
> wade
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
