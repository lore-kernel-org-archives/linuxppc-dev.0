Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 32C2367A77
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 17:09:32 +1000 (EST)
Date: Fri, 19 May 2006 16:50:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 05/14] powerpc: remove Irq from pci_dn
Message-Id: <20060519165039.7614a22b.sfr@canb.auug.org.au>
In-Reply-To: <20060519164249.2dc43bc4.sfr@canb.auug.org.au>
References: <20060519164249.2dc43bc4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As we now store enough information in the device_node to allocate the
irq number in pcibios_final_fixup.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/platforms/iseries/pci.c |   53 ++++++++++++++++++----------------
 include/asm-powerpc/pci-bridge.h     |    1 -
 2 files changed, 28 insertions(+), 26 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

0a0cf362cf41de98069fb817acf23a4d041b45f4
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 5bc08d4..edaafbb 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -190,9 +190,6 @@ void iSeries_pcibios_init(void)
 		/* Find and connect the devices. */
 		for (dn = NULL; (dn = of_get_next_child(node, dn)) != NULL;) {
 			struct pci_dn *pdn;
-			u8 irq;
-			int err;
-			u32 *agent;
 			u32 *reg;
 			u32 *lsn;
 
@@ -206,11 +203,6 @@ void iSeries_pcibios_init(void)
 				printk(KERN_DEBUG "no subbus property!\n");
 				continue;
 			}
-			agent = (u32 *)get_property(dn, "linux,agent-id", NULL);
-			if (agent == NULL) {
-				printk(KERN_DEBUG "no agent-id\n");
-				continue;
-			}
 			lsn = (u32 *)get_property(dn,
 					"linux,logical-slot-number", NULL);
 			if (lsn == NULL) {
@@ -218,21 +210,6 @@ void iSeries_pcibios_init(void)
 				continue;
 			}
 
-			irq = iSeries_allocate_IRQ(bus, 0, *busp);
-			err = HvCallXm_connectBusUnit(bus, *busp, *agent, irq);
-			if (err) {
-				pci_Log_Error("Connect Bus Unit",
-					      bus, *busp, *agent, err);
-				continue;
-			}
-			err = HvCallPci_configStore8(bus, *busp, *agent,
-					PCI_INTERRUPT_LINE, irq);
-			if (err) {
-				pci_Log_Error("PciCfgStore Irq Failed!",
-						bus, *busp, *agent, err);
-				continue;
-			}
-
 			pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
 			if (pdn == NULL)
 				return;
@@ -241,7 +218,6 @@ void iSeries_pcibios_init(void)
 			pdn->busno = bus;
 			pdn->devfn = (reg[0] >> 8) & 0xff;
 			pdn->bussubno = *busp;
-			pdn->Irq = irq;
 			pdn->LogicalSlot = *lsn;
 		}
 	}
@@ -266,6 +242,34 @@ void __init iSeries_pci_final_fixup(void
 		       pdev->bus->number, pdev->devfn, node);
 
 		if (node != NULL) {
+			struct pci_dn *pdn = PCI_DN(node);
+			u32 *agent;
+
+			agent = (u32 *)get_property(node, "linux,agent-id",
+					NULL);
+			if ((pdn != NULL) && (agent != NULL)) {
+				u8 irq = iSeries_allocate_IRQ(pdn->busno, 0,
+						pdn->bussubno);
+				int err;
+
+				err = HvCallXm_connectBusUnit(pdn->busno, pdn->bussubno,
+						*agent, irq);
+				if (err)
+					pci_Log_Error("Connect Bus Unit",
+						pdn->busno, pdn->bussubno, *agent, err);
+				else {
+					err = HvCallPci_configStore8(pdn->busno, pdn->bussubno,
+							*agent,
+							PCI_INTERRUPT_LINE,
+							irq);
+					if (err)
+						pci_Log_Error("PciCfgStore Irq Failed!",
+							pdn->busno, pdn->bussubno, *agent, err);
+				}
+				if (!err)
+					pdev->irq = irq;
+			}
+
 			++DeviceCount;
 			pdev->sysdata = (void *)node;
 			PCI_DN(node)->pcidev = pdev;
@@ -275,7 +279,6 @@ void __init iSeries_pci_final_fixup(void
 		} else
 			printk("PCI: Device Tree not found for 0x%016lX\n",
 					(unsigned long)pdev);
-		pdev->irq = PCI_DN(node)->Irq;
 	}
 	iSeries_activate_IRQs();
 	mf_display_src(0xC9000200);
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index 59794b4..09079e4 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -79,7 +79,6 @@ #endif
 	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
 	struct	device_node *node;	/* back-pointer to the device_node */
 #ifdef CONFIG_PPC_ISERIES
-	int	Irq;			/* Assigned IRQ */
 	int	Flags;			/* Possible flags(disable/bist)*/
 	u8	LogicalSlot;		/* Hv Slot Index for Tces */
 #endif
-- 
1.3.1.ge923
