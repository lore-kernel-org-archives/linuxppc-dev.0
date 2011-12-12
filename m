Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 8FC851007D4
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 10:37:38 +1100 (EST)
Received: from mail121-tx2 (localhost [127.0.0.1])	by
 mail121-tx2-R.bigfish.com (Postfix) with ESMTP id 1CD17801CE	for
 <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2011 23:37:33 +0000 (UTC)
Received: from TX2EHSMHS023.bigfish.com (unknown [10.9.14.254])	by
 mail121-tx2.bigfish.com (Postfix) with ESMTP id A7EF1100042	for
 <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2011 23:37:32 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <scottwood@freescale.com>,
 <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/fsl: add MSI support for the Freescale hypervisor
Date: Mon, 12 Dec 2011 17:37:32 -0600
Message-ID: <1323733052-21495-1-git-send-email-timur@freescale.com>
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

Add support for MSIs under the Freescale hypervisor.  This involves updating
the fsl_pci driver to support vmpic-msi nodes, and updating the fsl_pci
driver to create an ATMU for the rerouted MSIIR register.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c |   68 +++++++++++++++++++++++++++++------------
 arch/powerpc/sysdev/fsl_msi.h |    7 ++--
 arch/powerpc/sysdev/fsl_pci.c |   25 +++++++++++++++
 3 files changed, 77 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 89548e0..7dc473f 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -23,6 +23,8 @@
 #include <asm/hw_irq.h>
 #include <asm/ppc-pci.h>
 #include <asm/mpic.h>
+#include <asm/fsl_hcalls.h>
+
 #include "fsl_msi.h"
 #include "fsl_pci.h"
 
@@ -163,11 +165,13 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	 */
 	np = of_parse_phandle(hose->dn, "fsl,msi", 0);
 	if (np) {
-		if (of_device_is_compatible(np, "fsl,mpic-msi"))
+		if (of_device_is_compatible(np, "fsl,mpic-msi") ||
+		    of_device_is_compatible(np, "fsl,vmpic-msi"))
 			phandle = np->phandle;
 		else {
-			dev_err(&pdev->dev, "node %s has an invalid fsl,msi"
-				" phandle\n", hose->dn->full_name);
+			dev_err(&pdev->dev,
+				"node %s has an invalid fsl,msi phandle %u\n",
+				hose->dn->full_name, np->phandle);
 			return -EINVAL;
 		}
 	}
@@ -196,16 +200,14 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 
 		if (hwirq < 0) {
 			rc = hwirq;
-			pr_debug("%s: fail allocating msi interrupt\n",
-					__func__);
+			dev_err(&pdev->dev, "could not allocate MSI interrupt\n");
 			goto out_free;
 		}
 
 		virq = irq_create_mapping(msi_data->irqhost, hwirq);
 
 		if (virq == NO_IRQ) {
-			pr_debug("%s: fail mapping hwirq 0x%x\n",
-					__func__, hwirq);
+			dev_err(&pdev->dev, "fail mapping hwirq %i\n", hwirq);
 			msi_bitmap_free_hwirqs(&msi_data->bitmap, hwirq, 1);
 			rc = -ENOSPC;
 			goto out_free;
@@ -234,6 +236,7 @@ static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 	u32 intr_index;
 	u32 have_shift = 0;
 	struct fsl_msi_cascade_data *cascade_data;
+	unsigned int ret;
 
 	cascade_data = irq_get_handler_data(irq);
 	msi_data = cascade_data->msi_data;
@@ -265,6 +268,14 @@ static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 	case FSL_PIC_IP_IPIC:
 		msir_value = fsl_msi_read(msi_data->msi_regs, msir_index * 0x4);
 		break;
+	case FSL_PIC_IP_VMPIC:
+		ret = fh_vmpic_get_msir(virq_to_hw(irq), &msir_value);
+		if (ret) {
+			pr_err("fsl-msi: fh_vmpic_get_msir() failed for "
+			       "irq %u (ret=%u)\n", irq, ret);
+			msir_value = 0;
+		}
+		break;
 	}
 
 	while (msir_value) {
@@ -282,6 +293,7 @@ static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 
 	switch (msi_data->feature & FSL_PIC_IP_MASK) {
 	case FSL_PIC_IP_MPIC:
+	case FSL_PIC_IP_VMPIC:
 		chip->irq_eoi(idata);
 		break;
 	case FSL_PIC_IP_IPIC:
@@ -311,7 +323,8 @@ static int fsl_of_msi_remove(struct platform_device *ofdev)
 	}
 	if (msi->bitmap.bitmap)
 		msi_bitmap_free(&msi->bitmap);
-	iounmap(msi->msi_regs);
+	if ((msi->feature & FSL_PIC_IP_MASK) != FSL_PIC_IP_VMPIC)
+		iounmap(msi->msi_regs);
 	kfree(msi);
 
 	return 0;
@@ -383,26 +396,32 @@ static int __devinit fsl_of_msi_probe(struct platform_device *dev)
 		goto error_out;
 	}
 
