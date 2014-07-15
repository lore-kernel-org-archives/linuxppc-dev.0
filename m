Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93E8A1A01A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:46 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:25:46 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B980F2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:43 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F9PR537733520
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:27 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9Ph27026556
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:43 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 12/13] KVM: PPC: vfio kvm device: support spapr tce
Date: Tue, 15 Jul 2014 19:25:32 +1000
Message-Id: <1405416333-12477-13-git-send-email-aik@ozlabs.ru>
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

In addition to the external VFIO user API, a VFIO KVM device
has been introduced recently.

sPAPR TCE IOMMU is para-virtualized and the guest does map/unmap
via hypercalls which take a logical bus id (LIOBN) as a target IOMMU
identifier. LIOBNs are made up, advertised to the guest system and
linked to IOMMU groups by the user space.
In order to enable acceleration for IOMMU operations in KVM, we need
to tell KVM the information about LIOBN-to-group mapping.

For that, a new KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN parameter
is added. It accepts a pair of a VFIO group fd and LIOBN.

KVM uses kvm_vfio_find_group_by_liobn() once per KVM run and caches
the result in kvm_arch. iommu_group_put() for all groups is called
at KVM finish in the SPAPR TCE (will be added in KVM enablement patch).

Before notifying KVM about new link, this check the group for being
registered with KVM device in order to release them at unexpected KVM
finish.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v5:
* added lock in search function
* changed callback function type name

v4:
* fixed few bugs
* changed kvm_vfio_find_group_by_liobn() to return informative errors

v3:
* total rework
* added a release callback into kvm_vfio_find_group_by_liobn so now
the user of the API can get a notification if the group is about to
disappear
---
 Documentation/virtual/kvm/devices/vfio.txt | 20 ++++++++-
 arch/powerpc/kvm/Kconfig                   |  1 +
 arch/powerpc/kvm/Makefile                  |  3 ++
 include/uapi/linux/kvm.h                   |  8 ++++
 virt/kvm/vfio.c                            | 69 ++++++++++++++++++++++++++++++
 5 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/Documentation/virtual/kvm/devices/vfio.txt b/Documentation/virtual/kvm/devices/vfio.txt
index ef51740..eaf0f5e 100644
--- a/Documentation/virtual/kvm/devices/vfio.txt
+++ b/Documentation/virtual/kvm/devices/vfio.txt
@@ -16,7 +16,23 @@ Groups:
 
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
+			__u64	start_addr;
+		};
+		where
+		@argsz is the size of kvm_vfio_spapr_tce_liobn;
+		@fd is a file descriptor for a VFIO group;
+		@liobn is a logical bus id to be associated with the group;
+		@start_addr is a DMA window offset on the IO (PCI) bus.
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 301fa6b..f708e61 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -64,6 +64,7 @@ config KVM_BOOK3S_64
 	select KVM
 	select KVM_BOOK3S_PR_POSSIBLE if !KVM_BOOK3S_HV_POSSIBLE
 	select SPAPR_TCE_IOMMU if IOMMU_SUPPORT
+	select KVM_VFIO if VFIO
 	---help---
 	  Support running unmodified book3s_64 and book3s_32 guest kernels
 	  in virtual machines on book3s_64 host processors.
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index ce569b6..d55c097 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -97,6 +97,9 @@ endif
 kvm-book3s_64-objs-$(CONFIG_KVM_XICS) += \
 	book3s_xics.o
 
+kvm-book3s_64-objs-$(CONFIG_KVM_VFIO) += \
+	$(KVM)/vfio.o \
+
 kvm-book3s_64-module-objs += \
 	$(KVM)/kvm_main.o \
 	$(KVM)/eventfd.o \
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 3beb542..c1ad9b7 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -949,9 +949,17 @@ struct kvm_device_attr {
 #define  KVM_DEV_VFIO_GROUP			1
 #define   KVM_DEV_VFIO_GROUP_ADD			1
 #define   KVM_DEV_VFIO_GROUP_DEL			2
+#define   KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN	3
 #define KVM_DEV_TYPE_ARM_VGIC_V2	5
 #define KVM_DEV_TYPE_FLIC		6
 
+struct kvm_vfio_spapr_tce_liobn {
+	__u32	argsz;
+	__s32	fd;
+	__u32	liobn;
+	__u64	start_addr;
+};
+
 /*
  * ioctls for VM fds
  */
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index ba1a93f..43a224b 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -19,6 +19,10 @@
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
 
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+#include <asm/kvm_ppc.h>
+#endif
+
 struct kvm_vfio_group {
 	struct list_head node;
 	struct vfio_group *vfio_group;
@@ -196,6 +200,68 @@ static int kvm_vfio_set_group(struct kvm_device *dev, long attr, u64 arg)
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
+			group_id = vfio_external_user_iommu_id(kvg->vfio_group);
+			grp = iommu_group_get_by_id(group_id);
+			if (!grp) {
+				ret = -EFAULT;
+				break;
+			}
+
+			ret = kvm_spapr_tce_attach_iommu_group(dev->kvm,
+					param.liobn, param.start_addr, grp);
+			if (ret)
+				iommu_group_put(grp);
+
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
@@ -220,6 +286,9 @@ static int kvm_vfio_has_attr(struct kvm_device *dev,
 		switch (attr->attr) {
 		case KVM_DEV_VFIO_GROUP_ADD:
 		case KVM_DEV_VFIO_GROUP_DEL:
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+		case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN:
+#endif
 			return 0;
 		}
 
-- 
2.0.0
