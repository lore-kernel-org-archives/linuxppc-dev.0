Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 83EA01A0A3E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 16:54:49 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 22 Dec 2014 15:54:48 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3D5BC2BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 16:54:46 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBM5sh7m42926142
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 16:54:44 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBM5sjFd020281
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 16:54:45 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH V10 01/17] PCI/IOV: Export interface for retrieve VF's BDF
Date: Mon, 22 Dec 2014 13:54:21 +0800
Message-Id: <1419227677-12312-2-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1419227677-12312-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1419227677-12312-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When implementing the SR-IOV on PowerNV platform, some resource reservation is
needed for VFs which don't exist at the bootup stage. To do the match between
resources and VFs, the code need to get the VF's BDF in advance.

In this patch, it exports the interface to retrieve VF's BDF:
   * Make the virtfn_bus as an interface
   * Make the virtfn_devfn as an interface
   * Rename them with more specific name
   * Code cleanup in pci_sriov_resource_alignment()

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c   |   22 +++++++++++++---------
 include/linux/pci.h |   11 +++++++++++
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ea3a82c..e76d1a0 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -19,14 +19,18 @@
 
 #define VIRTFN_ID_LEN	16
 
-static inline u8 virtfn_bus(struct pci_dev *dev, int id)
+int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
 {
+	if (!dev->is_physfn)
+		return -EINVAL;
 	return dev->bus->number + ((dev->devfn + dev->sriov->offset +
 				    dev->sriov->stride * id) >> 8);
 }
 
-static inline u8 virtfn_devfn(struct pci_dev *dev, int id)
+int pci_iov_virtfn_devfn(struct pci_dev *dev, int id)
 {
+	if (!dev->is_physfn)
+		return -EINVAL;
 	return (dev->devfn + dev->sriov->offset +
 		dev->sriov->stride * id) & 0xff;
 }
@@ -62,7 +66,7 @@ static inline void pci_iov_max_bus_range(struct pci_dev *dev)
 
 	for ( ; total >= 0; total--) {
 		pci_iov_set_numvfs(dev, total);
-		busnr = virtfn_bus(dev, iov->total_VFs - 1);
+		busnr = pci_iov_virtfn_bus(dev, iov->total_VFs - 1);
 		if (busnr > max)
 			max = busnr;
 	}
@@ -108,7 +112,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 	struct pci_bus *bus;
 
 	mutex_lock(&iov->dev->sriov->lock);
-	bus = virtfn_add_bus(dev->bus, virtfn_bus(dev, id));
+	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
 	if (!bus)
 		goto failed;
 
@@ -116,7 +120,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 	if (!virtfn)
 		goto failed0;
 
-	virtfn->devfn = virtfn_devfn(dev, id);
+	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
 	virtfn->vendor = dev->vendor;
 	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_DID, &virtfn->device);
 	pci_setup_device(virtfn);
@@ -179,8 +183,8 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
 	struct pci_sriov *iov = dev->sriov;
 
 	virtfn = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus),
-					     virtfn_bus(dev, id),
-					     virtfn_devfn(dev, id));
+					     pci_iov_virtfn_bus(dev, id),
+					     pci_iov_virtfn_devfn(dev, id));
 	if (!virtfn)
 		return;
 
@@ -255,7 +259,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	iov->offset = offset;
 	iov->stride = stride;
 
-	if (virtfn_bus(dev, nr_virtfn - 1) > dev->bus->busn_res.end) {
+	if (pci_iov_virtfn_bus(dev, nr_virtfn - 1) > dev->bus->busn_res.end) {
 		dev_err(&dev->dev, "SR-IOV: bus number out of range\n");
 		return -ENOMEM;
 	}
@@ -551,7 +555,7 @@ resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
 	if (!reg)
 		return 0;
 
-	 __pci_read_base(dev, pci_bar_unknown, &tmp, reg);
+	__pci_read_base(dev, pci_bar_unknown, &tmp, reg);
 	return resource_alignment(&tmp);
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 360a966..74ef944 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1658,6 +1658,9 @@ int pci_ext_cfg_avail(void);
 void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar);
 
 #ifdef CONFIG_PCI_IOV
+int pci_iov_virtfn_bus(struct pci_dev *dev, int id);
+int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
+
 int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
 void pci_disable_sriov(struct pci_dev *dev);
 int pci_num_vf(struct pci_dev *dev);
@@ -1665,6 +1668,14 @@ int pci_vfs_assigned(struct pci_dev *dev);
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
 int pci_sriov_get_totalvfs(struct pci_dev *dev);
 #else
+static inline int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
+{
+	return -ENOSYS;
+}
+static inline int pci_iov_virtfn_devfn(struct pci_dev *dev, int id)
+{
+	return -ENOSYS;
+}
 static inline int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
 { return -ENODEV; }
 static inline void pci_disable_sriov(struct pci_dev *dev) { }
-- 
1.7.9.5
