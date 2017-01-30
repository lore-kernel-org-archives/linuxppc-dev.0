Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBlnL1KlNzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 21:22:14 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 20/20] KVM: PPC: Book3S HV: Enable radix guest support
Date: Mon, 30 Jan 2017 21:21:53 +1100
Message-Id: <1485771713-24801-21-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
References: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a few last pieces of the support for radix guests:

* Implement the backends for the KVM_PPC_CONFIGURE_V3_MMU and
  KVM_PPC_GET_RMMU_INFO ioctls for radix guests

* On POWER9, allow secondary threads to be on/off-lined while guests
  are running.

* Set up LPCR and the partition table entry for radix guests.

* Don't allocate the rmap array in the kvm_memory_slot structure
  on radix.

* Don't try to initialize the HPT for radix guests, since they don't
  have an HPT.

* Take out the code that prevents the HV KVM module from
  initializing on radix hosts.

At this stage, we only support radix guests if the host is running
in radix mode, and only support HPT guests if the host is running in
HPT mode.  Thus a guest cannot switch from one mode to the other,
which enables some simplifications.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_book3s.h  |  2 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c    |  1 -
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 45 +++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c           | 88 ++++++++++++++++++++++++----------
 arch/powerpc/kvm/powerpc.c             |  2 +-
 5 files changed, 111 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 57dc407..2bf3501 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -189,6 +189,7 @@ extern int kvmppc_book3s_radix_page_fault(struct kvm_run *run,
 			unsigned long ea, unsigned long dsisr);
 extern int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 			struct kvmppc_pte *gpte, bool data, bool iswrite);
+extern int kvmppc_init_vm_radix(struct kvm *kvm);
 extern void kvmppc_free_radix(struct kvm *kvm);
 extern int kvmppc_radix_init(void);
 extern void kvmppc_radix_exit(void);
@@ -200,6 +201,7 @@ extern int kvm_test_age_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			unsigned long gfn);
 extern long kvmppc_hv_get_dirty_log_radix(struct kvm *kvm,
 			struct kvm_memory_slot *memslot, unsigned long *map);
