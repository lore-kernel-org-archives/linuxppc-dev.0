Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECBE71A0B57
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:42:46 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 7 Mar 2016 13:42:44 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 38DB12CE8062
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:42:40 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u273gWSQ10158426
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:42:40 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u273g7Oo028593
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:42:07 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 9/9] KVM: PPC: VFIO device: support SPAPR TCE
Date: Mon,  7 Mar 2016 14:41:17 +1100
Message-Id: <1457322077-26640-10-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

sPAPR TCE IOMMU is para-virtualized and the guest does map/unmap
via hypercalls which take a logical bus id (LIOBN) as a target IOMMU
identifier. LIOBNs are made up, advertised to guest systems and
linked to IOMMU groups by the user space.
In order to enable acceleration for IOMMU operations in KVM, we need
to tell KVM the information about the LIOBN-to-group mapping.

For that, a new KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN parameter
is added which accepts:
- a VFIO group fd and IO base address to find the actual hardware
TCE table;
- a LIOBN to assign to the found table.

Before notifying KVM about new link, this check the group for being
registered with KVM device in order to release them at unexpected KVM
finish.

This advertises the new KVM_CAP_SPAPR_TCE_VFIO capability to the user
space.

While we are here, this also fixes VFIO KVM device compiling to let it
link to a KVM module.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 Documentation/virtual/kvm/devices/vfio.txt |  21 +++++-
 arch/powerpc/kvm/Kconfig                   |   1 +
 arch/powerpc/kvm/Makefile                  |   5 +-
 arch/powerpc/kvm/powerpc.c                 |   1 +
 include/uapi/linux/kvm.h                   |   9 +++
 virt/kvm/vfio.c                            | 106 +++++++++++++++++++++++++++++
 6 files changed, 140 insertions(+), 3 deletions(-)

diff --git a/Documentation/virtual/kvm/devices/vfio.txt b/Documentation/virtual/kvm/devices/vfio.txt
index ef51740..c0d3eb7 100644
--- a/Documentation/virtual/kvm/devices/vfio.txt
+++ b/Documentation/virtual/kvm/devices/vfio.txt
@@ -16,7 +16,24 @@ Groups:
 
 KVM_DEV_VFIO_GROUP attributes:
   KVM_DEV_VFIO_GROUP_ADD: Add a VFIO group to VFIO-KVM device tracking
+	kvm_device_attr.addr points to an int32_t file descriptor
+	for the VFIO group.
+
   KVM_DEV_VFIO_GROUP_DEL: Remove a VFIO group from VFIO-KVM device tracking
+	kvm_device_attr.addr points to an int32_t file descriptor
+	for the VFIO group.
 
-For each, kvm_device_attr.addr points to an int32_t file descriptor
-for the VFIO group.
+  KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN: sets a liobn for a VFIO group
+	kvm_device_attr.addr points to a struct:
+		struct kvm_vfio_spapr_tce_liobn {
+			__u32	argsz;
+			__s32	fd;
+			__u32	liobn;
+			__u8	pad[4];
+			__u64	start_addr;
+		};
+		where
+		@argsz is the size of kvm_vfio_spapr_tce_liobn;
+		@fd is a file descriptor for a VFIO group;
+		@liobn is a logical bus id to be associated with the group;
+		@start_addr is a DMA window offset on the IO (PCI) bus
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 1059846..dfa3488 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -65,6 +65,7 @@ config KVM_BOOK3S_64
 	select KVM
 	select KVM_BOOK3S_PR_POSSIBLE if !KVM_BOOK3S_HV_POSSIBLE
 	select SPAPR_TCE_IOMMU if IOMMU_SUPPORT
+	select KVM_VFIO if VFIO
 	---help---
 	  Support running unmodified book3s_64 and book3s_32 guest kernels
 	  in virtual machines on book3s_64 host processors.
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 7f7b6d8..71f577c 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -8,7 +8,7 @@ ccflags-y := -Ivirt/kvm -Iarch/powerpc/kvm
 KVM := ../../../virt/kvm
 
 common-objs-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o \
-		$(KVM)/eventfd.o $(KVM)/vfio.o
+		$(KVM)/eventfd.o
 
 CFLAGS_e500_mmu.o := -I.
 CFLAGS_e500_mmu_host.o := -I.
@@ -87,6 +87,9 @@ endif
 kvm-book3s_64-objs-$(CONFIG_KVM_XICS) += \
 	book3s_xics.o
 
+kvm-book3s_64-objs-$(CONFIG_KVM_VFIO) += \
+	$(KVM)/vfio.o \
+
 kvm-book3s_64-module-objs += \
 	$(KVM)/kvm_main.o \
 	$(KVM)/eventfd.o \
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 19aa59b..63f188d 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -521,6 +521,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 #ifdef CONFIG_PPC_BOOK3S_64
 	case KVM_CAP_SPAPR_TCE:
 	case KVM_CAP_SPAPR_TCE_64:
