Return-Path: <aik@ozlabs.ru>
Received: from mail-yh0-x230.google.com (mail-yh0-x230.google.com
 [IPv6:2607:f8b0:4002:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 478122C09C8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 17:26:22 +1000 (EST)
Received: by mail-yh0-f48.google.com with SMTP id f35so672110yha.21
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 May 2013 00:26:19 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/6] KVM: PPC: Add support for multiple-TCE hcalls
Date: Mon,  6 May 2013 17:25:53 +1000
Message-Id: <1367825157-27231-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1367825157-27231-1-git-send-email-aik@ozlabs.ru>
References: <1367825157-27231-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Joerg Roedel <joerg.roedel@amd.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds real mode handlers for the H_PUT_TCE_INDIRECT and
H_STUFF_TCE hypercalls for QEMU emulated devices such as virtio
devices or emulated PCI.  These calls allow adding multiple entries
(up to 512) into the TCE table in one call which saves time on
transition to/from real mode.

This adds a guest physical to host real address converter
and calls the existing H_PUT_TCE handler. The converting function
is going to be fully utilized by upcoming VFIO supporting patches.

This also implements the KVM_CAP_PPC_MULTITCE capability,
so in order to support the functionality of this patch, QEMU
needs to query for this capability and set the "hcall-multi-tce"
hypertas property only if the capability is present, otherwise
there will be serious performance degradation.

Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 Documentation/virtual/kvm/api.txt       |   15 ++
 arch/powerpc/include/asm/kvm_ppc.h      |   15 +-
 arch/powerpc/kvm/book3s_64_vio.c        |  114 +++++++++++++++
 arch/powerpc/kvm/book3s_64_vio_hv.c     |  231 +++++++++++++++++++++++++++----
 arch/powerpc/kvm/book3s_hv.c            |   23 +++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |    6 +
 arch/powerpc/kvm/book3s_pr_papr.c       |   37 ++++-
 arch/powerpc/kvm/powerpc.c              |    3 +
 include/uapi/linux/kvm.h                |    1 +
 9 files changed, 413 insertions(+), 32 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index a4df553..f621cd6 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2463,3 +2463,18 @@ For mmu types KVM_MMU_FSL_BOOKE_NOHV and KVM_MMU_FSL_BOOKE_HV:
    where "num_sets" is the tlb_sizes[] value divided by the tlb_ways[] value.
  - The tsize field of mas1 shall be set to 4K on TLB0, even though the
    hardware ignores this value for TLB0.
+
+
+6.4 KVM_CAP_PPC_MULTITCE
+
+Architectures: ppc
+Parameters: none
+Returns: 0 on success; -1 on error
+
+This capability enables the guest to put/remove multiple TCE entries
+per hypercall which significanly accelerates DMA operations for PPC KVM
+guests.
+
+When this capability is enabled, H_PUT_TCE_INDIRECT and H_STUFF_TCE are
+expected to occur rather than H_PUT_TCE which supports only one TCE entry
+per call.
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 99da298..d501246 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -139,8 +139,19 @@ extern void kvmppc_xics_free(struct kvm *kvm);
 
 extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				struct kvm_create_spapr_tce *args);
-extern long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
-			     unsigned long ioba, unsigned long tce);
+extern struct kvmppc_spapr_tce_table *kvmppc_find_tce_table(
+		struct kvm_vcpu *vcpu, unsigned long liobn);
+extern long kvmppc_emulated_h_put_tce(struct kvmppc_spapr_tce_table *stt,
+		unsigned long ioba, unsigned long tce);
+extern long kvmppc_virtmode_h_put_tce(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce);
+extern long kvmppc_virtmode_h_put_tce_indirect(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_list, unsigned long npages);
+extern long kvmppc_virtmode_h_stuff_tce(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_value, unsigned long npages);
 extern long kvm_vm_ioctl_allocate_rma(struct kvm *kvm,
 				struct kvm_allocate_rma *rma);
 extern struct kvmppc_linear_info *kvm_alloc_rma(void);
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 72ffc89..643ac1e 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -14,6 +14,7 @@
  *
  * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
  * Copyright 2011 David Gibson, IBM Corporation <dwg@au1.ibm.com>
