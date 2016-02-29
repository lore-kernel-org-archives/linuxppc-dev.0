Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56B741A005D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 16:42:11 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Mon, 29 Feb 2016 15:42:10 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9FA372BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 16:41:59 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1T5fpGJ61603956
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 16:41:59 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1T5fQYC013612
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 16:41:27 +1100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: [PATCH] cxl: Ignore probes for virtual afu pci devices
Date: Mon, 29 Feb 2016 11:10:53 +0530
Message-Id: <1456724453-10152-1-git-send-email-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a check at the beginning of cxl_probe function to ignore virtual pci
devices created for each afu registered. This fixes the the errors
messages logged about missing CXL vsec, when cxl probe is unable to
find necessary vsec entries in device pci config space. The error
message logged are of the form :

cxl-pci 0004:00:00.0: ABORTING: CXL VSEC not found!
cxl-pci 0004:00:00.0: cxl_init_adapter failed: -19

Cc: Ian Munsie <imunsie@au1.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/cxl.h  | 2 ++
 drivers/misc/cxl/pci.c  | 5 +++++
 drivers/misc/cxl/vphb.c | 9 +++++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index a521bc7..68d39f5 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -764,4 +764,6 @@ unsigned int afu_poll(struct file *file, struct poll_table_struct *poll);
 ssize_t afu_read(struct file *file, char __user *buf, size_t count, loff_t *off);
 extern const struct file_operations afu_fops;
 
+/* check if the given pci_dev is on the the cxl vphb bus */
+bool cxl_pci_is_vphb_device(struct pci_dev *dev);
 #endif
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 4c1903f..2f219c1 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1278,6 +1278,11 @@ static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	int slice;
 	int rc;
 
+	if (cxl_pci_is_vphb_device(dev)) {
+		dev_dbg(&dev->dev, "cxl_init_adapter: Ignoring cxl vphb device\n");
+		return -ENODEV;
+	}
+
 	if (cxl_verbose)
 		dump_cxl_config_space(dev);
 
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index cbd4331..e76a42a 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -296,6 +296,15 @@ void cxl_pci_vphb_remove(struct cxl_afu *afu)
 	pcibios_free_controller(phb);
 }
 
+bool cxl_pci_is_vphb_device(struct pci_dev *dev)
+{
+	struct pci_controller *phb;
+
+	phb = pci_bus_to_host(dev->bus);
+
+	return (phb->ops == &cxl_pcie_pci_ops);
+}
+
 struct cxl_afu *cxl_pci_to_afu(struct pci_dev *dev)
 {
 	struct pci_controller *phb;
-- 
2.7.0.dirty
