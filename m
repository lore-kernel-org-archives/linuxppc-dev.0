Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 65EBB1A0BAC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 16:03:07 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 17 Jul 2015 11:33:03 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id DA15B394006A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 11:32:58 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6H62vbj9371724
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 11:32:57 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6H62uTV002465
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 11:32:56 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V9 01/11] PCI/IOV: Rename and export virtfn_add/virtfn_remove
Date: Fri, 17 Jul 2015 14:02:31 +0800
Message-Id: <1437112961-17275-2-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1437112961-17275-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1437112961-17275-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During EEH recovery, hotplug is applied to the devices which don't
have drivers or their drivers don't support EEH. However, the hotplug,
which was implemented based on PCI bus, can't be applied to VF directly.

The patch renames virtn_{add,remove}() and exports them so that they
can be used in PCI hotplug during EEH recovery.

[gwshan: changelog]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c   |   10 +++++-----
 include/linux/pci.h |    8 ++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ee0ebff..cc941dd 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -108,7 +108,7 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 	return dev->sriov->barsz[resno - PCI_IOV_RESOURCES];
 }
 
-static int virtfn_add(struct pci_dev *dev, int id, int reset)
+int pci_iov_virtfn_add(struct pci_dev *dev, int id, int reset)
 {
 	int i;
 	int rc = -ENOMEM;
@@ -183,7 +183,7 @@ failed:
 	return rc;
 }
 
-static void virtfn_remove(struct pci_dev *dev, int id, int reset)
+void pci_iov_virtfn_remove(struct pci_dev *dev, int id, int reset)
 {
 	char buf[VIRTFN_ID_LEN];
 	struct pci_dev *virtfn;
@@ -320,7 +320,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	}
 
 	for (i = 0; i < initial; i++) {
-		rc = virtfn_add(dev, i, 0);
+		rc = pci_iov_virtfn_add(dev, i, 0);
 		if (rc)
 			goto failed;
 	}
@@ -332,7 +332,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 
 failed:
 	for (j = 0; j < i; j++)
-		virtfn_remove(dev, j, 0);
+		pci_iov_virtfn_remove(dev, j, 0);
 
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
 	pci_cfg_access_lock(dev);
@@ -361,7 +361,7 @@ static void sriov_disable(struct pci_dev *dev)
 		return;
 
 	for (i = 0; i < iov->num_VFs; i++)
-		virtfn_remove(dev, i, 0);
+		pci_iov_virtfn_remove(dev, i, 0);
 
 	pcibios_sriov_disable(dev);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8a0321a..3fed437 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1668,6 +1668,8 @@ int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
 
 int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
 void pci_disable_sriov(struct pci_dev *dev);
+int pci_iov_virtfn_add(struct pci_dev *dev, int id, int reset);
+void pci_iov_virtfn_remove(struct pci_dev *dev, int id, int reset);
 int pci_num_vf(struct pci_dev *dev);
 int pci_vfs_assigned(struct pci_dev *dev);
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
@@ -1685,6 +1687,12 @@ static inline int pci_iov_virtfn_devfn(struct pci_dev *dev, int id)
 static inline int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
 { return -ENODEV; }
 static inline void pci_disable_sriov(struct pci_dev *dev) { }
+static inline int pci_iov_virtfn_add(struct pci_dev *dev, int id, int reset)
+{
+	return -ENOSYS;
+}
+static inline void pci_iov_virtfn_remove(struct pci_dev *dev, int id, int reset)
+{ }
 static inline int pci_num_vf(struct pci_dev *dev) { return 0; }
 static inline int pci_vfs_assigned(struct pci_dev *dev)
 { return 0; }
-- 
1.7.9.5
