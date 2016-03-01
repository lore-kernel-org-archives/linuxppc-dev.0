Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 86E881A0B57
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 17:55:52 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 1 Mar 2016 16:55:50 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 957842BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 17:55:44 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u216tVbJ2359610
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 17:55:44 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u216t6ea015756
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 17:55:07 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: kvm-ppc@vger.kernel.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Subject: [PATCH kernel v2 4/4] KVM: PPC: Add support for 64bit TCE windows
Date: Tue,  1 Mar 2016 17:54:40 +1100
Message-Id: <1456815280-38546-5-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1456815280-38546-1-git-send-email-aik@ozlabs.ru>
References: <1456815280-38546-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The existing KVM_CREATE_SPAPR_TCE only supports 32bit windows which is not
enough for directly mapped windows as the guest can get more than 4GB.

This adds KVM_CREATE_SPAPR_TCE_64 ioctl and advertises it
via KVM_CAP_SPAPR_TCE_64 capability. The table size is checked against
the locked memory limit.

Since 64bit windows are to support Dynamic DMA windows (DDW), let's add
@bus_offset and @page_shift which are also required by DDW.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* fixed padding in kvm_create_spapr_tce_64
* added comment in commit log about checking the window size
---
 Documentation/virtual/kvm/api.txt   | 32 ++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/kvm_ppc.h  |  2 +-
 arch/powerpc/include/uapi/asm/kvm.h |  9 +++++++++
 arch/powerpc/kvm/book3s_64_vio.c    | 10 +++++++---
 arch/powerpc/kvm/powerpc.c          | 25 ++++++++++++++++++++++++-
 include/uapi/linux/kvm.h            |  2 ++
 6 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index da39435..bc78652 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3060,6 +3060,38 @@ an implementation for these despite the in kernel acceleration.
 
 This capability is always enabled.
 
+4.98 KVM_CREATE_SPAPR_TCE_64
+
+Capability: KVM_CAP_SPAPR_TCE_64
+Architectures: powerpc
+Type: vm ioctl
+Parameters: struct kvm_create_spapr_tce_64 (in)
+Returns: file descriptor for manipulating the created TCE table
+
+This is an extension for KVM_CAP_SPAPR_TCE which only supports 32bit
+windows, described in 4.62 KVM_CREATE_SPAPR_TCE
+
+This capability uses extended struct in ioctl interface:
+
+/* for KVM_CAP_SPAPR_TCE_64 */
+struct kvm_create_spapr_tce_64 {
+	__u64 liobn;
+	__u32 page_shift;
+	__u32 flags;
+	__u64 offset;	/* in pages */
+	__u64 size; 	/* in pages */
+};
+
+The aim of extension is to support an additional bigger DMA window with
+a variable page size.
+KVM_CREATE_SPAPR_TCE_64 receives a 64bit window size, an IOMMU page shift and
+a bus offset of the corresponding DMA window, @size and @offset are numbers
+of IOMMU pages.
+
+@flags are not used at the moment.
+
+The rest of functionality is identical to KVM_CREATE_SPAPR_TCE.
+
 5. The kvm_run structure
 ------------------------
 
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 197a8ac..2544eda 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -165,7 +165,7 @@ extern void kvmppc_map_vrma(struct kvm_vcpu *vcpu,
 extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
 
 extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
-				struct kvm_create_spapr_tce *args);
+				struct kvm_create_spapr_tce_64 *args);
 extern struct kvmppc_spapr_tce_table *kvmppc_find_table(
 		struct kvm_vcpu *vcpu, unsigned long liobn);
 extern long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index ab4d473..c93cf35 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -333,6 +333,15 @@ struct kvm_create_spapr_tce {
 	__u32 window_size;
 };
 
