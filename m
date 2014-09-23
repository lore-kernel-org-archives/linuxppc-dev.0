Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0FEB61A031A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 13:54:02 +1000 (EST)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D55F81400BE
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2014 13:54:01 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 23 Sep 2014 13:54:00 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 72BFC3578053
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2014 13:53:57 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8N3ToB145219994
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2014 13:29:50 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8N3ru78011534
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2014 13:53:56 +1000
Subject: [PATCH] powerpc/book3s: Fix flush_tlb cpu_spec hook to take a
 generic argument.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 23 Sep 2014 09:23:54 +0530
Message-ID: <20140923035330.6097.43515.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

The flush_tlb hook in cpu_spec was introduced as a generic function hook
to invalidate TLBs. But the current implementation of flush_tlb hook
takes IS (invalidation selector) as an argument which is architecture
dependent. Hence, It is not right to have a generic routine where caller
has to pass non-generic argument.

This patch fixes this and makes flush_tlb hook as high level API.

The old code used to call flush_tlb hook with IS=0 (single page) resulting
partial invalidation of TLBs which is not right. This fix now makes
sure that whole TLB is invalidated to be able to successfully recover from
TLB and ERAT errors.

Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cputable.h   |    2 +
 arch/powerpc/include/asm/mmu-hash64.h |    5 +++
 arch/powerpc/kernel/cpu_setup_power.S |   10 +-----
 arch/powerpc/kernel/cputable.c        |    4 +-
 arch/powerpc/kernel/mce_power.c       |   57 ++++++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_hv_ras.c      |    4 +-
 6 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index daa5af9..ae3e74f 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -100,7 +100,7 @@ struct cpu_spec {
 	/*
 	 * Processor specific routine to flush tlbs.
 	 */
-	void		(*flush_tlb)(unsigned long inval_selector);
+	void		(*flush_tlb)(unsigned int action);
 
 };
 
diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index d765144..068ac8b 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -112,6 +112,11 @@
 #define TLBIEL_INVAL_SET_SHIFT	12
 
 #define POWER7_TLB_SETS		128	/* # sets in POWER7 TLB */
+#define POWER8_TLB_SETS		512	/* # sets in POWER8 TLB */
+
+/* TLB flush actions. Used as argument to cpu_spec.flush_tlb() hook */
+#define FLUSH_TLB_ALL		0	/* invalidate all TLBs */
+#define FLUSH_TLB_LPID		1	/* invalidate TLBs for current LPID */
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 4673353..9c9b741 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -137,15 +137,11 @@ __init_HFSCR:
 /*
  * Clear the TLB using the specified IS form of tlbiel instruction
  * (invalidate by congruence class). P7 has 128 CCs., P8 has 512.
- *
- * r3 = IS field
  */
 __init_tlb_power7:
-	li	r3,0xc00	/* IS field = 0b11 */
-_GLOBAL(__flush_tlb_power7)
 	li	r6,128
 	mtctr	r6
-	mr	r7,r3		/* IS field */
+	li	r7,0xc00	/* IS field = 0b11 */
 	ptesync
 2:	tlbiel	r7
 	addi	r7,r7,0x1000
@@ -154,11 +150,9 @@ _GLOBAL(__flush_tlb_power7)
 1:	blr
 
 __init_tlb_power8:
-	li	r3,0xc00	/* IS field = 0b11 */
-_GLOBAL(__flush_tlb_power8)
 	li	r6,512
 	mtctr	r6
