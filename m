Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5A2FF2C00DD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 18:26:41 +1100 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 15 Mar 2013 01:26:38 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id E0AC01FF0039
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 01:21:40 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2F7QZCY115454
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 01:26:35 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2F7QY9x014891
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 01:26:35 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] VFIO: Architecture dependent VFIO device operations
Date: Fri, 15 Mar 2013 15:26:28 +0800
Message-Id: <1363332390-12754-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1363332390-12754-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1363332390-12754-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, alex.williamson@redhat.com,
 Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some architectures like PPC, especailly PowerNV platform, need to
do additional operations while adding or removing VFIO devices to
or from VFIO bus. The patch adds weak functions while to open,
release or ioctl for the specific VFIO device. Those functions could
be overrided by individual architectures if necessary.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/vfio/pci/vfio_pci.c |   42 +++++++++++++++++++++++++++++++++++-------
 include/linux/vfio.h        |    7 ++++++-
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 8189cb6..1a53e77 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -143,32 +143,51 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
 	pci_restore_state(pdev);
 }
 
+void __weak vfio_pci_arch_release(struct pci_dev *pdev)
+{
+	return;
+}
+
 static void vfio_pci_release(void *device_data)
 {
 	struct vfio_pci_device *vdev = device_data;
 
-	if (atomic_dec_and_test(&vdev->refcnt))
+	if (atomic_dec_and_test(&vdev->refcnt)) {
+		vfio_pci_arch_release(vdev->pdev);
+
 		vfio_pci_disable(vdev);
+	}
 
 	module_put(THIS_MODULE);
 }
 
+int __weak vfio_pci_arch_open(struct pci_dev *pdev)
+{
+	return 0;
+}
+
 static int vfio_pci_open(void *device_data)
 {
 	struct vfio_pci_device *vdev = device_data;
+	int ret;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
 	if (atomic_inc_return(&vdev->refcnt) == 1) {
-		int ret = vfio_pci_enable(vdev);
-		if (ret) {
-			module_put(THIS_MODULE);
-			return ret;
-		}
+		ret = vfio_pci_arch_open(vdev->pdev);
+		if (ret)
+			goto fail;
+
+		ret = vfio_pci_enable(vdev);
+		if (ret)
+			goto fail;
 	}
 
 	return 0;
+fail:
+	module_put(THIS_MODULE);
+	return ret;
 }
 
 static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
@@ -206,6 +225,12 @@ static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
 	return 0;
 }
 
+long __weak vfio_pci_arch_ioctl(struct pci_dev *pdev,
+				unsigned int cmd, unsigned long arg)
+{
+	return -ENOTTY;
+}
+
 static long vfio_pci_ioctl(void *device_data,
 			   unsigned int cmd, unsigned long arg)
 {
@@ -374,9 +399,12 @@ static long vfio_pci_ioctl(void *device_data,
 
 		return ret;
 
-	} else if (cmd == VFIO_DEVICE_RESET)
+	} else if (cmd == VFIO_DEVICE_RESET) {
 		return vdev->reset_works ?
 			pci_reset_function(vdev->pdev) : -EINVAL;
+	} else {
+		return vfio_pci_arch_ioctl(vdev->pdev, cmd, arg);
+	}
 
 	return -ENOTTY;
 }
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index ab9e862..a991c39 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -11,9 +11,9 @@
 #ifndef VFIO_H
 #define VFIO_H
 
-
 #include <linux/iommu.h>
 #include <linux/mm.h>
+#include <linux/pci.h>
 #include <uapi/linux/vfio.h>
 
 /**
@@ -40,6 +40,11 @@ struct vfio_device_ops {
 	int	(*mmap)(void *device_data, struct vm_area_struct *vma);
 };
 
+extern int vfio_pci_arch_open(struct pci_dev *pdev);
+extern long vfio_pci_arch_ioctl(struct pci_dev *pdev,
+				unsigned int cmd,
+				unsigned long arg);
+extern void vfio_pci_arch_release(struct pci_dev *pdev);
 extern int vfio_add_group_dev(struct device *dev,
 			      const struct vfio_device_ops *ops,
 			      void *device_data);
-- 
1.7.5.4
