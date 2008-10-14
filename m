Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 14 Oct 2008 17:49:47 +1100
Subject: [PATCH] powerpc: Fix CHRP PCI config access for indirect_pci
Message-Id: <20081014065031.6607DDDE41@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Recently, indirect_pci was changed to test if the bus number requested
is the one hanging straight off the PHB, then it substitutes the bus
number with another one contained in a new "self_busno" field of the
pci_controller structure.

However, this breaks CHRP which didn't initialize this new field, and
which relies on having the right bus number passed to the hardware.

This fixes it by initializing this variable properly for all CHRP bridges

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/platforms/chrp/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/platforms/chrp/pci.c	2008-10-14 17:35:12.000000000 +1100
+++ linux-work/arch/powerpc/platforms/chrp/pci.c	2008-10-14 17:35:18.000000000 +1100
@@ -263,7 +263,7 @@ chrp_find_bridges(void)
 				dev->full_name);
 			continue;
 		}
-		hose->first_busno = bus_range[0];
+		hose->first_busno = hose->self_busno = bus_range[0];
 		hose->last_busno = bus_range[1];
 
 		model = of_get_property(dev, "model", NULL);
