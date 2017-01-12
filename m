Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzfzf3g4qzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 20:07:42 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 11/18] KVM: PPC: Book3S HV: Add basic infrastructure for radix
 guests
Date: Thu, 12 Jan 2017 20:07:19 +1100
Message-Id: <1484212046-29591-12-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1484212046-29591-1-git-send-email-paulus@ozlabs.org>
References: <1484212046-29591-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a field in struct kvm_arch and an inline helper to
indicate whether a guest is a radix guest or not, plus a new file
to contain the radix MMU code, which currently contains just a
translate function which knows how to traverse the guest page
tables to translate an address.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_book3s.h    |   3 +
 arch/powerpc/include/asm/kvm_book3s_64.h |   6 ++
 arch/powerpc/include/asm/kvm_host.h      |   2 +
 arch/powerpc/kvm/Makefile                |   3 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |  10 ++-
 arch/powerpc/kvm/book3s_64_mmu_radix.c   | 139 +++++++++++++++++++++++++++++++
 6 files changed, 160 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/kvm/book3s_64_mmu_radix.c

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 5cf306a..7adfcc0 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -182,6 +182,9 @@ extern void kvmppc_mmu_hpte_sysexit(void);
 extern int kvmppc_mmu_hv_init(void);
 extern int kvmppc_book3s_hcall_implemented(struct kvm *kvm, unsigned long hc);
 
