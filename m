Return-Path: <markc@mail.com>
Received: from relay01.roc.ny.frontiernet.net (relay01.roc.ny.frontiernet.net
	[66.133.131.34]) by ozlabs.org (Postfix) with ESMTP id B5DDB2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Nov 2004 00:24:08 +1100 (EST)
Message-ID: <001d01c4d617$0f72f340$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: <alebas@televes.com>, <linuxppc-embedded@ozlabs.org>
References: <1101236780.41a38a2c7f44f@webmail.televes.com:443><2515D492-3D8C-11D9-B8D4-003065F9B7DC@embeddededge.com>
	<1101732712.41ab1b682760f@webmail.televes.com:443>
Date: Mon, 29 Nov 2004 08:26:26 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Kernel 2.6.10-rc1 yet not running on ads8272
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Hi all,
> 
> After commenting out the BCSR lines on m82xx_board_init as Dan
> suggested, some problem still prevents kernel 2.6.10-rc1 from
> running in ads8272 board.
> 
> After running MMU_init, next step in head.S is this
> 
> /*
>  * Go back to running unmapped so we can load up new values
>  * for SDR1 (hash table pointer) and the segment registers
>  * and change to using our exception vectors.
>  */
>         lis     r4,2f@h
>         ori     r4,r4,2f@l
>         tophys(r4,r4)
>         li      r3,MSR_KERNEL & ~(MSR_IR|MSR_DR)
>         FIX_SRR1(r3,r5)
>         mtspr   SRR0,r4
>         mtspr   SRR1,r3
>         SYNC
>         RFI
> /* Load up the kernel context */
> 2:      bl      load_up_mmu
> 
> which is not clear for me. Here, the execution flow breaks
> in RFI and never arrives to "bl load_up_mmu". The value of
> SRR0 and SRR1 before RFI is:
> 

RFI = Return From Interrupt.  In normal usage the current
address is copied into SRR0 when an exception occurs so
the processor will return to that point with an RFI.  So this
code is 'faking out' the RFI instruction to return to 2:

Are you maybe trying to trace through this code?  If so,
and depending on your debugger, you may not be able to.
If your debugger uses trace or some other exception to do
single step, once you get past mtspr SRR0,r4 the single
step exception will overwrite the correct SRR0.  You
can see if this is the case by only tracing to mtspr SRR0,r4
and then putting a breakpoint at 2:

Good luck,
Mark Chambers