+extern int kvmhv_get_rmmu_info(struct kvm *kvm, struct kvm_ppc_rmmu_info *info);
 
 /* XXX remove this export when load_last_inst() is generic */
 extern int kvmppc_ld(struct kvm_vcpu *vcpu, ulong *eaddr, int size, void *ptr, bool data);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index c9e587a2..9df3d94 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -155,7 +155,6 @@ long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
 
 void kvmppc_free_hpt(struct kvm *kvm)
 {
-	kvmppc_free_lpid(kvm->arch.lpid);
 	vfree(kvm->arch.revmap);
 	if (kvm->arch.hpt_cma_alloc)
 		kvm_release_hpt(virt_to_page(kvm->arch.hpt_virt),
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 125cc7c..4344651 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -610,6 +610,51 @@ long kvmppc_hv_get_dirty_log_radix(struct kvm *kvm,
 	return 0;
 }
 
+static void add_rmmu_ap_encoding(struct kvm_ppc_rmmu_info *info,
+				 int psize, int *indexp)
+{
+	if (!mmu_psize_defs[psize].shift)
+		return;
+	info->ap_encodings[*indexp] = mmu_psize_defs[psize].shift |
+		(mmu_psize_defs[psize].ap << 29);
+	++(*indexp);
+}
+
+int kvmhv_get_rmmu_info(struct kvm *kvm, struct kvm_ppc_rmmu_info *info)
+{
+	int i;
+
+	if (!radix_enabled())
+		return -EINVAL;
+	memset(info, 0, sizeof(*info));
+
+	/* 4k page size */
+	info->geometries[0].page_shift = 12;
+	info->geometries[0].level_bits[0] = 9;
+	for (i = 1; i < 4; ++i)
+		info->geometries[0].level_bits[i] = p9_supported_radix_bits[i];
+	/* 64k page size */
+	info->geometries[1].page_shift = 16;
+	for (i = 0; i < 4; ++i)
+		info->geometries[1].level_bits[i] = p9_supported_radix_bits[i];
+
+	i = 0;
+	add_rmmu_ap_encoding(info, MMU_PAGE_4K, &i);
+	add_rmmu_ap_encoding(info, MMU_PAGE_64K, &i);
+	add_rmmu_ap_encoding(info, MMU_PAGE_2M, &i);
+	add_rmmu_ap_encoding(info, MMU_PAGE_1G, &i);
+
+	return 0;
+}
+
+int kvmppc_init_vm_radix(struct kvm *kvm)
+{
+	kvm->arch.pgtable = pgd_alloc(kvm->mm);
+	if (!kvm->arch.pgtable)
+		return -ENOMEM;
+	return 0;
+}
+
 void kvmppc_free_radix(struct kvm *kvm)
 {
 	unsigned long ig, iu, im;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 50c230e..e4a7967 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1135,7 +1135,7 @@ static void kvmppc_set_lpcr(struct kvm_vcpu *vcpu, u64 new_lpcr,
 	/*
 	 * Userspace can only modify DPFD (default prefetch depth),
 	 * ILE (interrupt little-endian) and TC (translation control).
-	 * On POWER8 userspace can also modify AIL (alt. interrupt loc.)
+	 * On POWER8 and POWER9 userspace can also modify AIL (alt. interrupt loc.).
 	 */
 	mask = LPCR_DPFD | LPCR_ILE | LPCR_TC;
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
@@ -2922,7 +2922,7 @@ static int kvmppc_vcpu_run_hv(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	smp_mb();
 
 	/* On the first time here, set up HTAB and VRMA */
-	if (!vcpu->kvm->arch.hpte_setup_done) {
+	if (!kvm_is_radix(vcpu->kvm) && !vcpu->kvm->arch.hpte_setup_done) {
 		r = kvmppc_hv_setup_htab_rma(vcpu);
 		if (r)
 			goto out;
@@ -2984,6 +2984,13 @@ static int kvm_vm_ioctl_get_smmu_info_hv(struct kvm *kvm,
 {
 	struct kvm_ppc_one_seg_page_size *sps;
 
+	/*
+	 * Since we don't yet support HPT guests on a radix host,
+	 * return an error if the host uses radix.
+	 */
+	if (radix_enabled())
+		return -EINVAL;
+
 	info->flags = KVM_PPC_PAGE_SIZES_REAL;
 	if (mmu_has_feature(MMU_FTR_1T_SEGMENT))
 		info->flags |= KVM_PPC_1T_SEGMENTS;
@@ -3069,6 +3076,15 @@ static void kvmppc_core_free_memslot_hv(struct kvm_memory_slot *free,
 static int kvmppc_core_create_memslot_hv(struct kvm_memory_slot *slot,
 					 unsigned long npages)
 {
+	/*
+	 * For now, if radix_enabled() then we only support radix guests,
+	 * and in that case we don't need the rmap array.
+	 */
+	if (radix_enabled()) {
+		slot->arch.rmap = NULL;
+		return 0;
+	}
+
 	slot->arch.rmap = vzalloc(npages * sizeof(*slot->arch.rmap));
 	if (!slot->arch.rmap)
 		return -ENOMEM;
@@ -3149,14 +3165,20 @@ static void kvmppc_setup_partition_table(struct kvm *kvm)
 {
 	unsigned long dw0, dw1;
 
-	/* PS field - page size for VRMA */
-	dw0 = ((kvm->arch.vrma_slb_v & SLB_VSID_L) >> 1) |
-		((kvm->arch.vrma_slb_v & SLB_VSID_LP) << 1);
-	/* HTABSIZE and HTABORG fields */
-	dw0 |= kvm->arch.sdr1;
+	if (!kvm_is_radix(kvm)) {
+		/* PS field - page size for VRMA */
+		dw0 = ((kvm->arch.vrma_slb_v & SLB_VSID_L) >> 1) |
+			((kvm->arch.vrma_slb_v & SLB_VSID_LP) << 1);
+		/* HTABSIZE and HTABORG fields */
+		dw0 |= kvm->arch.sdr1;
 
-	/* Second dword as set by userspace */
-	dw1 = kvm->arch.process_table;
+		/* Second dword as set by userspace */
+		dw1 = kvm->arch.process_table;
+	} else {
+		dw0 = PATB_HR | radix__get_tree_size() |
+			__pa(kvm->arch.pgtable) | RADIX_PGD_INDEX_SIZE;
+		dw1 = PATB_GR | kvm->arch.process_table;
+	}
 
 	mmu_partition_table_set_entry(kvm->arch.lpid, dw0, dw1);
 }
@@ -3326,6 +3348,7 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 {
 	unsigned long lpcr, lpid;
 	char buf[32];
+	int ret;
 
 	/* Allocate the guest's logical partition ID */
 
@@ -3373,13 +3396,30 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 		lpcr |= LPCR_HVICE;
 	}
 
+	/*
+	 * For now, if the host uses radix, the guest must be radix.
+	 */
+	if (radix_enabled()) {
+		kvm->arch.radix = 1;
+		lpcr &= ~LPCR_VPM1;
+		lpcr |= LPCR_UPRT | LPCR_GTSE | LPCR_HR;
+		ret = kvmppc_init_vm_radix(kvm);
+		if (ret) {
+			kvmppc_free_lpid(kvm->arch.lpid);
+			return ret;
+		}
+		kvmppc_setup_partition_table(kvm);
+	}
+
 	kvm->arch.lpcr = lpcr;
 
 	/*
 	 * Work out how many sets the TLB has, for the use of
 	 * the TLB invalidation loop in book3s_hv_rmhandlers.S.
 	 */
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
+	if (kvm_is_radix(kvm))
+		kvm->arch.tlb_sets = POWER9_TLB_SETS_RADIX;	/* 128 */
+	else if (cpu_has_feature(CPU_FTR_ARCH_300))
 		kvm->arch.tlb_sets = POWER9_TLB_SETS_HASH;	/* 256 */
 	else if (cpu_has_feature(CPU_FTR_ARCH_207S))
 		kvm->arch.tlb_sets = POWER8_TLB_SETS;		/* 512 */
@@ -3389,8 +3429,11 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 	/*
 	 * Track that we now have a HV mode VM active. This blocks secondary
 	 * CPU threads from coming online.
+	 * On POWER9, we only need to do this for HPT guests on a radix
+	 * host, which is not yet supported.
 	 */
-	kvm_hv_vm_activated();
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		kvm_hv_vm_activated();
 
 	/*
 	 * Create a debugfs directory for the VM
@@ -3416,10 +3459,13 @@ static void kvmppc_core_destroy_vm_hv(struct kvm *kvm)
 {
 	debugfs_remove_recursive(kvm->arch.debugfs_dir);
 
-	kvm_hv_vm_deactivated();
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		kvm_hv_vm_deactivated();
 
 	kvmppc_free_vcores(kvm);
 
+	kvmppc_free_lpid(kvm->arch.lpid);
+
 	if (kvm_is_radix(kvm))
 		kvmppc_free_radix(kvm);
 	else
@@ -3452,11 +3498,6 @@ static int kvmppc_core_check_processor_compat_hv(void)
 	if (!cpu_has_feature(CPU_FTR_HVMODE) ||
 	    !cpu_has_feature(CPU_FTR_ARCH_206))
 		return -EIO;
-	/*
-	 * Disable KVM for Power9 in radix mode.
-	 */
-	if (cpu_has_feature(CPU_FTR_ARCH_300) && radix_enabled())
-		return -EIO;
 
 	return 0;
 }
@@ -3727,6 +3768,7 @@ static void init_default_hcalls(void)
 static int kvmhv_configure_mmu(struct kvm *kvm, struct kvm_ppc_mmuv3_cfg *cfg)
 {
 	unsigned long lpcr;
+	int radix;
 
 	/* If not on a POWER9, reject it */
 	if (!cpu_has_feature(CPU_FTR_ARCH_300))
@@ -3736,12 +3778,13 @@ static int kvmhv_configure_mmu(struct kvm *kvm, struct kvm_ppc_mmuv3_cfg *cfg)
 	if (cfg->flags & ~(KVM_PPC_MMUV3_RADIX | KVM_PPC_MMUV3_GTSE))
 		return -EINVAL;
 
-	/* We can't do radix yet */
-	if (cfg->flags & KVM_PPC_MMUV3_RADIX)
+	/* We can't change a guest to/from radix yet */
+	radix = !!(cfg->flags & KVM_PPC_MMUV3_RADIX);
+	if (radix != kvm_is_radix(kvm))
 		return -EINVAL;
 
 	/* GR (guest radix) bit in process_table field must match */
-	if (cfg->process_table & PATB_GR)
+	if (!!(cfg->process_table & PATB_GR) != radix)
 		return -EINVAL;
 
 	/* Process table size field must be reasonable, i.e. <= 24 */
@@ -3757,11 +3800,6 @@ static int kvmhv_configure_mmu(struct kvm *kvm, struct kvm_ppc_mmuv3_cfg *cfg)
 	return 0;
 }
 
-static int kvmhv_get_rmmu_info(struct kvm *kvm, struct kvm_ppc_rmmu_info *info)
-{
-	return -EINVAL;
-}
-
 static struct kvmppc_ops kvm_ops_hv = {
 	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
 	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 1476a48..40a5b2d 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -566,7 +566,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = kvmppc_hwrng_present();
 		break;
 	case KVM_CAP_PPC_MMU_RADIX:
-		r = !!(0 && hv_enabled && radix_enabled());
+		r = !!(hv_enabled && radix_enabled());
 		break;
 	case KVM_CAP_PPC_MMU_HASH_V3:
 		r = !!(hv_enabled && !radix_enabled() &&
-- 
2.7.4
