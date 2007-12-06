Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BE839DE042
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:58 +1100 (EST)
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 93AAB368006
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:58 +1100 (EST)
Date: Fri, 7 Dec 2007 01:54:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 10/19] [POWERPC] iSeries: remove pci_dn dependency from
	iSeries_Device_Information
Message-Id: <20071207015457.df19d2b8.sfr@canb.auug.org.au>
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
 arch/powerpc/platforms/iseries/pci.c     |    3 ++-
 arch/powerpc/platforms/iseries/pci.h     |    3 ++-
 arch/powerpc/platforms/iseries/vpdinfo.c |   17 ++---------------
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 8844d3e..3cf51c6 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -218,7 +218,8 @@ void __init iSeries_pci_final_fixup(void)
 		pdev->sysdata = node;
 		PCI_DN(node)->pcidev = pdev;
 		allocate_device_bars(pdev);
-		iSeries_Device_Information(pdev, num_dev);
+		iSeries_Device_Information(pdev, num_dev, pdn->busno,
+				pdn->bussubno);
 		iommu_devnode_init_iSeries(pdev, node);
 	}
 	iSeries_activate_IRQs();
diff --git a/arch/powerpc/platforms/iseries/pci.h b/arch/powerpc/platforms/iseries/pci.h
index 730986b..3cb18fa 100644
--- a/arch/powerpc/platforms/iseries/pci.h
+++ b/arch/powerpc/platforms/iseries/pci.h
@@ -58,7 +58,8 @@ static inline u64 iseries_ds_addr(struct device_node *node)
 			+ ((u64)0x10 << 32);
 }
 
-extern void	iSeries_Device_Information(struct pci_dev*, int);
+extern void	iSeries_Device_Information(struct pci_dev *PciDev, int count,
+			u16 bus, HvSubBusNumber subbus);
 #ifdef CONFIG_PCI
 extern void	iSeries_pci_final_fixup(void);
 #else
diff --git a/arch/powerpc/platforms/iseries/vpdinfo.c b/arch/powerpc/platforms/iseries/vpdinfo.c
index 9f83878..25dc0bb 100644
--- a/arch/powerpc/platforms/iseries/vpdinfo.c
+++ b/arch/powerpc/platforms/iseries/vpdinfo.c
@@ -31,7 +31,6 @@
 #include <asm/types.h>
 #include <asm/resource.h>
 #include <asm/abs_addr.h>
-#include <asm/pci-bridge.h>
 #include <asm/iseries/hv_types.h>
 
 #include "pci.h"
@@ -244,25 +243,13 @@ out_free:
  * PCI: Bus  0, Device 26, Vendor 0x12AE  Frame  1, Card  C10  Ethernet
  * controller
  */
-void __init iSeries_Device_Information(struct pci_dev *PciDev, int count)
+void __init iSeries_Device_Information(struct pci_dev *PciDev, int count,
+		u16 bus, HvSubBusNumber subbus)
 {
-	struct device_node *DevNode = PciDev->sysdata;
-	struct pci_dn *pdn;
-	u16 bus;
 	u8 frame = 0;
 	char card[4];
-	HvSubBusNumber subbus;
 	HvAgentId agent;
 
-	if (DevNode == NULL) {
-		printk("%d. PCI: iSeries_Device_Information DevNode is NULL\n",
-				count);
-		return;
-	}
-
-	pdn = PCI_DN(DevNode);
-	bus = pdn->busno;
-	subbus = pdn->bussubno;
 	agent = ISERIES_PCI_AGENTID(ISERIES_GET_DEVICE_FROM_SUBBUS(subbus),
 			ISERIES_GET_FUNCTION_FROM_SUBBUS(subbus));
 
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
