Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF3641A0B0E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Dec 2014 14:11:13 +1100 (AEDT)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 173341400A0
 for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2014 14:11:12 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 19 Dec 2014 08:41:10 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C87271258044
 for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2014 08:41:35 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBJ3Anof62062662
 for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2014 08:40:49 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBJ3B5Je025988
 for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2014 08:41:06 +0530
Subject: [PATCH v3] powerpc/book3s: Fix flush_tlb cpu_spec hook to take a
 generic argument.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 19 Dec 2014 08:41:05 +0530
Message-ID: <20141219031015.30799.91998.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Paul Mackerras <paulus@samba.org>
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

Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
Changes in V3:
- Changed TLB flush action #defines into enum.

Changes in V2:
- Moved TLB flush action #defines to cputable.h
- Added missing ptesyncs to before and after TLB flush.
- Moved switch case to flush_tlb_206() function as suggested by
  Michael Ellerman.
---
 arch/powerpc/include/asm/cputable.h   |    8 ++++-
 arch/powerpc/include/asm/mmu-hash64.h |    1 +
 arch/powerpc/kernel/cpu_setup_power.S |   10 +-----
 arch/powerpc/kernel/cputable.c        |    4 +-
 arch/powerpc/kernel/mce_power.c       |   53 ++++++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_hv_ras.c      |    4 +-
 6 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index daa5af9..493af2d 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -100,7 +100,7 @@ struct cpu_spec {
 	/*
 	 * Processor specific routine to flush tlbs.
 	 */
-	void		(*flush_tlb)(unsigned long inval_selector);
+	void		(*flush_tlb)(unsigned int action);
 
 };
 
@@ -114,6 +114,12 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 
 extern const char *powerpc_base_platform;
 
+/* TLB flush actions. Used as argument to cpu_spec.flush_tlb() hook */
+enum {
+	TLB_INVAL_SCOPE_GLOBAL = 0,	/* invalidate all TLBs */
+	TLB_INVAL_SCOPE_LPID = 1,	/* invalidate TLBs for current LPID */
+};
+
 #endif /* __ASSEMBLY__ */
 
 /* CPU kernel features */
diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index aeebc94..4f50db7 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -112,6 +112,7 @@
 #define TLBIEL_INVAL_SET_SHIFT	12
 
 #define POWER7_TLB_SETS		128	/* # sets in POWER7 TLB */
+#define POWER8_TLB_SETS		512	/* # sets in POWER8 TLB */
 
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
index 8084059..81c1ba5 100644
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
index b6f123a..2c647b1 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -28,6 +28,55 @@
 #include <asm/mce.h>
 #include <asm/machdep.h>
 
+static void flush_tlb_206(unsigned int num_sets, unsigned int action)
+{
+	unsigned long rb;
+	unsigned int i;
+
+	switch (action) {
+	case TLB_INVAL_SCOPE_GLOBAL:
+		rb = TLBIEL_INVAL_SET;
+		break;
+	case TLB_INVAL_SCOPE_LPID:
+		rb = TLBIEL_INVAL_SET_LPID;
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	asm volatile("ptesync" : : : "memory");
+	for (i = 0; i < num_sets; i++) {
+		asm volatile("tlbiel %0" : : "r" (rb));
+		rb += 1 << TLBIEL_INVAL_SET_SHIFT;
+	}
+	asm volatile("ptesync" : : : "memory");
+}
+
+/*
+ * Generic routine to flush TLB on power7. This routine is used as
+ * flush_tlb hook in cpu_spec for Power7 processor.
+ *
+ * action => TLB_INVAL_SCOPE_GLOBAL:  Invalidate all TLBs.
+ *	     TLB_INVAL_SCOPE_LPID: Invalidate TLB for current LPID.
+ */
+void __flush_tlb_power7(unsigned int action)
+{
+	flush_tlb_206(POWER7_TLB_SETS, action);
+}
+
+/*
+ * Generic routine to flush TLB on power8. This routine is used as
+ * flush_tlb hook in cpu_spec for power8 processor.
+ *
+ * action => TLB_INVAL_SCOPE_GLOBAL:  Invalidate all TLBs.
+ *	     TLB_INVAL_SCOPE_LPID: Invalidate TLB for current LPID.
+ */
+void __flush_tlb_power8(unsigned int action)
+{
+	flush_tlb_206(POWER8_TLB_SETS, action);
+}
+
 /* flush SLBs and reload */
 static void flush_and_reload_slb(void)
 {
@@ -79,7 +128,7 @@ static long mce_handle_derror(uint64_t dsisr, uint64_t slb_error_bits)
 	}
 	if (dsisr & P7_DSISR_MC_TLB_MULTIHIT_MFTLB) {
 		if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
-			cur_cpu_spec->flush_tlb(TLBIEL_INVAL_SET);
+			cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_GLOBAL);
 		/* reset error bits */
 		dsisr &= ~P7_DSISR_MC_TLB_MULTIHIT_MFTLB;
 	}
@@ -110,7 +159,7 @@ static long mce_handle_common_ierror(uint64_t srr1)
 		break;
 	case P7_SRR1_MC_IFETCH_TLB_MULTIHIT:
 		if (cur_cpu_spec && cur_cpu_spec->flush_tlb) {
-			cur_cpu_spec->flush_tlb(TLBIEL_INVAL_SET);
+			cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_GLOBAL);
 			handled = 1;
 		}
 		break;
diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
index d562c8e..d10dd57 100644
--- a/arch/powerpc/kvm/book3s_hv_ras.c
+++ b/arch/powerpc/kvm/book3s_hv_ras.c
@@ -84,7 +84,7 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
 		}
 		if (dsisr & DSISR_MC_TLB_MULTI) {
 			if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
-				cur_cpu_spec->flush_tlb(TLBIEL_INVAL_SET_LPID);
+				cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_LPID);
 			dsisr &= ~DSISR_MC_TLB_MULTI;
 		}
 		/* Any other errors we don't understand? */
@@ -102,7 +102,7 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
 		break;
 	case SRR1_MC_IFETCH_TLBMULTI:
 		if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
-			cur_cpu_spec->flush_tlb(TLBIEL_INVAL_SET_LPID);
+			cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_LPID);
 		break;
 	default:
 		handled = 0;
