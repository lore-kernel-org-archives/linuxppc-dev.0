Return-Path: <bhelgaas@google.com>
Received: from mail-pd0-x22a.google.com (mail-pd0-x22a.google.com
 [IPv6:2607:f8b0:400e:c02::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1169B1A0F7F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 19:33:42 +1100 (AEDT)
Received: by pdbfl12 with SMTP id fl12so31841480pdb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 00:33:40 -0800 (PST)
Subject: [PATCH v12 06/21] PCI: Calculate maximum number of buses required
 for VFs
To: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
 gwshan@linux.vnet.ibm.com
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 24 Feb 2015 02:33:38 -0600
Message-ID: <20150224083338.32124.56221.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c |   31 +++++++++++++++++++++++++++----
 drivers/pci/pci.h |    1 +
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index a8752c2c2b53..2ae921f84bd3 100644
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
index 57329645dd01..bae593c04541 100644
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
