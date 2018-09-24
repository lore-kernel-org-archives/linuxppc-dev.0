Return-Path: <bharata@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JVkz5YzQzDrDD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 13:56:56 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8O3rce8074502
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2018 23:56:54 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mpkd7qnkb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2018 23:56:54 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.ibm.com>;
 Mon, 24 Sep 2018 04:56:52 +0100
From: Bharata B Rao <bharata@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@au1.ibm.com, benh@linux.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 jglisse@redhat.com, linuxram@us.ibm.com,
 Bharata B Rao <bharata@linux.ibm.com>
Subject: [RFC PATCH v0 1/3] kvmppc: HMM backend driver to manage pages of
 secure guest
Date: Mon, 24 Sep 2018 09:26:39 +0530
In-Reply-To: <20180924035641.14572-1-bharata@linux.ibm.com>
References: <20180924035641.14572-1-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Message-Id: <20180924035641.14572-2-bharata@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

HMM driver for KVM PPC to manage page transitions of
secure guest via H_SVM_PAGE_IN and H_SVM_PAGE_OUT hcalls.

H_SVM_PAGE_IN: Move the content of a normal page to secure page
H_SVM_PAGE_OUT: Move the content of a secure page to normal page

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h    |   7 +-
 arch/powerpc/include/asm/kvm_host.h  |  10 +
 arch/powerpc/include/asm/kvm_ppc.h   |  28 ++
 arch/powerpc/include/asm/ucall-api.h |  20 ++
 arch/powerpc/kvm/Makefile            |   3 +
 arch/powerpc/kvm/book3s_hv.c         |  28 ++
 arch/powerpc/kvm/book3s_hv_hmm.c     | 531 +++++++++++++++++++++++++++++++++++
 7 files changed, 626 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/ucall-api.h
 create mode 100644 arch/powerpc/kvm/book3s_hv_hmm.c

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index a0b17f9f1ea4..89e6b70c1857 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -158,6 +158,9 @@
 /* Each control block has to be on a 4K boundary */
 #define H_CB_ALIGNMENT          4096
 
+/* Flags for H_SVM_PAGE_IN */
+#define H_PAGE_IN_SHARED	0x1
+
 /* pSeries hypervisor opcodes */
 #define H_REMOVE		0x04
 #define H_ENTER			0x08
@@ -295,7 +298,9 @@
 #define H_INT_ESB               0x3C8
 #define H_INT_SYNC              0x3CC
 #define H_INT_RESET             0x3D0
-#define MAX_HCALL_OPCODE	H_INT_RESET
+#define H_SVM_PAGE_IN		0x3D4
+#define H_SVM_PAGE_OUT		0x3D8
+#define MAX_HCALL_OPCODE	H_SVM_PAGE_OUT
 
 /* H_VIOCTL functions */
 #define H_GET_VIOA_DUMP_SIZE	0x01
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 906bcbdfd2a1..e03df112c471 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -830,4 +830,14 @@ static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
 
+#ifdef CONFIG_PPC_SVM
+struct kvmppc_hmm_device {
+	struct hmm_device *device;
+	struct hmm_devmem *devmem;
+	unsigned long *pfn_bitmap;
+};
+
+extern int kvmppc_hmm_init(void);
+extern void kvmppc_hmm_free(void);
+#endif
 #endif /* __POWERPC_KVM_HOST_H__ */
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index e991821dd7fa..ba81a07e2bdf 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -906,4 +906,32 @@ static inline ulong kvmppc_get_ea_indexed(struct kvm_vcpu *vcpu, int ra, int rb)
 
 extern void xics_wake_cpu(int cpu);
 
+#ifdef CONFIG_PPC_SVM
+extern unsigned long kvmppc_h_svm_page_in(struct kvm *kvm,
+					  unsigned int lpid,
+					  unsigned long gra,
+					  unsigned long flags,
+					  unsigned long page_shift);
+extern unsigned long kvmppc_h_svm_page_out(struct kvm *kvm,
+					  unsigned int lpid,
+					  unsigned long gra,
+					  unsigned long flags,
+					  unsigned long page_shift);
+#else
+static inline unsigned long
+kvmppc_h_svm_page_in(struct kvm *kvm, unsigned int lpid,
+		     unsigned long gra, unsigned long flags,
+		     unsigned long page_shift)
+{
+	return H_UNSUPPORTED;
+}
+
+static inline unsigned long
+kvmppc_h_svm_page_out(struct kvm *kvm, unsigned int lpid,
+		      unsigned long gra, unsigned long flags,
+		      unsigned long page_shift)
+{
+	return H_UNSUPPORTED;
+}
+#endif
 #endif /* __POWERPC_KVM_PPC_H__ */
