Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D758A2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 23:27:28 +1000 (EST)
Received: from mail52-tx2 (localhost [127.0.0.1])	by mail52-tx2-R.bigfish.com
 (Postfix) with ESMTP id 9BAE73C00EC	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Aug 2012 13:27:24 +0000 (UTC)
Received: from TX2EHSMHS005.bigfish.com (unknown [10.9.14.238])	by
 mail52-tx2.bigfish.com (Postfix) with ESMTP id A628C1A0046	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 13:27:22 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q76DRKLZ012097	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Aug 2012 06:27:21 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 5/6] powerpc/booke64: use SPRG0/3 scratch for bolted TLB miss
 & crit int
Date: Mon, 6 Aug 2012 16:27:07 +0300
Message-ID: <1344259628-31161-6-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1344259628-31161-1-git-send-email-mihai.caraman@freescale.com>
References: <1344259628-31161-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Embedded.Hypervisor category defines GSPRG0..3 physical registers for guests.
Avoid SPRG4-7 usage as scratch in host exception handlers, otherwise guest
SPRG4-7 registers will be clobbered.
For bolted TLB miss exception handlers, which is the version currently
supported by KVM, use SPRN_SPRG_GEN_SCRATCH aka SPRG0 instead of
SPRN_SPRG_TLB_SCRATCH aka SPRG6. Keep using TLB PACA slots to fit in one
64-byte cache line.
For critical exception handlers use SPRG3 instead of SPRG7. Provide a routine
to store and restore user-visible SPRGs. This will be subsequently used
to restore VDSO information in SPRG3. Add EX_R13 to paca slots to free up
SPRG3 and change the critical exception epilog to use it.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/include/asm/exception-64e.h |    5 +++--
 arch/powerpc/include/asm/reg.h           |    5 +++--
 arch/powerpc/kernel/exceptions-64e.S     |   17 +++++++++++++++--
 arch/powerpc/mm/tlb_low_64e.S            |    4 ++--
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/include/asm/exception-64e.h
index e73452f..51fa43e 100644
--- a/arch/powerpc/include/asm/exception-64e.h
+++ b/arch/powerpc/include/asm/exception-64e.h
@@ -46,8 +46,9 @@
 #define EX_CR		(1 * 8)
 #define EX_R10		(2 * 8)
 #define EX_R11		(3 * 8)
-#define EX_R14		(4 * 8)
-#define EX_R15		(5 * 8)
+#define EX_R13		(4 * 8)
+#define EX_R14		(5 * 8)
+#define EX_R15		(6 * 8)
 
 /*
  * The TLB miss exception uses different slots.
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 349d9c3..63a6159 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -761,7 +761,8 @@
  * 64-bit embedded
  *	- SPRG0 generic exception scratch
  *	- SPRG2 TLB exception stack
- *	- SPRG3 CPU and NUMA node for VDSO getcpu (user visible)
+ *	- SPRG3 critical exception scratch and
+ *        CPU and NUMA node for VDSO getcpu (user visible)
  *	- SPRG4 unused (user visible)
  *	- SPRG6 TLB miss scratch (user visible, sorry !)
  *	- SPRG7 critical exception scratch
@@ -858,7 +859,7 @@
 
 #ifdef CONFIG_PPC_BOOK3E_64
 #define SPRN_SPRG_MC_SCRATCH	SPRN_SPRG8
-#define SPRN_SPRG_CRIT_SCRATCH	SPRN_SPRG7
+#define SPRN_SPRG_CRIT_SCRATCH	SPRN_SPRG3
 #define SPRN_SPRG_DBG_SCRATCH	SPRN_SPRG9
 #define SPRN_SPRG_TLB_EXFRAME	SPRN_SPRG2
 #define SPRN_SPRG_TLB_SCRATCH	SPRN_SPRG6
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 83c20e8..7476b0a 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -42,6 +42,7 @@
 	mfspr	r13,SPRN_SPRG_PACA;	/* get PACA */			    \
 	std	r10,PACA_EX##type+EX_R10(r13);				    \
 	std	r11,PACA_EX##type+EX_R11(r13);				    \
+	PROLOG_STORE_RESTORE_SCRATCH_##type;				    \
 	mfcr	r10;			/* save CR */			    \
 	mfspr	r11,SPRN_##type##_SRR1;/* what are we coming from */	    \
 	DO_KVM	intnum,SPRN_##type##_SRR1;    /* KVM hook */		    \
@@ -99,6 +100,18 @@
 #define GDBELL_EXCEPTION_PROLOG(n, intnum, addition)			    \
 	EXCEPTION_PROLOG(n, intnum, GDBELL, addition##_GDBELL(n))
 
+/*
+ * Store user-visible scratch in PACA exception slots and restore proper value
+ */
+#define PROLOG_STORE_RESTORE_SCRATCH_GEN
+#define PROLOG_STORE_RESTORE_SCRATCH_GDBELL
+#define PROLOG_STORE_RESTORE_SCRATCH_DBG
+#define PROLOG_STORE_RESTORE_SCRATCH_MC
+
+#define PROLOG_STORE_RESTORE_SCRATCH_CRIT				    \
+	mfspr	r10,SPRN_SPRG_CRIT_SCRATCH;	/* get r13 */		    \
+	std	r10,PACA_EXCRIT+EX_R13(r13)
+
 /* Variants of the "addition" argument for the prolog
  */
 #define PROLOG_ADDITION_NONE_GEN(n)
@@ -454,7 +467,7 @@ interrupt_end_book3e:
 	mtcr	r10
 	ld	r10,PACA_EXCRIT+EX_R10(r13)	/* restore registers */
 	ld	r11,PACA_EXCRIT+EX_R11(r13)
-	mfspr	r13,SPRN_SPRG_CRIT_SCRATCH
+	ld	r13,PACA_EXCRIT+EX_R13(r13)
 	rfci
 
 	/* Normal debug exception */
@@ -467,7 +480,7 @@ interrupt_end_book3e:
 	/* Now we mash up things to make it look like we are coming on a
 	 * normal exception
 	 */
-	mfspr	r15,SPRN_SPRG_CRIT_SCRATCH
+	ld	r15,PACA_EXCRIT+EX_R13(r13)
 	mtspr	SPRN_SPRG_GEN_SCRATCH,r15
 	mfspr	r14,SPRN_DBSR
 	EXCEPTION_COMMON(0xd00, PACA_EXCRIT, INTS_DISABLE)
diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index d884fa4..b4113bf 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -40,7 +40,7 @@
  **********************************************************************/
 
 .macro tlb_prolog_bolted intnum addr
-	mtspr	SPRN_SPRG_TLB_SCRATCH,r13
+	mtspr	SPRN_SPRG_GEN_SCRATCH,r13
 	mfspr	r13,SPRN_SPRG_PACA
 	std	r10,PACA_EXTLB+EX_TLB_R10(r13)
 	mfcr	r10
@@ -69,7 +69,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	ld	r15,PACA_EXTLB+EX_TLB_R15(r13)
 	TLB_MISS_RESTORE_STATS_BOLTED
 	ld	r16,PACA_EXTLB+EX_TLB_R16(r13)
-	mfspr	r13,SPRN_SPRG_TLB_SCRATCH
+	mfspr	r13,SPRN_SPRG_GEN_SCRATCH
 .endm
 
 /* Data TLB miss */
-- 
1.7.4.1
