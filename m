Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2800EC43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:17:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D21D205C9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="NR+RJjfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D21D205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PdSm6y2WzF0RH
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 22:17:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="NR+RJjfW";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PcSN52lmzF35t
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 21:32:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="NR+RJjfW"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PcSM3RTkz9t0l; Tue,  2 Oct 2018 21:32:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42PcSM1xhsz9sjH;
 Tue,  2 Oct 2018 21:32:03 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538479923; bh=df7lIOSgA3COy75t7xspbVZ7xMC5vdVWUt/mz17ql38=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NR+RJjfWYmXYEKm6MKOKrjgokhTLTI81utMM6QvyzTA89VZJIzGpB3+mpUsxKgP+b
 VzhlBTQfeyo2ILCsRaMrCLnAR334ITHk1SKCNyREKoG55cM2gnW/6gfPRC8ys+cPYc
 KjdIKXMMI0YLHUfs4XY7TBJnDg/Z203k+f1F0f0mW0ggmU7j1IRxAF5MqGAq9brHVv
 lZzHl7go3N9V91BEwCzEkkXnYFfRYYJpJTBO1EdsBEGYlmf8lMAvDanNbau8q1Kjqf
 E1MpB5rLgdwKOdvZm/E5XIt3JOb6VYNl1BBqPBVlrjRIzR7joHMx/gJhiYulCj6sNE
 CMA9e9JOz5PaA==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v3 17/33] KVM: PPC: Book3S HV: Framework and hcall stubs for
 nested virtualization
Date: Tue,  2 Oct 2018 21:31:16 +1000
Message-Id: <1538479892-14835-18-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This starts the process of adding the code to support nested HV-style
virtualization.  It defines a new H_SET_PARTITION_TABLE hypercall which
a nested hypervisor can use to set the base address and size of a
partition table in its memory (analogous to the PTCR register).
On the host (level 0 hypervisor) side, the H_SET_PARTITION_TABLE
hypercall from the guest is handled by code that saves the virtual
PTCR value for the guest.

This also adds code for creating and destroying nested guests and for
reading the partition table entry for a nested guest from L1 memory.
Each nested guest has its own shadow LPID value, different in general
from the LPID value used by the nested hypervisor to refer to it.  The
shadow LPID value is allocated at nested guest creation time.

Nested hypervisor functionality is only available for a radix guest,
which therefore means a radix host on a POWER9 (or later) processor.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/hvcall.h         |   5 +
 arch/powerpc/include/asm/kvm_book3s.h     |  10 +-
 arch/powerpc/include/asm/kvm_book3s_64.h  |  33 ++++
 arch/powerpc/include/asm/kvm_book3s_asm.h |   3 +
 arch/powerpc/include/asm/kvm_host.h       |   5 +
 arch/powerpc/kvm/Makefile                 |   3 +-
 arch/powerpc/kvm/book3s_hv.c              |  27 ++-
 arch/powerpc/kvm/book3s_hv_nested.c       | 287 ++++++++++++++++++++++++++++++
 8 files changed, 366 insertions(+), 7 deletions(-)
 create mode 100644 arch/powerpc/kvm/book3s_hv_nested.c

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index a0b17f9..c95c651 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -322,6 +322,11 @@
 #define H_GET_24X7_DATA		0xF07C
 #define H_GET_PERF_COUNTER_INFO	0xF080
 
+/* Platform-specific hcalls used for nested HV KVM */
+#define H_SET_PARTITION_TABLE	0xF800
+#define H_ENTER_NESTED		0xF804
+#define H_TLB_INVALIDATE	0xF808
+
 /* Values for 2nd argument to H_SET_MODE */
 #define H_SET_MODE_RESOURCE_SET_CIABR		1
 #define H_SET_MODE_RESOURCE_SET_DAWR		2
diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 91c9779..43f212e 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -274,6 +274,13 @@ static inline void kvmppc_save_tm_sprs(struct kvm_vcpu *vcpu) {}
 static inline void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu) {}
 #endif
 
+long kvmhv_nested_init(void);
+void kvmhv_nested_exit(void);
+void kvmhv_vm_nested_init(struct kvm *kvm);
+long kvmhv_set_partition_table(struct kvm_vcpu *vcpu);
+void kvmhv_set_ptbl_entry(unsigned int lpid, u64 dw0, u64 dw1);
+void kvmhv_release_all_nested(struct kvm *kvm);
+
 void kvmppc_giveup_fac(struct kvm_vcpu *vcpu, ulong fac);
 
 extern int kvm_irq_bypass;
