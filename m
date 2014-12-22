Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC0921A0C56
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 16:54:56 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 22 Dec 2014 15:54:55 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4ED8A2CE8060
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 16:54:53 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBM5srBi40239250
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 16:54:53 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBM5sqBB020526
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 16:54:53 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH V10 04/17] PCI: Store VF BAR size in pci_sriov
Date: Mon, 22 Dec 2014 13:54:24 +0800
Message-Id: <1419227677-12312-5-git-send-email-weiyang@linux.vnet.ibm.com>
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

Currently we don't store the VF BAR size, and each time we calculate the size
by dividing the PF's IOV BAR size by total_VFs.

This patch stores the VF BAR size in pci_sriov and introduces a function to
retrieve it. Also, it adds a log message to show the total PF's IOV BAR size.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c   |   28 ++++++++++++++++++++--------
 drivers/pci/pci.h   |    2 ++
 include/linux/pci.h |    3 +++
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 554dd64..9a3e16c 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -100,6 +100,14 @@ static void virtfn_remove_bus(struct pci_bus *physbus, struct pci_bus *virtbus)
 		pci_remove_bus(virtbus);
 }
 
+resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
+{
+	if (!dev->is_physfn)
+		return 0;
+
+	return dev->sriov->res[resno - PCI_IOV_RESOURCES];
+}
+
 static int virtfn_add(struct pci_dev *dev, int id, int reset)
 {
 	int i;
@@ -135,8 +143,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 			continue;
 		virtfn->resource[i].name = pci_name(virtfn);
 		virtfn->resource[i].flags = res->flags;
-		size = resource_size(res);
-		do_div(size, iov->total_VFs);
+		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
 		virtfn->resource[i].start = res->start + size * id;
 		virtfn->resource[i].end = virtfn->resource[i].start + size - 1;
 		rc = request_resource(res, &virtfn->resource[i]);
@@ -419,6 +426,12 @@ found:
 	pgsz &= ~(pgsz - 1);
 	pci_write_config_dword(dev, pos + PCI_SRIOV_SYS_PGSIZE, pgsz);
 
+	iov = kzalloc(sizeof(*iov), GFP_KERNEL);
+	if (!iov) {
+		rc = -ENOMEM;
+		goto failed;
+	}
+
 	nres = 0;
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = dev->resource + PCI_IOV_RESOURCES + i;
@@ -430,16 +443,15 @@ found:
 			rc = -EIO;
 			goto failed;
 		}
+		iov->res[res - dev->resource - PCI_IOV_RESOURCES] =
+			resource_size(res);
 		res->end = res->start + resource_size(res) * total - 1;
+		dev_info(&dev->dev, "VF BAR%ld: %pR (for %d VFs)",
+				res - dev->resource - PCI_IOV_RESOURCES,
+				res, total);
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
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 94faf97..b1c9fdd 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -241,6 +241,8 @@ struct pci_sriov {
 	struct pci_dev *dev;	/* lowest numbered PF */
 	struct pci_dev *self;	/* this PF */
 	struct mutex lock;	/* lock for VF bus */
+	resource_size_t res[PCI_SRIOV_NUM_BARS];
+				/* VF BAR size */
 };
 
 #ifdef CONFIG_PCI_ATS
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ae7a7ea..f0b5f87 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1670,6 +1670,7 @@ int pci_num_vf(struct pci_dev *dev);
 int pci_vfs_assigned(struct pci_dev *dev);
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
 int pci_sriov_get_totalvfs(struct pci_dev *dev);
+resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
 #else
 static inline int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
 {
@@ -1689,6 +1690,8 @@ static inline int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
 { return 0; }
 static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
 { return 0; }
+static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
+{ return 0; }
 #endif
 
 #if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)
-- 
1.7.9.5
