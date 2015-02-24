Return-Path: <bhelgaas@google.com>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ABC121A1084
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 19:33:21 +1100 (AEDT)
Received: by padfa1 with SMTP id fa1so34458133pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 00:33:19 -0800 (PST)
Subject: [PATCH v12 03/21] PCI: Keep individual VF BAR size in struct pci_sriov
To: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
 gwshan@linux.vnet.ibm.com
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 24 Feb 2015 02:33:16 -0600
Message-ID: <20150224083316.32124.29294.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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

Currently we don't store the individual VF BAR size.  We calculate it when
needed by dividing the PF's IOV resource size (which contains space for
*all* the VFs) by total_VFs or by reading the BAR in the SR-IOV capability
again.

Keep the individual VF BAR size in struct pci_sriov.barsz[], add
pci_iov_resource_size() to retrieve it, and use that instead of doing the
division or reading the SR-IOV capability BAR.

[bhelgaas: rename to "barsz[]", simplify barsz[] index computation, remove
SR-IOV capability BAR sizing]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c   |   39 ++++++++++++++++++++-------------------
 drivers/pci/pci.h   |    1 +
 include/linux/pci.h |    3 +++
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 05f9d97e4175..5bca0e1a2799 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -57,6 +57,14 @@ static void virtfn_remove_bus(struct pci_bus *physbus, struct pci_bus *virtbus)
 		pci_remove_bus(virtbus);
 }
 
+resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
+{
+	if (!dev->is_physfn)
+		return 0;
+
+	return dev->sriov->barsz[resno - PCI_IOV_RESOURCES];
+}
+
 static int virtfn_add(struct pci_dev *dev, int id, int reset)
 {
 	int i;
@@ -92,8 +100,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 			continue;
 		virtfn->resource[i].name = pci_name(virtfn);
 		virtfn->resource[i].flags = res->flags;
-		size = resource_size(res);
-		do_div(size, iov->total_VFs);
+		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
 		virtfn->resource[i].start = res->start + size * id;
 		virtfn->resource[i].end = virtfn->resource[i].start + size - 1;
 		rc = request_resource(res, &virtfn->resource[i]);
@@ -311,7 +318,7 @@ static void sriov_disable(struct pci_dev *dev)
 
 static int sriov_init(struct pci_dev *dev, int pos)
 {
-	int i;
+	int i, bar64;
 	int rc;
 	int nres;
 	u32 pgsz;
@@ -360,29 +367,29 @@ found:
 	pgsz &= ~(pgsz - 1);
 	pci_write_config_dword(dev, pos + PCI_SRIOV_SYS_PGSIZE, pgsz);
 
+	iov = kzalloc(sizeof(*iov), GFP_KERNEL);
+	if (!iov)
+		return -ENOMEM;
+
 	nres = 0;
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = dev->resource + PCI_IOV_RESOURCES + i;
-		i += __pci_read_base(dev, pci_bar_unknown, res,
-				     pos + PCI_SRIOV_BAR + i * 4);
+		bar64 = __pci_read_base(dev, pci_bar_unknown, res,
+					pos + PCI_SRIOV_BAR + i * 4);
 		if (!res->flags)
 			continue;
 		if (resource_size(res) & (PAGE_SIZE - 1)) {
 			rc = -EIO;
 			goto failed;
 		}
+		iov->barsz[i] = resource_size(res);
 		res->end = res->start + resource_size(res) * total - 1;
 		dev_info(&dev->dev, "VF(n) BAR%d space: %pR (contains BAR%d for %d VFs)\n",
 			 i, res, i, total);
+		i += bar64;
 		nres++;
 	}
 
-	iov = kzalloc(sizeof(*iov), GFP_KERNEL);
-	if (!iov) {
-		rc = -ENOMEM;
-		goto failed;
-	}
-
 	iov->pos = pos;
 	iov->nres = nres;
 	iov->ctrl = ctrl;
@@ -414,6 +421,7 @@ failed:
 		res->flags = 0;
 	}
 
+	kfree(iov);
 	return rc;
 }
 
@@ -510,14 +518,7 @@ int pci_iov_resource_bar(struct pci_dev *dev, int resno)
  */
 resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
 {
-	struct resource tmp;
-	int reg = pci_iov_resource_bar(dev, resno);
-
-	if (!reg)
-		return 0;
-
-	 __pci_read_base(dev, pci_bar_unknown, &tmp, reg);
-	return resource_alignment(&tmp);
+	return pci_iov_resource_size(dev, resno);
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4091f82239cd..57329645dd01 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -247,6 +247,7 @@ struct pci_sriov {
 	struct pci_dev *dev;	/* lowest numbered PF */
 	struct pci_dev *self;	/* this PF */
 	struct mutex lock;	/* lock for VF bus */
+	resource_size_t barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
 };
 
 #ifdef CONFIG_PCI_ATS
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 211e9da8a7d7..15596582e575 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1675,6 +1675,7 @@ int pci_num_vf(struct pci_dev *dev);
 int pci_vfs_assigned(struct pci_dev *dev);
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
 int pci_sriov_get_totalvfs(struct pci_dev *dev);
+resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
 #else
 static inline int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
 { return -ENODEV; }
@@ -1686,6 +1687,8 @@ static inline int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
 { return 0; }
 static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
 { return 0; }
+static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
+{ return 0; }
 #endif
 
 #if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)
