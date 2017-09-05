Return-Path: <srs0=cfcn=ag=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmYLR3hzQzDrCc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 14:16:15 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xmYLR1N8Sz8t2N
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 14:16:15 +1000 (AEST)
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xmYLQ3PyCz9s9Y
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Sep 2017 14:16:14 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id m1so1109705pfk.0
 for <linuxppc-dev@ozlabs.org>; Mon, 04 Sep 2017 21:16:14 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: npiggin@gmail.com,
	mahesh@linux.vnet.ibm.com,
	alistair@popple.id.au
Cc: linuxppc-dev@ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [rfc 2/3] powerpc/mce: Extract physical_address for UE errors
Date: Tue,  5 Sep 2017 14:15:54 +1000
Message-Id: <20170905041555.27696-3-bsingharora@gmail.com>
In-Reply-To: <20170905041555.27696-1-bsingharora@gmail.com>
References: <20170905041555.27696-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Walk the page table for NIP and extract the instruction. Then
use the instruction to find the effective address via analyse_instr().

We might have page table walking races, but we expect them to
be rare, the physical address extraction is best effort. The idea
is to then hook up this infrastructure to memory failure eventually.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/mce.h  |  2 +-
 arch/powerpc/kernel/mce.c       |  6 ++++-
 arch/powerpc/kernel/mce_power.c | 60 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 61 insertions(+), 7 deletions(-)

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
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index e254399..f41a75d 100644
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
index b76ca19..b77a698 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -27,6 +27,25 @@
 #include <asm/mmu.h>
 #include <asm/mce.h>
 #include <asm/machdep.h>
+#include <asm/pgtable.h>
+#include <asm/pte-walk.h>
+#include <asm/sstep.h>
+
+static unsigned long addr_to_pfn(struct mm_struct *mm, unsigned long addr)
+{
+	pte_t *ptep;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (mm == current->mm)
+		ptep = find_current_mm_pte(mm->pgd, addr, NULL, NULL);
+	else
+		ptep = find_init_mm_pte(addr, NULL);
+	local_irq_restore(flags);
+	if (!ptep)
+		return ULONG_MAX;
+	return pte_pfn(*ptep);
+}
 
 static void flush_tlb_206(unsigned int num_sets, unsigned int action)
 {
@@ -489,7 +508,8 @@ static int mce_handle_ierror(struct pt_regs *regs,
 
 static int mce_handle_derror(struct pt_regs *regs,
 		const struct mce_derror_table table[],
-		struct mce_error_info *mce_err, uint64_t *addr)
+		struct mce_error_info *mce_err, uint64_t *addr,
+		uint64_t *phys_addr)
 {
 	uint64_t dsisr = regs->dsisr;
 	int handled = 0;
@@ -555,7 +575,37 @@ static int mce_handle_derror(struct pt_regs *regs,
 		mce_err->initiator = table[i].initiator;
 		if (table[i].dar_valid)
 			*addr = regs->dar;
-
+		else if (mce_err->severity == MCE_SEV_ERROR_SYNC &&
+				table[i].error_type == MCE_ERROR_TYPE_UE) {
+			/*
+			 * Carefully look at the NIP to determine
+			 * the instruction to analyse. Reading the NIP
+			 * in real-mode is tricky and can lead to recursive
+			 * faults
+			 */
+			int instr;
+			struct mm_struct *mm;
+			unsigned long nip = regs->nip;
+			unsigned long pfn = 0, instr_addr;
+			struct instruction_op op;
+			struct pt_regs tmp = *regs;
+
+			if (user_mode(regs))
+				mm = current->mm;
+			else
+				mm = &init_mm;
+
+			pfn = addr_to_pfn(mm, nip);
+			if (pfn != ULONG_MAX) {
+				instr_addr = (pfn << PAGE_SHIFT) + (nip & ~PAGE_MASK);
+				instr = *(unsigned int *)(instr_addr);
+				if (!analyse_instr(&op, &tmp, instr)) {
+					pfn = addr_to_pfn(mm, op.ea);
+					*addr = op.ea;
+					*phys_addr = pfn;
+				}
+			}
+		}
 		found = 1;
 	}
 
@@ -592,19 +642,19 @@ static long mce_handle_error(struct pt_regs *regs,
 		const struct mce_ierror_table itable[])
 {
 	struct mce_error_info mce_err = { 0 };
-	uint64_t addr;
+	uint64_t addr, phys_addr;
 	uint64_t srr1 = regs->msr;
 	long handled;
 
 	if (SRR1_MC_LOADSTORE(srr1))
-		handled = mce_handle_derror(regs, dtable, &mce_err, &addr);
+		handled = mce_handle_derror(regs, dtable, &mce_err, &addr, &phys_addr);
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
