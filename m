Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 10 Nov 2006 18:44:59 +1100
Subject: [PATCH 18/32] powerpc: Resolve the parent address of a PCI bus range
In-Reply-To: <1163144683.554182.685908332811.qpush@grosgo>
Message-Id: <20061110074502.A88E567ED2@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When parsing the OF "ranges" properties of PCI host busses to determine
the mapping of a PCI bus, we need to translate the "parent" address using
the prom_parse.c routines in order to obtain a CPU physical address.

This wasn't necessary while PCI busses were always at the root of the
device-tree but this is no longer the case on Cell where they can be
anywhere in the tree.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/kernel/pci_64.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: linux-cell/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/pci_64.c	2006-11-10 16:26:34.000000000 +1100
+++ linux-cell/arch/powerpc/kernel/pci_64.c	2006-11-10 16:40:42.000000000 +1100
@@ -975,11 +975,7 @@ void __devinit pci_process_bridge_OF_ran
 		res = NULL;
 		pci_space = ranges[0];
 		pci_addr = ((unsigned long)ranges[1] << 32) | ranges[2];
-
-		cpu_phys_addr = ranges[3];
-		if (na >= 2)
-			cpu_phys_addr = (cpu_phys_addr << 32) | ranges[4];
-
+		cpu_phys_addr = of_translate_address(dev, &ranges[3]);
 		size = ((unsigned long)ranges[na+3] << 32) | ranges[na+4];
 		ranges += np;
 		if (size == 0)
