Return-Path: <prvs=414b27ec5=jschoenh@amazon.com>
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
 [207.171.184.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xn2nK3DDGzDqh4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 09:22:45 +1000 (AEST)
From: =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
 linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] PCI: Remove reset argument from pci_iov_{add,
 remove}_virtfn()
Date: Wed,  6 Sep 2017 01:21:22 +0200
Message-Id: <1504653683-11543-1-git-send-email-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The reset argument passed to pci_iov_add_virtfn() and
pci_iov_remove_virtfn() is always zero since commit 46cb7b1bd86fc227a
("PCI: Remove unused SR-IOV VF Migration support").

Remove the argument together with the associated code.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 arch/powerpc/kernel/eeh_driver.c |  4 ++--
 drivers/pci/iov.c                | 18 +++++-------------
 include/linux/pci.h              |  8 ++++----
 3 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index c405c79..23ea86f 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -441,7 +441,7 @@ static void *eeh_add_virt_device(void *data, void *userdata)
 	}
 
 #ifdef CONFIG_PPC_POWERNV
-	pci_iov_add_virtfn(edev->physfn, pdn->vf_index, 0);
+	pci_iov_add_virtfn(edev->physfn, pdn->vf_index);
 #endif
 	return NULL;
 }
@@ -499,7 +499,7 @@ static void *eeh_rmv_device(void *data, void *userdata)
 #ifdef CONFIG_PPC_POWERNV
 		struct pci_dn *pdn = eeh_dev_to_pdn(edev);
 
-		pci_iov_remove_virtfn(edev->physfn, pdn->vf_index, 0);
+		pci_iov_remove_virtfn(edev->physfn, pdn->vf_index);
 		edev->pdev = NULL;
 
 		/*
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 120485d..21b55ca 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -113,7 +113,7 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 	return dev->sriov->barsz[resno - PCI_IOV_RESOURCES];
 }
 
-int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
+int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 {
 	int i;
 	int rc = -ENOMEM;
@@ -157,9 +157,6 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
 		BUG_ON(rc);
 	}
 
-	if (reset)
-		__pci_reset_function(virtfn);
-
 	pci_device_add(virtfn, virtfn->bus);
 
 	pci_bus_add_device(virtfn);
@@ -187,7 +184,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
 	return rc;
 }
 
-void pci_iov_remove_virtfn(struct pci_dev *dev, int id, int reset)
+void pci_iov_remove_virtfn(struct pci_dev *dev, int id)
 {
 	char buf[VIRTFN_ID_LEN];
 	struct pci_dev *virtfn;
@@ -198,11 +195,6 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int id, int reset)
 	if (!virtfn)
 		return;
 
-	if (reset) {
-		device_release_driver(&virtfn->dev);
-		__pci_reset_function(virtfn);
-	}
-
 	sprintf(buf, "virtfn%u", id);
 	sysfs_remove_link(&dev->dev.kobj, buf);
 	/*
@@ -317,7 +309,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	pci_cfg_access_unlock(dev);
 
 	for (i = 0; i < initial; i++) {
-		rc = pci_iov_add_virtfn(dev, i, 0);
+		rc = pci_iov_add_virtfn(dev, i);
 		if (rc)
 			goto failed;
 	}
@@ -329,7 +321,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 
 failed:
 	while (i--)
-		pci_iov_remove_virtfn(dev, i, 0);
+		pci_iov_remove_virtfn(dev, i);
 
 	pcibios_sriov_disable(dev);
 err_pcibios:
@@ -355,7 +347,7 @@ static void sriov_disable(struct pci_dev *dev)
 		return;
 
 	for (i = 0; i < iov->num_VFs; i++)
-		pci_iov_remove_virtfn(dev, i, 0);
+		pci_iov_remove_virtfn(dev, i);
 
 	pcibios_sriov_disable(dev);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f958d07..4acf321 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1903,8 +1903,8 @@ int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
 
 int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
 void pci_disable_sriov(struct pci_dev *dev);
-int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset);
-void pci_iov_remove_virtfn(struct pci_dev *dev, int id, int reset);
+int pci_iov_add_virtfn(struct pci_dev *dev, int id);
+void pci_iov_remove_virtfn(struct pci_dev *dev, int id);
 int pci_num_vf(struct pci_dev *dev);
 int pci_vfs_assigned(struct pci_dev *dev);
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
@@ -1921,12 +1921,12 @@ static inline int pci_iov_virtfn_devfn(struct pci_dev *dev, int id)
 }
 static inline int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
 { return -ENODEV; }
-static inline int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
+static inline int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 {
 	return -ENOSYS;
 }
 static inline void pci_iov_remove_virtfn(struct pci_dev *dev,
-					 int id, int reset) { }
+					 int id) { }
 static inline void pci_disable_sriov(struct pci_dev *dev) { }
 static inline int pci_num_vf(struct pci_dev *dev) { return 0; }
 static inline int pci_vfs_assigned(struct pci_dev *dev)
-- 
2.10.0.1.g70cd14e