@@ -387,9 +394,6 @@ extern int kvmppc_h_logical_ci_store(struct kvm_vcpu *vcpu);
 /* TO = 31 for unconditional trap */
 #define INS_TW				0x7fe00008
 
-/* LPIDs we support with this build -- runtime limit may be lower */
-#define KVMPPC_NR_LPIDS			(LPID_RSVD + 1)
-
 #define SPLIT_HACK_MASK			0xff000000
 #define SPLIT_HACK_OFFS			0xfb000000
 
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 5c0e2d9..6d67b6a 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -23,6 +23,39 @@
 #include <linux/string.h>
 #include <asm/bitops.h>
 #include <asm/book3s/64/mmu-hash.h>
+#include <asm/cpu_has_feature.h>
+
+#ifdef CONFIG_PPC_PSERIES
+static inline bool kvmhv_on_pseries(void)
+{
+	return !cpu_has_feature(CPU_FTR_HVMODE);
+}
+#else
+static inline bool kvmhv_on_pseries(void)
+{
+	return false;
+}
+#endif
+
+/*
+ * Structure for a nested guest, that is, for a guest that is managed by
+ * one of our guests.
+ */
+struct kvm_nested_guest {
+	struct kvm *l1_host;		/* L1 VM that owns this nested guest */
+	int l1_lpid;			/* lpid L1 guest thinks this guest is */
+	int shadow_lpid;		/* real lpid of this nested guest */
+	pgd_t *shadow_pgtable;		/* our page table for this guest */
+	u64 l1_gr_to_hr;		/* L1's addr of part'n-scoped table */
+	u64 process_table;		/* process table entry for this guest */
+	long refcnt;			/* number of pointers to this struct */
+	struct mutex tlb_lock;		/* serialize page faults and tlbies */
+	struct kvm_nested_guest *next;
+};
+
+struct kvm_nested_guest *kvmhv_get_nested(struct kvm *kvm, int l1_lpid,
+					  bool create);
+void kvmhv_put_nested(struct kvm_nested_guest *gp);
 
 /* Power architecture requires HPT is at least 256kiB, at most 64TiB */
 #define PPC_MIN_HPT_ORDER	18
diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index d978fdf..eb3ba63 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -25,6 +25,9 @@
 #define XICS_MFRR		0xc
 #define XICS_IPI		2	/* interrupt source # for IPIs */
 
+/* LPIDs we support with this build -- runtime limit may be lower */
+#define KVMPPC_NR_LPIDS			(LPID_RSVD + 1)
+
 /* Maximum number of threads per physical core */
 #define MAX_SMT_THREADS		8
 
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index c9cc42f..c35d4f2 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -46,6 +46,7 @@
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 #include <asm/kvm_book3s_asm.h>		/* for MAX_SMT_THREADS */
 #define KVM_MAX_VCPU_ID		(MAX_SMT_THREADS * KVM_MAX_VCORES)
+#define KVM_MAX_NESTED_GUESTS	KVMPPC_NR_LPIDS
 
 #else
 #define KVM_MAX_VCPU_ID		KVM_MAX_VCPUS
@@ -287,6 +288,7 @@ struct kvm_arch {
 	u8 radix;
 	u8 fwnmi_enabled;
 	bool threads_indep;
+	bool nested_enable;
 	pgd_t *pgtable;
 	u64 process_table;
 	struct dentry *debugfs_dir;
@@ -312,6 +314,9 @@ struct kvm_arch {
 #endif
 	struct kvmppc_ops *kvm_ops;
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	u64 l1_ptcr;
+	int max_nested_lpid;
+	struct kvm_nested_guest *nested_guests[KVM_MAX_NESTED_GUESTS];
 	/* This array can grow quite large, keep it at the end */
 	struct kvmppc_vcore *vcores[KVM_MAX_VCORES];
 #endif
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index f872c04..e814f40 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -75,7 +75,8 @@ kvm-hv-y += \
 	book3s_hv.o \
 	book3s_hv_interrupts.o \
 	book3s_64_mmu_hv.o \
-	book3s_64_mmu_radix.o
+	book3s_64_mmu_radix.o \
+	book3s_hv_nested.o
 
 kvm-hv-$(CONFIG_PPC_TRANSACTIONAL_MEM) += \
 	book3s_hv_tm.o
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ca0e4f4..ca2529e 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -934,6 +934,19 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 		if (ret == H_TOO_HARD)
 			return RESUME_HOST;
 		break;
+
+	case H_SET_PARTITION_TABLE:
+		ret = H_FUNCTION;
+		if (vcpu->kvm->arch.nested_enable)
+			ret = kvmhv_set_partition_table(vcpu);
+		break;
+	case H_ENTER_NESTED:
+		ret = H_FUNCTION;
+		break;
+	case H_TLB_INVALIDATE:
+		ret = H_FUNCTION;
+		break;
+
 	default:
 		return RESUME_HOST;
 	}
@@ -4149,8 +4162,7 @@ void kvmppc_setup_partition_table(struct kvm *kvm)
 			__pa(kvm->arch.pgtable) | RADIX_PGD_INDEX_SIZE;
 		dw1 = PATB_GR | kvm->arch.process_table;
 	}
