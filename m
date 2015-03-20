Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E3BC11A012C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:11:05 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 20 Mar 2015 13:11:05 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4BF5C2BB005A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:11:03 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2K3AtTE55836844
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:11:03 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2K3ATd0005531
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:10:30 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH V14 08/21] PCI: Calculate maximum number of buses required for
 VFs
Date: Fri, 20 Mar 2015 11:06:24 +0800
Message-Id: <1426820797-6267-9-git-send-email-weiyang@linux.vnet.ibm.com>
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

An SR-IOV device can change its First VF Offset and VF Stride based on the
values of ARI Capable Hierarchy and NumVFs.  The number of buses required
for all VFs is determined by NumVFs, First VF Offset, and VF Stride (see
SR-IOV spec r1.1, sec 2.1.2).

Previously pci_iov_bus_range() computed how many buses would be required by
TotalVFs, but this was based on a single NumVFs value and may not have been
the maximum for all NumVFs configurations.

Iterate over all valid NumVFs and calculate the maximum number of bus
numbers that could ever be required for VFs of this device.

[bhelgaas: changelog, compute busnr of NumVFs, not TotalVFs, remove
kerenl-doc comment marker]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c |   31 +++++++++++++++++++++++++++----
 drivers/pci/pci.h |    1 +
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index a8752c2..2ae921f 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -46,6 +46,30 @@ static inline void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn)
 	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_STRIDE, &iov->stride);
 }
 
+/*
+ * The PF consumes one bus number.  NumVFs, First VF Offset, and VF Stride
+ * determine how many additional bus numbers will be consumed by VFs.
+ *
+ * Iterate over all valid NumVFs and calculate the maximum number of bus
+ * numbers that could ever be required.
+ */
+static inline u8 virtfn_max_buses(struct pci_dev *dev)
+{
+	struct pci_sriov *iov = dev->sriov;
+	int nr_virtfn;
+	u8 max = 0;
+	u8 busnr;
+
+	for (nr_virtfn = 1; nr_virtfn <= iov->total_VFs; nr_virtfn++) {
+		pci_iov_set_numvfs(dev, nr_virtfn);
+		busnr = virtfn_bus(dev, nr_virtfn - 1);
+		if (busnr > max)
+			max = busnr;
+	}
+
+	return max;
+}
+
 static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
 {
 	struct pci_bus *child;
@@ -427,6 +451,7 @@ found:
 
 	dev->sriov = iov;
 	dev->is_physfn = 1;
+	iov->max_VF_buses = virtfn_max_buses(dev);
 
 	return 0;
 
@@ -556,15 +581,13 @@ void pci_restore_iov_state(struct pci_dev *dev)
 int pci_iov_bus_range(struct pci_bus *bus)
 {
 	int max = 0;
-	u8 busnr;
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (!dev->is_physfn)
 			continue;
-		busnr = virtfn_bus(dev, dev->sriov->total_VFs - 1);
-		if (busnr > max)
-			max = busnr;
+		if (dev->sriov->max_VF_buses > max)
+			max = dev->sriov->max_VF_buses;
 	}
 
 	return max ? max - bus->number : 0;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5732964..bae593c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -243,6 +243,7 @@ struct pci_sriov {
 	u16 stride;		/* following VF stride */
 	u32 pgsz;		/* page size for BAR alignment */
 	u8 link;		/* Function Dependency Link */
+	u8 max_VF_buses;	/* max buses consumed by VFs */
 	u16 driver_max_VFs;	/* max num VFs driver supports */
 	struct pci_dev *dev;	/* lowest numbered PF */
 	struct pci_dev *self;	/* this PF */
-- 
1.7.9.5
