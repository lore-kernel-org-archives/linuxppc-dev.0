Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E96921A1A16
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:54:11 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 25 Mar 2015 15:54:11 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D9C1D2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:54:09 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2P5s15m36372618
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:54:09 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2P5radr025552
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:53:36 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH V15 09/21] PCI: Export pci_iov_virtfn_bus() and
 pci_iov_virtfn_devfn()
Date: Wed, 25 Mar 2015 13:44:45 +0800
Message-Id: <1427262297-5694-10-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1427262297-5694-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1427262297-5694-1-git-send-email-weiyang@linux.vnet.ibm.com>
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

On PowerNV, some resource reservation is needed for SR-IOV VFs that don't
exist at the bootup stage.  To do the match between resources and VFs, the
code need to get the VF's BDF in advance.

Rename virtfn_bus() and virtfn_devfn() to pci_iov_virtfn_bus() and
pci_iov_virtfn_devfn() and export them.

[bhelgaas: changelog, make "busnr" int]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c   |   28 ++++++++++++++++------------
 include/linux/pci.h |   11 +++++++++++
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 2ae921f..5643a10 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -19,16 +19,20 @@
 
 #define VIRTFN_ID_LEN	16
 
-static inline u8 virtfn_bus(struct pci_dev *dev, int id)
+int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
 {
+	if (!dev->is_physfn)
+		return -EINVAL;
 	return dev->bus->number + ((dev->devfn + dev->sriov->offset +
-				    dev->sriov->stride * id) >> 8);
+				    dev->sriov->stride * vf_id) >> 8);
 }
 
-static inline u8 virtfn_devfn(struct pci_dev *dev, int id)
+int pci_iov_virtfn_devfn(struct pci_dev *dev, int vf_id)
 {
+	if (!dev->is_physfn)
+		return -EINVAL;
 	return (dev->devfn + dev->sriov->offset +
-		dev->sriov->stride * id) & 0xff;
+		dev->sriov->stride * vf_id) & 0xff;
 }
 
 /*
@@ -58,11 +62,11 @@ static inline u8 virtfn_max_buses(struct pci_dev *dev)
 	struct pci_sriov *iov = dev->sriov;
 	int nr_virtfn;
 	u8 max = 0;
-	u8 busnr;
+	int busnr;
 
 	for (nr_virtfn = 1; nr_virtfn <= iov->total_VFs; nr_virtfn++) {
 		pci_iov_set_numvfs(dev, nr_virtfn);
-		busnr = virtfn_bus(dev, nr_virtfn - 1);
+		busnr = pci_iov_virtfn_bus(dev, nr_virtfn - 1);
 		if (busnr > max)
 			max = busnr;
 	}
@@ -116,7 +120,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 	struct pci_bus *bus;
 
 	mutex_lock(&iov->dev->sriov->lock);
-	bus = virtfn_add_bus(dev->bus, virtfn_bus(dev, id));
+	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
 	if (!bus)
 		goto failed;
 
@@ -124,7 +128,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 	if (!virtfn)
 		goto failed0;
 
-	virtfn->devfn = virtfn_devfn(dev, id);
+	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
 	virtfn->vendor = dev->vendor;
 	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_DID, &virtfn->device);
 	pci_setup_device(virtfn);
@@ -186,8 +190,8 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
 	struct pci_sriov *iov = dev->sriov;
 
 	virtfn = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus),
-					     virtfn_bus(dev, id),
-					     virtfn_devfn(dev, id));
+					     pci_iov_virtfn_bus(dev, id),
+					     pci_iov_virtfn_devfn(dev, id));
 	if (!virtfn)
 		return;
 
@@ -226,7 +230,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	struct pci_dev *pdev;
 	struct pci_sriov *iov = dev->sriov;
 	int bars = 0;
-	u8 bus;
+	int bus;
 
 	if (!nr_virtfn)
 		return 0;
@@ -263,7 +267,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	iov->offset = offset;
 	iov->stride = stride;
 
-	bus = virtfn_bus(dev, nr_virtfn - 1);
+	bus = pci_iov_virtfn_bus(dev, nr_virtfn - 1);
 	if (bus > dev->bus->busn_res.end) {
 		dev_err(&dev->dev, "can't enable %d VFs (bus %02x out of range of %pR)\n",
 			nr_virtfn, bus, &dev->bus->busn_res);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1559658..99ea948 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1669,6 +1669,9 @@ int pci_ext_cfg_avail(void);
 void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar);
 
 #ifdef CONFIG_PCI_IOV
+int pci_iov_virtfn_bus(struct pci_dev *dev, int id);
+int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
+
 int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
 void pci_disable_sriov(struct pci_dev *dev);
 int pci_num_vf(struct pci_dev *dev);
@@ -1677,6 +1680,14 @@ int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
 int pci_sriov_get_totalvfs(struct pci_dev *dev);
 resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
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
