Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id D79911008BE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:36 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <0f7da9acd12131810f00eeffccec35114a7779ae.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:28:44 -0500
Subject: [PATCH 04/37] powerpc/iseries: cleanup and fix secondary startup
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

9cb82f2f4692293a27c578c3038518ce4477de72 (Make iSeries spin on
__secondary_hold_spinloop, like pSeries) added a load of current_set
but this load was repeated later and we don't even have the paca yet.
It also checked __secondary_hold_spinloop with a 32 bit compare instead
of a 64 bit compare.

b6f6b98a4e91fcf31db7de54c3aa86252fc6fb5f (Don't spin on sync instruction
at boot time) missed the copy of the startup code in iseries.

1426d5a3bd07589534286375998c0c8c6fdc5260 (Dynamically allocate pacas)
doesn't allow for pacas to be less than lppacas and recalculated the paca
location from the cpu id in r0 every time through the secondary loop.

Various revisions over time made the comments on conditional branches
confusing with respect to being a hold loop or forward progress

Mostly in-order description of the changes:

Replicate the few lines of code saved by the ugly scoped ifdef CONFIG_SMP
in the secondary loop between yielding on UP and marking time with the
hypervisor on SMP.  Always compile the iseries_secondary_yield loop and
use it if the cpu id is above nr_cpu_ids.  Change all forward progress
paths to be forward branches to the next numerical label.  Assign a
label to all loops.  Move all sync instructions from the loops to the
forward progress path.  Wait to load current_set until paca is set to go.
Move the iseries_secondary_smp_loop label to cover the whole spin loop.
Add HMT_MEDIUM when we make forward progress.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
commpile tested only
---
 arch/powerpc/platforms/iseries/exception.S |   59 ++++++++++++++++-----------
 1 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/exception.S b/arch/powerpc/platforms/iseries/exception.S
index a67984c..29c02f3 100644
--- a/arch/powerpc/platforms/iseries/exception.S
+++ b/arch/powerpc/platforms/iseries/exception.S
@@ -61,29 +61,31 @@ system_reset_iSeries:
 /* Spin on __secondary_hold_spinloop until it is updated by the boot cpu. */
 /* In the UP case we'll yield() later, and we will not access the paca anyway */
 #ifdef CONFIG_SMP
-1:
+iSeries_secondary_wait_paca:
 	HMT_LOW
 	LOAD_REG_ADDR(r23, __secondary_hold_spinloop)
 	ld	r23,0(r23)
-	sync
-	LOAD_REG_ADDR(r3,current_set)
-	sldi	r28,r24,3		/* get current_set[cpu#] */
-	ldx	r3,r3,r28
-	addi	r1,r3,THREAD_SIZE
-	subi	r1,r1,STACK_FRAME_OVERHEAD
 
-	cmpwi	0,r23,0			/* Keep poking the Hypervisor until */
-	bne	2f			/* we're released */
-	/* Let the Hypervisor know we are alive */
+	cmpdi	0,r23,0
+	bne	2f			/* go on when the master is ready */
+
+	/* Keep poking the Hypervisor until we're released */
 	/* 8002 is a call to HvCallCfg::getLps, a harmless Hypervisor function */
 	lis	r3,0x8002
 	rldicr	r3,r3,32,15		/* r0 = (r3 << 32) & 0xffff000000000000 */
 	li	r0,-1			/* r0=-1 indicates a Hypervisor call */
 	sc				/* Invoke the hypervisor via a system call */
-	b	1b
-#endif
+	b	iSeries_secondary_wait_paca
 
 2:
+	HMT_MEDIUM
+	sync
+
+	LOAD_REG_ADDR(r3, nr_cpu_ids)	/* get number of pacas allocated */
+	lwz	r3,0(r3)		/* nr_cpus= or NR_CPUS can limit */
+	cmpld	0,r24,r3		/* is our cpu number allocated? */
+	bge	iSeries_secondary_yield	/* no, yield forever */
+
 	/* Load our paca now that it's been allocated */
 	LOAD_REG_ADDR(r13, paca)
 	ld	r13,0(r13)
@@ -94,10 +96,24 @@ system_reset_iSeries:
 	ori	r23,r23,MSR_RI
 	mtmsrd	r23			/* RI on */
 
-	HMT_LOW
-#ifdef CONFIG_SMP
+iSeries_secondary_smp_loop:
 	lbz	r23,PACAPROCSTART(r13)	/* Test if this processor
 					 * should start */
+	cmpwi	0,r23,0
+	bne	3f			/* go on when we are told */
+
+	HMT_LOW
+	/* Let the Hypervisor know we are alive */
+	/* 8002 is a call to HvCallCfg::getLps, a harmless Hypervisor function */
+	lis	r3,0x8002
+	rldicr	r3,r3,32,15		/* r0 = (r3 << 32) & 0xffff000000000000 */
+	li	r0,-1			/* r0=-1 indicates a Hypervisor call */
+	sc				/* Invoke the hypervisor via a system call */
+	mfspr	r13,SPRN_SPRG_PACA	/* Put r13 back ???? */
+	b	iSeries_secondary_smp_loop /* wait for signal to start */
+
+3:
+	HMT_MEDIUM
 	sync
 	LOAD_REG_ADDR(r3,current_set)
 	sldi	r28,r24,3		/* get current_set[cpu#] */
@@ -105,27 +121,22 @@ system_reset_iSeries:
 	addi	r1,r3,THREAD_SIZE
 	subi	r1,r1,STACK_FRAME_OVERHEAD
 
-	cmpwi	0,r23,0
-	beq	iSeries_secondary_smp_loop	/* Loop until told to go */
 	b	__secondary_start		/* Loop until told to go */
-iSeries_secondary_smp_loop:
-	/* Let the Hypervisor know we are alive */
-	/* 8002 is a call to HvCallCfg::getLps, a harmless Hypervisor function */
-	lis	r3,0x8002
-	rldicr	r3,r3,32,15		/* r0 = (r3 << 32) & 0xffff000000000000 */
-#else /* CONFIG_SMP */
+#endif /* CONFIG_SMP */
+
+iSeries_secondary_yield:
 	/* Yield the processor.  This is required for non-SMP kernels
 		which are running on multi-threaded machines. */
+	HMT_LOW
 	lis	r3,0x8000
 	rldicr	r3,r3,32,15		/* r3 = (r3 << 32) & 0xffff000000000000 */
 	addi	r3,r3,18		/* r3 = 0x8000000000000012 which is "yield" */
 	li	r4,0			/* "yield timed" */
 	li	r5,-1			/* "yield forever" */
-#endif /* CONFIG_SMP */
 	li	r0,-1			/* r0=-1 indicates a Hypervisor call */
 	sc				/* Invoke the hypervisor via a system call */
 	mfspr	r13,SPRN_SPRG_PACA	/* Put r13 back ???? */
-	b	2b			/* If SMP not configured, secondaries
+	b	iSeries_secondary_yield	/* If SMP not configured, secondaries
 					 * loop forever */
 
 /***  ISeries-LPAR interrupt handlers ***/
-- 
1.7.0.4
