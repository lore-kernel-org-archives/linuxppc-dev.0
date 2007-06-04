Return-Path: <arnd@arndb.de>
Message-Id: <20070604181739.375615838@arndb.de>
References: <20070604181438.569356702@arndb.de>
Date: Mon, 04 Jun 2007 20:14:39 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [patch 1/3] powerpc: fix pci_setup_phb_io_dynamic for pci_iomap
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
We had a problem on a system with only dynamically allocated
PCI buses (using of_pci_phb_driver) in combination with libata.
This setup ended up having no "primary" phb, which means
that pci_io_base never got initialized and all IO port
numbers are 64 bit numbers, which is larger than the
PIO_MASK limit.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
Index: linux-2.6/arch/powerpc/kernel/of_platform.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/of_platform.c
+++ linux-2.6/arch/powerpc/kernel/of_platform.c
@@ -433,7 +433,7 @@ static int __devinit of_pci_phb_probe(st
 	 * Note also that we don't do ISA, this will also be fixed with a
 	 * more massive rework.
 	 */
-	pci_setup_phb_io(phb, 0);
+	pci_setup_phb_io(phb, pci_io_base == 0);
 
 	/* Init pci_dn data structures */
 	pci_devs_phb_init_dynamic(phb);

--
