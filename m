Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Reply-To: <jwalden@digitalatlantic.com>
From: "Jerry Walden" <jwalden@digitalatlantic.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Need Help w/ PPC Boot
Date: Thu, 26 Dec 2002 11:51:20 -0800
Message-ID: <EGEGIJHKDKJGAJMGIDPNEEEICDAA.jwalden@digitalatlantic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <EGEGIJHKDKJGAJMGIDPNAEBOCDAA.jwalden@digitalatlantic.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings:

I apologize in advance if this is a stupid question, or a question
with an obvious answer.  The fact is that I have place linux on
and ARM, and an X86 board, however never on a PPC platform.  In
fact I have very little experience with the PPC, and RISC processors
in general.  I am trying to trace my way through the u-boot code -
since I do not have access to an in circuit emulator, I am somewhat
hindered.  However I do have the capability to turn on a LED via a
GPIO register.  So I am tracing through the code in a "burn an learn"
fashion.

I have a routine called "led" that turns on an led.  The code below is
from start.S from the u-boot distro from the cpu/ppc4xx, my processor is
a ppc 405GPr.

The below code turns the LEN on. Note the branch instruction that branches
to some code to turn the led on.  If I put the branch instruction AFTER
the "mtmsr	r4" instruction the LED does not turn on.  I cannot figure out
what is going on.  If anyone has any recommendations on documentation to
read (I have the 600 page "green book") or if there is something I am
obviously missing (i.e. not being familiar enough with how a risc
processor works) any advice is welcome.

	. = EXC_OFF_SYS_RESET
	.globl	_start
_start:


/* Clear and set up some registers. */
	addi	r4,r0,0x0000
	mtspr	sgr,r4
	mtspr	dcwr,r4
	mtesr	r4			/* clear Exception Syndrome Reg */
	mttcr	r4			/* clear Timer Control Reg */
	mtxer	r4			/* clear Fixed-Point Exception Reg */
	mtevpr r4		 	/* clear Exception Vector Prefix Reg */
	addi	r4,r0,0x1000	/* set ME bit (Machine Exceptions) */
	oris	r4,r4,0x0002	/* set CE bit (Critical Exceptions) */


	/* the LED will turn on if I branch here */
	b	LED

	mtmsr	r4			/* change MSR */

	/* the LED will NOT turn on if I branch here */
	/*b	LED */

	addi	r4,r0,(0xFFFF-0x10000)	/* set r4 to 0xFFFFFFFF */
					/* dbsr is cleared by setting bits to 1) */
	mtdbsr	r4		/* clear/reset the dbsr */


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
