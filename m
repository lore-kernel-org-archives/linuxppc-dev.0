Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B325E1A0254
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:42 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:25:42 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D02DE3578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:40 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F92wcC1900954
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:02:58 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9Pe5U026467
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:40 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 07/13] KVM: PPC: Add support for 64bit TCE windows
Date: Tue, 15 Jul 2014 19:25:27 +1000
Message-Id: <1405416333-12477-8-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405416333-12477-1-git-send-email-aik@ozlabs.ru>
References: <1405416333-12477-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
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
via KVM_CAP_SPAPR_TCE_64 capability.

Since 64bit windows are to support Dynamic DMA windows (DDW), let's add
@bus_offset and @page_shift which are also required by DDW.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 Documentation/virtual/kvm/api.txt   | 51 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/kvm_ppc.h  |  2 +-
 arch/powerpc/include/uapi/asm/kvm.h |  9 +++++++
 arch/powerpc/kvm/book3s_64_vio.c    | 10 +++++---
 arch/powerpc/kvm/powerpc.c          | 25 +++++++++++++++++-
 include/uapi/linux/kvm.h            |  2 ++
 6 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index e1c72bf..b4695ea 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2520,6 +2520,57 @@ an implementation for these despite the in kernel acceleration.
 This capability is always enabled.
 
 
+4.88 KVM_CREATE_SPAPR_TCE_64
+
+Capability: KVM_CAP_SPAPR_TCE_64
+Architectures: powerpc
+Type: vm ioctl
+Parameters: struct kvm_create_spapr_tce_64 (in)
+Returns: file descriptor for manipulating the created TCE table
+
+This is an extension for KVM_CAP_SPAPR_TCE which only supports 32bit
+windows.
+
+This creates a virtual TCE (translation control entry) table, which
+is an IOMMU for PAPR-style virtual I/O.  It is used to translate
+logical addresses used in virtual I/O into guest physical addresses,
+and provides a scatter/gather capability for PAPR virtual I/O.
+
+/* for KVM_CAP_SPAPR_TCE_64 */
+struct kvm_create_spapr_tce_64 {
+	__u64 liobn;
+	__u32 page_shift;
+	__u64 offset;	/* in pages */
+	__u64 size; 	/* in pages */
+	__u32 flags;
+};
+
+
+!!! FIXME !!!
+
+
+The liobn field gives the logical IO bus number for which to create a
+TCE table. The window_size field specifies the size of the DMA window
+which this TCE table will translate - the table will contain one 64
+bit TCE entry for every IOMMU page. The bus_offset field tells where
+this window is mapped on the IO bus. The page_shift field tells the size
+of the pages in this window (for example, 10, 16, 24 for 4K, 64K, 16MB
+page sizes respectively). The flags field is not used at the moment
+but provides the room for extensions.
+
+When the guest issues an H_PUT_TCE/H_PUT_TCE_INDIRECT/H_STUFF_TCE hcall
+on a liobn for which a TCE table has been created using this ioctl(),
+the kernel will handle it in real or virtual mode, updating the TCE table.
+If liobn has not been registered with this ioctl, H_PUT_TCE/etc calls
+will cause a vm exit and must be handled by userspace.
+
+The return value is a file descriptor which can be passed to mmap(2)
+to map the created TCE table into userspace.  This lets userspace read
+the entries written by kernel-handled H_PUT_TCE calls, and also lets
+userspace update the TCE table directly which is useful in some
+circumstances.
+
+
 5. The kvm_run structure
 ------------------------
 
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index b84ed80..e0a68ef 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -128,7 +128,7 @@ extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
 extern int kvmppc_spapr_tce_init(struct kvm_vcpu *vcpu);
 extern void kvmppc_spapr_tce_free(struct kvm_vcpu *vcpu);
 extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
-				struct kvm_create_spapr_tce *args);
+				struct kvm_create_spapr_tce_64 *args);
 extern struct kvmppc_spapr_tce_table *kvmppc_find_tce_table(
 		struct kvm *kvm, unsigned long liobn);
 extern long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 2bc4a94..4452f6e 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -333,6 +333,15 @@ struct kvm_create_spapr_tce {
 	__u32 window_size;
 };
 
+/* for KVM_CAP_SPAPR_TCE_64 */
+struct kvm_create_spapr_tce_64 {
+	__u64 liobn;
+	__u32 page_shift;
+	__u64 offset;	/* in pages */
+	__u64 size;	/* in pages */
+	__u32 flags;
+};
+
 /* for KVM_ALLOCATE_RMA */
 struct kvm_allocate_rma {
 	__u64 rma_size;
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index f2c8e4d..2c6ab20 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -155,20 +155,23 @@ static const struct file_operations kvm_spapr_tce_fops = {
 };
 
 long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
-				   struct kvm_create_spapr_tce *args)
+				   struct kvm_create_spapr_tce_64 *args)
 {
 	struct kvmppc_spapr_tce_table *stt = NULL;
 	long npages, size;
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
 	npages = kvmppc_stt_npages(size);
 	ret = kvmppc_account_memlimit(npages + 1);
 	if (ret)
@@ -180,7 +183,8 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 		goto fail;
 
 	stt->liobn = args->liobn;
-	stt->page_shift = IOMMU_PAGE_SHIFT_4K;
+	stt->page_shift = args->page_shift;
+	stt->offset = args->offset;
 	stt->size = size;
 	stt->kvm = kvm;
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index e66793b..4d674ed 100644
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
@@ -414,6 +415,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	case KVM_CAP_SPAPR_TCE:
+	case KVM_CAP_SPAPR_TCE_64:
 	case KVM_CAP_PPC_ALLOC_HTAB:
 	case KVM_CAP_PPC_RTAS:
 	case KVM_CAP_PPC_FIXUP_HCALL:
@@ -1122,13 +1124,34 @@ long kvm_arch_vm_ioctl(struct file *filp,
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
index 65c2689..3beb542 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1033,6 +1033,8 @@ struct kvm_s390_ucas_mapping {
 /* Available with KVM_CAP_PPC_ALLOC_HTAB */
 #define KVM_PPC_ALLOCATE_HTAB	  _IOWR(KVMIO, 0xa7, __u32)
 #define KVM_CREATE_SPAPR_TCE	  _IOW(KVMIO,  0xa8, struct kvm_create_spapr_tce)
+#define KVM_CREATE_SPAPR_TCE_64	  _IOW(KVMIO,  0xa8, \
+				       struct kvm_create_spapr_tce_64)
 /* Available with KVM_CAP_RMA */
 #define KVM_ALLOCATE_RMA	  _IOR(KVMIO,  0xa9, struct kvm_allocate_rma)
 /* Available with KVM_CAP_PPC_HTAB_FD */
-- 
2.0.0
