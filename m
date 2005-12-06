Return-Path: <rsushko@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C145068871
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Dec 2005 23:50:37 +1100 (EST)
From: "Ruslan V. Sushko" <rsushko@ru.mvista.com>
To: rollandd@cisco.com
Content-Type: multipart/mixed; boundary="=-WlvpCMguvkG5in9n9GuQ"
Date: Tue, 06 Dec 2005 15:50:32 +0300
Message-Id: <1133873432.16347.45.camel@mephisto.spb.rtsoft.ru>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH 4/5] ppc32: Fix the PCI bus numbering assignment for Yucca
	PCI initialization.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-WlvpCMguvkG5in9n9GuQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Fix the PCI bus numbering assignment. This will be an issue if more
than one PCI card will be inserted.

Signed-off-by: Ruslan V. Sushko <rsushko@ru.mvista.com>

--=-WlvpCMguvkG5in9n9GuQ
Content-Disposition: attachment; filename=yucca_pci_bus_num.patch
Content-Type: text/x-patch; name=yucca_pci_bus_num.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


Fix the PCI bus numbering assignment for PCI initialization for Yucca board.
This will be an issue if more than one PCI card is inserted.
---
commit 9bc85a59a27ae0559a59a852f3ce58a49368d3dd
tree cb2b3d77931e4bbc8e98f5ea776514c23e1b50ca
parent 4776902accd7c0721532168f73dc7618675bda1e
author Ruslan V. Sushko <rsushko@ru.mvista.com> Tue, 06 Dec 2005 13:14:17 +0300
committer Ruslan V. Sushko <rsushko@ru.mvista.com> Tue, 06 Dec 2005 13:14:17 +0300

 arch/ppc/platforms/4xx/yucca.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/platforms/4xx/yucca.c b/arch/ppc/platforms/4xx/yucca.c
--- a/arch/ppc/platforms/4xx/yucca.c
+++ b/arch/ppc/platforms/4xx/yucca.c
@@ -240,6 +240,7 @@ yucca_setup_hoses(void)
 {
 	struct pci_controller *hose;
 	char name[20];
+	int bus_no = 0;
 	int i;
 
 	for (i = 0; i <= 2; ++i) {
@@ -275,12 +276,14 @@ yucca_setup_hoses(void)
 				  IORESOURCE_MEM,
 				  name);
 
-		hose->first_busno = 0;
-		hose->last_busno  = 15;
+		hose->first_busno = bus_no;
+		hose->last_busno  = 0xFF;
 		hose_type[hose->index] = HOSE_PCIE0 + i;
 
 		ppc440spe_setup_pcie(hose, i);
 		hose->last_busno = pciauto_bus_scan(hose, hose->first_busno);
+		bus_no = hose->last_busno + 1;
+		printk(KERN_INFO "%s: resources allocated\n", name);
 	}
 
 	ppc_md.pci_swizzle = common_swizzle;



--=-WlvpCMguvkG5in9n9GuQ--