-	mr	r7,r3		/* IS field */
+	li	r7,0xc00	/* IS field = 0b11 */
 	ptesync
 2:	tlbiel	r7
 	addi	r7,r7,0x1000
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 9b6dcaa..5cfffeb 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -71,8 +71,8 @@ extern void __restore_cpu_power7(void);
 extern void __setup_cpu_power8(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_power8(void);
 extern void __restore_cpu_a2(void);
-extern void __flush_tlb_power7(unsigned long inval_selector);
-extern void __flush_tlb_power8(unsigned long inval_selector);
+extern void __flush_tlb_power7(unsigned int action);
+extern void __flush_tlb_power8(unsigned int action);
 extern long __machine_check_early_realmode_p7(struct pt_regs *regs);
 extern long __machine_check_early_realmode_p8(struct pt_regs *regs);
 #endif /* CONFIG_PPC64 */
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index aa9aff3..ffe22aa 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -28,6 +28,59 @@
 #include <asm/mce.h>
 #include <asm/machdep.h>
 
+static void _flush_tlb(uint32_t tlb_set, unsigned long inval_selector)
+{
+	unsigned long i, rb;
+
+	rb = inval_selector;
+	for (i = 0; i < tlb_set; i++) {
+		asm volatile("tlbiel %0" : : "r" (rb));
+		rb += 1 << TLBIEL_INVAL_SET_SHIFT;
+	}
+}
+
+/*
+ * Generic routine to flush TLB on power7. This routine is used as
+ * flush_tlb hook in cpu_spec for Power7 processor.
+ *
+ * action => FLUSH_TLB_ALL:  Invalidate all TLBs.
+ *	     FLUSH_TLB_LPID: Invalidate TLB for current LPID.
+ */
+void __flush_tlb_power7(unsigned int action)
+{
+	switch (action) {
+	case FLUSH_TLB_ALL:
+		_flush_tlb(POWER7_TLB_SETS, TLBIEL_INVAL_SET);
+		break;
+	case FLUSH_TLB_LPID:
+		_flush_tlb(POWER7_TLB_SETS, TLBIEL_INVAL_SET_LPID);
+		break;
+	default:
+		break;
+	}
+}
+
+/*
+ * Generic routine to flush TLB on power8. This routine is used as
+ * flush_tlb hook in cpu_spec for power8 processor.
+ *
+ * action => FLUSH_TLB_ALL:  Invalidate all TLBs.
+ *	     FLUSH_TLB_LPID: Invalidate TLB for current LPID.
+ */
+void __flush_tlb_power8(unsigned int action)
+{
+	switch (action) {
+	case FLUSH_TLB_ALL:
+		_flush_tlb(POWER8_TLB_SETS, TLBIEL_INVAL_SET);
+		break;
+	case FLUSH_TLB_LPID:
+		_flush_tlb(POWER8_TLB_SETS, TLBIEL_INVAL_SET_LPID);
+		break;
+	default:
+		break;
+	}
+}
+
 /* flush SLBs and reload */
 static void flush_and_reload_slb(void)
 {
@@ -79,7 +132,7 @@ static long mce_handle_derror(uint64_t dsisr, uint64_t slb_error_bits)
 	}
 	if (dsisr & P7_DSISR_MC_TLB_MULTIHIT_MFTLB) {
 		if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
-			cur_cpu_spec->flush_tlb(TLBIEL_INVAL_PAGE);
+			cur_cpu_spec->flush_tlb(FLUSH_TLB_ALL);
 		/* reset error bits */
 		dsisr &= ~P7_DSISR_MC_TLB_MULTIHIT_MFTLB;
 	}
@@ -110,7 +163,7 @@ static long mce_handle_common_ierror(uint64_t srr1)
 		break;
 	case P7_SRR1_MC_IFETCH_TLB_MULTIHIT:
 		if (cur_cpu_spec && cur_cpu_spec->flush_tlb) {
-			cur_cpu_spec->flush_tlb(TLBIEL_INVAL_PAGE);
+			cur_cpu_spec->flush_tlb(FLUSH_TLB_ALL);
 			handled = 1;
 		}
 		break;
diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
index d562c8e..8246090 100644
--- a/arch/powerpc/kvm/book3s_hv_ras.c
+++ b/arch/powerpc/kvm/book3s_hv_ras.c
@@ -84,7 +84,7 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
 		}
 		if (dsisr & DSISR_MC_TLB_MULTI) {
 			if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
-				cur_cpu_spec->flush_tlb(TLBIEL_INVAL_SET_LPID);
+				cur_cpu_spec->flush_tlb(FLUSH_TLB_LPID);
 			dsisr &= ~DSISR_MC_TLB_MULTI;
 		}
 		/* Any other errors we don't understand? */
@@ -102,7 +102,7 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
 		break;
 	case SRR1_MC_IFETCH_TLBMULTI:
 		if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
-			cur_cpu_spec->flush_tlb(TLBIEL_INVAL_SET_LPID);
+			cur_cpu_spec->flush_tlb(FLUSH_TLB_LPID);
 		break;
 	default:
 		handled = 0;
