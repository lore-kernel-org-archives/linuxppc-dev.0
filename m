Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 37C701A088C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 12:47:31 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 7 Aug 2014 08:17:28 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 9AE33394001C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 08:17:27 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s772lef056492194
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Aug 2014 08:17:41 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s772lQTE029231
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Aug 2014 08:17:26 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 5/5] drivers/vfio: Enable VFIO if EEH is not supported
Date: Thu,  7 Aug 2014 12:47:20 +1000
Message-Id: <1407379640-13065-6-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1407379640-13065-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1407379640-13065-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, alex.williamson@redhat.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The existing vfio_pci_open() fails upon error returned from
vfio_spapr_pci_eeh_open(), which breaks POWER7's P5IOC2 PHB
support which this patch brings back.

The patch fixes the issue by dropping the return value of
vfio_spapr_pci_eeh_open().

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v3: Drop return value of vfio_spapr_pci_eeh_open()
v4: Add warning message in eeh_dev_open() in PATCH[2/5]
---
 drivers/vfio/pci/vfio_pci.c   | 6 +-----
 drivers/vfio/vfio_spapr_eeh.c | 4 ++--
 include/linux/vfio.h          | 5 ++---
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index e2ee80f..32d69c8 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -178,11 +178,7 @@ static int vfio_pci_open(void *device_data)
 		if (ret)
 			goto error;
 
-		ret = vfio_spapr_pci_eeh_open(vdev->pdev);
-		if (ret) {
-			vfio_pci_disable(vdev);
-			goto error;
-		}
+		vfio_spapr_pci_eeh_open(vdev->pdev);
 	}
 
 	return 0;
diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
index 4779cac..86dfceb 100644
--- a/drivers/vfio/vfio_spapr_eeh.c
+++ b/drivers/vfio/vfio_spapr_eeh.c
@@ -19,9 +19,9 @@
 #define DRIVER_DESC	"VFIO IOMMU SPAPR EEH"
 
 /* We might build address mapping here for "fast" path later */
-int vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
+void vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
 {
-	return eeh_dev_open(pdev);
+	eeh_dev_open(pdev);
 }
 EXPORT_SYMBOL_GPL(vfio_spapr_pci_eeh_open);
 
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 224128a..d320411 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -100,15 +100,14 @@ extern long vfio_external_check_extension(struct vfio_group *group,
 
 struct pci_dev;
 #ifdef CONFIG_EEH
-extern int vfio_spapr_pci_eeh_open(struct pci_dev *pdev);
+extern void vfio_spapr_pci_eeh_open(struct pci_dev *pdev);
 extern void vfio_spapr_pci_eeh_release(struct pci_dev *pdev);
 extern long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
 				       unsigned int cmd,
 				       unsigned long arg);
 #else
-static inline int vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
+static inline void vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
 {
-	return 0;
 }
 
 static inline void vfio_spapr_pci_eeh_release(struct pci_dev *pdev)
-- 
1.8.3.2
