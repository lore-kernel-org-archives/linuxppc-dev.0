Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E5AAD2C0114
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Mar 2014 11:01:19 +1100 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 06/10] powerpc/booke64: Use SPRG_TLB_EXFRAME on bolted handlers
Date: Thu, 13 Mar 2014 19:00:45 -0500
Message-ID: <1394755249-8856-7-git-send-email-scottwood@freescale.com>
In-Reply-To: <1394755249-8856-1-git-send-email-scottwood@freescale.com>
References: <1394755249-8856-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kvm-ppc@vger.kernel.org, Tiejun Chen <tiejun.chen@windriver.com>,
 Scott Wood <scottwood@freescale.com>,
 Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While bolted handlers (including e6500) do not need to deal with a TLB
miss recursively causing another TLB miss, nested TLB misses can still
happen with crit/mc/debug exceptions -- so we still need to honor
SPRG_TLB_EXFRAME.

We don't need to spend time modifying it in the TLB miss fastpath,
though -- the special level exception will handle that.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Mihai Caraman <mihai.caraman@freescale.com>
Cc: kvm-ppc@vger.kernel.org
---
 arch/powerpc/include/asm/exception-64e.h    | 10 -------
 arch/powerpc/include/asm/kvm_booke_hv_asm.h |  8 ++++--
 arch/powerpc/kvm/bookehv_interrupts.S       | 14 +++++++--
 arch/powerpc/mm/tlb_low_64e.S               | 44 ++++++++++++++++++-----------
 4 files changed, 45 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/include/asm/exception-64e.h
index e73452f..a563d9af 100644
--- a/arch/powerpc/include/asm/exception-64e.h
+++ b/arch/powerpc/include/asm/exception-64e.h
@@ -172,16 +172,6 @@ exc_##label##_book3e:
 	ld	r9,EX_TLB_R9(r12);					    \
 	ld	r8,EX_TLB_R8(r12);					    \
 	mtlr	r16;
-#define TLB_MISS_PROLOG_STATS_BOLTED						    \
-	mflr	r10;							    \
-	std	r8,PACA_EXTLB+EX_TLB_R8(r13);				    \
-	std	r9,PACA_EXTLB+EX_TLB_R9(r13);				    \
-	std	r10,PACA_EXTLB+EX_TLB_LR(r13);
-#define TLB_MISS_RESTORE_STATS_BOLTED					            \
-	ld	r16,PACA_EXTLB+EX_TLB_LR(r13);				    \
-	ld	r9,PACA_EXTLB+EX_TLB_R9(r13);				    \
-	ld	r8,PACA_EXTLB+EX_TLB_R8(r13);				    \
-	mtlr	r16;
 #define TLB_MISS_STATS_D(name)						    \
 	addi	r9,r13,MMSTAT_DSTATS+name;				    \
 	bl	.tlb_stat_inc;
diff --git a/arch/powerpc/include/asm/kvm_booke_hv_asm.h b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
index c3e3fd5..e5f048b 100644
--- a/arch/powerpc/include/asm/kvm_booke_hv_asm.h
+++ b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
@@ -45,10 +45,12 @@
  *
  * Expected inputs (TLB exception type):
  *  r10 = saved CR
+ *  r12 = extlb pointer
  *  r13 = PACA_POINTER
