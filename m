Subject: MMU Problem bringing up kernel with PPC 603 chip
From: Bob Beck <beck@assurtech.com>
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040227103636.78365C0655@atlas.denx.de>
References: <20040227103636.78365C0655@atlas.denx.de>
Content-Type: text/plain
Message-Id: <1077830593.4199.7.camel@budweiser>
Mime-Version: 1.0
Date: 27 Feb 2004 11:23:13 +1400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All,

I'm bringing up my 1st kernel on a proprietary board
using a PPC 603E chip.


The kernel is configured using the 6xx/7xx ppc selection.

The kernel starts executing at __start in head.S and
branches to early_init(). I have stubbed out the call
to prom_init() since this is an embedded system and
not a power mac (as the comments at the top of the
prom.c file indicate).

The code returns to head.S and branches to mmu_off.
Here is the code for mmu_off.

mmu_off:
	addi	r4, r3, __after_mmu_off - _start
	mfmsr	r3
	andi.	r0,r3,MSR_DR|MSR_IR		/* MMU enabled? */
	beqlr
	andc	r3,r3,r0
	mtspr	SRR0,r4
	mtspr	SRR1,r3
	sync
	RFI

This executes all the way to the "RFI" instruction,
but never comes back to the place in the code that
called mmu_off.

Why is the "return from interrupt" going out into
space ? Any suggestions ?


Best Regards,

Bob Beck
beck@assurtech.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
