Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE8201A0C4D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:10:05 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 20 Mar 2015 13:10:05 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 347F02CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:10:03 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2K39stK39125234
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:10:03 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2K39SN5004093
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:09:29 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH V14 05/21] PCI: Keep individual VF BAR size in struct pci_sriov
Date: Fri, 20 Mar 2015 11:06:21 +0800
Message-Id: <1426820797-6267-6-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
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
---
 drivers/pci/iov.c   |   39 ++++++++++++++++++++-------------------
 drivers/pci/pci.h   |    1 +
 include/linux/pci.h |    3 +++
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 05f9d97..5bca0e1 100644
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
index 4091f82..5732964 100644
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
index 211e9da..1559658 100644
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
-- 
1.7.9.5
