Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx9.toshiba.co.jp (imx9.toshiba.co.jp [202.33.96.51])
	by ozlabs.org (Postfix) with ESMTP id 8910CDDD0D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 17:36:55 +1000 (EST)
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5 [202.33.96.24])
	by imx9.toshiba.co.jp  with ESMTP id l497asD8020954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 16:36:54 +0900 (JST)
Date: Wed, 09 May 2007 16:36:40 +0900 (JST)
Message-Id: <200705090736.l497akNR009559@toshiba.co.jp>
Subject: [PATCH 2/4] celleb: fix pci config space accesses to subordinary buses
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Checking whether bus->self is NULL is not enough to know "bus" is the
primary bus.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/scc_epci.c
diff -u linux-powerpc-git/arch/powerpc/platforms/celleb/scc_epci.c:1.1.1.3 linux-powerpc-git/arch/powerpc/platforms/celleb/scc_epci.c:1.22
--- linux-powerpc-git/arch/powerpc/platforms/celleb/scc_epci.c:1.1.1.3	Thu Mar 15 10:41:25 2007
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/scc_epci.c	Thu Mar 22 14:56:30 2007
@@ -133,13 +133,13 @@
 }
 
 static volatile void __iomem *celleb_epci_make_config_addr(
+					struct pci_bus *bus,
 					struct pci_controller *hose,
 					unsigned int devfn, int where)
 {
 	volatile void __iomem *addr;
-	struct pci_bus *bus = hose->bus;
 
-	if (bus->self)
+	if (bus != hose->bus)
 		addr = celleb_epci_get_epci_cfg(hose) +
 		       (((bus->number & 0xff) << 16)
 		        | ((devfn & 0xff) << 8)
@@ -193,7 +193,7 @@
 	} else {
 
 		clear_and_disable_master_abort_interrupt(hose);
-		addr = celleb_epci_make_config_addr(hose, devfn, where);
+		addr = celleb_epci_make_config_addr(bus, hose, devfn, where);
 
 		switch (size) {
 		case 1:
@@ -257,7 +257,7 @@
 	} else {
 
 		clear_and_disable_master_abort_interrupt(hose);
-		addr = celleb_epci_make_config_addr(hose, devfn, where);
+		addr = celleb_epci_make_config_addr(bus, hose, devfn, where);
 
 		switch (size) {
 		case 1:
