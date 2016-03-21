Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qT22p0C4FzDqDW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 14:52:18 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 michael@ellerman.id.au, David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv3 08/17] powerpc/kvm: Gather HPT related variables into
 sub-structure
Date: Mon, 21 Mar 2016 14:53:15 +1100
Message-Id: <1458532404-21258-9-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
References: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the powerpc kvm_arch structure contains a number of variables
tracking the state of the guest's hashed page table (HPT) in KVM HV.  This
patch gathers them all together into a single kvm_hpt_info substructure.
This makes life more convenient for the upcoming HPT resizing
implementation.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/kvm_host.h | 16 ++++---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 90 ++++++++++++++++++-------------------
 arch/powerpc/kvm/book3s_hv.c        |  2 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 62 ++++++++++++-------------
 4 files changed, 87 insertions(+), 83 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index d7b3431..549e3ae 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -226,11 +226,19 @@ struct kvm_arch_memory_slot {
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 };
 
+struct kvm_hpt_info {
+	unsigned long virt;
+	struct revmap_entry *rev;
+	unsigned long npte;
+	unsigned long mask;
+	u32 order;
+	int cma;
+};
+
 struct kvm_arch {
 	unsigned int lpid;
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	unsigned long hpt_virt;
-	struct revmap_entry *revmap;
+	struct kvm_hpt_info hpt;
 	unsigned int host_lpid;
 	unsigned long host_lpcr;
 	unsigned long sdr1;
@@ -239,14 +247,10 @@ struct kvm_arch {
 	unsigned long lpcr;
 	unsigned long vrma_slb_v;
 	int hpte_setup_done;
-	u32 hpt_order;
 	atomic_t vcpus_running;
 	u32 online_vcores;
-	unsigned long hpt_npte;
-	unsigned long hpt_mask;
 	atomic_t hpte_mod_interest;
 	cpumask_t need_tlb_flush;
-	int hpt_cma_alloc;
 	struct dentry *debugfs_dir;
 	struct dentry *htab_dentry;
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 1164ab6..152534c 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -61,12 +61,12 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
 			order = PPC_MIN_HPT_ORDER;
 	}
 
-	kvm->arch.hpt_cma_alloc = 0;
+	kvm->arch.hpt.cma = 0;
 	page = kvm_alloc_hpt_cma(1ul << (order - PAGE_SHIFT));
 	if (page) {
 		hpt = (unsigned long)pfn_to_kaddr(page_to_pfn(page));
 		memset((void *)hpt, 0, (1ul << order));
-		kvm->arch.hpt_cma_alloc = 1;
+		kvm->arch.hpt.cma = 1;
 	}
 
 	/* Lastly try successively smaller sizes from the page allocator */
@@ -81,20 +81,20 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
 	if (!hpt)
 		return -ENOMEM;
 
-	kvm->arch.hpt_virt = hpt;
-	kvm->arch.hpt_order = order;
+	kvm->arch.hpt.virt = hpt;
+	kvm->arch.hpt.order = order;
 	/* HPTEs are 2**4 bytes long */
-	kvm->arch.hpt_npte = 1ul << (order - 4);
+	kvm->arch.hpt.npte = 1ul << (order - 4);
 	/* 128 (2**7) bytes in each HPTEG */
-	kvm->arch.hpt_mask = (1ul << (order - 7)) - 1;
+	kvm->arch.hpt.mask = (1ul << (order - 7)) - 1;
 
 	/* Allocate reverse map array */
-	rev = vmalloc(sizeof(struct revmap_entry) * kvm->arch.hpt_npte);
+	rev = vmalloc(sizeof(struct revmap_entry) * kvm->arch.hpt.npte);
 	if (!rev) {
 		pr_err("kvmppc_alloc_hpt: Couldn't alloc reverse map array\n");
 		goto out_freehpt;
 	}
-	kvm->arch.revmap = rev;
+	kvm->arch.hpt.rev = rev;
 	kvm->arch.sdr1 = __pa(hpt) | (order - 18);
 
 	pr_info("KVM guest htab at %lx (order %ld), LPID %x\n",
@@ -105,7 +105,7 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
 	return 0;
 
  out_freehpt:
-	if (kvm->arch.hpt_cma_alloc)
+	if (kvm->arch.hpt.cma)
 		kvm_free_hpt_cma(page, 1 << (order - PAGE_SHIFT));
 	else
 		free_pages(hpt, order - PAGE_SHIFT);
@@ -127,10 +127,10 @@ long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
 			goto out;
 		}
 	}