-
-	mmu_partition_table_set_entry(kvm->arch.lpid, dw0, dw1);
+	kvmhv_set_ptbl_entry(kvm->arch.lpid, dw0, dw1);
 }
 
 /*
@@ -4366,6 +4378,8 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 
 	kvmppc_alloc_host_rm_ops();
 
+	kvmhv_vm_nested_init(kvm);
+
 	/*
 	 * Since we don't flush the TLB when tearing down a VM,
 	 * and this lpid might have previously been used,
@@ -4509,8 +4523,10 @@ static void kvmppc_core_destroy_vm_hv(struct kvm *kvm)
 
 	/* Perform global invalidation and return lpid to the pool */
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		if (kvm->arch.nested_enable)
+			kvmhv_release_all_nested(kvm);
 		kvm->arch.process_table = 0;
-		kvmppc_setup_partition_table(kvm);
+		kvmhv_set_ptbl_entry(kvm->arch.lpid, 0, 0);
 	}
 	kvmppc_free_lpid(kvm->arch.lpid);
 
@@ -4981,6 +4997,10 @@ static int kvmppc_book3s_init_hv(void)
 	if (r < 0)
 		return -ENODEV;
 
+	r = kvmhv_nested_init();
+	if (r)
+		return r;
+
 	r = kvm_init_subcore_bitmap();
 	if (r)
 		return r;
@@ -5039,6 +5059,7 @@ static void kvmppc_book3s_exit_hv(void)
 	if (kvmppc_radix_possible())
 		kvmppc_radix_exit();
 	kvmppc_hv_ops = NULL;
