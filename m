Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 32EBADE1FF
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:56 +1100 (EST)
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 10504368002
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:56 +1100 (EST)
Date: Fri, 7 Dec 2007 01:50:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 06/19] [POWERPC] iSeries: remove some dead code from pci.c
Message-Id: <20071207015035.95099a6d.sfr@canb.auug.org.au>
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

and an unnecessary cast.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/pci.c |   19 +------------------
 1 files changed, 1 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 705f52c..cff832a 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -210,7 +210,7 @@ void __init iSeries_pci_final_fixup(void)
 			}
 
 			++num_dev;
-			pdev->sysdata = (void *)node;
+			pdev->sysdata = node;
 			PCI_DN(node)->pcidev = pdev;
 			allocate_device_bars(pdev);
 			iSeries_Device_Information(pdev, num_dev);
@@ -223,23 +223,6 @@ void __init iSeries_pci_final_fixup(void)
 	mf_display_src(0xC9000200);
 }
 
-#if 0
-/*
- * Returns the device node for the passed pci_dev
- * Sanity Check Node PciDev to passed pci_dev
- * If none is found, returns a NULL which the client must handle.
- */
-static struct device_node *get_device_node(struct pci_dev *pdev)
-{
-	struct device_node *node;
-
-	node = pdev->sysdata;
-	if (node == NULL || PCI_DN(node)->pcidev != pdev)
-		node = find_device_node(pdev->bus->number, pdev->devfn);
-	return node;
-}
-#endif
-
 /*
  * Config space read and write functions.
  * For now at least, we look for the device node for the bus and devfn
-- 
1.5.3.7


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
