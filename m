Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3JS92J50zDsPN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 14:27:21 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id y192so240485pgd.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 21:27:21 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v4 3/5] powerpc/mce: Hookup derror (load/store) UE errors
Date: Fri, 29 Sep 2017 14:26:53 +1000
Message-Id: <20170929042655.14570-4-bsingharora@gmail.com>
In-Reply-To: <20170929042655.14570-1-bsingharora@gmail.com>
References: <20170929042655.14570-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Extract physical_address for UE errors by walking the page
tables for the mm and address at the NIP, to extract the
instruction. Then use the instruction to find the effective
address via analyse_instr().

We might have page table walking races, but we expect them to
be rare, the physical address extraction is best effort. The idea
is to then hook up this infrastructure to memory failure eventually.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h |  5 ++
 arch/powerpc/include/asm/mce.h           |  2 +-
 arch/powerpc/kernel/exceptions-64s.S     |  2 +-
 arch/powerpc/kernel/mce.c                |  6 ++-
 arch/powerpc/kernel/mce_power.c          | 87 ++++++++++++++++++++++++++++++--
 5 files changed, 94 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 9a31897..b272052 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -55,6 +55,11 @@
 #endif
 
 /*
+ * maximum recursive depth of MCE exceptions
+ */
+#define MAX_MCE_DEPTH	4
+
+/*
  * EX_LR is only used in EXSLB and where it does not overlap with EX_DAR
  * EX_CCR similarly with DSISR, but being 4 byte registers there is a hole
  * in the save area so it's not necessary to overlap them. Could be used
diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index 75292c7..3a1226e 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -204,7 +204,7 @@ struct mce_error_info {
 
 extern void save_mce_event(struct pt_regs *regs, long handled,
 			   struct mce_error_info *mce_err, uint64_t nip,
-			   uint64_t addr);
+			   uint64_t addr, uint64_t phys_addr);
 extern int get_mce_event(struct machine_check_event *mce, bool release);
 extern void release_mce_event(void);
 extern void machine_check_queue_event(void);
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 48da0f5..3a6c8c8 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -232,7 +232,7 @@ BEGIN_FTR_SECTION
 	addi	r10,r10,1		/* increment paca->in_mce */
 	sth	r10,PACA_IN_MCE(r13)
 	/* Limit nested MCE to level 4 to avoid stack overflow */
-	cmpwi	r10,4
+	cmpwi	r10,MAX_MCE_DEPTH
 	bgt	2f			/* Check if we hit limit of 4 */
 	std	r11,GPR1(r1)		/* Save r1 on the stack. */
 	std	r11,0(r1)		/* make stack chain pointer */
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index fef1408..ee148f4 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -82,7 +82,7 @@ static void mce_set_error_info(struct machine_check_event *mce,
  */
 void save_mce_event(struct pt_regs *regs, long handled,
 		    struct mce_error_info *mce_err,
-		    uint64_t nip, uint64_t addr)
+		    uint64_t nip, uint64_t addr, uint64_t phys_addr)
 {
 	int index = __this_cpu_inc_return(mce_nest_count) - 1;
 	struct machine_check_event *mce = this_cpu_ptr(&mce_event[index]);
@@ -140,6 +140,10 @@ void save_mce_event(struct pt_regs *regs, long handled,
 	} else if (mce->error_type == MCE_ERROR_TYPE_UE) {
 		mce->u.ue_error.effective_address_provided = true;
 		mce->u.ue_error.effective_address = addr;
+		if (phys_addr != ULONG_MAX) {
+			mce->u.ue_error.physical_address_provided = true;
+			mce->u.ue_error.physical_address = phys_addr;
+		}
 	}
 	return;
 }
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index b76ca19..0e584d5 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -27,6 +27,36 @@
 #include <asm/mmu.h>
 #include <asm/mce.h>
 #include <asm/machdep.h>
