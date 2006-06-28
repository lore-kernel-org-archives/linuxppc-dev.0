Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id ABA9E67A3F
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 11:54:18 +1000 (EST)
Date: Wed, 28 Jun 2006 11:53:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] Remove unused function call_with_mmu_off
Message-Id: <20060628115356.265a3af2.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/misc_64.S |   42 -----------------------------------------
 1 files changed, 0 insertions(+), 42 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index e8883d4..6bf4a46 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -101,48 +101,6 @@ _GLOBAL(call___do_IRQ)
 	blr
 #endif /* CONFIG_IRQSTACKS */
 
-	/*
- * To be called by C code which needs to do some operations with MMU
- * disabled. Note that interrupts have to be disabled by the caller
- * prior to calling us. The code called _MUST_ be in the RMO of course
- * and part of the linear mapping as we don't attempt to translate the
- * stack pointer at all. The function is called with the stack switched
- * to this CPU emergency stack
- *
- * prototype is void *call_with_mmu_off(void *func, void *data);
- *
- * the called function is expected to be of the form
- *
- * void *called(void *data); 
- */
-_GLOBAL(call_with_mmu_off)
-	mflr	r0			/* get link, save it on stackframe */
-	std	r0,16(r1)
-	mr	r1,r5			/* save old stack ptr */
-	ld	r1,PACAEMERGSP(r13)	/* get emerg. stack */
-	subi	r1,r1,STACK_FRAME_OVERHEAD
-	std	r0,16(r1)		/* save link on emerg. stack */
-	std	r5,0(r1)		/* save old stack ptr in backchain */
-	ld	r3,0(r3)		/* get to real function ptr (assume same TOC) */
-	bl	2f			/* we need LR to return, continue at label 2 */
-
-	ld	r0,16(r1)		/* we return here from the call, get LR and */
-	ld	r1,0(r1)		/* .. old stack ptr */
-	mtspr	SPRN_SRR0,r0		/* and get back to virtual mode with these */
-	mfmsr	r4
-	ori	r4,r4,MSR_IR|MSR_DR
-	mtspr	SPRN_SRR1,r4
-	rfid
-
-2:	mtspr	SPRN_SRR0,r3		/* coming from above, enter real mode */
-	mr	r3,r4			/* get parameter */
-	mfmsr	r0
-	ori	r0,r0,MSR_IR|MSR_DR
-	xori	r0,r0,MSR_IR|MSR_DR
-	mtspr	SPRN_SRR1,r0
-	rfid
-
-
 	.section	".toc","aw"
 PPC64_CACHES:
 	.tc		ppc64_caches[TC],ppc64_caches
-- 
1.4.0