+	case KVM_CAP_SPAPR_TCE_VFIO:
 	case KVM_CAP_PPC_ALLOC_HTAB:
 	case KVM_CAP_PPC_RTAS:
 	case KVM_CAP_PPC_FIXUP_HCALL:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 080ffbf..f1abbea 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1056,6 +1056,7 @@ struct kvm_device_attr {
 #define  KVM_DEV_VFIO_GROUP			1
 #define   KVM_DEV_VFIO_GROUP_ADD			1
 #define   KVM_DEV_VFIO_GROUP_DEL			2
+#define   KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN	3
 
 enum kvm_device_type {
 	KVM_DEV_TYPE_FSL_MPIC_20	= 1,
@@ -1075,6 +1076,14 @@ enum kvm_device_type {
 	KVM_DEV_TYPE_MAX,
 };
 
+struct kvm_vfio_spapr_tce_liobn {
+	__u32	argsz;
+	__s32	fd;
+	__u32	liobn;
+	__u8	pad[4];
+	__u64	start_addr;
+};
+
 /*
  * ioctls for VM fds
  */
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 1dd087d..87c771e 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -20,6 +20,10 @@
 #include <linux/vfio.h>
 #include "vfio.h"
 
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+#include <asm/kvm_ppc.h>
+#endif
+
 struct kvm_vfio_group {
 	struct list_head node;
 	struct vfio_group *vfio_group;
@@ -60,6 +64,22 @@ static void kvm_vfio_group_put_external_user(struct vfio_group *vfio_group)
 	symbol_put(vfio_group_put_external_user);
 }
 
+static int kvm_vfio_external_user_iommu_id(struct vfio_group *vfio_group)
+{
+	int (*fn)(struct vfio_group *);
+	int ret = -1;
+
+	fn = symbol_get(vfio_external_user_iommu_id);
+	if (!fn)
+		return ret;
+
+	ret = fn(vfio_group);
+
+	symbol_put(vfio_external_user_iommu_id);
+
+	return ret;
+}
+
 static bool kvm_vfio_group_is_coherent(struct vfio_group *vfio_group)
 {
 	long (*fn)(struct vfio_group *, unsigned long);
@@ -110,6 +130,22 @@ static void kvm_vfio_update_coherency(struct kvm_device *dev)
 	mutex_unlock(&kv->lock);
 }
 
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+static void kvm_vfio_spapr_detach_iommu_group(struct kvm *kvm,
+		struct vfio_group *vfio_group)
+{
+	int group_id;
+	struct iommu_group *grp;
+
+	group_id = kvm_vfio_external_user_iommu_id(vfio_group);
+	grp = iommu_group_get_by_id(group_id);
+	if (grp) {
+		kvm_spapr_tce_detach_iommu_group(kvm, grp);
+		iommu_group_put(grp);
+	}
+}
+#endif
+
 static int kvm_vfio_set_group(struct kvm_device *dev, long attr, u64 arg)
 {
 	struct kvm_vfio *kv = dev->private;
@@ -186,6 +222,10 @@ static int kvm_vfio_set_group(struct kvm_device *dev, long attr, u64 arg)
 				continue;
 
 			list_del(&kvg->node);
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+			kvm_vfio_spapr_detach_iommu_group(dev->kvm,
+					kvg->vfio_group);
+#endif
 			kvm_vfio_group_put_external_user(kvg->vfio_group);
 			kfree(kvg);
 			ret = 0;
@@ -201,6 +241,69 @@ static int kvm_vfio_set_group(struct kvm_device *dev, long attr, u64 arg)
 		kvm_vfio_update_coherency(dev);
 
 		return ret;
+
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+	case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN: {
+		struct kvm_vfio_spapr_tce_liobn param;
+		unsigned long minsz;
+		struct kvm_vfio *kv = dev->private;
+		struct vfio_group *vfio_group;
+		struct kvm_vfio_group *kvg;
+		struct fd f;
+
+		minsz = offsetofend(struct kvm_vfio_spapr_tce_liobn,
+				start_addr);
+
+		if (copy_from_user(&param, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (param.argsz < minsz)
+			return -EINVAL;
+
+		f = fdget(param.fd);
+		if (!f.file)
+			return -EBADF;
+
+		vfio_group = kvm_vfio_group_get_external_user(f.file);
+		fdput(f);
+
+		if (IS_ERR(vfio_group))
+			return PTR_ERR(vfio_group);
+
+		ret = -ENOENT;
+
+		mutex_lock(&kv->lock);
+
+		list_for_each_entry(kvg, &kv->group_list, node) {
+			int group_id;
+			struct iommu_group *grp;
+
+			if (kvg->vfio_group != vfio_group)
+				continue;
+
+			group_id = kvm_vfio_external_user_iommu_id(
+					kvg->vfio_group);
+			grp = iommu_group_get_by_id(group_id);
+			if (!grp) {
+				ret = -EFAULT;
+				break;
+			}
+
+			ret = kvm_spapr_tce_attach_iommu_group(dev->kvm,
+					param.liobn, param.start_addr,
+					grp);
+			if (ret)
+				iommu_group_put(grp);
+			break;
+		}
+
+		mutex_unlock(&kv->lock);
+
+		kvm_vfio_group_put_external_user(vfio_group);
+
+		return ret;
+	}
+#endif /* CONFIG_SPAPR_TCE_IOMMU */
 	}
 
 	return -ENXIO;
@@ -225,6 +328,9 @@ static int kvm_vfio_has_attr(struct kvm_device *dev,
 		switch (attr->attr) {
 		case KVM_DEV_VFIO_GROUP_ADD:
 		case KVM_DEV_VFIO_GROUP_DEL:
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+		case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN:
+#endif
 			return 0;
 		}
 
-- 
2.5.0.rc3
