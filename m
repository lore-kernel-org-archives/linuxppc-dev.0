Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1E65A1401DB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:58 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:27:57 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7F7E42BB004A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:55 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4516m2k21037258
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:06:48 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451RsVq011701
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:55 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 08/22] kvm: Address mapping for VFIO device
Date: Mon,  5 May 2014 11:27:57 +1000
Message-Id: <1399253291-3975-9-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The address (domain/bus/slot/function) looks different from the
perspective of host and guest. We have to setup the mapping for
EEH and tear it down accordingly. The patch introduces additional
attributes to KVM VFIO device for address mapping or unmapping.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/Kconfig  |  1 +
 arch/powerpc/kvm/Makefile |  3 +++
 include/uapi/linux/kvm.h  | 10 ++++++++
 virt/kvm/vfio.c           | 60 ++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 743d2d9..6764fc5 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -64,6 +64,7 @@ config KVM_BOOK3S_64
 	select KVM_BOOK3S_64_HANDLER
 	select KVM
 	select KVM_BOOK3S_PR_POSSIBLE if !KVM_BOOK3S_HV_POSSIBLE
+	select KVM_VFIO if VFIO
 	---help---
 	  Support running unmodified book3s_64 and book3s_32 guest kernels
 	  in virtual machines on book3s_64 host processors.
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index ce569b6..673038d 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -97,6 +97,9 @@ endif
 kvm-book3s_64-objs-$(CONFIG_KVM_XICS) += \
 	book3s_xics.o
 
+kvm-book3s_64-objs-$(CONFIG_KVM_VFIO) += \
+	$(addprefix ../../../virt/kvm/, vfio.o)
+
 kvm-book3s_64-module-objs += \
 	$(KVM)/kvm_main.o \
 	$(KVM)/eventfd.o \
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index a8f4ee5..97b4d1e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -932,9 +932,19 @@ struct kvm_device_attr {
 #define  KVM_DEV_VFIO_GROUP			1
 #define   KVM_DEV_VFIO_GROUP_ADD			1
 #define   KVM_DEV_VFIO_GROUP_DEL			2
+#define  KVM_DEV_VFIO_DEV			2
+#define   KVM_DEV_VFIO_DEV_EEH_MAP			1
+#define   KVM_DEV_VFIO_DEV_EEH_UNMAP			2
 #define KVM_DEV_TYPE_ARM_VGIC_V2	5
 #define KVM_DEV_TYPE_FLIC		6
 
+struct kvm_vfio_pci_addr {
+	__u32 domain;	/* Host PHB domain	*/
+	__u32 bdn;	/* Host bus/dev/func	*/
+	__u64 gbuid;	/* Guet PHB BUID	*/
+	__u32 gbdn;	/* Guest bus/dev/func	*/
+};
+
 /*
  * ioctls for VM fds
  */
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index ba1a93f..778015d 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -28,6 +28,10 @@ struct kvm_vfio {
 	struct list_head group_list;
 	struct mutex lock;
 	bool noncoherent;
+#ifdef CONFIG_KVM_EEH
+	kvm_vfio_dev_eeh_map eeh_map;
+	kvm_vfio_dev_eeh_unmap eeh_unmap;
+#endif
 };
 
 static struct vfio_group *kvm_vfio_group_get_external_user(struct file *filep)
@@ -201,12 +205,53 @@ static int kvm_vfio_set_group(struct kvm_device *dev, long attr, u64 arg)
 	return -ENXIO;
 }
 
+static int kvm_vfio_set_dev(struct kvm_device *dev, long attr, u64 arg)
+{
+	struct kvm_vfio *kv = dev->private;
+	struct kvm_vfio_pci_addr addr;
+	int ret = -ENXIO;
+
+	switch (attr) {
+#ifdef CONFIG_KVM_EEH
+	case KVM_DEV_VFIO_DEV_EEH_MAP:
+		if (copy_from_user(&addr, (void __user *)arg, sizeof(addr))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		if (kv->eeh_map)
+			ret = kv->eeh_map(dev->kvm, addr.domain,
+					  addr.bdn, addr.gbuid, addr.gbdn);
+		else
+			ret = 0;
+
+		break;
+	case KVM_DEV_VFIO_DEV_EEH_UNMAP:
+		if (copy_from_user(&addr, (void __user *)arg, sizeof(addr))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		if (kv->eeh_unmap)
+			ret = kv->eeh_unmap(dev->kvm, addr.domain, addr.bdn);
+		else
+			ret = 0;
+
+		break;
+#endif
+	}
+
+	return ret;
+}
+
 static int kvm_vfio_set_attr(struct kvm_device *dev,
 			     struct kvm_device_attr *attr)
 {
 	switch (attr->group) {
 	case KVM_DEV_VFIO_GROUP:
 		return kvm_vfio_set_group(dev, attr->attr, attr->addr);
+	case KVM_DEV_VFIO_DEV:
+		return kvm_vfio_set_dev(dev, attr->attr, attr->addr);
 	}
 
 	return -ENXIO;
@@ -224,6 +269,16 @@ static int kvm_vfio_has_attr(struct kvm_device *dev,
 		}
 
 		break;
+	case KVM_DEV_VFIO_DEV:
+		switch (attr->attr) {
+#ifdef CONFIG_KVM_EEH
+		case KVM_DEV_VFIO_DEV_EEH_MAP:
+		case KVM_DEV_VFIO_DEV_EEH_UNMAP:
+			return 0;
+#endif
+		}
+
+		break;
 	}
 
 	return -ENXIO;
@@ -262,7 +317,10 @@ static int kvm_vfio_create(struct kvm_device *dev, u32 type)
 
 	INIT_LIST_HEAD(&kv->group_list);
 	mutex_init(&kv->lock);
-
+#ifdef CONFIG_KVM_EEH
+	kv->eeh_map = kvm_vfio_eeh_dev_map;
+	kv->eeh_unmap = kvm_vfio_eeh_dev_unmap;
+#endif
 	dev->private = kv;
 
 	return 0;
-- 
1.8.3.2
