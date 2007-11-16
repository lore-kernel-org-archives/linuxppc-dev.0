Return-Path: <benh@ozlabs.org>
To: auke-jan.h.kok@intel.com
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 16 Nov 2007 18:37:38 +1100
Subject: [PATCH] e1000: Fix for 32 bits platforms with 64 bits resources
Message-Id: <20071116073821.548CCDDDF4@ozlabs.org>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The e1000 driver stores the content of the PCI resources into
unsigned long's before ioremapping. This breaks on 32 bits
platforms that support 64 bits MMIO resources such as ppc 44x.

This fixes it by removing those temporary variables and passing
directly the result of pci_resource_start/len to ioremap.

The side effect is that I removed the assignments to the netdev
fields mem_start, mem_end and base_addr, which are totally useless
for PCI devices.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
--

 drivers/net/e1000/e1000_main.c |   18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

Index: linux-work/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-work.orig/drivers/net/e1000/e1000_main.c	2007-11-16 17:14:32.000000000 +1100
+++ linux-work/drivers/net/e1000/e1000_main.c	2007-11-16 18:32:07.000000000 +1100
@@ -861,8 +861,6 @@ e1000_probe(struct pci_dev *pdev,
 {
 	struct net_device *netdev;
 	struct e1000_adapter *adapter;
-	unsigned long mmio_start, mmio_len;
-	unsigned long flash_start, flash_len;
 
 	static int cards_found = 0;
 	static int global_quad_port_a = 0; /* global ksp3 port a indication */
@@ -905,11 +903,9 @@ e1000_probe(struct pci_dev *pdev,
 	adapter->hw.back = adapter;
 	adapter->msg_enable = (1 << debug) - 1;
 
-	mmio_start = pci_resource_start(pdev, BAR_0);
-	mmio_len = pci_resource_len(pdev, BAR_0);
-
 	err = -EIO;
-	adapter->hw.hw_addr = ioremap(mmio_start, mmio_len);
+	adapter->hw.hw_addr = ioremap(pci_resource_start(pdev, BAR_0),
+				      pci_resource_len(pdev, BAR_0));
 	if (!adapter->hw.hw_addr)
 		goto err_ioremap;
 
@@ -944,10 +940,6 @@ e1000_probe(struct pci_dev *pdev,
 #endif
 	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
 
-	netdev->mem_start = mmio_start;
-	netdev->mem_end = mmio_start + mmio_len;
-	netdev->base_addr = adapter->hw.io_base;
-
 	adapter->bd_number = cards_found;
 
 	/* setup the private structure */
@@ -960,9 +952,9 @@ e1000_probe(struct pci_dev *pdev,
 	 * because it depends on mac_type */
 	if ((adapter->hw.mac_type == e1000_ich8lan) &&
 	   (pci_resource_flags(pdev, 1) & IORESOURCE_MEM)) {
-		flash_start = pci_resource_start(pdev, 1);
-		flash_len = pci_resource_len(pdev, 1);
-		adapter->hw.flash_address = ioremap(flash_start, flash_len);
+		adapter->hw.flash_address =
+			ioremap(pci_resource_start(pdev, 1),
+				pci_resource_len(pdev, 1));
 		if (!adapter->hw.flash_address)
 			goto err_flashmap;
 	}