diff --git a/arch/powerpc/include/asm/ucall-api.h b/arch/powerpc/include/asm/ucall-api.h
new file mode 100644
index 000000000000..2c12f514f8ab
--- /dev/null
+++ b/arch/powerpc/include/asm/ucall-api.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_UCALL_API_H
+#define _ASM_POWERPC_UCALL_API_H
+
+#define U_SUCCESS 0
+
+/*
+ * TODO: Dummy uvcalls, will be replaced by real calls
+ */
+static inline int uv_page_in(u64 lpid, u64 dw0, u64 dw1, u64 dw2, u64 dw3)
+{
+	return U_SUCCESS;
+}
+
+static inline int uv_page_out(u64 lpid, u64 dw0, u64 dw1, u64 dw2, u64 dw3)
+{
+	return U_SUCCESS;
+}
+
+#endif	/* _ASM_POWERPC_UCALL_API_H */
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index f872c04bb5b1..6945ffc18679 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -77,6 +77,9 @@ kvm-hv-y += \
 	book3s_64_mmu_hv.o \
 	book3s_64_mmu_radix.o
 
+kvm-hv-$(CONFIG_PPC_SVM) += \
+	book3s_hv_hmm.o
+
 kvm-hv-$(CONFIG_PPC_TRANSACTIONAL_MEM) += \
 	book3s_hv_tm.o
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 3e3a71594e63..78865b515e73 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -73,6 +73,7 @@
 #include <asm/opal.h>
 #include <asm/xics.h>
 #include <asm/xive.h>
+#include <asm/kvm_host.h>
 
 #include "book3s.h"
 
@@ -935,6 +936,20 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 		if (ret == H_TOO_HARD)
 			return RESUME_HOST;
 		break;
+	case H_SVM_PAGE_IN:
+		ret = kvmppc_h_svm_page_in(vcpu->kvm,
+					   kvmppc_get_gpr(vcpu, 4),
+					   kvmppc_get_gpr(vcpu, 5),
+					   kvmppc_get_gpr(vcpu, 6),
+					   kvmppc_get_gpr(vcpu, 7));
+		break;
+	case H_SVM_PAGE_OUT:
+		ret = kvmppc_h_svm_page_out(vcpu->kvm,
+					    kvmppc_get_gpr(vcpu, 4),
+					    kvmppc_get_gpr(vcpu, 5),
+					    kvmppc_get_gpr(vcpu, 6),
+					    kvmppc_get_gpr(vcpu, 7));
+		break;
 	default:
 		return RESUME_HOST;
 	}
@@ -961,6 +976,8 @@ static int kvmppc_hcall_impl_hv(unsigned long cmd)
 	case H_IPOLL:
 	case H_XIRR_X:
 #endif
+	case H_SVM_PAGE_IN:
+	case H_SVM_PAGE_OUT:
 		return 1;
 	}
 
@@ -4384,6 +4401,8 @@ static unsigned int default_hcall_list[] = {
 	H_XIRR,
 	H_XIRR_X,
 #endif
+	H_SVM_PAGE_IN,
+	H_SVM_PAGE_OUT,
 	0
 };
 
@@ -4596,11 +4615,20 @@ static int kvmppc_book3s_init_hv(void)
 			no_mixing_hpt_and_radix = true;
 	}
 
