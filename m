Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (unknown [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id A0D5DDDF71
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Aug 2008 02:01:49 +1000 (EST)
Subject: PPC405EP errata CPU 213 (Incorrect data may be flushed from the
	data cache)
From: Darcy Watkins <dwatkins@tranzeo.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Date: Tue, 26 Aug 2008 09:01:47 -0700
Message-Id: <1219766507.26004.92.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

The IBM/AMCC errata document recommends setting reserved bits 1 & 3 in
CCR0 as a workaround to PPC405EP errata CPU 213 (Incorrect data may be
flushed from the data cache).  For a start, I just tried hacking in a
few lines of assembly code into...

  arch/powerpc/kernel/head_40x.S

---

Around line #839 ...

	bl	early_init	/* We have to do this with MMU on */

/*
 * Decide what sort of machine this is and initialize the MMU.
 */
	mr	r3,r31
	mr	r4,r30
	mr	r5,r29
	mr	r6,r28
	mr	r7,r27
	bl	machine_init
	bl	MMU_init
/* DLW hack!! - for PPC405EP errata CPU 213 */
	mfspr	r4,SPRN_CCR0
	oris	r4,r4,0x5000
	mtspr	SPRN_CCR0,r4
	isync

/* Go back to running unmapped so we can load up new values
 * and change to using our exception vectors.
 * On the 4xx, all we have to do is invalidate the TLB to clear
 * the old 16M byte TLB mappings.
 */
	lis	r4,2f@h
...

Since I am not a PowerPC assembler guru, does this appear right?

I think that eventually I'd want to create a cpu_setup_40x.S with the
fixup code as part of a setup_cpu_405ep function and then hook this into
cputable.c, but first I want to make sure that the errata workaround is
actually taking effect (and also not being undone by later startup
code).

-- 


Regards,

Darcy

--------------
Darcy L. Watkins - Senior Software Developer
Tranzeo Wireless Technologies, Inc.
19273 Fraser Way, Pitt Meadows, BC, Canada V3Y 2V4
T:604-460-6002 ext:410
http://www.tranzeo.com
