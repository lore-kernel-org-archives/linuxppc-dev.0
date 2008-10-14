Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 14 Oct 2008 17:14:09 +1100
Subject: [PATCH] powerpc/chrp: Fix detection of Python PCI host bridge on IBM
	CHRPs
Message-Id: <20081014061446.5EAA8DDE31@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The detection of the IBM "Python" PCI host bridge on IBM CHRP
machines such as old RS6000 was broken when we changed
of_device_is_compatible() from strncasecmp to strcasecmp (dropped
the "n" variant) due to the way IBM encodes the chip version.

We fix that by instead doing a match on the model property like
we do for others bridges in that file. It should be good enough
for those machines. If yours is still broken, let me know.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/platforms/chrp/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/platforms/chrp/pci.c	2008-10-14 16:37:05.000000000 +1100
+++ linux-work/arch/powerpc/platforms/chrp/pci.c	2008-10-14 17:05:09.000000000 +1100
@@ -266,7 +266,7 @@ chrp_find_bridges(void)
 		model = of_get_property(dev, "model", NULL);
 		if (model == NULL)
 			model = "<none>";
-		if (of_device_is_compatible(dev, "IBM,python")) {
+		if (strncmp(model, "IBM, Python", 11) == 0) {
 			setup_python(hose, dev);
 		} else if (is_mot
 			   || strncmp(model, "Motorola, Grackle", 17) == 0) {