+ * Copyright 2013 Alexey Kardashevskiy, IBM Corporation <aik@au1.ibm.com>
  */
 
 #include <linux/types.h>
@@ -36,9 +37,14 @@
 #include <asm/ppc-opcode.h>
 #include <asm/kvm_host.h>
 #include <asm/udbg.h>
+#include <asm/iommu.h>
 
 #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
+#define ERROR_ADDR      (~(unsigned long)0x0)
 
+/*
+ * TCE tables handlers.
+ */
 static long kvmppc_stt_npages(unsigned long window_size)
 {
 	return ALIGN((window_size >> SPAPR_TCE_SHIFT)
@@ -148,3 +154,111 @@ fail:
 	}
 	return ret;
 }
+
+/*
+ * Virtual mode handling of IOMMU map/unmap.
+ */
+/* Converts guest physical address into host virtual */
+static unsigned long get_virt_address(struct kvm_vcpu *vcpu,
+		unsigned long gpa)
+{
+	unsigned long hva, gfn = gpa >> PAGE_SHIFT;
+	struct kvm_memory_slot *memslot;
+
+	memslot = search_memslots(kvm_memslots(vcpu->kvm), gfn);
+	if (!memslot)
+		return ERROR_ADDR;
+
+	/*
+	 * Convert gfn to hva preserving flags and an offset
+	 * within a system page
+	 */
+	hva = __gfn_to_hva_memslot(memslot, gfn) + (gpa & ~PAGE_MASK);
+	return hva;
+}
+
+long kvmppc_virtmode_h_put_tce(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce)
+{
+	struct kvmppc_spapr_tce_table *tt;
+
+	tt = kvmppc_find_tce_table(vcpu, liobn);
+	/* Didn't find the liobn, put it to userspace */
+	if (!tt)
+		return H_TOO_HARD;
+
+	/* Emulated IO */
+	return kvmppc_emulated_h_put_tce(tt, ioba, tce);
+}
+
+long kvmppc_virtmode_h_put_tce_indirect(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_list, unsigned long npages)
+{
+	struct kvmppc_spapr_tce_table *tt;
+	long i;
+	unsigned long tces;
+
+	/* The whole table addressed by tce_list resides in 4K page */
+	if (npages > 512)
+		return H_PARAMETER;
+
+	tt = kvmppc_find_tce_table(vcpu, liobn);
+	/* Didn't find the liobn, put it to userspace */
+	if (!tt)
+		return H_TOO_HARD;
+
+	tces = get_virt_address(vcpu, tce_list);
+	if (tces == ERROR_ADDR)
+		return H_TOO_HARD;
+
+	/* Emulated IO */
+	if ((ioba + (npages << IOMMU_PAGE_SHIFT)) > tt->window_size)
+		return H_PARAMETER;
+
+	for (i = 0; i < npages; ++i) {
+		unsigned long tce;
+		unsigned long ptce = tces + i * sizeof(unsigned long);
+
+		if (get_user(tce, (unsigned long __user *)ptce))
+			break;
+
+		if (kvmppc_emulated_h_put_tce(tt,
+				ioba + (i << IOMMU_PAGE_SHIFT),	tce))
+			break;
+	}
+	if (i == npages)
+		return H_SUCCESS;
+
+	/* Failed, do cleanup */
+	do {
+		--i;
+		kvmppc_emulated_h_put_tce(tt, ioba + (i << IOMMU_PAGE_SHIFT),
+				0);
+	} while (i);
+
+	return H_PARAMETER;
+}
+
+long kvmppc_virtmode_h_stuff_tce(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_value, unsigned long npages)
+{
+	struct kvmppc_spapr_tce_table *tt;
+	long i;
+
+	tt = kvmppc_find_tce_table(vcpu, liobn);
+	/* Didn't find the liobn, put it to userspace */
+	if (!tt)
+		return H_TOO_HARD;
+
+	/* Emulated IO */
+	if ((ioba + (npages << IOMMU_PAGE_SHIFT)) > tt->window_size)
+		return H_PARAMETER;
+
+	for (i = 0; i < npages; ++i, ioba += IOMMU_PAGE_SIZE)
+		kvmppc_emulated_h_put_tce(tt, ioba, tce_value);
+
+	return H_SUCCESS;
+}
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 30c2f3b..55fdf7a 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -14,6 +14,7 @@
  *
  * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
  * Copyright 2011 David Gibson, IBM Corporation <dwg@au1.ibm.com>