+#include <asm/pgtable.h>
+#include <asm/pte-walk.h>
+#include <asm/sstep.h>
+#include <asm/exception-64s.h>
+
+/*
+ * Convert an address related to an mm to a PFN. NOTE: we are in real
+ * mode, we could potentially race with page table updates.
+ */
+static unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
+{
+	pte_t *ptep;
+	unsigned long flags;
+	struct mm_struct *mm;
+
+	if (user_mode(regs))
+		mm = current->mm;
+	else
+		mm = &init_mm;
+
+	local_irq_save(flags);
+	if (mm == current->mm)
+		ptep = find_current_mm_pte(mm->pgd, addr, NULL, NULL);
+	else
+		ptep = find_init_mm_pte(addr, NULL);
+	local_irq_restore(flags);
+	if (!ptep || pte_special(*ptep))
+		return ULONG_MAX;
+	return pte_pfn(*ptep);
+}
 
 static void flush_tlb_206(unsigned int num_sets, unsigned int action)
 {
@@ -421,6 +451,41 @@ static const struct mce_derror_table mce_p9_derror_table[] = {
   MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
 { 0, false, 0, 0, 0, 0 } };
 
+static int mce_find_instr_ea_and_pfn(struct pt_regs *regs, uint64_t *addr,
+					uint64_t *phys_addr)
+{
+	/*
+	 * Carefully look at the NIP to determine
+	 * the instruction to analyse. Reading the NIP
+	 * in real-mode is tricky and can lead to recursive
+	 * faults
+	 */
+	int instr;
+	unsigned long pfn, instr_addr;
+	struct instruction_op op;
+	struct pt_regs tmp = *regs;
+
+	pfn = addr_to_pfn(regs, regs->nip);
+	if (pfn != ULONG_MAX) {
+		instr_addr = (pfn << PAGE_SHIFT) + (regs->nip & ~PAGE_MASK);
+		instr = *(unsigned int *)(instr_addr);
+		if (!analyse_instr(&op, &tmp, instr)) {
+			pfn = addr_to_pfn(regs, op.ea);
+			*addr = op.ea;
+			*phys_addr = (pfn << PAGE_SHIFT);
+			return 0;
+		}
+		/*
+		 * analyse_instr() might fail if the instruction
+		 * is not a load/store, although this is unexpected
+		 * for load/store errors or if we got the NIP
+		 * wrong
+		 */
+	}
+	*addr = 0;
+	return -1;
+}
+
 static int mce_handle_ierror(struct pt_regs *regs,
 		const struct mce_ierror_table table[],
 		struct mce_error_info *mce_err, uint64_t *addr)
@@ -489,7 +554,8 @@ static int mce_handle_ierror(struct pt_regs *regs,
 
 static int mce_handle_derror(struct pt_regs *regs,
 		const struct mce_derror_table table[],
-		struct mce_error_info *mce_err, uint64_t *addr)
+		struct mce_error_info *mce_err, uint64_t *addr,
+		uint64_t *phys_addr)
 {
 	uint64_t dsisr = regs->dsisr;
 	int handled = 0;
@@ -555,7 +621,17 @@ static int mce_handle_derror(struct pt_regs *regs,
 		mce_err->initiator = table[i].initiator;
 		if (table[i].dar_valid)
 			*addr = regs->dar;
-
+		else if (mce_err->severity == MCE_SEV_ERROR_SYNC &&
+				table[i].error_type == MCE_ERROR_TYPE_UE) {
+			/*
+			 * We do a maximum of 4 nested MCE calls, see
+			 * kernel/exception-64s.h
+			 */
+			if (get_paca()->in_mce < MAX_MCE_DEPTH)
+				if (!mce_find_instr_ea_and_pfn(regs, addr,
+								phys_addr))
+					handled = 1;
+		}
 		found = 1;
 	}
 
@@ -592,19 +668,20 @@ static long mce_handle_error(struct pt_regs *regs,
 		const struct mce_ierror_table itable[])
 {
 	struct mce_error_info mce_err = { 0 };
-	uint64_t addr;
+	uint64_t addr, phys_addr;
 	uint64_t srr1 = regs->msr;
 	long handled;
 
 	if (SRR1_MC_LOADSTORE(srr1))
-		handled = mce_handle_derror(regs, dtable, &mce_err, &addr);
+		handled = mce_handle_derror(regs, dtable, &mce_err, &addr,
+				&phys_addr);
 	else
 		handled = mce_handle_ierror(regs, itable, &mce_err, &addr);
 
 	if (!handled && mce_err.error_type == MCE_ERROR_TYPE_UE)
 		handled = mce_handle_ue_error(regs);
 
-	save_mce_event(regs, handled, &mce_err, regs->nip, addr);
+	save_mce_event(regs, handled, &mce_err, regs->nip, addr, phys_addr);
 
 	return handled;
 }
-- 
2.9.5
