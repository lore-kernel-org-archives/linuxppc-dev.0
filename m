Subject: 440GX tlb problem?
From: Travis Sawyer <tsawyer+linuxppc@sandburst.com>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1086979205.29360.5.camel@pavement.sandburst.com>
Mime-Version: 1.0
Date: Fri, 11 Jun 2004 14:40:05 -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings:

I'm attempting to bring up a new board (our custom hw) and am blowing an
Instruction TLB error in head_440.S where the original TLB for SDRAM
(u-boot and initial kernel space) is invalidated after we've switched to
0xc000_0000.

the instructions:
3:/*	iccci   r0,r0    rcblach 12/19/02 clear all caches again on 1/17/03
I took out these changes
	dccci   r0,r0    again clear all caches */
	cmpwi	r23,62
	beq	4f
	li	r6,0
	tlbwe   r6,r23,PPC440_TLB_PAGEID
	sync


The exception hits when the sync is executed.

I hope this hasn't been discussed ad nauseum in the archives... I
couldn't seem to find it.

Kernel is 2.4.21

Any ideas?

TIA

Travis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