+ * Copyright 2013 Alexey Kardashevskiy, IBM Corporation <aik@au1.ibm.com>
  */
 
 #include <linux/types.h>
@@ -35,42 +36,214 @@
 #include <asm/ppc-opcode.h>
 #include <asm/kvm_host.h>
 #include <asm/udbg.h>
+#include <asm/iommu.h>
+#include <asm/tce.h>
 
 #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
+#define ERROR_ADDR      (~(unsigned long)0x0)
 
-/* WARNING: This will be called in real-mode on HV KVM and virtual
- *          mode on PR KVM
+/*
+ * Finds a TCE table descriptor by LIOBN.
  */
+struct kvmppc_spapr_tce_table *kvmppc_find_tce_table(struct kvm_vcpu *vcpu,
+		unsigned long liobn)
+{
+	struct kvmppc_spapr_tce_table *tt;
+
+	list_for_each_entry(tt, &vcpu->kvm->arch.spapr_tce_tables, list) {
+		if (tt->liobn == liobn)
+			return tt;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(kvmppc_find_tce_table);
+
+/*
+ * kvmppc_emulated_h_put_tce() handles TCE requests for devices emulated
+ * by QEMU. It puts guest TCE values into the table and expects
+ * the QEMU to convert them later in the QEMU device implementation.
+ * Works in both real and virtual modes.
+ */
+long kvmppc_emulated_h_put_tce(struct kvmppc_spapr_tce_table *tt,
+		unsigned long ioba, unsigned long tce)
+{
+	unsigned long idx = ioba >> SPAPR_TCE_SHIFT;
+	struct page *page;
+	u64 *tbl;
+
+	/* udbg_printf("H_PUT_TCE: liobn 0x%lx => tt=%p  window_size=0x%x\n", */
+	/*	    liobn, tt, tt->window_size); */
+	if (ioba >= tt->window_size) {
+		/* pr_err("%s failed on ioba=%lx\n", __func__, ioba); */
+		return H_PARAMETER;
+	}
+	/*
+	 * Note on the use of page_address() in real mode,
+	 *
+	 * It is safe to use page_address() in real mode on ppc64 because
+	 * page_address() is always defined as lowmem_page_address()
+	 * which returns __va(PFN_PHYS(page_to_pfn(page))) which is arithmetial
+	 * operation and does not access page struct.
+	 *
+	 * Theoretically page_address() could be defined different
+	 * but either WANT_PAGE_VIRTUAL or HASHED_PAGE_VIRTUAL
+	 * should be enabled.
+	 * WANT_PAGE_VIRTUAL is never enabled on ppc32/ppc64,
+	 * HASHED_PAGE_VIRTUAL could be enabled for ppc32 only and only
+	 * if CONFIG_HIGHMEM is defined. As CONFIG_SPARSEMEM_VMEMMAP
+	 * is not expected to be enabled on ppc32, page_address()
+	 * is safe for ppc32 as well.
+	 */
+#if defined(HASHED_PAGE_VIRTUAL) || defined(WANT_PAGE_VIRTUAL)
+#error TODO: fix to avoid page_address() here
+#endif
+	page = tt->pages[idx / TCES_PER_PAGE];
+	tbl = (u64 *)page_address(page);
+
+	/*
+	 * Validate TCE address.
+	 * At the moment only flags are validated
+	 * as other check will significantly slow down
+	 * or can make it even impossible to handle TCE requests
+	 * in real mode.
+	 */
+	if (tce & ~(IOMMU_PAGE_MASK | TCE_PCI_WRITE | TCE_PCI_READ))
+		return H_PARAMETER;
+
+	/* udbg_printf("tce @ %p\n", &tbl[idx % TCES_PER_PAGE]); */
+	tbl[idx % TCES_PER_PAGE] = tce;
+
+	return H_SUCCESS;
+}
+EXPORT_SYMBOL_GPL(kvmppc_emulated_h_put_tce);
+
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+/*
+ * Converts guest physical address into host real address.
+ * Also returns pte and page size if the page is present in page table.
+ */
+static unsigned long get_real_address(struct kvm_vcpu *vcpu,
+		unsigned long gpa, bool writing,
+		pte_t *ptep, unsigned long *pg_sizep)
+{
+	struct kvm_memory_slot *memslot;
+	pte_t pte;
+	unsigned long hva, pg_size = 0, hwaddr, offset;
+	unsigned long gfn = gpa >> PAGE_SHIFT;
+
+	/* Find a KVM memslot */
+	memslot = search_memslots(kvm_memslots(vcpu->kvm), gfn);
+	if (!memslot)
+		return ERROR_ADDR;
+
+	/* Convert guest physical address to host virtual */
+	hva = __gfn_to_hva_memslot(memslot, gfn);
+
+	/* Find a PTE and determine the size */
+	pte = lookup_linux_pte(vcpu->arch.pgdir, hva,
+			writing, &pg_size);
+	if (!pte_present(pte))
+		return ERROR_ADDR;
+
+	/* Calculate host phys address keeping flags and offset in the page */
+	offset = gpa & (pg_size - 1);
+
+	/* pte_pfn(pte) should return an address aligned to pg_size */
+	hwaddr = (pte_pfn(pte) << PAGE_SHIFT) + offset;
+
+	/* Copy outer values if required */
+	if (pg_sizep)
+		*pg_sizep = pg_size;
+	if (ptep)
+		*ptep = pte;
+
+	return hwaddr;
+}
+
 long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		      unsigned long ioba, unsigned long tce)
 {
-	struct kvm *kvm = vcpu->kvm;
-	struct kvmppc_spapr_tce_table *stt;
-
-	/* udbg_printf("H_PUT_TCE(): liobn=0x%lx ioba=0x%lx, tce=0x%lx\n", */
-	/* 	    liobn, ioba, tce); */
-
-	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
-		if (stt->liobn == liobn) {
-			unsigned long idx = ioba >> SPAPR_TCE_SHIFT;
-			struct page *page;
-			u64 *tbl;
-
-			/* udbg_printf("H_PUT_TCE: liobn 0x%lx => stt=%p  window_size=0x%x\n", */
-			/* 	    liobn, stt, stt->window_size); */
-			if (ioba >= stt->window_size)
-				return H_PARAMETER;
-
-			page = stt->pages[idx / TCES_PER_PAGE];
-			tbl = (u64 *)page_address(page);
-
-			/* FIXME: Need to validate the TCE itself */
-			/* udbg_printf("tce @ %p\n", &tbl[idx % TCES_PER_PAGE]); */
-			tbl[idx % TCES_PER_PAGE] = tce;
-			return H_SUCCESS;
-		}
+	struct kvmppc_spapr_tce_table *tt;
+
+	tt = kvmppc_find_tce_table(vcpu, liobn);
+	/* Didn't find the liobn, put it to virtual space */
+	if (!tt)
+		return H_TOO_HARD;
+
+	/* Emulated IO */
+	return kvmppc_emulated_h_put_tce(tt, ioba, tce);
+}
+
+long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_list,	unsigned long npages)
+{
+	struct kvmppc_spapr_tce_table *tt;
+	long i;
+	unsigned long tces;
+
+	/* The whole table addressed by tce_list resides in 4K page */
+	if (npages > 512)
+		return H_PARAMETER;
+
+	tt = kvmppc_find_tce_table(vcpu, liobn);
+	/* Didn't find the liobn, put it to virtual space */
+	if (!tt)
+		return H_TOO_HARD;
+
+	tces = get_real_address(vcpu, tce_list, false, NULL, NULL);
+	if (tces == ERROR_ADDR)
+		return H_TOO_HARD;
+
+	/* Emulated IO */
+	if ((ioba + (npages << IOMMU_PAGE_SHIFT)) > tt->window_size)
+		return H_PARAMETER;
+
+	for (i = 0; i < npages; ++i) {
+		unsigned long tce;
+		unsigned long ptce = tces + i * sizeof(unsigned long);
+
+		if (get_user(tce, (unsigned long __user *)ptce))
+			break;
+
+		if (kvmppc_emulated_h_put_tce(tt,
+				ioba + (i << IOMMU_PAGE_SHIFT), tce))
+			break;
 	}
+	if (i == npages)
+		return H_SUCCESS;
+
+	/* Failed, do cleanup */
+	do {
+		--i;
+		kvmppc_emulated_h_put_tce(tt, ioba + (i << IOMMU_PAGE_SHIFT),
+				0);
+	} while (i);
+
+	return H_PARAMETER;
+}
 
