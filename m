Return-Path: <bharata@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JVl304N1zDrDD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 13:57:02 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8O3rcM3074115
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2018 23:57:00 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mpmf0pa49-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2018 23:57:00 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.ibm.com>;
 Mon, 24 Sep 2018 04:56:57 +0100
From: Bharata B Rao <bharata@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@au1.ibm.com, benh@linux.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 jglisse@redhat.com, linuxram@us.ibm.com,
 Bharata B Rao <bharata@linux.ibm.com>
Subject: [RFC PATCH v0 3/3] kvmppc: Handle memory plug/unplug to secure VM
Date: Mon, 24 Sep 2018 09:26:41 +0530
In-Reply-To: <20180924035641.14572-1-bharata@linux.ibm.com>
References: <20180924035641.14572-1-bharata@linux.ibm.com>
Message-Id: <20180924035641.14572-4-bharata@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Register the new memslot with UV during plug and unregister the memslot
during unplug.

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 arch/powerpc/include/asm/kvm_ppc.h   |  6 ++++--
 arch/powerpc/include/asm/ucall-api.h |  5 +++++
 arch/powerpc/kvm/book3s.c            |  5 +++--
 arch/powerpc/kvm/book3s_hv.c         | 23 ++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_pr.c         |  3 ++-
 arch/powerpc/kvm/powerpc.c           |  2 +-
 6 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index ba81a07e2bdf..2f0d7c64eb18 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -226,7 +226,8 @@ extern int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 extern void kvmppc_core_commit_memory_region(struct kvm *kvm,
 				const struct kvm_userspace_memory_region *mem,
 				const struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new);
+				const struct kvm_memory_slot *new,
+				enum kvm_mr_change change);
 extern int kvm_vm_ioctl_get_smmu_info(struct kvm *kvm,
 				      struct kvm_ppc_smmu_info *info);
 extern void kvmppc_core_flush_memslot(struct kvm *kvm,
@@ -296,7 +297,8 @@ struct kvmppc_ops {
 	void (*commit_memory_region)(struct kvm *kvm,
 				     const struct kvm_userspace_memory_region *mem,
 				     const struct kvm_memory_slot *old,
-				     const struct kvm_memory_slot *new);
+				     const struct kvm_memory_slot *new,
+				     enum kvm_mr_change change);
 	int (*unmap_hva_range)(struct kvm *kvm, unsigned long start,
 			   unsigned long end);
 	int (*age_hva)(struct kvm *kvm, unsigned long start, unsigned long end);
diff --git a/arch/powerpc/include/asm/ucall-api.h b/arch/powerpc/include/asm/ucall-api.h
index 9ddfcf541211..652797184b86 100644
--- a/arch/powerpc/include/asm/ucall-api.h
+++ b/arch/powerpc/include/asm/ucall-api.h
@@ -23,4 +23,9 @@ static inline int uv_register_mem_slot(u64 lpid, u64 dw0, u64 dw1, u64 dw2,
 	return 0;
 }
 
+static inline int uv_unregister_mem_slot(u64 lpid, u64 dw0)
+{
+	return 0;
+}
+
 #endif	/* _ASM_POWERPC_UCALL_API_H */
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 87348e498c89..15ddae43849d 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -804,9 +804,10 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 void kvmppc_core_commit_memory_region(struct kvm *kvm,
 				const struct kvm_userspace_memory_region *mem,
 				const struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new)
+				const struct kvm_memory_slot *new,
+				enum kvm_mr_change change)
 {
-	kvm->arch.kvm_ops->commit_memory_region(kvm, mem, old, new);
+	kvm->arch.kvm_ops->commit_memory_region(kvm, mem, old, new, change);
 }
 
 int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 708545edb17d..9d4c42c1d3ee 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3729,7 +3729,8 @@ static int kvmppc_core_prepare_memory_region_hv(struct kvm *kvm,
 static void kvmppc_core_commit_memory_region_hv(struct kvm *kvm,
 				const struct kvm_userspace_memory_region *mem,
 				const struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new)
+				const struct kvm_memory_slot *new,
+				enum kvm_mr_change change)
 {
 	unsigned long npages = mem->memory_size >> PAGE_SHIFT;
 
@@ -3741,6 +3742,26 @@ static void kvmppc_core_commit_memory_region_hv(struct kvm *kvm,
 	 */
 	if (npages)
 		atomic64_inc(&kvm->arch.mmio_update);
+	/*
+	 * If UV hasn't yet called H_SVM_INIT_START, don't register memslots.
+	 */
+	if (!kvm->arch.svm_init_start)
+		return;
+
+#ifdef CONFIG_PPC_SVM
+	/*
+	 * TODO: Handle KVM_MR_MOVE
+	 */
+	if (change == KVM_MR_CREATE) {
+		uv_register_mem_slot(kvm->arch.lpid,
+					   new->base_gfn << PAGE_SHIFT,
+					   new->npages * PAGE_SIZE,
+					   0,
+					   new->id);
+	} else if (change == KVM_MR_DELETE) {
+		uv_unregister_mem_slot(kvm->arch.lpid, old->id);
+	}
+#endif
 }
 
 /*
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 614ebb4261f7..844af9844a0c 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1914,7 +1914,8 @@ static int kvmppc_core_prepare_memory_region_pr(struct kvm *kvm,
 static void kvmppc_core_commit_memory_region_pr(struct kvm *kvm,
 				const struct kvm_userspace_memory_region *mem,
 				const struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new)
+				const struct kvm_memory_slot *new,
+				enum kvm_mr_change change)
 {
 	return;
 }
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index eba5756d5b41..cfc6e5dcd1c5 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -691,7 +691,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				   const struct kvm_memory_slot *new,
 				   enum kvm_mr_change change)
 {
-	kvmppc_core_commit_memory_region(kvm, mem, old, new);
+	kvmppc_core_commit_memory_region(kvm, mem, old, new, change);
 }
 
 void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
-- 
2.14.3
