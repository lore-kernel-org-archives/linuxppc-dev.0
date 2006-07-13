Return-Path: <michael@ozlabs.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 13 Jul 2006 17:54:39 +1000
Subject: [PATCH 1/3] iseries: Fix a compiler warning in
	platforms/iseries/vpdinfo.c
Message-Id: <1152777279.500377.573076823663.qpush@concordia>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

iSeries_Get_Location_Code() has error paths, but currently returns void, so
give it a return code and only print the output if it returns successfully.
Gcc isn't smart enough to be quiet though, so set frame to 0 to shut it up.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/iseries/vpdinfo.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

Index: to-merge/arch/powerpc/platforms/iseries/vpdinfo.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/vpdinfo.c
+++ to-merge/arch/powerpc/platforms/iseries/vpdinfo.c
@@ -205,15 +205,16 @@ static void __init iSeries_Parse_Vpd(u8 
 	}
 }
 
-static void __init iSeries_Get_Location_Code(u16 bus, HvAgentId agent,
+static int __init iSeries_Get_Location_Code(u16 bus, HvAgentId agent,
 		u8 *frame, char card[4])
 {
+	int status = 0;
 	int BusVpdLen = 0;
 	u8 *BusVpdPtr = kmalloc(BUS_VPDSIZE, GFP_KERNEL);
 
 	if (BusVpdPtr == NULL) {
 		printk("PCI: Bus VPD Buffer allocation failure.\n");
-		return;
+		return 0;
 	}
 	BusVpdLen = HvCallPci_getBusVpd(bus, iseries_hv_addr(BusVpdPtr),
 					BUS_VPDSIZE);
@@ -228,8 +229,10 @@ static void __init iSeries_Get_Location_
 		goto out_free;
 	}
 	iSeries_Parse_Vpd(BusVpdPtr, BusVpdLen, agent, frame, card);
+	status = 1;
 out_free:
 	kfree(BusVpdPtr);
+	return status;
 }
 
 /*
@@ -246,7 +249,7 @@ void __init iSeries_Device_Information(s
 	struct device_node *DevNode = PciDev->sysdata;
 	struct pci_dn *pdn;
 	u16 bus;
-	u8 frame;
+	u8 frame = 0;
 	char card[4];
 	HvSubBusNumber subbus;
 	HvAgentId agent;
@@ -262,10 +265,11 @@ void __init iSeries_Device_Information(s
 	subbus = pdn->bussubno;
 	agent = ISERIES_PCI_AGENTID(ISERIES_GET_DEVICE_FROM_SUBBUS(subbus),
 			ISERIES_GET_FUNCTION_FROM_SUBBUS(subbus));
-	iSeries_Get_Location_Code(bus, agent, &frame, card);
 
-	printk("%d. PCI: Bus%3d, Device%3d, Vendor %04X Frame%3d, Card %4s  ",
-			count, bus, PCI_SLOT(PciDev->devfn), PciDev->vendor,
-			frame, card);
-	printk("0x%04X\n", (int)(PciDev->class >> 8));
+	if (iSeries_Get_Location_Code(bus, agent, &frame, card)) {
+		printk("%d. PCI: Bus%3d, Device%3d, Vendor %04X Frame%3d, "
+			"Card %4s  0x%04X\n", count, bus,
+			PCI_SLOT(PciDev->devfn), PciDev->vendor, frame,
+			card, (int)(PciDev->class >> 8));
+	}
 }
