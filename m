Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3DA501A0F19
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:10:48 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 20 Mar 2015 13:10:47 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id AF064357804C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:10:45 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2K3Abhf47448136
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:10:45 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2K3ABqw005074
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:10:12 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH V14 07/21] PCI: Refresh First VF Offset and VF Stride when
 updating NumVFs
Date: Fri, 20 Mar 2015 11:06:23 +0800
Message-Id: <1426820797-6267-8-git-send-email-weiyang@linux.vnet.ibm.com>
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

The First VF Offset and VF Stride fields depend on the NumVFs setting, so
refresh the cached fields in struct pci_sriov when updating NumVFs.  See
the SR-IOV spec r1.1, sec 3.3.9 and 3.3.10.

[bhelgaas: changelog, remove kernel-doc comment marker]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 27b98c3..a8752c2 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -31,6 +31,21 @@ static inline u8 virtfn_devfn(struct pci_dev *dev, int id)
 		dev->sriov->stride * id) & 0xff;
 }
 
+/*
+ * Per SR-IOV spec sec 3.3.10 and 3.3.11, First VF Offset and VF Stride may
+ * change when NumVFs changes.
+ *
+ * Update iov->offset and iov->stride when NumVFs is written.
+ */
+static inline void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn)
+{
+	struct pci_sriov *iov = dev->sriov;
+
+	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, nr_virtfn);
+	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_OFFSET, &iov->offset);
+	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_STRIDE, &iov->stride);
+}
+
 static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
 {
 	struct pci_bus *child;
@@ -253,7 +268,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 			return rc;
 	}
 
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, nr_virtfn);
+	pci_iov_set_numvfs(dev, nr_virtfn);
 	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
@@ -282,7 +297,7 @@ failed:
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, 0);
+	pci_iov_set_numvfs(dev, 0);
 	ssleep(1);
 	pci_cfg_access_unlock(dev);
 
@@ -313,7 +328,7 @@ static void sriov_disable(struct pci_dev *dev)
 		sysfs_remove_link(&dev->dev.kobj, "dep_link");
 
 	iov->num_VFs = 0;
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, 0);
+	pci_iov_set_numvfs(dev, 0);
 }
 
 static int sriov_init(struct pci_dev *dev, int pos)
@@ -452,7 +467,7 @@ static void sriov_restore_state(struct pci_dev *dev)
 		pci_update_resource(dev, i);
 
 	pci_write_config_dword(dev, iov->pos + PCI_SRIOV_SYS_PGSIZE, iov->pgsz);
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, iov->num_VFs);
+	pci_iov_set_numvfs(dev, iov->num_VFs);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
 	if (iov->ctrl & PCI_SRIOV_CTRL_VFE)
 		msleep(100);
-- 
1.7.9.5
