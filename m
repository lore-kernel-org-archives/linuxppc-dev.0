Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 9F98367B92
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 14:59:55 +1100 (EST)
Date: Mon, 27 Nov 2006 14:59:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries: Eliminate "exceeds stub group size" warnings
Message-Id: <20061127145950.1fdda368.sfr@canb.auug.org.au>
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

Commit 3ccfc65c5004e5fe5cfbffe43b8acc686680b53e missed the same fixes for
legacy iSeries specific code, so make some more symbols no longer global.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/entry_64.S |    4 +++-
 arch/powerpc/kernel/head_64.S  |   10 ++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

I have built this for various configurations and booted it on legcay
iSeries.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index ec754c9..1a3d4de 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -97,7 +97,9 @@ BEGIN_FW_FTR_SECTION
 	cmpdi	cr1,r0,0x5555		/* syscall 0x5555 */
 	andi.	r10,r12,MSR_PR		/* from kernel */
 	crand	4*cr0+eq,4*cr1+eq,4*cr0+eq
-	beq	hardware_interrupt_entry
+	bne	2f
+	b	hardware_interrupt_entry
+2:
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif
 	mfmsr	r11
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 3a0ba9d..4227a13 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -825,7 +825,7 @@ system_reset_iSeries:
 
 	cmpwi	0,r23,0
 	beq	iSeries_secondary_smp_loop	/* Loop until told to go */
-	bne	.__secondary_start		/* Loop until told to go */
+	bne	__secondary_start		/* Loop until told to go */
 iSeries_secondary_smp_loop:
 	/* Let the Hypervisor know we are alive */
 	/* 8002 is a call to HvCallCfg::getLps, a harmless Hypervisor function */
@@ -846,7 +846,6 @@ iSeries_secondary_smp_loop:
 	b	1b			/* If SMP not configured, secondaries
 					 * loop forever */
 
-	.globl decrementer_iSeries_masked
 decrementer_iSeries_masked:
 	/* We may not have a valid TOC pointer in here. */
 	li	r11,1
@@ -857,7 +856,6 @@ decrementer_iSeries_masked:
 	mtspr	SPRN_DEC,r12
 	/* fall through */
 
-	.globl hardware_interrupt_iSeries_masked
 hardware_interrupt_iSeries_masked:
 	mtcrf	0x80,r9		/* Restore regs */
 	ld	r12,PACALPPACAPTR(r13)
@@ -1604,7 +1602,7 @@ _GLOBAL(generic_secondary_smp_init)
 	ld	r1,PACAEMERGSP(r13)
 	subi	r1,r1,STACK_FRAME_OVERHEAD
 
-	b	.__secondary_start
+	b	__secondary_start
 #endif
 
 #ifdef CONFIG_PPC_ISERIES
@@ -1873,7 +1871,7 @@ _GLOBAL(pmac_secondary_start)
 	ld	r1,PACAEMERGSP(r13)
 	subi	r1,r1,STACK_FRAME_OVERHEAD
 
-	b	.__secondary_start
+	b	__secondary_start
 
 #endif /* CONFIG_PPC_PMAC */
 
@@ -1890,7 +1888,7 @@ _GLOBAL(pmac_secondary_start)
  *   r13   = paca virtual address
  *   SPRG3 = paca virtual address
  */
-_GLOBAL(__secondary_start)
+__secondary_start:
 	/* Set thread priority to MEDIUM */
 	HMT_MEDIUM
 
-- 
1.4.4
