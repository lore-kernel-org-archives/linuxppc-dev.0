Return-Path: <mihai.caraman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD67A1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 00:45:44 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [RFC PATCH 3/4] KVM: PPC: e500: TLB emulation for IND entries
Date: Thu, 3 Jul 2014 17:45:26 +0300
Message-ID: <1404398727-12844-4-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1404398727-12844-1-git-send-email-mihai.caraman@freescale.com>
References: <1404398727-12844-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Handle indirect entries (IND) in TLB emulation code. Translation size of IND
entries differ from the size of referred Page Tables (Linux guests now use IND
of 2MB for 4KB PTs) and this require careful tweak of the existing logic.

TLB search emulation requires additional search in HW TLB0 (since these entries
are directly added by HTW) and found entries shoud be presented to the guest with
RPN changed from PFN to GFN. There might be more GFNs pointing to the same PFN so
the only way to get the corresponding GFN is to search it in guest's PTE. If IND
entry for the corresponding PT is not available just invalidate guest's ea and
report a tlbsx miss. This patch only implements the invalidation and let a TODO
note for searching HW TLB0.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/include/asm/mmu-book3e.h |  2 +
 arch/powerpc/kvm/e500.h               | 81 ++++++++++++++++++++++++++++-------
 arch/powerpc/kvm/e500_mmu.c           | 78 +++++++++++++++++++++++++++------
 arch/powerpc/kvm/e500_mmu_host.c      | 31 ++++++++++++--
 arch/powerpc/kvm/e500mc.c             | 53 +++++++++++++++++++++--
 5 files changed, 211 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index ac6acf7..e482ad8 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -59,6 +59,7 @@
 #define MAS1_IPROT		0x40000000
 #define MAS1_TID(x)		(((x) << 16) & 0x3FFF0000)
 #define MAS1_IND		0x00002000
+#define MAS1_IND_SHIFT		13
 #define MAS1_TS			0x00001000
 #define MAS1_TSIZE_MASK		0x00000f80
 #define MAS1_TSIZE_SHIFT	7
@@ -94,6 +95,7 @@
 #define MAS4_TLBSEL_MASK	MAS0_TLBSEL_MASK
 #define MAS4_TLBSELD(x) 	MAS0_TLBSEL(x)
 #define MAS4_INDD		0x00008000	/* Default IND */
+#define MAS4_INDD_SHIFT		15
 #define MAS4_TSIZED(x)		MAS1_TSIZE(x)
 #define MAS4_X0D		0x00000040
 #define MAS4_X1D		0x00000020
diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index a326178..70a556d 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -148,6 +148,22 @@ unsigned int kvmppc_e500_get_sid(struct kvmppc_vcpu_e500 *vcpu_e500,
 				 unsigned int pr, int avoid_recursion);
 #endif
 
+static inline bool has_feature(const struct kvm_vcpu *vcpu,
+			       enum vcpu_ftr ftr)
+{
+	bool has_ftr;
+
+	switch (ftr) {
+	case VCPU_FTR_MMU_V2:
+		has_ftr = ((vcpu->arch.mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V2);
+		break;
+
+	default:
+		return false;
+	}
+	return has_ftr;
+}
+
 /* TLB helper functions */
 static inline unsigned int
 get_tlb_size(const struct kvm_book3e_206_tlb_entry *tlbe)
@@ -207,6 +223,16 @@ get_tlb_tsize(const struct kvm_book3e_206_tlb_entry *tlbe)
 	return (tlbe->mas1 & MAS1_TSIZE_MASK) >> MAS1_TSIZE_SHIFT;
 }
 
+static inline unsigned int
+get_tlb_ind(const struct kvm_vcpu *vcpu,
+	    const struct kvm_book3e_206_tlb_entry *tlbe)
+{
+	if (has_feature(vcpu, VCPU_FTR_MMU_V2))
+		return (tlbe->mas1 & MAS1_IND) >> MAS1_IND_SHIFT;
+
+	return 0;
+}
+
 static inline unsigned int get_cur_pid(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.pid & 0xff;
@@ -232,6 +258,30 @@ static inline unsigned int get_cur_sas(const struct kvm_vcpu *vcpu)
 	return vcpu->arch.shared->mas6 & 0x1;
 }
 
+static inline unsigned int get_cur_ind(const struct kvm_vcpu *vcpu)
+{
+	if (has_feature(vcpu, VCPU_FTR_MMU_V2))
+		return (vcpu->arch.shared->mas1 & MAS1_IND) >> MAS1_IND_SHIFT;
+
+	return 0;
+}
+
+static inline unsigned int get_cur_indd(const struct kvm_vcpu *vcpu)
+{
+	if (has_feature(vcpu, VCPU_FTR_MMU_V2))
+		return (vcpu->arch.shared->mas4 & MAS4_INDD) >> MAS4_INDD_SHIFT;
+
+	return 0;
+}
+
+static inline unsigned int get_cur_sind(const struct kvm_vcpu *vcpu)
+{
+	if (has_feature(vcpu, VCPU_FTR_MMU_V2))
+		return (vcpu->arch.shared->mas6 & MAS6_SIND) >> MAS6_SIND_SHIFT;
+
+	return 0;
+}
+
 static inline unsigned int get_tlb_tlbsel(const struct kvm_vcpu *vcpu)
 {
 	/*
@@ -286,6 +336,22 @@ void kvmppc_e500_tlbil_one(struct kvmppc_vcpu_e500 *vcpu_e500,
 void kvmppc_e500_tlbil_all(struct kvmppc_vcpu_e500 *vcpu_e500);
 
 #ifdef CONFIG_KVM_BOOKE_HV
+void inval_tlb_on_host(struct kvm_vcpu *vcpu, int type, int pid);
+
+void inval_ea_on_host(struct kvm_vcpu *vcpu, gva_t ea, int pid, int sas,
+		      int sind);
+#else
+/* TLB is fully virtualized */
+static inline void inval_tlb_on_host(struct kvm_vcpu *vcpu,
+				     int type, int pid)
+{}
+
+static inline void inval_ea_on_host(struct kvm_vcpu *vcpu, gva_t ea, int pid,
+				    int sas, int sind)
+{}
+#endif
+
+#ifdef CONFIG_KVM_BOOKE_HV
 #define kvmppc_e500_get_tlb_stid(vcpu, gtlbe)       get_tlb_tid(gtlbe)
 #define get_tlbmiss_tid(vcpu)           get_cur_pid(vcpu)
 #define get_tlb_sts(gtlbe)              (gtlbe->mas1 & MAS1_TS)
@@ -304,19 +370,4 @@ static inline unsigned int get_tlbmiss_tid(struct kvm_vcpu *vcpu)
 /* Force TS=1 for all guest mappings. */
 #define get_tlb_sts(gtlbe)              (MAS1_TS)
 #endif /* !BOOKE_HV */
-
-static inline bool has_feature(const struct kvm_vcpu *vcpu,
-			       enum vcpu_ftr ftr)
-{
-	bool has_ftr;
-	switch (ftr) {
-	case VCPU_FTR_MMU_V2:
-		has_ftr = ((vcpu->arch.mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V2);
-		break;
-	default:
-		return false;
-	}
-	return has_ftr;
-}
-
 #endif /* KVM_E500_H */
diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index 50860e9..b775e6a 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -81,7 +81,8 @@ static unsigned int get_tlb_esel(struct kvm_vcpu *vcpu, int tlbsel)
 
 /* Search the guest TLB for a matching entry. */
 static int kvmppc_e500_tlb_index(struct kvmppc_vcpu_e500 *vcpu_e500,
-		gva_t eaddr, int tlbsel, unsigned int pid, int as)
+		gva_t eaddr, int tlbsel, unsigned int pid, int as,
+		int sind)
 {
 	int size = vcpu_e500->gtlb_params[tlbsel].entries;
 	unsigned int set_base, offset;
@@ -120,6 +121,9 @@ static int kvmppc_e500_tlb_index(struct kvmppc_vcpu_e500 *vcpu_e500,
 		if (get_tlb_ts(tlbe) != as && as != -1)
 			continue;
 
+		if (sind != -1 && get_tlb_ind(&vcpu_e500->vcpu, tlbe) != sind)
+			continue;
+
 		return set_base + i;
 	}
 
@@ -130,25 +134,28 @@ static inline void kvmppc_e500_deliver_tlb_miss(struct kvm_vcpu *vcpu,
 		gva_t eaddr, int as)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
-	unsigned int victim, tsized;
+	unsigned int victim, tsized, indd;
 	int tlbsel;
 
 	/* since we only have two TLBs, only lower bit is used. */
 	tlbsel = (vcpu->arch.shared->mas4 >> 28) & 0x1;
 	victim = (tlbsel == 0) ? gtlb0_get_next_victim(vcpu_e500) : 0;
 	tsized = (vcpu->arch.shared->mas4 >> 7) & 0x1f;
+	indd = get_cur_indd(vcpu);
 
 	vcpu->arch.shared->mas0 = MAS0_TLBSEL(tlbsel) | MAS0_ESEL(victim)
 		| MAS0_NV(vcpu_e500->gtlb_nv[tlbsel]);
 	vcpu->arch.shared->mas1 = MAS1_VALID | (as ? MAS1_TS : 0)
 		| MAS1_TID(get_tlbmiss_tid(vcpu))
-		| MAS1_TSIZE(tsized);
+		| MAS1_TSIZE(tsized)
+		| (indd << MAS1_IND_SHIFT);
 	vcpu->arch.shared->mas2 = (eaddr & MAS2_EPN)
 		| (vcpu->arch.shared->mas4 & MAS2_ATTRIB_MASK);
 	vcpu->arch.shared->mas7_3 &= MAS3_U0 | MAS3_U1 | MAS3_U2 | MAS3_U3;
 	vcpu->arch.shared->mas6 = (vcpu->arch.shared->mas6 & MAS6_SPID1)
 		| (get_cur_pid(vcpu) << 16)
-		| (as ? MAS6_SAS : 0);
+		| (as ? MAS6_SAS : 0)
+		| (indd << MAS6_SIND_SHIFT);
 }
 
 static void kvmppc_recalc_tlb1map_range(struct kvmppc_vcpu_e500 *vcpu_e500)
@@ -264,12 +271,12 @@ int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *vcpu, gva_t ea)
 	} else {
 		ea &= 0xfffff000;
 		esel = kvmppc_e500_tlb_index(vcpu_e500, ea, tlbsel,
-				get_cur_pid(vcpu), -1);
+				get_cur_pid(vcpu), -1, get_cur_sind(vcpu));
 		if (esel >= 0)
 			kvmppc_e500_gtlbe_invalidate(vcpu_e500, tlbsel, esel);
 	}
 
-	/* Invalidate all host shadow mappings */
+	/* Invalidate all host shadow mappings including those set by HTW */
 	kvmppc_core_flush_tlb(&vcpu_e500->vcpu);
 
 	return EMULATE_DONE;
@@ -280,6 +287,7 @@ static void tlbilx_all(struct kvmppc_vcpu_e500 *vcpu_e500, int tlbsel,
 {
 	struct kvm_book3e_206_tlb_entry *tlbe;
 	int tid, esel;
+	int sind = get_cur_sind(&vcpu_e500->vcpu);
 
 	/* invalidate all entries */
 	for (esel = 0; esel < vcpu_e500->gtlb_params[tlbsel].entries; esel++) {
@@ -290,21 +298,32 @@ static void tlbilx_all(struct kvmppc_vcpu_e500 *vcpu_e500, int tlbsel,
 			kvmppc_e500_gtlbe_invalidate(vcpu_e500, tlbsel, esel);
 		}
 	}
+
+	/* Invalidate enties added by HTW */
+	if (has_feature(&vcpu_e500->vcpu, VCPU_FTR_MMU_V2) && (!sind))
+		inval_tlb_on_host(&vcpu_e500->vcpu, type, pid);
 }
 
 static void tlbilx_one(struct kvmppc_vcpu_e500 *vcpu_e500, int pid,
 		       gva_t ea)
 {
 	int tlbsel, esel;
+	int sas = get_cur_sas(&vcpu_e500->vcpu);
+	int sind = get_cur_sind(&vcpu_e500->vcpu);
 
 	for (tlbsel = 0; tlbsel < 2; tlbsel++) {
-		esel = kvmppc_e500_tlb_index(vcpu_e500, ea, tlbsel, pid, -1);
+		esel = kvmppc_e500_tlb_index(vcpu_e500, ea, tlbsel, pid, -1,
+					     sind);
 		if (esel >= 0) {
 			inval_gtlbe_on_host(vcpu_e500, tlbsel, esel);
 			kvmppc_e500_gtlbe_invalidate(vcpu_e500, tlbsel, esel);
 			break;
 		}
 	}
+
+	/* Invalidate enties added by HTW */
+	if (has_feature(&vcpu_e500->vcpu, VCPU_FTR_MMU_V2) && (!sind))
+		inval_ea_on_host(&vcpu_e500->vcpu, ea, pid, sas, sind);
 }
 
 int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int type, gva_t ea)
@@ -350,7 +369,8 @@ int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *vcpu, gva_t ea)
 	struct kvm_book3e_206_tlb_entry *gtlbe = NULL;
 
 	for (tlbsel = 0; tlbsel < 2; tlbsel++) {
-		esel = kvmppc_e500_tlb_index(vcpu_e500, ea, tlbsel, pid, as);
+		esel = kvmppc_e500_tlb_index(vcpu_e500, ea, tlbsel, pid, as,
+					     get_cur_sind(vcpu));
 		if (esel >= 0) {
 			gtlbe = get_entry(vcpu_e500, tlbsel, esel);
 			break;
@@ -368,6 +388,23 @@ int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *vcpu, gva_t ea)
 	} else {
 		int victim;
 
+		if (has_feature(vcpu, VCPU_FTR_MMU_V2) &&
+			get_cur_sind(vcpu) != 1) {
+			/*
+			 * TLB0 entries are not cached in KVM being written
+			 * directly by HTW. TLB0 entry found in HW TLB0 needs
+			 * to be presented to the guest with RPN changed from
+			 * PFN to GFN. There might be more GFNs pointing to the
+			 * same PFN so the only way to get the corresponding GFN
+			 * is to search it in guest's PTE. If IND entry for the
+			 * corresponding PT is not available just invalidate
+			 * guest's ea and report a tlbsx miss.
+			 *
+			 * TODO: search ea in HW TLB0
+			 */
+			inval_ea_on_host(vcpu, ea, pid, as, 0);
+		}
+
 		/* since we only have two TLBs, only lower bit is used. */
 		tlbsel = vcpu->arch.shared->mas4 >> 28 & 0x1;
 		victim = (tlbsel == 0) ? gtlb0_get_next_victim(vcpu_e500) : 0;
@@ -378,7 +415,8 @@ int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *vcpu, gva_t ea)
 		vcpu->arch.shared->mas1 =
 			  (vcpu->arch.shared->mas6 & MAS6_SPID0)
 			| (vcpu->arch.shared->mas6 & (MAS6_SAS ? MAS1_TS : 0))
-			| (vcpu->arch.shared->mas4 & MAS4_TSIZED(~0));
+			| (vcpu->arch.shared->mas4 & MAS4_TSIZED(~0))
+			| (get_cur_indd(vcpu) << MAS1_IND_SHIFT);
 		vcpu->arch.shared->mas2 &= MAS2_EPN;
 		vcpu->arch.shared->mas2 |= vcpu->arch.shared->mas4 &
 					   MAS2_ATTRIB_MASK;
@@ -396,7 +434,7 @@ int kvmppc_e500_emul_tlbwe(struct kvm_vcpu *vcpu)
 	struct kvm_book3e_206_tlb_entry *gtlbe;
 	int tlbsel, esel;
 	int recal = 0;
-	int idx;
+	int idx, tsize;
 
 	tlbsel = get_tlb_tlbsel(vcpu);
 	esel = get_tlb_esel(vcpu, tlbsel);
@@ -411,9 +449,17 @@ int kvmppc_e500_emul_tlbwe(struct kvm_vcpu *vcpu)
 	}
 
 	gtlbe->mas1 = vcpu->arch.shared->mas1;
+
 	gtlbe->mas2 = vcpu->arch.shared->mas2;
+	/* EPN offset bits should be zero, fix early versions of Linux HTW */
+	if (get_cur_ind(vcpu)) {
+		tsize = (vcpu->arch.shared->mas1 & MAS1_TSIZE_MASK) >>
+			MAS1_TSIZE_SHIFT;
+		gtlbe->mas2 &= MAS2_EPN_MASK(tsize) | (~MAS2_EPN);
+	}
 	if (!(vcpu->arch.shared->msr & MSR_CM))
 		gtlbe->mas2 &= 0xffffffffUL;