+/* for KVM_CAP_SPAPR_TCE_64 */
+struct kvm_create_spapr_tce_64 {
+	__u64 liobn;
+	__u32 page_shift;
+	__u32 flags;
+	__u64 offset;	/* in pages */
+	__u64 size;	/* in pages */
+};
+
 /* for KVM_ALLOCATE_RMA */
 struct kvm_allocate_rma {
 	__u64 rma_size;
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 61cbc44..2c2d103 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -147,20 +147,23 @@ static const struct file_operations kvm_spapr_tce_fops = {
 };
 
 long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
-				   struct kvm_create_spapr_tce *args)
+				   struct kvm_create_spapr_tce_64 *args)
 {
 	struct kvmppc_spapr_tce_table *stt = NULL;
 	unsigned long npages, size;
 	int ret = -ENOMEM;
 	int i;
 
+	if (!args->size)
+		return -EINVAL;
+
 	/* Check this LIOBN hasn't been previously allocated */
 	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
 		if (stt->liobn == args->liobn)
 			return -EBUSY;
 	}
 
-	size = args->window_size >> IOMMU_PAGE_SHIFT_4K;
+	size = args->size;
 	npages = kvmppc_tce_pages(size);
 	ret = kvmppc_account_memlimit(kvmppc_stt_pages(npages), true);
 	if (ret) {
@@ -174,7 +177,8 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 		goto fail;
 
 	stt->liobn = args->liobn;
-	stt->page_shift = IOMMU_PAGE_SHIFT_4K;
+	stt->page_shift = args->page_shift;
+	stt->offset = args->offset;
 	stt->size = size;
 	stt->kvm = kvm;
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 9258675..19aa59b 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -33,6 +33,7 @@
 #include <asm/tlbflush.h>
 #include <asm/cputhreads.h>
 #include <asm/irqflags.h>
+#include <asm/iommu.h>
 #include "timing.h"
 #include "irq.h"
 #include "../mm/mmu_decl.h"
@@ -519,6 +520,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	case KVM_CAP_SPAPR_TCE:
+	case KVM_CAP_SPAPR_TCE_64:
 	case KVM_CAP_PPC_ALLOC_HTAB:
 	case KVM_CAP_PPC_RTAS:
 	case KVM_CAP_PPC_FIXUP_HCALL:
@@ -1344,13 +1346,34 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		break;
 	}
 #ifdef CONFIG_PPC_BOOK3S_64
+	case KVM_CREATE_SPAPR_TCE_64: {
+		struct kvm_create_spapr_tce_64 create_tce_64;
+
+		r = -EFAULT;
+		if (copy_from_user(&create_tce_64, argp, sizeof(create_tce_64)))
+			goto out;
+		if (create_tce_64.flags) {
+			r = -EINVAL;
+			goto out;
+		}
+		r = kvm_vm_ioctl_create_spapr_tce(kvm, &create_tce_64);
+		goto out;
+	}
 	case KVM_CREATE_SPAPR_TCE: {
 		struct kvm_create_spapr_tce create_tce;
+		struct kvm_create_spapr_tce_64 create_tce_64;
 
 		r = -EFAULT;
 		if (copy_from_user(&create_tce, argp, sizeof(create_tce)))
 			goto out;
-		r = kvm_vm_ioctl_create_spapr_tce(kvm, &create_tce);
+
+		create_tce_64.liobn = create_tce.liobn;
+		create_tce_64.page_shift = IOMMU_PAGE_SHIFT_4K;
+		create_tce_64.offset = 0;
+		create_tce_64.size = create_tce.window_size >>
+				IOMMU_PAGE_SHIFT_4K;
+		create_tce_64.flags = 0;
+		r = kvm_vm_ioctl_create_spapr_tce(kvm, &create_tce_64);
 		goto out;
 	}
 	case KVM_PPC_GET_SMMU_INFO: {
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 8ce5f64..b06208b 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1143,6 +1143,8 @@ struct kvm_s390_ucas_mapping {
 /* Available with KVM_CAP_PPC_ALLOC_HTAB */
 #define KVM_PPC_ALLOCATE_HTAB	  _IOWR(KVMIO, 0xa7, __u32)
 #define KVM_CREATE_SPAPR_TCE	  _IOW(KVMIO,  0xa8, struct kvm_create_spapr_tce)
+#define KVM_CREATE_SPAPR_TCE_64	  _IOW(KVMIO,  0xa8, \
+				       struct kvm_create_spapr_tce_64)
 /* Available with KVM_CAP_RMA */
 #define KVM_ALLOCATE_RMA	  _IOR(KVMIO,  0xa9, struct kvm_allocate_rma)
 /* Available with KVM_CAP_PPC_HTAB_FD */
-- 
2.5.0.rc3
