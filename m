Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BAD4CDE1FF
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:56 +1100 (EST)
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 87C44368002
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:56 +1100 (EST)
Date: Fri, 7 Dec 2007 01:51:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 07/19] [POWERPC] iSeries: unindent and clean
	iSeries_pci_final_fixup
Message-Id: <20071207015148.917436cc.sfr@canb.auug.org.au>
In-Reply-To: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/pci.c |   68 +++++++++++++++++----------------
 1 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index cff832a..8e2ac3d 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -177,47 +177,49 @@ void __init iSeries_pci_final_fixup(void)
 
 	printk("pcibios_final_fixup\n");
 	for_each_pci_dev(pdev) {
+		struct pci_dn *pdn;
+		const u32 *agent;
+
 		node = find_device_node(pdev->bus->number, pdev->devfn);
 		printk("pci dev %p (%x.%x), node %p\n", pdev,
 		       pdev->bus->number, pdev->devfn, node);
+		if (!node) {
+			printk("PCI: Device Tree not found for 0x%016lX\n",
+					(unsigned long)pdev);
+			continue;
+		}
 
-		if (node != NULL) {
-			struct pci_dn *pdn = PCI_DN(node);
-			const u32 *agent;
-
-			agent = of_get_property(node, "linux,agent-id", NULL);
-			if ((pdn != NULL) && (agent != NULL)) {
-				u8 irq = iSeries_allocate_IRQ(pdn->busno, 0,
-						pdn->bussubno);
-				int err;
-
-				err = HvCallXm_connectBusUnit(pdn->busno, pdn->bussubno,
-						*agent, irq);
+		pdn = PCI_DN(node);
+		agent = of_get_property(node, "linux,agent-id", NULL);
+		if (pdn && agent) {
+			u8 irq = iSeries_allocate_IRQ(pdn->busno, 0,
+					pdn->bussubno);
+			int err;
+
+			err = HvCallXm_connectBusUnit(pdn->busno, pdn->bussubno,
+					*agent, irq);
+			if (err)
+				pci_log_error("Connect Bus Unit",
+					pdn->busno, pdn->bussubno, *agent, err);
+			else {
+				err = HvCallPci_configStore8(pdn->busno,
+					pdn->bussubno, *agent,
+					PCI_INTERRUPT_LINE, irq);
 				if (err)
-					pci_log_error("Connect Bus Unit",
-						pdn->busno, pdn->bussubno, *agent, err);
-				else {
-					err = HvCallPci_configStore8(pdn->busno, pdn->bussubno,
-							*agent,
-							PCI_INTERRUPT_LINE,
-							irq);
-					if (err)
-						pci_log_error("PciCfgStore Irq Failed!",
-							pdn->busno, pdn->bussubno, *agent, err);
-				}
-				if (!err)
+					pci_log_error("PciCfgStore Irq Failed!",
+						pdn->busno, pdn->bussubno,
+						*agent, err);
+				else
 					pdev->irq = irq;
 			}
+		}
 
-			++num_dev;
-			pdev->sysdata = node;
-			PCI_DN(node)->pcidev = pdev;
-			allocate_device_bars(pdev);
-			iSeries_Device_Information(pdev, num_dev);
-			iommu_devnode_init_iSeries(pdev, node);
-		} else
-			printk("PCI: Device Tree not found for 0x%016lX\n",
-					(unsigned long)pdev);
+		num_dev++;
+		pdev->sysdata = node;
+		PCI_DN(node)->pcidev = pdev;
+		allocate_device_bars(pdev);
+		iSeries_Device_Information(pdev, num_dev);
+		iommu_devnode_init_iSeries(pdev, node);
 	}
 	iSeries_activate_IRQs();
 	mf_display_src(0xC9000200);
-- 
1.5.3.7


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