+
 	gtlbe->mas7_3 = vcpu->arch.shared->mas7_3;
 
 	trace_kvm_booke206_gtlb_write(vcpu->arch.shared->mas0, gtlbe->mas1,
@@ -460,7 +506,8 @@ static int kvmppc_e500_tlb_search(struct kvm_vcpu *vcpu,
 	int esel, tlbsel;
 
 	for (tlbsel = 0; tlbsel < 2; tlbsel++) {
-		esel = kvmppc_e500_tlb_index(vcpu_e500, eaddr, tlbsel, pid, as);
+		esel = kvmppc_e500_tlb_index(vcpu_e500, eaddr, tlbsel, pid, as,
+					     -1);
 		if (esel >= 0)
 			return index_of(tlbsel, esel);
 	}
@@ -531,7 +578,14 @@ gpa_t kvmppc_mmu_xlate(struct kvm_vcpu *vcpu, unsigned int index,
 	u64 pgmask;
 
 	gtlbe = get_entry(vcpu_e500, tlbsel_of(index), esel_of(index));
-	pgmask = get_tlb_bytes(gtlbe) - 1;
+	/*
+	 * Use 4095 for page mask for IND enties:
+	 *	(1ULL << (10 + BOOK3E_PAGESZ_4K)) - 1
+	 */
+	if (get_tlb_ind(vcpu, gtlbe))
+		pgmask = 4095;
+	else
+		pgmask = get_tlb_bytes(gtlbe) - 1;
 
 	return get_tlb_raddr(gtlbe) | (eaddr & pgmask);
 }
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index be1454b..60bf272 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -438,7 +438,8 @@ static void kvmppc_e500_setup_stlbe(
 	BUG_ON(!(ref->flags & E500_TLB_VALID));
 
 	/* Force IPROT=0 for all guest mappings. */
-	stlbe->mas1 = MAS1_TSIZE(tsize) | get_tlb_sts(gtlbe) | MAS1_VALID;
+	stlbe->mas1 = MAS1_TSIZE(tsize) | get_tlb_sts(gtlbe) | MAS1_VALID |
+		      (get_tlb_ind(vcpu, gtlbe) << MAS1_IND_SHIFT);
 	stlbe->mas2 = (gvaddr & MAS2_EPN) | (ref->flags & E500_TLB_MAS2_ATTR);
 	stlbe->mas7_3 = ((u64)pfn << PAGE_SHIFT) |
 			e500_shadow_mas3_attrib(gtlbe->mas7_3, pr);
@@ -465,6 +466,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	pte_t *ptep;
 	unsigned int wimg = 0;
 	pgd_t *pgdir;
+	int ind;
 
 	/* used to check for invalidations in progress */
 	mmu_seq = kvm->mmu_notifier_seq;
@@ -481,6 +483,15 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	slot = gfn_to_memslot(vcpu_e500->vcpu.kvm, gfn);
 	hva = gfn_to_hva_memslot(slot, gfn);
 
+	/*
+	 * An IND entry refer a Page Table which have a different size
+	 * then the translation size.
+	 *	page size bytes = (tsize bytes / 4KB) * 8 bytes
+	 * so we have
+	 *	psize = tsize - BOOK3E_PAGESZ_4K - 7;
+	 */
+	ind = get_tlb_ind(&vcpu_e500->vcpu, gtlbe);
+
 	if (tlbsel == 1) {
 		struct vm_area_struct *vma;
 		down_read(&current->mm->mmap_sem);
@@ -516,12 +527,17 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 
 			tsize = (gtlbe->mas1 & MAS1_TSIZE_MASK) >>
 				MAS1_TSIZE_SHIFT;
+			if (ind)
+				tsize -= BOOK3E_PAGESZ_4K + 7;
 
 			/*
 			 * e500 doesn't implement the lowest tsize bit,
 			 * or 1K pages.
 			 */
-			tsize = max(BOOK3E_PAGESZ_4K, tsize & ~1);
+			if (!has_feature(&vcpu_e500->vcpu, VCPU_FTR_MMU_V2))
+				tsize &= ~1;
+
+			tsize = max(BOOK3E_PAGESZ_4K, tsize);
 
 			/*
 			 * Now find the largest tsize (up to what the guest
@@ -555,6 +571,8 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 
 			tsize = (gtlbe->mas1 & MAS1_TSIZE_MASK) >>
 				MAS1_TSIZE_SHIFT;
+			if (ind)
+				tsize -= BOOK3E_PAGESZ_4K + 7;
 
 			/*
 			 * Take the largest page size that satisfies both host
@@ -566,7 +584,10 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 			 * e500 doesn't implement the lowest tsize bit,
 			 * or 1K pages.
 			 */
-			tsize = max(BOOK3E_PAGESZ_4K, tsize & ~1);
+			if (!has_feature(&vcpu_e500->vcpu, VCPU_FTR_MMU_V2))
+				tsize &= ~1;
+
+			tsize = max(BOOK3E_PAGESZ_4K, tsize);
 		}
 
 		up_read(&current->mm->mmap_sem);
@@ -606,6 +627,10 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	}
 	kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
 
+	/* Restore translation size for indirect entries */
+	if (ind)
+		tsize += BOOK3E_PAGESZ_4K + 7;
+
 	kvmppc_e500_setup_stlbe(&vcpu_e500->vcpu, gtlbe, tsize,
 				ref, gvaddr, stlbe);
 
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index 5622d9a..933a4cf 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -58,7 +58,7 @@ void kvmppc_set_pending_interrupt(struct kvm_vcpu *vcpu, enum int_class type)
 void kvmppc_e500_tlbil_one(struct kvmppc_vcpu_e500 *vcpu_e500,
 			   struct kvm_book3e_206_tlb_entry *gtlbe)
 {
-	unsigned int tid, ts;
+	unsigned int tid, ts, ind;
 	gva_t eaddr;
 	u32 val, lpid;
 	unsigned long flags;
@@ -66,9 +66,10 @@ void kvmppc_e500_tlbil_one(struct kvmppc_vcpu_e500 *vcpu_e500,
 	ts = get_tlb_ts(gtlbe);
 	tid = get_tlb_tid(gtlbe);
 	lpid = vcpu_e500->vcpu.kvm->arch.lpid;
+	ind = get_tlb_ind(&vcpu_e500->vcpu, gtlbe);
 
 	/* We search the host TLB to invalidate its shadow TLB entry */
-	val = (tid << 16) | ts;
+	val = (tid << 16) | ts | (ind << MAS6_SIND_SHIFT);
 	eaddr = get_tlb_eaddr(gtlbe);
 
 	local_irq_save(flags);
@@ -90,16 +91,60 @@ void kvmppc_e500_tlbil_one(struct kvmppc_vcpu_e500 *vcpu_e500,
 	local_irq_restore(flags);
 }
 
-void kvmppc_e500_tlbil_all(struct kvmppc_vcpu_e500 *vcpu_e500)
+void inval_ea_on_host(struct kvm_vcpu *vcpu, gva_t ea, int pid, int sas,
+		      int sind)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	mtspr(SPRN_MAS5, MAS5_SGS | vcpu->kvm->arch.lpid);
+	mtspr(SPRN_MAS6, (pid << MAS6_SPID_SHIFT) |
+		sas | (sind << MAS6_SIND_SHIFT));
+	asm volatile("tlbilx 3, 0, %[ea]\n" : : [ea] "r" (ea));
+	mtspr(SPRN_MAS5, 0);
+	isync();
+
+	local_irq_restore(flags);
+}
+
+void kvmppc_e500_tlbil_pid(struct kvm_vcpu *vcpu, int pid)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	mtspr(SPRN_MAS5, MAS5_SGS | vcpu->kvm->arch.lpid);
+	mtspr(SPRN_MAS6, pid << MAS6_SPID_SHIFT);
+	asm volatile("tlbilxpid");
+	mtspr(SPRN_MAS5, 0);
+	isync();
+
+	local_irq_restore(flags);
+}
+
+void kvmppc_e500_tlbil_lpid(struct kvm_vcpu *vcpu)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
-	mtspr(SPRN_MAS5, MAS5_SGS | vcpu_e500->vcpu.kvm->arch.lpid);
+	mtspr(SPRN_MAS5, MAS5_SGS | vcpu->kvm->arch.lpid);
 	asm volatile("tlbilxlpid");
 	mtspr(SPRN_MAS5, 0);
+	isync();
+
 	local_irq_restore(flags);
+}
 
+void inval_tlb_on_host(struct kvm_vcpu *vcpu, int type, int pid)
+{
+	if (type == 0)
+		kvmppc_e500_tlbil_lpid(vcpu);
+	else
+		kvmppc_e500_tlbil_pid(vcpu, pid);
+}
+
+void kvmppc_e500_tlbil_all(struct kvmppc_vcpu_e500 *vcpu_e500)
+{
+	kvmppc_e500_tlbil_lpid(&vcpu_e500->vcpu);
 	kvmppc_lrat_invalidate(&vcpu_e500->vcpu);
 }
 
-- 
1.7.11.7
