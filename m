Return-Path: <arnd@arndb.de>
Message-Id: <20061219143452.376366000@arndb.de>
References: <20061219143240.705255000@arndb.de>
Date: Tue, 19 Dec 2006 15:32:43 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 3/6] cell: Enable spider workarounds on all PCI buses
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jens Osterkamp <jens@de.ibm.com>
Don't limit spider I/O workarounds to the first two buses.
The IBM Cell blade has three of them (one PCI, two PCIe)
and we want to handle them all.

Signed-off-by: Jens Osterkamp <jens@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/io-workarounds.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/io-workarounds.c
+++ linux-2.6/arch/powerpc/platforms/cell/io-workarounds.c
@@ -37,7 +37,7 @@
  */
 #define SPIDER_DISABLE_PREFETCH
 
-#define MAX_SPIDERS	2
+#define MAX_SPIDERS	3
 
 static struct spider_pci_bus {
 	void __iomem	*regs;

--
