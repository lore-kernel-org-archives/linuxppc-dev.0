Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 19/20] [powerpc,tsi108] Constify & voidify get_property()
Message-ID: 1151993427.2210.20@pokey
Date: Tue,  4 Jul 2006 16:47:56 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that get_property() returns a void *, there's no need to cast its
return value. Also, treat the return value as const, so we can
constify get_property later.

tsi108 driver changes.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 tsi108_pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/powerpc/sysdev/tsi108_pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/tsi108_pci.c
+++ linux-2.6/arch/powerpc/sysdev/tsi108_pci.c
@@ -195,7 +195,7 @@ int __init tsi108_setup_pci(struct devic
 	int len;
 	struct pci_controller *hose;
 	struct resource rsrc;
-	int *bus_range;
+	const int *bus_range;
 	int primary = 0, has_address = 0;
 
 	/* PCI Config mapping */
@@ -208,7 +208,7 @@ int __init tsi108_setup_pci(struct devic
 	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
 
 	/* Get bus range if any */
-	bus_range = (int *)get_property(dev, "bus-range", &len);
+	bus_range = get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
 		       " bus 0\n", dev->full_name);