+extern int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
+			struct kvmppc_pte *gpte, bool data, bool iswrite);
+
 /* XXX remove this export when load_last_inst() is generic */
 extern int kvmppc_ld(struct kvm_vcpu *vcpu, ulong *eaddr, int size, void *ptr, bool data);
 extern void kvmppc_book3s_queue_irqprio(struct kvm_vcpu *vcpu, unsigned int vec);
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 8482921..0db010c 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -36,6 +36,12 @@ static inline void svcpu_put(struct kvmppc_book3s_shadow_vcpu *svcpu)
 #endif
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+
+static inline bool kvm_is_radix(struct kvm *kvm)
+{
+	return kvm->arch.radix;
+}
+
 #define KVM_DEFAULT_HPT_ORDER	24	/* 16MB HPT by default */
 #endif
 
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 944532d..fb73518 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -264,6 +264,8 @@ struct kvm_arch {
 	atomic_t hpte_mod_interest;
 	cpumask_t need_tlb_flush;
 	int hpt_cma_alloc;
+	u8 radix;
+	pgd_t *pgtable;
 	u64 process_table;
 	struct dentry *debugfs_dir;
 	struct dentry *htab_dentry;
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 7dd89b7..b87ccde 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -70,7 +70,8 @@ endif
 kvm-hv-y += \
 	book3s_hv.o \
 	book3s_hv_interrupts.o \
-	book3s_64_mmu_hv.o
+	book3s_64_mmu_hv.o \
+	book3s_64_mmu_radix.o
 
 kvm-book3s_64-builtin-xics-objs-$(CONFIG_KVM_XICS) := \
 	book3s_hv_rm_xics.o
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index b795dd1..c208bf3 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -119,6 +119,9 @@ long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
 	long err = -EBUSY;
 	long order;
 
+	if (kvm_is_radix(kvm))
+		return -EINVAL;
+
 	mutex_lock(&kvm->lock);
 	if (kvm->arch.hpte_setup_done) {
 		kvm->arch.hpte_setup_done = 0;
@@ -157,7 +160,7 @@ void kvmppc_free_hpt(struct kvm *kvm)
 	if (kvm->arch.hpt_cma_alloc)
 		kvm_release_hpt(virt_to_page(kvm->arch.hpt_virt),
 				1 << (kvm->arch.hpt_order - PAGE_SHIFT));
-	else
+	else if (kvm->arch.hpt_virt)
 		free_pages(kvm->arch.hpt_virt,
 			   kvm->arch.hpt_order - PAGE_SHIFT);
 }
@@ -1675,7 +1678,10 @@ void kvmppc_mmu_book3s_hv_init(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.slb_nr = 32;		/* POWER7/POWER8 */
 
-	mmu->xlate = kvmppc_mmu_book3s_64_hv_xlate;
+	if (kvm_is_radix(vcpu->kvm))
+		mmu->xlate = kvmppc_mmu_radix_xlate;
+	else
+		mmu->xlate = kvmppc_mmu_book3s_64_hv_xlate;
 	mmu->reset_msr = kvmppc_mmu_book3s_64_hv_reset_msr;
 
 	vcpu->arch.hflags |= BOOK3S_HFLAG_SLB;
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
new file mode 100644
index 0000000..9091407
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -0,0 +1,139 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * Copyright 2016 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
+ */
+
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/kvm.h>
+#include <linux/kvm_host.h>
+
+#include <asm/kvm_ppc.h>
+#include <asm/kvm_book3s.h>
+#include <asm/page.h>
+#include <asm/mmu.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+
+/*
+ * Supported radix tree geometry.
+ * Like p9, we support either 5 or 9 bits at the first (lowest) level,
+ * for a page size of 64k or 4k.
+ */
+static int p9_supported_radix_bits[4] = { 5, 9, 9, 13 };
+
+int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
+			   struct kvmppc_pte *gpte, bool data, bool iswrite)
+{
+	struct kvm *kvm = vcpu->kvm;
+	u32 pid;
+	int ret, level, ps;
+	__be64 prte, rpte;
+	unsigned long root, pte, index;
+	unsigned long rts, bits, offset;
+	unsigned long gpa;
+	unsigned long proc_tbl_size;
+
+	/* Work out effective PID */
+	switch (eaddr >> 62) {
+	case 0:
+		pid = vcpu->arch.pid;
+		break;
+	case 3:
+		pid = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+	proc_tbl_size = 1 << ((kvm->arch.process_table & PRTS_MASK) + 12);
+	if (pid * 16 >= proc_tbl_size)
+		return -EINVAL;
+
+	/* Read partition table to find root of tree for effective PID */
+	ret = kvm_read_guest(kvm, kvm->arch.process_table + pid * 16,
+			     &prte, sizeof(prte));
+	if (ret)
+		return ret;
+
+	root = be64_to_cpu(prte);
+	rts = ((root & RTS1_MASK) >> (RTS1_SHIFT - 3)) |
+		((root & RTS2_MASK) >> RTS2_SHIFT);
+	bits = root & RPDS_MASK;
+	root = root & RPDB_MASK;
+
+	/* P9 DD1 interprets RTS (radix tree size) differently */
+	offset = rts + 31;
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+		offset -= 3;
+
+	/* current implementations only support 52-bit space */
+	if (offset != 52)
+		return -EINVAL;
+
+	for (level = 3; level >= 0; --level) {
+		if (level && bits != p9_supported_radix_bits[level])
+			return -EINVAL;
+		if (level == 0 && !(bits == 5 || bits == 9))
+			return -EINVAL;
+		offset -= bits;
+		index = (eaddr >> offset) & ((1UL << bits) - 1);
+		/* check that low bits of page table base are zero */
+		if (root & ((1UL << (bits + 3)) - 1))
+			return -EINVAL;
+		ret = kvm_read_guest(kvm, root + index * 8,
+				     &rpte, sizeof(rpte));
+		if (ret)
+			return ret;
+		pte = __be64_to_cpu(rpte);
+		if (!(pte & _PAGE_PRESENT))
+			return -ENOENT;
+		if (pte & _PAGE_PTE)
+			break;
+		bits = pte & 0x1f;
+		root = pte & 0x0fffffffffffff00ul;
+	}
+	/* need a leaf at lowest level; 512GB pages not supported */
+	if (level < 0 || level == 3)
+		return -EINVAL;
+
+	/* offset is now log base 2 of the page size */
+	gpa = pte & 0x01fffffffffff000ul;
+	if (gpa & ((1ul << offset) - 1))
+		return -EINVAL;
+	gpa += eaddr & ((1ul << offset) - 1);
+	for (ps = MMU_PAGE_4K; ps < MMU_PAGE_COUNT; ++ps)
+		if (offset == mmu_psize_defs[ps].shift)
+			break;
+	gpte->page_size = ps;
+
+	gpte->eaddr = eaddr;
+	gpte->raddr = gpa;
+
+	/* Work out permissions */
+	gpte->may_read = !!(pte & _PAGE_READ);
+	gpte->may_write = !!(pte & _PAGE_WRITE);
+	gpte->may_execute = !!(pte & _PAGE_EXEC);
+	if (kvmppc_get_msr(vcpu) & MSR_PR) {
+		if (pte & _PAGE_PRIVILEGED) {
+			gpte->may_read = 0;
+			gpte->may_write = 0;
+			gpte->may_execute = 0;
+		}
+	} else {
+		if (!(pte & _PAGE_PRIVILEGED)) {
+			/* Check AMR/IAMR to see if strict mode is in force */
+			if (vcpu->arch.amr & (1ul << 62))
+				gpte->may_read = 0;
+			if (vcpu->arch.amr & (1ul << 63))
+				gpte->may_write = 0;
+			if (vcpu->arch.iamr & (1ul << 62))
+				gpte->may_execute = 0;
+		}
+	}
+
+	return 0;
+}
+
-- 
2.7.4
