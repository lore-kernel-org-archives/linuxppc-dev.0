Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 016251A0061
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 02:41:45 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 3 Nov 2014 01:41:45 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E634D2CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 02:41:41 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sA2Fhef638666460
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 02:43:40 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sA2FfeCu028013
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 02:41:41 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V9 01/18] PCI/IOV: Export interface for retrieve VF's BDF
Date: Sun,  2 Nov 2014 23:41:17 +0800
Message-Id: <1414942894-17034-2-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
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
index 4d109c0..5e8091b 100644
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
@@ -69,7 +73,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 	struct pci_bus *bus;
 
 	mutex_lock(&iov->dev->sriov->lock);
-	bus = virtfn_add_bus(dev->bus, virtfn_bus(dev, id));
+	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
 	if (!bus)
 		goto failed;
 
@@ -77,7 +81,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 	if (!virtfn)
 		goto failed0;
 
-	virtfn->devfn = virtfn_devfn(dev, id);
+	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
 	virtfn->vendor = dev->vendor;
 	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_DID, &virtfn->device);
 	pci_setup_device(virtfn);
@@ -140,8 +144,8 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
 	struct pci_sriov *iov = dev->sriov;
 
 	virtfn = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus),
-					     virtfn_bus(dev, id),
-					     virtfn_devfn(dev, id));
+					     pci_iov_virtfn_bus(dev, id),
+					     pci_iov_virtfn_devfn(dev, id));
 	if (!virtfn)
 		return;
 
@@ -216,7 +220,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	iov->offset = offset;
 	iov->stride = stride;
 
-	if (virtfn_bus(dev, nr_virtfn - 1) > dev->bus->busn_res.end) {
+	if (pci_iov_virtfn_bus(dev, nr_virtfn - 1) > dev->bus->busn_res.end) {
 		dev_err(&dev->dev, "SR-IOV: bus number out of range\n");
 		return -ENOMEM;
 	}
@@ -516,7 +520,7 @@ resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
 	if (!reg)
 		return 0;
 
-	 __pci_read_base(dev, type, &tmp, reg);
+	__pci_read_base(dev, type, &tmp, reg);
 	return resource_alignment(&tmp);
 }
 
@@ -546,7 +550,7 @@ int pci_iov_bus_range(struct pci_bus *bus)
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (!dev->is_physfn)
 			continue;
-		busnr = virtfn_bus(dev, dev->sriov->total_VFs - 1);
+		busnr = pci_iov_virtfn_bus(dev, dev->sriov->total_VFs - 1);
 		if (busnr > max)
 			max = busnr;
 	}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5be8db4..3ed7c66 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1654,6 +1654,9 @@ int pci_ext_cfg_avail(void);
 void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar);
 
 #ifdef CONFIG_PCI_IOV
+int pci_iov_virtfn_bus(struct pci_dev *dev, int id);
+int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
+
 int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
 void pci_disable_sriov(struct pci_dev *dev);
 int pci_num_vf(struct pci_dev *dev);
@@ -1661,6 +1664,14 @@ int pci_vfs_assigned(struct pci_dev *dev);
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
