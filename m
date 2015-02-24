Return-Path: <bhelgaas@google.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 138991A104D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 19:33:49 +1100 (AEDT)
Received: by padet14 with SMTP id et14so34317713pad.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 00:33:47 -0800 (PST)
Subject: [PATCH v12 07/21] PCI: Export pci_iov_virtfn_bus() and
 pci_iov_virtfn_devfn()
To: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
 gwshan@linux.vnet.ibm.com
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 24 Feb 2015 02:33:45 -0600
Message-ID: <20150224083345.32124.25546.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yang <weiyang@linux.vnet.ibm.com>

On PowerNV, some resource reservation is needed for SR-IOV VFs that don't
exist at the bootup stage.  To do the match between resources and VFs, the
code need to get the VF's BDF in advance.

Rename virtfn_bus() and virtfn_devfn() to pci_iov_virtfn_bus() and
pci_iov_virtfn_devfn() and export them.

[bhelgaas: changelog, make "busnr" int]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c   |   28 ++++++++++++++++------------
 include/linux/pci.h |   11 +++++++++++
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 2ae921f84bd3..5643a1011e23 100644
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
index 15596582e575..99ea94835fb6 100644
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