-	/* Get the MSI reg base */
-	err = of_address_to_resource(dev->dev.of_node, 0, &res);
-	if (err) {
-		dev_err(&dev->dev, "%s resource error!\n",
+	/*
+	 * Under the Freescale hypervisor, the msi nodes don't have a 'reg'
+	 * property.  Instead, we use hypercalls to access the MSI.
+	 */
+	if ((features->fsl_pic_ip & FSL_PIC_IP_MASK) != FSL_PIC_IP_VMPIC) {
+		err = of_address_to_resource(dev->dev.of_node, 0, &res);
+		if (err) {
+			dev_err(&dev->dev, "invalid resource for node %s\n",
 				dev->dev.of_node->full_name);
-		goto error_out;
-	}
+			goto error_out;
+		}
 
-	msi->msi_regs = ioremap(res.start, resource_size(&res));
-	if (!msi->msi_regs) {
-		dev_err(&dev->dev, "ioremap problem failed\n");
-		goto error_out;
+		msi->msi_regs = ioremap(res.start, resource_size(&res));
+		if (!msi->msi_regs) {
+			dev_err(&dev->dev, "could not map node %s\n",
+				dev->dev.of_node->full_name);
+			goto error_out;
+		}
+		msi->msiir_offset =
+			features->msiir_offset + (res.start & 0xfffff);
 	}
 
 	msi->feature = features->fsl_pic_ip;
 
 	msi->irqhost->host_data = msi;
 
-	msi->msiir_offset = features->msiir_offset + (res.start & 0xfffff);
-
 	/*
 	 * Remember the phandle, so that we can match with any PCI nodes
 	 * that have an "fsl,msi" property.
@@ -476,6 +495,11 @@ static const struct fsl_msi_feature ipic_msi_feature = {
 	.msiir_offset = 0x38,
 };
 
+static const struct fsl_msi_feature vmpic_msi_feature = {
+	.fsl_pic_ip = FSL_PIC_IP_VMPIC,
+	.msiir_offset = 0,
+};
+
 static const struct of_device_id fsl_of_msi_ids[] = {
 	{
 		.compatible = "fsl,mpic-msi",
@@ -485,6 +509,10 @@ static const struct of_device_id fsl_of_msi_ids[] = {
 		.compatible = "fsl,ipic-msi",
 		.data = (void *)&ipic_msi_feature,
 	},
+ 	{
+		.compatible = "fsl,vmpic-msi",
+		.data = (void *)&vmpic_msi_feature,
+	},
 	{}
 };
 
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
index b5d25ba..f6c646a 100644
--- a/arch/powerpc/sysdev/fsl_msi.h
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -20,9 +20,10 @@
 #define IRQS_PER_MSI_REG	32
 #define NR_MSI_IRQS	(NR_MSI_REG * IRQS_PER_MSI_REG)
 
-#define FSL_PIC_IP_MASK	0x0000000F
-#define FSL_PIC_IP_MPIC	0x00000001
-#define FSL_PIC_IP_IPIC	0x00000002
+#define FSL_PIC_IP_MASK   0x0000000F
+#define FSL_PIC_IP_MPIC   0x00000001
+#define FSL_PIC_IP_IPIC   0x00000002
+#define FSL_PIC_IP_VMPIC  0x00000003
 
 struct fsl_msi {
 	struct irq_host *irqhost;
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4ce547e..819987c 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -113,6 +113,8 @@ static void __init setup_pci_atmu(struct pci_controller *hose,
 	u32 piwar = PIWAR_EN | PIWAR_PF | PIWAR_TGI_LOCAL |
 			PIWAR_READ_SNOOP | PIWAR_WRITE_SNOOP;
 	char *name = hose->dn->full_name;
+	const u64 *reg;
+	int len;
 
 	pr_debug("PCI memory map start 0x%016llx, size 0x%016llx\n",
 		 (u64)rsrc->start, (u64)resource_size(rsrc));
@@ -205,6 +207,29 @@ static void __init setup_pci_atmu(struct pci_controller *hose,
 
 	/* Setup inbound mem window */
 	mem = memblock_end_of_DRAM();
+
+	/*
+	 * The msi-address-64 property, if it exists, indicates the physical
+	 * address of the MSIIR register.  Normally, this register is located
+	 * inside CCSR, so the ATMU that covers all of CCSR is used for MSIs.
+	 * But if this property exists, then we'll normally need to create a
+	 * new ATMU for it.  For now, however, we cheat.  The only entity that
+	 * creates this property is the Freescale hypervisor, and it
+	 * always locates MSIIR in the page immediately after the end of DDR.
+	 * So we can avoid allocating a new ATMU by just extending the DDR
+	 * ATMU by one page.
+	 */
+	reg = of_get_property(hose->dn, "msi-address-64", &len);
+	if (reg && (len == sizeof(u64))) {
+		u64 address = be64_to_cpup(reg);
+
+		if ((address >= mem) && (address < (mem + PAGE_SIZE)))
+			mem += PAGE_SIZE;
+		else
+			pr_warn("msi-address-64 address of %llx in node %s is "
+				"unsupported\n", address, hose->dn->full_name);
+	}
+
 	sz = min(mem, paddr_lo);
 	mem_log = __ilog2_u64(sz);
 
-- 
1.7.3.4