+#ifdef CONFIG_PPC_SVM
+	r = kvmppc_hmm_init();
+	if (r < 0)
+		pr_err("KVM-HV: kvmppc_hmm_init failed %d\n", r);
+#endif
+
 	return r;
 }
 
 static void kvmppc_book3s_exit_hv(void)
 {
+#ifdef CONFIG_PPC_SVM
+	kvmppc_hmm_free();
+#endif
 	kvmppc_free_host_rm_ops();
 	if (kvmppc_radix_possible())
 		kvmppc_radix_exit();
diff --git a/arch/powerpc/kvm/book3s_hv_hmm.c b/arch/powerpc/kvm/book3s_hv_hmm.c
new file mode 100644
index 000000000000..4a17c62b0eb4
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_hv_hmm.c
@@ -0,0 +1,531 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HMM driver to manage page migration between normal and secure
+ * memory.
+ *
+ * Based on Jérôme Glisse's HMM dummy driver.
+ *
+ * Copyright 2018 Bharata B Rao, IBM Corp. <bharata@linux.ibm.com>
+ */
+
+/*
+ * A pseries guest can be run as a secure guest on Ultravisor-enabled
+ * POWER platforms. On such platforms, this driver will be used to manage
+ * the movement of guest pages between the normal memory managed by
+ * hypervisor (HV) and secure memory managed by Ultravisor (UV).
+ *
+ * Private ZONE_DEVICE memory equal to the amount of secure memory
+ * available in the platform for running secure guests is created
+ * via a HMM device. The movement of pages between normal and secure
+ * memory is done by ->alloc_and_copy() callback routine of migrate_vma().
+ *
+ * The page-in or page-out requests from UV will come to HV as hcalls and
+ * HV will call back into UV via uvcalls to satisfy these page requests.
+ * Both hcalls and uvcalls use (LPID, guest real address) tuple to
+ * indentify the page.
+ *
+ * For each page that gets moved into secure memory, a HMM PFN is used
+ * on the HV side and HMM migration PTE corresponding to that PFN would be
+ * populated in the QEMU page tables. A hash table is created to manage
+ * the pool of HMM PFNs. (LPID, guest real address) tuple is used as
+ * key to index into the hash table and choose a free HMM PFN.
+ *
+ * Currently page requests from all the guests are satisfied via
+ * a single hash table. However when we support bulk release of pages
+ * during guest shutdown, we will probably have to switch to per guest
+ * (per-LPID) tables for quicker release of all HMM PFNs corresponding
+ * to one particular guest (TODO)
+ */
+
+#include <linux/hmm.h>
+#include <linux/kvm_host.h>
+#include <linux/sched/mm.h>
+#include <asm/ucall-api.h>
+
+static struct kvmppc_hmm_device *kvmppc_hmm;
+spinlock_t kvmppc_hmm_lock;
+
+/*
+ * TODO: Probably the size of hash table should be a function of secure
+ * memory size.
+ */
+#define KVMPPC_HMM_HASH_BITS    10
+#define KVMPPC_HMM_HASH_SIZE   (1 << KVMPPC_HMM_HASH_BITS)
+static struct hlist_head kvmppc_hmm_pfn_hash[KVMPPC_HMM_HASH_SIZE];
+
+struct kvmppc_hmm_pfn_entry {
+	struct hlist_node hlist;
+	unsigned long addr;
+};
+
+struct kvmppc_hmm_page_pvt {
+	unsigned int lpid;
+	unsigned long gra;
+};
+
+struct kvmppc_hmm_migrate_args {
+	unsigned int lpid;
+	unsigned long gra;
+	unsigned long page_shift;
+};
+
+/*
+ * The addr will be PAGE_SIZE aligned. For 64k page size, addr|lpid will
+ * not overwrite addr part at least for 64k lpids. However LPIDR is
+ * 32bits wide.
+ */
+static u64 kvmppc_hmm_pfn_hash_fn(u64 addr, unsigned int lpid)
+{
+	return hash_64(addr | lpid, KVMPPC_HMM_HASH_BITS);
+}
+
+static void kvmppc_hmm_hash_free_pfn(unsigned long gra, unsigned long lpid)
+{
+	struct kvmppc_hmm_pfn_entry *p;
+	struct hlist_head *list;
+
+	list = &kvmppc_hmm_pfn_hash[kvmppc_hmm_pfn_hash_fn(gra, lpid)];
+	hlist_for_each_entry(p, list, hlist) {
+		if (p->addr == gra) {
+			hlist_del(&p->hlist);
+			kfree(p);
+			return;
+		}
+	}
+}
+
+/*
+ * Get a free HMM PFN from the pool
+ *
+ * Called when a normal page is moved to secure memory (UV_PAGE_IN). HMM
+ * PFN will be used to keep track of the secure page on HV side.
+ */
+static struct page *kvmppc_hmm_get_page(unsigned long gra, unsigned int lpid)
+{
+	struct page *dpage = NULL;
+	unsigned long bit;
+	unsigned long nr_pfns = kvmppc_hmm->devmem->pfn_last -
+				kvmppc_hmm->devmem->pfn_first;
+	u64 index;
+	struct hlist_head *list;
+	struct kvmppc_hmm_pfn_entry *p;
+	bool found = false;
+	unsigned long flags;
+	struct kvmppc_hmm_page_pvt *pvt;
+	unsigned long hmm_pfn;
+
+	spin_lock_irqsave(&kvmppc_hmm_lock, flags);
+	index = kvmppc_hmm_pfn_hash_fn(gra, lpid);
+	list = &kvmppc_hmm_pfn_hash[index];
+	hlist_for_each_entry(p, list, hlist) {
+		if (p->addr == gra) {
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		p = kzalloc(sizeof(struct kvmppc_hmm_pfn_entry), GFP_ATOMIC);
+		if (!p) {
+			spin_unlock_irqrestore(&kvmppc_hmm_lock, flags);
+			return NULL;
+		}
+		p->addr = gra;
+		bit = find_first_zero_bit(kvmppc_hmm->pfn_bitmap, nr_pfns);
+		if (bit >= nr_pfns) {
+			kfree(p);
+			spin_unlock_irqrestore(&kvmppc_hmm_lock, flags);
+			return NULL;
+		}
+		bitmap_set(kvmppc_hmm->pfn_bitmap, bit, 1);
+		hmm_pfn = bit + kvmppc_hmm->devmem->pfn_first;
+		INIT_HLIST_NODE(&p->hlist);
+		hlist_add_head(&p->hlist, list);
+	} else {
+		spin_unlock_irqrestore(&kvmppc_hmm_lock, flags);
+		return NULL;
+	}
+	dpage = pfn_to_page(hmm_pfn);
+
+	if (!trylock_page(dpage)) {
+		bitmap_clear(kvmppc_hmm->pfn_bitmap,
+			     hmm_pfn - kvmppc_hmm->devmem->pfn_first, 1);
+		hlist_del(&p->hlist);
+		kfree(p);
+		spin_unlock_irqrestore(&kvmppc_hmm_lock, flags);
+		return NULL;
+	}
+	spin_unlock_irqrestore(&kvmppc_hmm_lock, flags);
+
+	pvt = kzalloc(sizeof(*pvt), GFP_ATOMIC);
+	pvt->gra = gra;
+	pvt->lpid = lpid;
+	hmm_devmem_page_set_drvdata(dpage, (unsigned long)pvt);
+
+	get_page(dpage);
+	return dpage;
+}
+
+/*
+ * Release the HMM PFN back to the pool
+ *
+ * Called when secure page becomes a normal page during UV_PAGE_OUT.
+ */
+static void kvmppc_hmm_put_page(struct page *page)
+{
+	unsigned long pfn = page_to_pfn(page);
+	unsigned long flags;
+	struct kvmppc_hmm_page_pvt *pvt;
+
+	pvt = (struct kvmppc_hmm_page_pvt *)hmm_devmem_page_get_drvdata(page);
+	hmm_devmem_page_set_drvdata(page, 0);
+
+	spin_lock_irqsave(&kvmppc_hmm_lock, flags);
+	bitmap_clear(kvmppc_hmm->pfn_bitmap,
+		     pfn - kvmppc_hmm->devmem->pfn_first, 1);
+	kvmppc_hmm_hash_free_pfn(pvt->gra, pvt->lpid);
+	spin_unlock_irqrestore(&kvmppc_hmm_lock, flags);
+	kfree(pvt);
+}
+
+static void kvmppc_hmm_migrate_alloc_and_copy(struct vm_area_struct *vma,
+					      const unsigned long *src_pfns,
+					      unsigned long *dst_pfns,
+					      unsigned long start,
+					      unsigned long end,
+					      void *private)
+{
+	unsigned long addr;
+	struct kvmppc_hmm_migrate_args *args = private;
+	unsigned long page_size = 1UL << args->page_shift;
+
+	for (addr = start; addr < end;
+		addr += page_size, src_pfns++, dst_pfns++) {
+		struct page *spage = migrate_pfn_to_page(*src_pfns);
+		struct page *dpage;
+		unsigned long pfn = *src_pfns >> MIGRATE_PFN_SHIFT;
+		int ret;
+
+		*dst_pfns = 0;
+		if (!spage && !(*src_pfns & MIGRATE_PFN_MIGRATE))
+			continue;
+
+		if (spage && !(*src_pfns & MIGRATE_PFN_MIGRATE))
+			continue;
+
+		dpage = kvmppc_hmm_get_page(args->gra, args->lpid);
+		if (!dpage)
+			continue;
+
+		if (spage) {
+			ret = uv_page_in(args->lpid,
+					 pfn << args->page_shift,
+					 args->gra, 0, args->page_shift);
+			if (ret == U_SUCCESS)
+				*dst_pfns = migrate_pfn(page_to_pfn(dpage)) |
+				MIGRATE_PFN_DEVICE | MIGRATE_PFN_LOCKED;
+		}
+	}
+}
+
+static void kvmppc_hmm_migrate_finalize_and_map(struct vm_area_struct *vma,
+						const unsigned long *src_pfns,
+						const unsigned long *dst_pfns,
+						unsigned long start,
+						unsigned long end,
+						void *private)
+{
+}
+
+static const struct migrate_vma_ops kvmppc_hmm_migrate_ops = {
+	.alloc_and_copy = kvmppc_hmm_migrate_alloc_and_copy,
+	.finalize_and_map = kvmppc_hmm_migrate_finalize_and_map,
+};
+
+static unsigned long kvmppc_gra_to_hva(struct kvm *kvm, unsigned long gra,
+				       unsigned long page_shift)
+{
+	unsigned long gfn, hva;
+	struct kvm_memory_slot *memslot;
+
+	gfn = gra >> page_shift;
+	memslot = gfn_to_memslot(kvm, gfn);
+	hva = gfn_to_hva_memslot(memslot, gfn);
+
+	return hva;
+}
+
+/*
+ * Shares the page with HV, thus making it a normal page.
+ *
+ * We get the page and let UV copy it over. If UV requests sharing
+ * of a page that is already secure, then this will result in HV
+ * faulting on that page first and fault handler getting the page
+ * copied over to HV side by doing UV_PAGE_OUT. This can be avoided
+ * if we just drop the HMM PTE right here and provision an new page (TODO).
+ */
+static unsigned long
+kvmppc_share_page(unsigned int lpid, unsigned long gra,
+		  unsigned long addr, unsigned long page_shift)
+{
+	struct page *page;
+	unsigned long pfn;
+	int ret;
+
+	ret = get_user_pages_fast(addr, 1, 0, &page);
+	if (ret != 1)
+		return H_PARAMETER;
+
+	pfn = page_to_pfn(page);
+	if (is_zero_pfn(pfn)) {
+		ret = U_SUCCESS;
+		goto skip_zero_page;
+	}
+
+	ret = uv_page_in(lpid, pfn << page_shift, gra, 0, page_shift);
+
+skip_zero_page:
+	put_page(page);
+	if (ret != U_SUCCESS)
+		return H_PARAMETER;
+	else
+		return H_SUCCESS;
+}
+
+/*
+ * Move page from normal memory to secure memory.
+ */
+unsigned long kvmppc_h_svm_page_in(struct kvm *kvm,
+				   unsigned long gra,
+				   unsigned long flags,
+				   unsigned long page_shift)
+{
+	unsigned long addr, end;
+	unsigned long src_pfn, dst_pfn;
+	struct kvmppc_hmm_migrate_args args;
+	struct mm_struct *mm = get_task_mm(current);
+	struct vm_area_struct *vma;
+	int ret = H_SUCCESS;
+
+	if (page_shift != PAGE_SHIFT)
+		return H_P4;
+
+	addr = kvmppc_gra_to_hva(kvm, gra, page_shift);
+	if (!addr)
+		return H_P2;
+	end = addr + (1UL << page_shift);
+
+	if (flags & H_PAGE_IN_SHARED)
+		return kvmppc_share_page(kvm->arch.lpid, gra, addr, page_shift);
+
+	args.lpid = kvm->arch.lpid;
+	args.gra = gra;
+	args.page_shift = page_shift;
+
+	down_read(&mm->mmap_sem);
+	vma = find_vma_intersection(mm, addr, end);
+	if (!vma || vma->vm_start > addr || vma->vm_end < end) {
+		ret = H_PARAMETER;
+		goto out;
+	}
+	ret = migrate_vma(&kvmppc_hmm_migrate_ops, vma, addr, end,
+			  &src_pfn, &dst_pfn, &args);
+	if (ret < 0)
+		ret = H_PARAMETER;
+out:
+	up_read(&mm->mmap_sem);
+	return ret;
+}
+
+static void
+kvmppc_hmm_fault_migrate_alloc_and_copy(struct vm_area_struct *vma,
+					const unsigned long *src_pfn,
+					unsigned long *dst_pfn,
+					unsigned long start,
+					unsigned long end,
+					void *private)
+{
+	struct page *dpage, *spage;
+	struct kvmppc_hmm_page_pvt *pvt;
+	unsigned long pfn;
+	int ret;
+
+	*dst_pfn = MIGRATE_PFN_ERROR;
+	spage = migrate_pfn_to_page(*src_pfn);
+	if (!spage || !(*src_pfn & MIGRATE_PFN_MIGRATE))
+		return;
+	if (!is_zone_device_page(spage))
+		return;
+	dpage = hmm_vma_alloc_locked_page(vma, start);
+	if (!dpage)
+		return;
+	pvt = (struct kvmppc_hmm_page_pvt *)
+	       hmm_devmem_page_get_drvdata(spage);
+
+	pfn = page_to_pfn(dpage);
+	ret = uv_page_out(pvt->lpid, pfn << PAGE_SHIFT,
+			  pvt->gra, 0, PAGE_SHIFT);
+	if (ret == U_SUCCESS)
+		*dst_pfn = migrate_pfn(pfn) | MIGRATE_PFN_LOCKED;
+}
+
+static void
+kvmppc_hmm_fault_migrate_finalize_and_map(struct vm_area_struct *vma,
+					  const unsigned long *src_pfns,
+					  const unsigned long *dst_pfns,
+					  unsigned long start,
+					  unsigned long end,
+					  void *private)
+{
+}
+
+static const struct migrate_vma_ops kvmppc_hmm_fault_migrate_ops = {
+	.alloc_and_copy = kvmppc_hmm_fault_migrate_alloc_and_copy,
+	.finalize_and_map = kvmppc_hmm_fault_migrate_finalize_and_map,
+};
+
+/*
+ * Fault handler callback when HV touches any page that has been
+ * moved to secure memory, we ask UV to give back the page by
+ * issuing a UV_PAGE_OUT uvcall.
+ */
+static int kvmppc_hmm_devmem_fault(struct hmm_devmem *devmem,
+				   struct vm_area_struct *vma,
+				   unsigned long addr,
+				   const struct page *page,
+				   unsigned int flags,
+				   pmd_t *pmdp)
+{
+	unsigned long end = addr + PAGE_SIZE;
+	unsigned long src_pfn, dst_pfn = 0;
+
+	if (migrate_vma(&kvmppc_hmm_fault_migrate_ops, vma, addr, end,
+			&src_pfn, &dst_pfn, NULL))
+		return VM_FAULT_SIGBUS;
+	if (dst_pfn == MIGRATE_PFN_ERROR)
+		return VM_FAULT_SIGBUS;
+	return 0;
+}
+
+static void kvmppc_hmm_devmem_free(struct hmm_devmem *devmem,
+				   struct page *page)
+{
+	kvmppc_hmm_put_page(page);
+}
+
+static const struct hmm_devmem_ops kvmppc_hmm_devmem_ops = {
+	.free = kvmppc_hmm_devmem_free,
+	.fault = kvmppc_hmm_devmem_fault,
+};
+
+/*
+ * Move page from secure memory to normal memory.
+ */
+unsigned long kvmppc_h_svm_page_out(struct kvm *kvm,
+				    unsigned long gra,
+				    unsigned long flags,
+				    unsigned long page_shift)
+{
+	unsigned long addr, end;
+	struct mm_struct *mm = get_task_mm(current);
+	struct vm_area_struct *vma;
+	unsigned long src_pfn, dst_pfn = 0;
+	int ret = H_SUCCESS;
+
+	if (page_shift != PAGE_SHIFT)
+		return H_P4;
+
+	addr = kvmppc_gra_to_hva(kvm, gra, page_shift);
+	if (!addr)
+		return H_P2;
+	end = addr + (1UL << page_shift);
+
+	down_read(&mm->mmap_sem);
+	vma = find_vma_intersection(mm, addr, end);
+	if (!vma || vma->vm_start > addr || vma->vm_end < end) {
+		ret = H_PARAMETER;
+		goto out;
+	}
+	ret = migrate_vma(&kvmppc_hmm_fault_migrate_ops, vma, addr, end,
+			  &src_pfn, &dst_pfn, NULL);
+	if (ret < 0)
+		ret = H_PARAMETER;
+out:
+	up_read(&mm->mmap_sem);
+	return ret;
+}
+
+/*
+ * TODO: Number of secure pages and the page size order would probably come
+ * via DT or via some uvcall. Return 8G for now.
+ */
+static unsigned long kvmppc_get_secmem_size(void)
+{
+	return (1UL << 33);
+}
+
+static int kvmppc_hmm_pages_init(void)
+{
+	int i;
+	unsigned long nr_pfns = kvmppc_hmm->devmem->pfn_last -
+				kvmppc_hmm->devmem->pfn_first;
+
+	kvmppc_hmm->pfn_bitmap = kcalloc(BITS_TO_LONGS(nr_pfns),
+					 sizeof(unsigned long), GFP_KERNEL);
+	if (!kvmppc_hmm->pfn_bitmap)
+		return -ENOMEM;
+
+	for (i = 0; i < KVMPPC_HMM_HASH_SIZE; i++)
+		INIT_HLIST_HEAD(&kvmppc_hmm_pfn_hash[i]);
+	spin_lock_init(&kvmppc_hmm_lock);
+
+	return 0;
+}
+
+int kvmppc_hmm_init(void)
+{
+	int ret = 0;
+	unsigned long size = kvmppc_get_secmem_size();
+
+	kvmppc_hmm = kzalloc(sizeof(*kvmppc_hmm), GFP_KERNEL);
+	if (!kvmppc_hmm) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	kvmppc_hmm->device = hmm_device_new(NULL);
+	if (IS_ERR(kvmppc_hmm->device)) {
+		ret = PTR_ERR(kvmppc_hmm->device);
+		goto out_free;
+	}
+
+	kvmppc_hmm->devmem = hmm_devmem_add(&kvmppc_hmm_devmem_ops,
+					    &kvmppc_hmm->device->device, size);
+	if (IS_ERR(kvmppc_hmm->devmem)) {
+		ret = PTR_ERR(kvmppc_hmm->devmem);
+		goto out_device;
+	}
+	ret = kvmppc_hmm_pages_init();
+	if (ret < 0)
+		goto out_devmem;
+
+	return ret;
+
+out_devmem:
+	hmm_devmem_remove(kvmppc_hmm->devmem);
+out_device:
+	hmm_device_put(kvmppc_hmm->device);
+out_free:
+	kfree(kvmppc_hmm);
+	kvmppc_hmm = NULL;
+out:
+	return ret;
+}
+
+void kvmppc_hmm_free(void)
+{
+	kfree(kvmppc_hmm->pfn_bitmap);
+	hmm_devmem_remove(kvmppc_hmm->devmem);
+	hmm_device_put(kvmppc_hmm->device);
+	kfree(kvmppc_hmm);
+	kvmppc_hmm = NULL;
+}
-- 
2.14.3