+	kvmhv_nested_exit();
 }
 
 module_init(kvmppc_book3s_init_hv);
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
new file mode 100644
index 0000000..3ae5c39
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright IBM Corporation, 2018
+ * Authors Suraj Jitindar Singh <sjitindarsingh@gmail.com>
+ *	   Paul Mackerras <paulus@ozlabs.org>
+ *
+ * Description: KVM functions specific to running nested KVM-HV guests
+ * on Book3S processors (specifically POWER9 and later).
+ */
+
+#include <linux/kernel.h>
+#include <linux/kvm_host.h>
+
+#include <asm/kvm_ppc.h>
+#include <asm/mmu.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+
+static struct patb_entry *pseries_partition_tb;
+
+static void kvmhv_update_ptbl_cache(struct kvm_nested_guest *gp);
+
+long kvmhv_nested_init(void)
+{
+	long int ptb_order;
+	unsigned long ptcr;
+	long rc;
+
+	if (!kvmhv_on_pseries())
+		return 0;
+	if (!radix_enabled())
+		return -ENODEV;
+
+	/* find log base 2 of KVMPPC_NR_LPIDS, rounding up */
+	ptb_order = __ilog2(KVMPPC_NR_LPIDS - 1) + 1;
+	if (ptb_order < 8)
+		ptb_order = 8;
+	pseries_partition_tb = kmalloc(sizeof(struct patb_entry) << ptb_order,
+				       GFP_KERNEL);
+	if (!pseries_partition_tb) {
+		pr_err("kvm-hv: failed to allocated nested partition table\n");
+		return -ENOMEM;
+	}
+
+	ptcr = __pa(pseries_partition_tb) | (ptb_order - 8);
+	rc = plpar_hcall_norets(H_SET_PARTITION_TABLE, ptcr);
+	if (rc != H_SUCCESS) {
+		pr_err("kvm-hv: Parent hypervisor does not support nesting (rc=%ld)\n",
+		       rc);
+		kfree(pseries_partition_tb);
+		pseries_partition_tb = NULL;
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+void kvmhv_nested_exit(void)
+{
+	/*
+	 * N.B. the kvmhv_on_pseries() test is there because it enables
+	 * the compiler to remove the call to plpar_hcall_norets()
+	 * when CONFIG_PPC_PSERIES=n.
+	 */
+	if (kvmhv_on_pseries() && pseries_partition_tb) {
+		plpar_hcall_norets(H_SET_PARTITION_TABLE, 0);
+		kfree(pseries_partition_tb);
+		pseries_partition_tb = NULL;
+	}
+}
+
+void kvmhv_set_ptbl_entry(unsigned int lpid, u64 dw0, u64 dw1)
+{
+	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		mmu_partition_table_set_entry(lpid, dw0, dw1);
+	} else {
+		pseries_partition_tb[lpid].patb0 = cpu_to_be64(dw0);
+		pseries_partition_tb[lpid].patb1 = cpu_to_be64(dw1);
+		/* this will be emulated, L0 will do the necessary barriers */
+		asm volatile(PPC_TLBIE_5(%0, %1, 2, 0, 1) : :
+			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
+	}
+}
+
+static void kvmhv_set_nested_ptbl(struct kvm_nested_guest *gp)
+{
+	unsigned long dw0;
+
+	dw0 = PATB_HR | radix__get_tree_size() |
+		__pa(gp->shadow_pgtable) | RADIX_PGD_INDEX_SIZE;
+	kvmhv_set_ptbl_entry(gp->shadow_lpid, dw0, gp->process_table);
+}
+
+void kvmhv_vm_nested_init(struct kvm *kvm)
+{
+	kvm->arch.max_nested_lpid = -1;
+}
+
+/*
+ * Handle the H_SET_PARTITION_TABLE hcall.
+ * r4 = guest real address of partition table + log_2(size) - 12
+ * (formatted as for the PTCR).
+ */
+long kvmhv_set_partition_table(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	unsigned long ptcr = kvmppc_get_gpr(vcpu, 4);
+
+	kvm->arch.l1_ptcr = ptcr;
+	return H_SUCCESS;
+}
+
+/*
+ * Reload the partition table entry for a guest.
+ * Caller must hold gp->tlb_lock.
+ */
+static void kvmhv_update_ptbl_cache(struct kvm_nested_guest *gp)
+{
+	int ret;
+	struct patb_entry ptbl_entry;
+	unsigned long ptbl_addr;
+	struct kvm *kvm = gp->l1_host;
+
+	ptbl_addr = (kvm->arch.l1_ptcr & PRTB_MASK) + (gp->l1_lpid << 4);
+	ret = kvm_read_guest(kvm, ptbl_addr,
+			     &ptbl_entry, sizeof(ptbl_entry));
+	if (ret) {
+		gp->l1_gr_to_hr = 0;
+		gp->process_table = 0;
+	} else {
+		gp->l1_gr_to_hr = be64_to_cpu(ptbl_entry.patb0);
+		gp->process_table = be64_to_cpu(ptbl_entry.patb1);
+	}
+	kvmhv_set_nested_ptbl(gp);
+}
+
+struct kvm_nested_guest *kvmhv_alloc_nested(struct kvm *kvm, unsigned int lpid)
+{
+	struct kvm_nested_guest *gp;
+	long shadow_lpid;
+
+	gp = kzalloc(sizeof(*gp), GFP_KERNEL);
+	if (!gp)
+		return NULL;
+	gp->l1_host = kvm;
+	gp->l1_lpid = lpid;
+	mutex_init(&gp->tlb_lock);
+	gp->shadow_pgtable = pgd_alloc(kvm->mm);
+	if (!gp->shadow_pgtable)
+		goto out_free;
+	shadow_lpid = kvmppc_alloc_lpid();
+	if (shadow_lpid < 0)
+		goto out_free2;
+	gp->shadow_lpid = shadow_lpid;
+
+	return gp;
+
+ out_free2:
+	pgd_free(kvm->mm, gp->shadow_pgtable);
+ out_free:
+	kfree(gp);
+	return NULL;
+}
+
+/*
+ * Free up any resources allocated for a nested guest.
+ */
+static void kvmhv_release_nested(struct kvm_nested_guest *gp)
+{
+	kvmhv_set_ptbl_entry(gp->shadow_lpid, 0, 0);
+	kvmppc_free_lpid(gp->shadow_lpid);
+	if (gp->shadow_pgtable)
+		pgd_free(gp->l1_host->mm, gp->shadow_pgtable);
+	kfree(gp);
+}
+
+static void kvmhv_remove_nested(struct kvm_nested_guest *gp)
+{
+	struct kvm *kvm = gp->l1_host;
+	int lpid = gp->l1_lpid;
+	long ref;
+
+	spin_lock(&kvm->mmu_lock);
+	if (gp == kvm->arch.nested_guests[lpid]) {
+		kvm->arch.nested_guests[lpid] = NULL;
+		if (lpid == kvm->arch.max_nested_lpid) {
+			while (--lpid >= 0 && !kvm->arch.nested_guests[lpid])
+				;
+			kvm->arch.max_nested_lpid = lpid;
+		}
+		--gp->refcnt;
+	}
+	ref = gp->refcnt;
+	spin_unlock(&kvm->mmu_lock);
+	if (ref == 0)
+		kvmhv_release_nested(gp);
+}
+
+/*
+ * Free up all nested resources allocated for this guest.
+ */
+void kvmhv_release_all_nested(struct kvm *kvm)
+{
+	int i;
+	struct kvm_nested_guest *gp;
+	struct kvm_nested_guest *freelist = NULL;
+
+	spin_lock(&kvm->mmu_lock);
+	for (i = 0; i <= kvm->arch.max_nested_lpid; i++) {
+		gp = kvm->arch.nested_guests[i];
+		if (!gp)
+			continue;
+		kvm->arch.nested_guests[i] = NULL;
+		if (--gp->refcnt == 0) {
+			gp->next = freelist;
+			freelist = gp;
+		}
+	}
+	kvm->arch.max_nested_lpid = -1;
+	spin_unlock(&kvm->mmu_lock);
+	while ((gp = freelist) != NULL) {
+		freelist = gp->next;
+		kvmhv_release_nested(gp);
+	}
+}
+
+/* caller must hold gp->tlb_lock */
+void kvmhv_flush_nested(struct kvm_nested_guest *gp)
+{
+	kvmhv_update_ptbl_cache(gp);
+	if (gp->l1_gr_to_hr == 0)
+		kvmhv_remove_nested(gp);
+}
+
+struct kvm_nested_guest *kvmhv_get_nested(struct kvm *kvm, int l1_lpid,
+					  bool create)
+{
+	struct kvm_nested_guest *gp, *newgp;
+
+	if (l1_lpid >= KVM_MAX_NESTED_GUESTS ||
+	    l1_lpid >= (1ul << ((kvm->arch.l1_ptcr & PRTS_MASK) + 12 - 4)))
+		return NULL;
+
+	spin_lock(&kvm->mmu_lock);
+	gp = kvm->arch.nested_guests[l1_lpid];
+	if (gp)
+		++gp->refcnt;
+	spin_unlock(&kvm->mmu_lock);
+
+	if (gp || !create)
+		return gp;
+
+	newgp = kvmhv_alloc_nested(kvm, l1_lpid);
+	if (!newgp)
+		return NULL;
+	spin_lock(&kvm->mmu_lock);
+	if (kvm->arch.nested_guests[l1_lpid]) {
+		/* someone else beat us to it */
+		gp = kvm->arch.nested_guests[l1_lpid];
+	} else {
+		kvm->arch.nested_guests[l1_lpid] = newgp;
+		++newgp->refcnt;
+		gp = newgp;
+		newgp = NULL;
+		if (l1_lpid > kvm->arch.max_nested_lpid)
+			kvm->arch.max_nested_lpid = l1_lpid;
+	}
+	++gp->refcnt;
+	spin_unlock(&kvm->mmu_lock);
+
+	if (newgp)
+		kvmhv_release_nested(newgp);
+
+	return gp;
+}
+
+void kvmhv_put_nested(struct kvm_nested_guest *gp)
+{
+	struct kvm *kvm = gp->l1_host;
+	long ref;
+
+	spin_lock(&kvm->mmu_lock);
+	ref = --gp->refcnt;
+	spin_unlock(&kvm->mmu_lock);
+	if (ref == 0)
+		kvmhv_release_nested(gp);
+}
-- 
2.7.4

