MIME-Version: 1.0
Subject: RE: MMU Problem bringing up kernel with PPC 603 chip
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 27 Feb 2004 10:19:59 -0700
Message-ID: <8039970AF146314597457D3B51A68B388F36A0@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You are turning off the MMU when you execute the RFI.  This is a very delicate operation: any screw up here causes the machine to crash mysteriously.  Oh, wait, you know that already ;-).

Questions: Why is your MMU on when you call this routine?  Who turned it on?  Why?  What is the MMU mapping to/from?

Several suspect areas:
* You have cache enabled and are using the MMU to mark areas as cache-inhibited (necessary for all I/O type stuff).  When you disable the MMU, _everything_ becames cached by fiat, causing all I/O to become cached.  At this point, the CPU state is indistingishable from crashed because it is being held hostage by the cache (nothing comes in, nothing goes out).  Solution: disable the cache before disabling the MMU.

* Your MMU is not mapping memory 1:1 so turning it off makes your memory disappear out from under your CPU.  Crash.  Solution: you need to return (RFI) to an area of memory that will exist when the MMU is disabled.

gvb


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf
> Of Bob Beck
> Sent: Thursday, February 26, 2004 4:23 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: MMU Problem bringing up kernel with PPC 603 chip
>
>
>
> All,
>
> I'm bringing up my 1st kernel on a proprietary board
> using a PPC 603E chip.
>
>
> The kernel is configured using the 6xx/7xx ppc selection.
>
> The kernel starts executing at __start in head.S and
> branches to early_init(). I have stubbed out the call
> to prom_init() since this is an embedded system and
> not a power mac (as the comments at the top of the
> prom.c file indicate).
>
> The code returns to head.S and branches to mmu_off.
> Here is the code for mmu_off.
>
> mmu_off:
> 	addi	r4, r3, __after_mmu_off - _start
> 	mfmsr	r3
> 	andi.	r0,r3,MSR_DR|MSR_IR		/* MMU enabled? */
> 	beqlr
> 	andc	r3,r3,r0
> 	mtspr	SRR0,r4
> 	mtspr	SRR1,r3
> 	sync
> 	RFI
>
> This executes all the way to the "RFI" instruction,
> but never comes back to the place in the code that
> called mmu_off.
>
> Why is the "return from interrupt" going out into
> space ? Any suggestions ?
>
>
> Best Regards,
>
> Bob Beck
> beck@assurtech.com
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