-	/* Didn't find the liobn, punt it to userspace */
-	return H_TOO_HARD;
+long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_value, unsigned long npages)
+{
+	struct kvmppc_spapr_tce_table *tt;
+	long i;
+
+	tt = kvmppc_find_tce_table(vcpu, liobn);
+	/* Didn't find the liobn, put it to virtual space */
+	if (!tt)
+		return H_TOO_HARD;
+
+	/* Emulated IO */
+	if ((ioba + (npages << IOMMU_PAGE_SHIFT)) > tt->window_size)
+		return H_PARAMETER;
+
+	for (i = 0; i < npages; ++i, ioba += IOMMU_PAGE_SIZE)
+		kvmppc_emulated_h_put_tce(tt, ioba, tce_value);
+
+	return H_SUCCESS;
 }
+
+#endif /* CONFIG_KVM_BOOK3S_64_HV */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index e5afdcb..6eb6f44 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -565,6 +565,29 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 			ret = kvmppc_xics_hcall(vcpu, req);
 			break;
 		} /* fallthrough */
+	case H_PUT_TCE:
+		ret = kvmppc_virtmode_h_put_tce(vcpu, kvmppc_get_gpr(vcpu, 4),
+						kvmppc_get_gpr(vcpu, 5),
+						kvmppc_get_gpr(vcpu, 6));
+		if (ret == H_TOO_HARD)
+			return RESUME_HOST;
+		break;
+	case H_PUT_TCE_INDIRECT:
+		ret = kvmppc_virtmode_h_put_tce_indirect(vcpu, kvmppc_get_gpr(vcpu, 4),
+						kvmppc_get_gpr(vcpu, 5),
+						kvmppc_get_gpr(vcpu, 6),
+						kvmppc_get_gpr(vcpu, 7));
+		if (ret == H_TOO_HARD)
+			return RESUME_HOST;
+		break;
+	case H_STUFF_TCE:
+		ret = kvmppc_virtmode_h_stuff_tce(vcpu, kvmppc_get_gpr(vcpu, 4),
+						kvmppc_get_gpr(vcpu, 5),
+						kvmppc_get_gpr(vcpu, 6),
+						kvmppc_get_gpr(vcpu, 7));
+		if (ret == H_TOO_HARD)
+			return RESUME_HOST;
+		break;
 	default:
 		return RESUME_HOST;
 	}
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index d3e26be..4d73406 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1472,6 +1472,12 @@ hcall_real_table:
 	.long	0		/* 0x11c */
 	.long	0		/* 0x120 */
 	.long	.kvmppc_h_bulk_remove - hcall_real_table