- *  *(r13 + PACA_EX##type + EX_TLB_R10) = saved r10
- *  *(r13 + PACA_EX##type + EX_TLB_R11) = saved r11
- *  SPRN_SPRG_GEN_SCRATCH = saved r13
+ *  *(r12 + EX_TLB_R10) = saved r10
+ *  *(r12 + EX_TLB_R11) = saved r11
+ *  *(r12 + EX_TLB_R13) = saved r13
+ *  SPRN_SPRG_GEN_SCRATCH = saved r12
  *
  * Only the bolted version of TLB miss exception handlers is supported now.
  */
diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index 99635a3..890e338 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -229,13 +229,20 @@
 	stw	r10, VCPU_CR(r4)
 	PPC_STL r11, VCPU_GPR(R4)(r4)
 	PPC_STL	r5, VCPU_GPR(R5)(r4)
-	mfspr	r5, \scratch
 	PPC_STL	r6, VCPU_GPR(R6)(r4)
 	PPC_STL	r8, VCPU_GPR(R8)(r4)
 	PPC_STL	r9, VCPU_GPR(R9)(r4)
-	PPC_STL r5, VCPU_GPR(R13)(r4)
+	.if \type == EX_TLB
+	PPC_LL	r5, EX_TLB_R13(r12)
+	PPC_LL	r6, EX_TLB_R10(r12)
+	PPC_LL	r8, EX_TLB_R11(r12)
+	mfspr	r12, \scratch
+	.else
+	mfspr	r5, \scratch
 	PPC_LL	r6, (\paca_ex + \ex_r10)(r13)
 	PPC_LL	r8, (\paca_ex + \ex_r11)(r13)
+	.endif
+	PPC_STL r5, VCPU_GPR(R13)(r4)
 	PPC_STL r3, VCPU_GPR(R3)(r4)
 	PPC_STL r7, VCPU_GPR(R7)(r4)
 	PPC_STL r12, VCPU_GPR(R12)(r4)
@@ -444,6 +451,9 @@ _GLOBAL(kvmppc_resume_host)
 	PPC_STD(r8, VCPU_SHARED_SPRG6, r11)
 	mfxer	r3
 	PPC_STD(r9, VCPU_SHARED_SPRG7, r11)
+#ifdef CONFIG_64BIT
+	mtspr	SPRN_SPRG_VDSO_WRITE, r3
+#endif
 
 	/* save guest MAS registers and restore host mas4 & mas6 */
 	mfspr	r5, SPRN_MAS0
diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index 1e50249..356e8b4 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -39,37 +39,49 @@
  *                                                                    *
  **********************************************************************/
 
+/*
+ * Note that, unlike non-bolted handlers, TLB_EXFRAME is not
+ * modified by the TLB miss handlers themselves, since the TLB miss
+ * handler code will not itself cause a recursive TLB miss.
+ *
+ * TLB_EXFRAME will be modified when crit/mc/debug exceptions are
+ * entered/exited.
+ */
 .macro tlb_prolog_bolted intnum addr
-	mtspr	SPRN_SPRG_GEN_SCRATCH,r13
+	mtspr	SPRN_SPRG_GEN_SCRATCH,r12
+	mfspr	r12,SPRN_SPRG_TLB_EXFRAME
+	std	r13,EX_TLB_R13(r12)
+	std	r10,EX_TLB_R10(r12)
 	mfspr	r13,SPRN_SPRG_PACA
-	std	r10,PACA_EXTLB+EX_TLB_R10(r13)
+
 	mfcr	r10
-	std	r11,PACA_EXTLB+EX_TLB_R11(r13)
+	std	r11,EX_TLB_R11(r12)
 #ifdef CONFIG_KVM_BOOKE_HV
 BEGIN_FTR_SECTION
 	mfspr	r11, SPRN_SRR1
 END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 #endif
 	DO_KVM	\intnum, SPRN_SRR1
-	std	r16,PACA_EXTLB+EX_TLB_R16(r13)
+	std	r16,EX_TLB_R16(r12)
 	mfspr	r16,\addr		/* get faulting address */
-	std	r14,PACA_EXTLB+EX_TLB_R14(r13)
+	std	r14,EX_TLB_R14(r12)
 	ld	r14,PACAPGD(r13)
-	std	r15,PACA_EXTLB+EX_TLB_R15(r13)
-	std	r10,PACA_EXTLB+EX_TLB_CR(r13)
-	TLB_MISS_PROLOG_STATS_BOLTED
+	std	r15,EX_TLB_R15(r12)
+	std	r10,EX_TLB_CR(r12)
+	TLB_MISS_PROLOG_STATS
 .endm
 
 .macro tlb_epilog_bolted
-	ld	r14,PACA_EXTLB+EX_TLB_CR(r13)
-	ld	r10,PACA_EXTLB+EX_TLB_R10(r13)
-	ld	r11,PACA_EXTLB+EX_TLB_R11(r13)
+	ld	r14,EX_TLB_CR(r12)
+	ld	r10,EX_TLB_R10(r12)
+	ld	r11,EX_TLB_R11(r12)
+	ld	r13,EX_TLB_R13(r12)
 	mtcr	r14
-	ld	r14,PACA_EXTLB+EX_TLB_R14(r13)
-	ld	r15,PACA_EXTLB+EX_TLB_R15(r13)
-	TLB_MISS_RESTORE_STATS_BOLTED
-	ld	r16,PACA_EXTLB+EX_TLB_R16(r13)
-	mfspr	r13,SPRN_SPRG_GEN_SCRATCH
+	ld	r14,EX_TLB_R14(r12)
+	ld	r15,EX_TLB_R15(r12)
+	TLB_MISS_RESTORE_STATS
+	ld	r16,EX_TLB_R16(r12)
+	mfspr	r12,SPRN_SPRG_GEN_SCRATCH
 .endm
 
 /* Data TLB miss */
-- 
1.8.3.2
