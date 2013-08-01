Return-Path: <R65777@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F047F2C02C4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 21:18:23 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <benh@kernel.crashing.org>, <agraf@suse.de>, <kvm-ppc@vger.kernel.org>,
 <kvm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <scottwood@freescale.com>
Subject: [PATCH 6/6 v2] kvm: powerpc: use caching attributes as per linux pte
Date: Thu, 1 Aug 2013 16:42:38 +0530
Message-ID: <1375355558-19187-7-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1375355558-19187-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1375355558-19187-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

KVM uses same WIM tlb attributes as the corresponding qemu pte.
For this we now search the linux pte for the requested page and
get these cache caching/coherency attributes from pte.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
v1->v2
 - Use Linux pte for wimge rather than RAM/no-RAM mechanism

 arch/powerpc/include/asm/kvm_host.h |    2 +-
 arch/powerpc/kvm/booke.c            |    2 +-
 arch/powerpc/kvm/e500.h             |    8 +++++---
 arch/powerpc/kvm/e500_mmu_host.c    |   31 ++++++++++++++++++-------------
 4 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 3328353..583d405 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -535,6 +535,7 @@ struct kvm_vcpu_arch {
 #endif
 	gpa_t paddr_accessed;
 	gva_t vaddr_accessed;
+	pgd_t *pgdir;
 
 	u8 io_gpr; /* GPR used as IO source/target */
 	u8 mmio_is_bigendian;
@@ -592,7 +593,6 @@ struct kvm_vcpu_arch {
 	struct list_head run_list;
 	struct task_struct *run_task;
 	struct kvm_run *kvm_run;
-	pgd_t *pgdir;
 
 	spinlock_t vpa_update_lock;
 	struct kvmppc_vpa vpa;
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 17722d8..ebcccc2 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -697,7 +697,7 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 #endif
 
 	kvmppc_fix_ee_before_entry();
-
+	vcpu->arch.pgdir = current->mm->pgd;
 	ret = __kvmppc_vcpu_run(kvm_run, vcpu);
 
 	/* No need for kvm_guest_exit. It's done in handle_exit.
diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index 4fd9650..fc4b2f6 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -31,11 +31,13 @@ enum vcpu_ftr {
 #define E500_TLB_NUM   2
 
 /* entry is mapped somewhere in host TLB */
-#define E500_TLB_VALID		(1 << 0)
+#define E500_TLB_VALID		(1 << 31)
 /* TLB1 entry is mapped by host TLB1, tracked by bitmaps */
-#define E500_TLB_BITMAP		(1 << 1)
+#define E500_TLB_BITMAP		(1 << 30)
 /* TLB1 entry is mapped by host TLB0 */
-#define E500_TLB_TLB0		(1 << 2)
+#define E500_TLB_TLB0		(1 << 29)
+/* Lower 5 bits have WIMGE value */
+#define E500_TLB_WIMGE_MASK	(0x1f)
 
 struct tlbe_ref {
 	pfn_t pfn;		/* valid only for TLB0, except briefly */
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index 1c6a9d7..9b10b0b 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -64,15 +64,6 @@ static inline u32 e500_shadow_mas3_attrib(u32 mas3, int usermode)
 	return mas3;
 }
 
-static inline u32 e500_shadow_mas2_attrib(u32 mas2, int usermode)
-{
-#ifdef CONFIG_SMP
-	return (mas2 & MAS2_ATTRIB_MASK) | MAS2_M;
-#else
-	return mas2 & MAS2_ATTRIB_MASK;
-#endif
-}
-
 /*
  * writing shadow tlb entry to host TLB
  */
@@ -248,10 +239,12 @@ static inline int tlbe_is_writable(struct kvm_book3e_206_tlb_entry *tlbe)
 
 static inline void kvmppc_e500_ref_setup(struct tlbe_ref *ref,
 					 struct kvm_book3e_206_tlb_entry *gtlbe,
-					 pfn_t pfn)
+					 pfn_t pfn, int wimg)
 {
 	ref->pfn = pfn;
 	ref->flags |= E500_TLB_VALID;
+	/* Use guest supplied MAS2_G and MAS2_E */
+	ref->flags |= (gtlbe->mas2 & MAS2_ATTRIB_MASK) | wimg;
 
 	if (tlbe_is_writable(gtlbe))
 		kvm_set_pfn_dirty(pfn);
@@ -312,8 +305,7 @@ static void kvmppc_e500_setup_stlbe(
 
 	/* Force IPROT=0 for all guest mappings. */
 	stlbe->mas1 = MAS1_TSIZE(tsize) | get_tlb_sts(gtlbe) | MAS1_VALID;
-	stlbe->mas2 = (gvaddr & MAS2_EPN) |
-		      e500_shadow_mas2_attrib(gtlbe->mas2, pr);
+	stlbe->mas2 = (gvaddr & MAS2_EPN) | (ref->flags & E500_TLB_WIMGE_MASK);
 	stlbe->mas7_3 = ((u64)pfn << PAGE_SHIFT) |
 			e500_shadow_mas3_attrib(gtlbe->mas7_3, pr);
 
@@ -332,6 +324,8 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	unsigned long hva;
 	int pfnmap = 0;
 	int tsize = BOOK3E_PAGESZ_4K;
+	pte_t pte;
+	int wimg = 0;
 
 	/*
 	 * Translate guest physical to true physical, acquiring
@@ -437,6 +431,8 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 
 	if (likely(!pfnmap)) {
 		unsigned long tsize_pages = 1 << (tsize + 10 - PAGE_SHIFT);
+		pgd_t *pgdir;
+
 		pfn = gfn_to_pfn_memslot(slot, gfn);
 		if (is_error_noslot_pfn(pfn)) {
 			printk(KERN_ERR "Couldn't get real page for gfn %lx!\n",
@@ -447,9 +443,18 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 		/* Align guest and physical address to page map boundaries */
 		pfn &= ~(tsize_pages - 1);
 		gvaddr &= ~((tsize_pages << PAGE_SHIFT) - 1);
+		pgdir = vcpu_e500->vcpu.arch.pgdir;
+		pte = lookup_linux_pte(pgdir, hva, 1, &tsize_pages);
+		if (pte_present(pte)) {
+			wimg = (pte >> PTE_WIMGE_SHIFT) & MAS2_WIMGE_MASK;
+		} else {
+			printk(KERN_ERR "pte not present: gfn %lx, pfn %lx\n",
+					(long)gfn, pfn);
+			return -EINVAL;
+		}
 	}
 
-	kvmppc_e500_ref_setup(ref, gtlbe, pfn);
+	kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
 
 	kvmppc_e500_setup_stlbe(&vcpu_e500->vcpu, gtlbe, tsize,
 				ref, gvaddr, stlbe);
-- 
1.7.0.4