+	.long	0		/* 0x128 */
+	.long	0		/* 0x12c */
+	.long	0		/* 0x130 */
+	.long	0		/* 0x134 */
+	.long	.kvmppc_h_stuff_tce - hcall_real_table
+	.long	.kvmppc_h_put_tce_indirect - hcall_real_table
 hcall_real_table_end:
 
 ignore_hdec:
diff --git a/arch/powerpc/kvm/book3s_pr_papr.c b/arch/powerpc/kvm/book3s_pr_papr.c
index 8352cac..603e4f2 100644
--- a/arch/powerpc/kvm/book3s_pr_papr.c
+++ b/arch/powerpc/kvm/book3s_pr_papr.c
@@ -220,7 +220,38 @@ static int kvmppc_h_pr_put_tce(struct kvm_vcpu *vcpu)
 	unsigned long tce = kvmppc_get_gpr(vcpu, 6);
 	long rc;
 
-	rc = kvmppc_h_put_tce(vcpu, liobn, ioba, tce);
+	rc = kvmppc_virtmode_h_put_tce(vcpu, liobn, ioba, tce);
+	if (rc == H_TOO_HARD)
+		return EMULATE_FAIL;
+	kvmppc_set_gpr(vcpu, 3, rc);
+	return EMULATE_DONE;
+}
+
+static int kvmppc_h_pr_put_tce_indirect(struct kvm_vcpu *vcpu)
+{
+	unsigned long liobn = kvmppc_get_gpr(vcpu, 4);
+	unsigned long ioba = kvmppc_get_gpr(vcpu, 5);
+	unsigned long tce = kvmppc_get_gpr(vcpu, 6);
+	unsigned long npages = kvmppc_get_gpr(vcpu, 7);
+	long rc;
+
+	rc = kvmppc_virtmode_h_put_tce_indirect(vcpu, liobn, ioba,
+			tce, npages);
+	if (rc == H_TOO_HARD)
+		return EMULATE_FAIL;
+	kvmppc_set_gpr(vcpu, 3, rc);
+	return EMULATE_DONE;
+}
+
+static int kvmppc_h_pr_stuff_tce(struct kvm_vcpu *vcpu)
+{
+	unsigned long liobn = kvmppc_get_gpr(vcpu, 4);
+	unsigned long ioba = kvmppc_get_gpr(vcpu, 5);
+	unsigned long tce_value = kvmppc_get_gpr(vcpu, 6);
+	unsigned long npages = kvmppc_get_gpr(vcpu, 7);
+	long rc;
+
+	rc = kvmppc_virtmode_h_stuff_tce(vcpu, liobn, ioba, tce_value, npages);
 	if (rc == H_TOO_HARD)
 		return EMULATE_FAIL;
 	kvmppc_set_gpr(vcpu, 3, rc);
@@ -249,6 +280,10 @@ int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned long cmd)
 		return kvmppc_h_pr_bulk_remove(vcpu);
 	case H_PUT_TCE:
 		return kvmppc_h_pr_put_tce(vcpu);
+	case H_PUT_TCE_INDIRECT:
+		return kvmppc_h_pr_put_tce_indirect(vcpu);
+	case H_STUFF_TCE:
+		return kvmppc_h_pr_stuff_tce(vcpu);
 	case H_CEDE:
 		vcpu->arch.shared->msr |= MSR_EE;
 		kvm_vcpu_block(vcpu);
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index f9c159e..b7ad589 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -384,6 +384,9 @@ int kvm_dev_ioctl_check_extension(long ext)
 		r = 1;
 		break;
 #endif
+	case KVM_CAP_SPAPR_MULTITCE:
+		r = 1;
+		break;
 	default:
 		r = 0;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6f49c87..6c04da1 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -640,6 +640,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_PPC_HTAB_FD 84
 #define KVM_CAP_PPC_RTAS (0x100000 + 87)
 #define KVM_CAP_SPAPR_XICS (0x100000 + 88)
+#define KVM_CAP_SPAPR_MULTITCE (0x110000 + 89)
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.7.10.4
