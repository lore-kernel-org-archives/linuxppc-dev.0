Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DA861DDF31
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:59 +1100 (EST)
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id ACD19368002
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:59 +1100 (EST)
Date: Fri, 7 Dec 2007 01:56:55 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 12/19] [POWERPC] iSeries: reduce dependence on pci_dn bussubno
Message-Id: <20071207015655.bf31fc29.sfr@canb.auug.org.au>
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
 arch/powerpc/platforms/iseries/pci.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index b46d8c5..7e00e35 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -190,6 +190,7 @@ void __init iSeries_pci_final_fixup(void)
 	for_each_pci_dev(pdev) {
 		struct pci_dn *pdn;
 		const u32 *agent;
+		const u32 *sub_bus;
 
 		node = find_device_node(pdev->bus->number, pdev->devfn);
 		printk("pci dev %p (%x.%x), node %p\n", pdev,
@@ -202,23 +203,23 @@ void __init iSeries_pci_final_fixup(void)
 
 		pdn = PCI_DN(node);
 		agent = of_get_property(node, "linux,agent-id", NULL);
-		if (pdn && agent) {
-			u8 irq = iSeries_allocate_IRQ(pdn->busno, 0,
-					pdn->bussubno);
+		sub_bus = of_get_property(node, "linux,subbus", NULL);
+		if (pdn && agent && sub_bus) {
+			u8 irq = iSeries_allocate_IRQ(pdn->busno, 0, *sub_bus);
 			int err;
 
-			err = HvCallXm_connectBusUnit(pdn->busno, pdn->bussubno,
+			err = HvCallXm_connectBusUnit(pdn->busno, *sub_bus,
 					*agent, irq);
 			if (err)
 				pci_log_error("Connect Bus Unit",
-					pdn->busno, pdn->bussubno, *agent, err);
+					pdn->busno, *sub_bus, *agent, err);
 			else {
 				err = HvCallPci_configStore8(pdn->busno,
-					pdn->bussubno, *agent,
+					*sub_bus, *agent,
 					PCI_INTERRUPT_LINE, irq);
 				if (err)
 					pci_log_error("PciCfgStore Irq Failed!",
-						pdn->busno, pdn->bussubno,
+						pdn->busno, *sub_bus,
 						*agent, err);
 				else
 					pdev->irq = irq;
@@ -229,8 +230,7 @@ void __init iSeries_pci_final_fixup(void)
 		pdev->sysdata = node;
 		PCI_DN(node)->pcidev = pdev;
 		allocate_device_bars(pdev);
-		iSeries_Device_Information(pdev, num_dev, pdn->busno,
-				pdn->bussubno);
+		iSeries_Device_Information(pdev, num_dev, pdn->busno, *sub_bus);
 		iommu_devnode_init_iSeries(pdev, node);
 	}
 	iSeries_activate_IRQs();
-- 
1.5.3.7


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
