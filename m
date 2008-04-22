Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 2A37EDE13E
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 13:30:07 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Message-Id: <7be4c4c6f56d04b595c92690b297de17140304d2.1208834828.git.tony@bakeyournoodle.com>
In-Reply-To: <767e424a294239aba86aa7da086f6395f7066d14.1208834828.git.tony@bakeyournoodle.com>
References: <767e424a294239aba86aa7da086f6395f7066d14.1208834828.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 2/3] Make iSeries spin on __secondary_hold_spinloop,
	like pSeries.
Date: Tue, 22 Apr 2008 13:30:06 +1000 (EST)
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently all iSeries secondary CPU's spin directly on the cpu_start in thier
paca.  Make them spin on the global __secondary_hold_spinloop, until after the
pacas have been initialised.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/platforms/iseries/exception.S |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/exception.S b/arch/powerpc/platforms/iseries/exception.S
index c775cd4..8ff330d 100644
--- a/arch/powerpc/platforms/iseries/exception.S
+++ b/arch/powerpc/platforms/iseries/exception.S
@@ -59,8 +59,33 @@ system_reset_iSeries:
 	andc	r4,r4,r5
 	mtspr	SPRN_CTRLT,r4
 
+/* Spin on __secondary_hold_spinloop until it is updated by the boot cpu. */
+/* In the UP case we'll yeild() later, and we will not access the paca anyway */
+#ifdef CONFIG_SMP
 1:
 	HMT_LOW
+	LOAD_REG_IMMEDIATE(r23, __secondary_hold_spinloop)
+	ld	r23,0(r23)
+	sync
+	LOAD_REG_IMMEDIATE(r3,current_set)
+	sldi	r28,r24,3		/* get current_set[cpu#] */
+	ldx	r3,r3,r28
+	addi	r1,r3,THREAD_SIZE
+	subi	r1,r1,STACK_FRAME_OVERHEAD
+
+	cmpwi	0,r23,0			/* Keep poking the Hypervisor until */
+	bne	2f			/* we're released */
+	/* Let the Hypervisor know we are alive */
+	/* 8002 is a call to HvCallCfg::getLps, a harmless Hypervisor function */
+	lis	r3,0x8002
+	rldicr	r3,r3,32,15		/* r0 = (r3 << 32) & 0xffff000000000000 */
+	li	r0,-1			/* r0=-1 indicates a Hypervisor call */
+	sc				/* Invoke the hypervisor via a system call */
+	b	1b
+#endif
+
+2:
+	HMT_LOW
 #ifdef CONFIG_SMP
 	lbz	r23,PACAPROCSTART(r13)	/* Test if this processor
 					 * should start */
@@ -91,7 +116,7 @@ iSeries_secondary_smp_loop:
 	li	r0,-1			/* r0=-1 indicates a Hypervisor call */
 	sc				/* Invoke the hypervisor via a system call */
 	mfspr	r13,SPRN_SPRG3		/* Put r13 back ???? */
-	b	1b			/* If SMP not configured, secondaries
+	b	2b			/* If SMP not configured, secondaries
 					 * loop forever */
 
 /***  ISeries-LPAR interrupt handlers ***/
-- 
1.5.5
