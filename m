Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
 [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 58C371007D7
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Oct 2011 09:30:23 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <scottwood@freescale.com>, <miltonm@bga.com>,
 <tglx@linutronix.de>, <benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] [v2] powerpc/fsl_msi: add support for the fsl,
 msi property in PCI nodes
Date: Wed, 26 Oct 2011 17:30:15 -0500
Message-ID: <1319668215-20089-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Freescale parts with multiple MSI controllers, the controllers are
combined into one "pool" of interrupts.  Whenever a device requests an MSI
interrupt, the next available interrupt from the pool is selected,
regardless of which MSI controller the interrupt is from.  This works
because each PCI bus has an ATMU to all of CCSR, so any PCI device can
access any MSI interrupt register.

The fsl,msi property is used to specify that a given PCI bus should only
use a specific MSI device.  This is necessary, for example, with the
Freescale hypervisor, because the MSI devices are assigned to specific
partitions.

Ideally, we'd like to be able to assign MSI devices to PCI busses within
the MSI or PCI layers.  However, there does not appear to be a mechanism
to do that.  Whenever the MSI layer wants to allocate an MSI interrupt to
a PCI device, it just calls arch_setup_msi_irqs().  It would be nice if we
could register an MSI device with a specific PCI bus.

So instead we remember the phandles of each MSI device, and we use that to
limit our search for an available interrupt.  Whenever we are asked to
allocate a new interrupt for a PCI device, we check the fsl,msi property
of the PCI bus for that device.  If it exists, then as we are looping over
all MSI devices, we skip the ones that don't have a matching phandle.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c |   33 +++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_msi.h |    3 +++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index e5c344d..155ccb2 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -148,14 +148,41 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 
 static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct device_node *np;
+	phandle phandle = 0;
 	int rc, hwirq = -ENOMEM;
 	unsigned int virq;
 	struct msi_desc *entry;
 	struct msi_msg msg;
 	struct fsl_msi *msi_data;
 
+	/*
+	 * If the PCI node has an fsl,msi property, then we need to use it
+	 * to find the specific MSI.
+	 */
+	np = of_parse_phandle(hose->dn, "fsl,msi", 0);
+	if (np)
+		phandle = np->phandle;
+
 	list_for_each_entry(entry, &pdev->msi_list, list) {
+		/*
+		 * Loop over all the available MSI devices until we find one
+		 * that has an available interrupt.
+		 */
 		list_for_each_entry(msi_data, &msi_head, list) {
+			/*
+			 * If the PCI node has an fsl,msi property, then we
+			 * need to restrict our search to the corresponding
+			 * MSI node.  The simplest way is to skip over MSI
+			 * nodes with the wrong phandle. Under the Freescale
+			 * hypervisor, this has the additional benefit of
+			 * skipping over MSI nodes that are not mapped in the
+			 * PAMU.
+			 */
+			if (phandle && (phandle != msi_data->phandle))
+				continue;
+
 			hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
 			if (hwirq >= 0)
 				break;
@@ -370,6 +397,12 @@ static int __devinit fsl_of_msi_probe(struct platform_device *dev)
 
 	msi->msiir_offset = features->msiir_offset + (res.start & 0xfffff);
 
+	/*
+	 * Remember the phandle, so that we can match with any PCI nodes
+	 * that have an "fsl,msi" property.
+	 */
+	msi->phandle = dev->dev.of_node->phandle;
+
 	rc = fsl_msi_init_allocator(msi);
 	if (rc) {
 		dev_err(&dev->dev, "Error allocating MSI bitmap\n");
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
index 1313abb..b5d25ba 100644
--- a/arch/powerpc/sysdev/fsl_msi.h
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -13,6 +13,7 @@
 #ifndef _POWERPC_SYSDEV_FSL_MSI_H
 #define _POWERPC_SYSDEV_FSL_MSI_H
 
+#include <linux/of.h>
 #include <asm/msi_bitmap.h>
 
 #define NR_MSI_REG		8
@@ -36,6 +37,8 @@ struct fsl_msi {
 	struct msi_bitmap bitmap;
 
 	struct list_head list;          /* support multiple MSI banks */
+
+	phandle phandle;
 };
 
 #endif /* _POWERPC_SYSDEV_FSL_MSI_H */
-- 
1.7.3.4