-	if (kvm->arch.hpt_virt) {
-		order = kvm->arch.hpt_order;
+	if (kvm->arch.hpt.virt) {
+		order = kvm->arch.hpt.order;
 		/* Set the entire HPT to 0, i.e. invalid HPTEs */
-		memset((void *)kvm->arch.hpt_virt, 0, 1ul << order);
+		memset((void *)kvm->arch.hpt.virt, 0, 1ul << order);
 		/*
 		 * Reset all the reverse-mapping chains for all memslots
 		 */
@@ -151,13 +151,13 @@ long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
 void kvmppc_free_hpt(struct kvm *kvm)
 {
 	kvmppc_free_lpid(kvm->arch.lpid);
-	vfree(kvm->arch.revmap);
-	if (kvm->arch.hpt_cma_alloc)
-		kvm_free_hpt_cma(virt_to_page(kvm->arch.hpt_virt),
-				 1 << (kvm->arch.hpt_order - PAGE_SHIFT));
+	vfree(kvm->arch.hpt.rev);
+	if (kvm->arch.hpt.cma)
+		kvm_free_hpt_cma(virt_to_page(kvm->arch.hpt.virt),
+				 1 << (kvm->arch.hpt.order - PAGE_SHIFT));
 	else
-		free_pages(kvm->arch.hpt_virt,
-			   kvm->arch.hpt_order - PAGE_SHIFT);
+		free_pages(kvm->arch.hpt.virt,
+			   kvm->arch.hpt.order - PAGE_SHIFT);
 }
 
 /* Bits in first HPTE dword for pagesize 4k, 64k or 16M */
@@ -192,8 +192,8 @@ void kvmppc_map_vrma(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	if (npages > 1ul << (40 - porder))
 		npages = 1ul << (40 - porder);
 	/* Can't use more than 1 HPTE per HPTEG */
-	if (npages > kvm->arch.hpt_mask + 1)
-		npages = kvm->arch.hpt_mask + 1;
+	if (npages > kvm->arch.hpt.mask + 1)
+		npages = kvm->arch.hpt.mask + 1;
 
 	hp0 = HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16)) |
 		HPTE_V_BOLTED | hpte0_pgsize_encoding(psize);
@@ -203,7 +203,7 @@ void kvmppc_map_vrma(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	for (i = 0; i < npages; ++i) {
 		addr = i << porder;
 		/* can't use hpt_hash since va > 64 bits */
-		hash = (i ^ (VRMA_VSID ^ (VRMA_VSID << 25))) & kvm->arch.hpt_mask;
+		hash = (i ^ (VRMA_VSID ^ (VRMA_VSID << 25))) & kvm->arch.hpt.mask;
 		/*
 		 * We assume that the hash table is empty and no
 		 * vcpus are using it at this stage.  Since we create
@@ -336,9 +336,9 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 		preempt_enable();
 		return -ENOENT;
 	}
-	hptep = (__be64 *)(kvm->arch.hpt_virt + (index << 4));
+	hptep = (__be64 *)(kvm->arch.hpt.virt + (index << 4));
 	v = be64_to_cpu(hptep[0]) & ~HPTE_V_HVLOCK;
-	gr = kvm->arch.revmap[index].guest_rpte;
+	gr = kvm->arch.hpt.rev[index].guest_rpte;
 
 	unlock_hpte(hptep, v);
 	preempt_enable();
@@ -461,8 +461,8 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	if (ea != vcpu->arch.pgfault_addr)
 		return RESUME_GUEST;
 	index = vcpu->arch.pgfault_index;
-	hptep = (__be64 *)(kvm->arch.hpt_virt + (index << 4));
-	rev = &kvm->arch.revmap[index];
+	hptep = (__be64 *)(kvm->arch.hpt.virt + (index << 4));
+	rev = &kvm->arch.hpt.rev[index];
 	preempt_disable();
 	while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
 		cpu_relax();
@@ -713,7 +713,7 @@ static int kvm_handle_hva(struct kvm *kvm, unsigned long hva,
 static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
 			   unsigned long gfn)
 {
-	struct revmap_entry *rev = kvm->arch.revmap;
+	struct revmap_entry *rev = kvm->arch.hpt.rev;
 	unsigned long h, i, j;
 	__be64 *hptep;
 	unsigned long ptel, psize, rcbits;
@@ -731,7 +731,7 @@ static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
 		 * rmap chain lock.
 		 */
 		i = *rmapp & KVMPPC_RMAP_INDEX;
-		hptep = (__be64 *) (kvm->arch.hpt_virt + (i << 4));
+		hptep = (__be64 *) (kvm->arch.hpt.virt + (i << 4));
 		if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
 			/* unlock rmap before spinning on the HPTE lock */
 			unlock_rmap(rmapp);
@@ -813,7 +813,7 @@ void kvmppc_core_flush_memslot_hv(struct kvm *kvm,
 static int kvm_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
 			 unsigned long gfn)
 {
-	struct revmap_entry *rev = kvm->arch.revmap;
+	struct revmap_entry *rev = kvm->arch.hpt.rev;
 	unsigned long head, i, j;
 	__be64 *hptep;
 	int ret = 0;
@@ -831,7 +831,7 @@ static int kvm_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
 
 	i = head = *rmapp & KVMPPC_RMAP_INDEX;
 	do {
-		hptep = (__be64 *) (kvm->arch.hpt_virt + (i << 4));
+		hptep = (__be64 *) (kvm->arch.hpt.virt + (i << 4));
 		j = rev[i].forw;
 
 		/* If this HPTE isn't referenced, ignore it */
@@ -871,7 +871,7 @@ int kvm_age_hva_hv(struct kvm *kvm, unsigned long start, unsigned long end)
 static int kvm_test_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
 			      unsigned long gfn)
 {
-	struct revmap_entry *rev = kvm->arch.revmap;
+	struct revmap_entry *rev = kvm->arch.hpt.rev;
 	unsigned long head, i, j;
 	unsigned long *hp;
 	int ret = 1;
@@ -886,7 +886,7 @@ static int kvm_test_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
 	if (*rmapp & KVMPPC_RMAP_PRESENT) {
 		i = head = *rmapp & KVMPPC_RMAP_INDEX;
 		do {
-			hp = (unsigned long *)(kvm->arch.hpt_virt + (i << 4));
+			hp = (unsigned long *)(kvm->arch.hpt.virt + (i << 4));
 			j = rev[i].forw;
 			if (be64_to_cpu(hp[1]) & HPTE_R_R)
 				goto out;
@@ -920,7 +920,7 @@ static int vcpus_running(struct kvm *kvm)
  */
 static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
 {
-	struct revmap_entry *rev = kvm->arch.revmap;
+	struct revmap_entry *rev = kvm->arch.hpt.rev;
 	unsigned long head, i, j;
 	unsigned long n;
 	unsigned long v, r;
@@ -945,7 +945,7 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
 	i = head = *rmapp & KVMPPC_RMAP_INDEX;
 	do {
 		unsigned long hptep1;
-		hptep = (__be64 *) (kvm->arch.hpt_virt + (i << 4));
+		hptep = (__be64 *) (kvm->arch.hpt.virt + (i << 4));
 		j = rev[i].forw;
 
 		/*
@@ -1252,8 +1252,8 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
 	flags = ctx->flags;
 
 	i = ctx->index;
-	hptp = (__be64 *)(kvm->arch.hpt_virt + (i * HPTE_SIZE));
-	revp = kvm->arch.revmap + i;
+	hptp = (__be64 *)(kvm->arch.hpt.virt + (i * HPTE_SIZE));
+	revp = kvm->arch.hpt.rev + i;
 	lbuf = (unsigned long __user *)buf;
 
 	nb = 0;
@@ -1268,7 +1268,7 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
 
 		/* Skip uninteresting entries, i.e. clean on not-first pass */
 		if (!first_pass) {
-			while (i < kvm->arch.hpt_npte &&
+			while (i < kvm->arch.hpt.npte &&
 			       !hpte_dirty(revp, hptp)) {
 				++i;
 				hptp += 2;
@@ -1278,7 +1278,7 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
 		hdr.index = i;
 
 		/* Grab a series of valid entries */
-		while (i < kvm->arch.hpt_npte &&
+		while (i < kvm->arch.hpt.npte &&
 		       hdr.n_valid < 0xffff &&
 		       nb + HPTE_SIZE < count &&
 		       record_hpte(flags, hptp, hpte, revp, 1, first_pass)) {
@@ -1294,7 +1294,7 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
 			++revp;
 		}
 		/* Now skip invalid entries while we can */
-		while (i < kvm->arch.hpt_npte &&
+		while (i < kvm->arch.hpt.npte &&
 		       hdr.n_invalid < 0xffff &&
 		       record_hpte(flags, hptp, hpte, revp, 0, first_pass)) {
 			/* found an invalid entry */
@@ -1315,7 +1315,7 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
 		}
 
 		/* Check if we've wrapped around the hash table */
-		if (i >= kvm->arch.hpt_npte) {
+		if (i >= kvm->arch.hpt.npte) {
 			i = 0;
 			ctx->first_pass = 0;
 			break;
@@ -1374,11 +1374,11 @@ static ssize_t kvm_htab_write(struct file *file, const char __user *buf,
 
 		err = -EINVAL;
 		i = hdr.index;
-		if (i >= kvm->arch.hpt_npte ||
-		    i + hdr.n_valid + hdr.n_invalid > kvm->arch.hpt_npte)
+		if (i >= kvm->arch.hpt.npte ||
+		    i + hdr.n_valid + hdr.n_invalid > kvm->arch.hpt.npte)
 			break;
 
-		hptp = (__be64 *)(kvm->arch.hpt_virt + (i * HPTE_SIZE));
+		hptp = (__be64 *)(kvm->arch.hpt.virt + (i * HPTE_SIZE));
 		lbuf = (unsigned long __user *)buf;
 		for (j = 0; j < hdr.n_valid; ++j) {
 			__be64 hpte_v;
@@ -1565,8 +1565,8 @@ static ssize_t debugfs_htab_read(struct file *file, char __user *buf,
 
 	kvm = p->kvm;
 	i = p->hpt_index;
-	hptp = (__be64 *)(kvm->arch.hpt_virt + (i * HPTE_SIZE));
-	for (; len != 0 && i < kvm->arch.hpt_npte; ++i, hptp += 2) {
+	hptp = (__be64 *)(kvm->arch.hpt.virt + (i * HPTE_SIZE));
+	for (; len != 0 && i < kvm->arch.hpt.npte; ++i, hptp += 2) {
 		if (!(be64_to_cpu(hptp[0]) & (HPTE_V_VALID | HPTE_V_ABSENT)))
 			continue;
 
@@ -1576,7 +1576,7 @@ static ssize_t debugfs_htab_read(struct file *file, char __user *buf,
 			cpu_relax();
 		v = be64_to_cpu(hptp[0]) & ~HPTE_V_HVLOCK;
 		hr = be64_to_cpu(hptp[1]);
-		gr = kvm->arch.revmap[i].guest_rpte;
+		gr = kvm->arch.hpt.rev[i].guest_rpte;
 		unlock_hpte(hptp, v);
 		preempt_enable();
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 84fb4fc..889f8ce 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3000,7 +3000,7 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
 		goto out;	/* another vcpu beat us to it */
 
 	/* Allocate hashed page table (if not done already) and reset it */
-	if (!kvm->arch.hpt_virt) {
+	if (!kvm->arch.hpt.virt) {
 		err = kvmppc_alloc_hpt(kvm, NULL);
 		if (err) {
 			pr_err("KVM: Couldn't alloc HPT\n");
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 4cb8db0..3259a7b 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -79,10 +79,10 @@ void kvmppc_add_revmap_chain(struct kvm *kvm, struct revmap_entry *rev,
 
 	if (*rmap & KVMPPC_RMAP_PRESENT) {
 		i = *rmap & KVMPPC_RMAP_INDEX;
-		head = &kvm->arch.revmap[i];
+		head = &kvm->arch.hpt.rev[i];
 		if (realmode)
 			head = real_vmalloc_addr(head);
-		tail = &kvm->arch.revmap[head->back];
+		tail = &kvm->arch.hpt.rev[head->back];
 		if (realmode)
 			tail = real_vmalloc_addr(tail);
 		rev->forw = i;
@@ -147,8 +147,8 @@ static void remove_revmap_chain(struct kvm *kvm, long pte_index,
 	lock_rmap(rmap);
 
 	head = *rmap & KVMPPC_RMAP_INDEX;
-	next = real_vmalloc_addr(&kvm->arch.revmap[rev->forw]);
-	prev = real_vmalloc_addr(&kvm->arch.revmap[rev->back]);
+	next = real_vmalloc_addr(&kvm->arch.hpt.rev[rev->forw]);
+	prev = real_vmalloc_addr(&kvm->arch.hpt.rev[rev->back]);
 	next->back = rev->back;
 	prev->forw = rev->forw;
 	if (head == pte_index) {
@@ -281,11 +281,11 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 
 	/* Find and lock the HPTEG slot to use */
  do_insert:
-	if (pte_index >= kvm->arch.hpt_npte)
+	if (pte_index >= kvm->arch.hpt.npte)
 		return H_PARAMETER;
 	if (likely((flags & H_EXACT) == 0)) {
 		pte_index &= ~7UL;
-		hpte = (__be64 *)(kvm->arch.hpt_virt + (pte_index << 4));
+		hpte = (__be64 *)(kvm->arch.hpt.virt + (pte_index << 4));
 		for (i = 0; i < 8; ++i) {
 			if ((be64_to_cpu(*hpte) & HPTE_V_VALID) == 0 &&
 			    try_lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID |
@@ -316,7 +316,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 		}
 		pte_index += i;
 	} else {
-		hpte = (__be64 *)(kvm->arch.hpt_virt + (pte_index << 4));
+		hpte = (__be64 *)(kvm->arch.hpt.virt + (pte_index << 4));
 		if (!try_lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID |
 				   HPTE_V_ABSENT)) {
 			/* Lock the slot and check again */
@@ -333,7 +333,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	}
 
 	/* Save away the guest's idea of the second HPTE dword */
-	rev = &kvm->arch.revmap[pte_index];
+	rev = &kvm->arch.hpt.rev[pte_index];
 	if (realmode)
 		rev = real_vmalloc_addr(rev);
 	if (rev) {
@@ -437,9 +437,9 @@ long kvmppc_do_h_remove(struct kvm *kvm, unsigned long flags,
 	struct revmap_entry *rev;
 	u64 pte;
 
-	if (pte_index >= kvm->arch.hpt_npte)
+	if (pte_index >= kvm->arch.hpt.npte)
 		return H_PARAMETER;
-	hpte = (__be64 *)(kvm->arch.hpt_virt + (pte_index << 4));
+	hpte = (__be64 *)(kvm->arch.hpt.virt + (pte_index << 4));
 	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 		cpu_relax();
 	pte = be64_to_cpu(hpte[0]);
@@ -450,7 +450,7 @@ long kvmppc_do_h_remove(struct kvm *kvm, unsigned long flags,
 		return H_NOT_FOUND;
 	}
 
-	rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
+	rev = real_vmalloc_addr(&kvm->arch.hpt.rev[pte_index]);
 	v = pte & ~HPTE_V_HVLOCK;
 	if (v & HPTE_V_VALID) {
 		hpte[0] &= ~cpu_to_be64(HPTE_V_VALID);
@@ -515,13 +515,13 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 				break;
 			}
 			if (req != 1 || flags == 3 ||
-			    pte_index >= kvm->arch.hpt_npte) {
+			    pte_index >= kvm->arch.hpt.npte) {
 				/* parameter error */
 				args[j] = ((0xa0 | flags) << 56) + pte_index;
 				ret = H_PARAMETER;
 				break;
 			}
-			hp = (__be64 *) (kvm->arch.hpt_virt + (pte_index << 4));
+			hp = (__be64 *) (kvm->arch.hpt.virt + (pte_index << 4));
 			/* to avoid deadlock, don't spin except for first */
 			if (!try_lock_hpte(hp, HPTE_V_HVLOCK)) {
 				if (n)
@@ -553,7 +553,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 			}
 
 			args[j] = ((0x80 | flags) << 56) + pte_index;
-			rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
+			rev = real_vmalloc_addr(&kvm->arch.hpt.rev[pte_index]);
 			note_hpte_modification(kvm, rev);
 
 			if (!(hp0 & HPTE_V_VALID)) {
@@ -607,10 +607,10 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	unsigned long v, r, rb, mask, bits;
 	u64 pte;
 
-	if (pte_index >= kvm->arch.hpt_npte)
+	if (pte_index >= kvm->arch.hpt.npte)
 		return H_PARAMETER;
 
-	hpte = (__be64 *)(kvm->arch.hpt_virt + (pte_index << 4));
+	hpte = (__be64 *)(kvm->arch.hpt.virt + (pte_index << 4));
 	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 		cpu_relax();
 	pte = be64_to_cpu(hpte[0]);
@@ -628,7 +628,7 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	/* Update guest view of 2nd HPTE dword */
 	mask = HPTE_R_PP0 | HPTE_R_PP | HPTE_R_N |
 		HPTE_R_KEY_HI | HPTE_R_KEY_LO;
-	rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
+	rev = real_vmalloc_addr(&kvm->arch.hpt.rev[pte_index]);
 	if (rev) {
 		r = (rev->guest_rpte & ~mask) | bits;
 		rev->guest_rpte = r;
@@ -670,15 +670,15 @@ long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
 	int i, n = 1;
 	struct revmap_entry *rev = NULL;
 
-	if (pte_index >= kvm->arch.hpt_npte)
+	if (pte_index >= kvm->arch.hpt.npte)
 		return H_PARAMETER;
 	if (flags & H_READ_4) {
 		pte_index &= ~3;
 		n = 4;
 	}
-	rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
+	rev = real_vmalloc_addr(&kvm->arch.hpt.rev[pte_index]);
 	for (i = 0; i < n; ++i, ++pte_index) {
-		hpte = (__be64 *)(kvm->arch.hpt_virt + (pte_index << 4));
+		hpte = (__be64 *)(kvm->arch.hpt.virt + (pte_index << 4));
 		v = be64_to_cpu(hpte[0]) & ~HPTE_V_HVLOCK;
 		r = be64_to_cpu(hpte[1]);
 		if (v & HPTE_V_ABSENT) {
@@ -705,11 +705,11 @@ long kvmppc_h_clear_ref(struct kvm_vcpu *vcpu, unsigned long flags,
 	unsigned long *rmap;
 	long ret = H_NOT_FOUND;
 
-	if (pte_index >= kvm->arch.hpt_npte)
+	if (pte_index >= kvm->arch.hpt.npte)
 		return H_PARAMETER;
 
-	rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
-	hpte = (__be64 *)(kvm->arch.hpt_virt + (pte_index << 4));
+	rev = real_vmalloc_addr(&kvm->arch.hpt.rev[pte_index]);
+	hpte = (__be64 *)(kvm->arch.hpt.virt + (pte_index << 4));
 	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 		cpu_relax();
 	v = be64_to_cpu(hpte[0]);
@@ -751,11 +751,11 @@ long kvmppc_h_clear_mod(struct kvm_vcpu *vcpu, unsigned long flags,
 	unsigned long *rmap;
 	long ret = H_NOT_FOUND;
 
-	if (pte_index >= kvm->arch.hpt_npte)
+	if (pte_index >= kvm->arch.hpt.npte)
 		return H_PARAMETER;
 
-	rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
-	hpte = (__be64 *)(kvm->arch.hpt_virt + (pte_index << 4));
+	rev = real_vmalloc_addr(&kvm->arch.hpt.rev[pte_index]);
+	hpte = (__be64 *)(kvm->arch.hpt.virt + (pte_index << 4));
 	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 		cpu_relax();
 	v = be64_to_cpu(hpte[0]);
@@ -861,7 +861,7 @@ long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
 		somask = (1UL << 28) - 1;
 		vsid = (slb_v & ~SLB_VSID_B) >> SLB_VSID_SHIFT;
 	}
-	hash = (vsid ^ ((eaddr & somask) >> pshift)) & kvm->arch.hpt_mask;
+	hash = (vsid ^ ((eaddr & somask) >> pshift)) & kvm->arch.hpt.mask;
 	avpn = slb_v & ~(somask >> 16);	/* also includes B */
 	avpn |= (eaddr & somask) >> 16;
 
@@ -872,7 +872,7 @@ long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
 	val |= avpn;
 
 	for (;;) {
-		hpte = (__be64 *)(kvm->arch.hpt_virt + (hash << 7));
+		hpte = (__be64 *)(kvm->arch.hpt.virt + (hash << 7));
 
 		for (i = 0; i < 16; i += 2) {
 			/* Read the PTE racily */
@@ -902,7 +902,7 @@ long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
 		if (val & HPTE_V_SECONDARY)
 			break;
 		val |= HPTE_V_SECONDARY;
-		hash = hash ^ kvm->arch.hpt_mask;
+		hash = hash ^ kvm->arch.hpt.mask;
 	}
 	return -1;
 }
@@ -941,10 +941,10 @@ long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
 			return status;	/* there really was no HPTE */
 		return 0;		/* for prot fault, HPTE disappeared */
 	}
-	hpte = (__be64 *)(kvm->arch.hpt_virt + (index << 4));
+	hpte = (__be64 *)(kvm->arch.hpt.virt + (index << 4));
 	v = be64_to_cpu(hpte[0]) & ~HPTE_V_HVLOCK;
 	r = be64_to_cpu(hpte[1]);
-	rev = real_vmalloc_addr(&kvm->arch.revmap[index]);
+	rev = real_vmalloc_addr(&kvm->arch.hpt.rev[index]);
 	gr = rev->guest_rpte;
 
 	unlock_hpte(hpte, v);
-- 
2.5.0
