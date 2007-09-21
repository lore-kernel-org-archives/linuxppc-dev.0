Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id F00D4DDE2B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 18:08:25 +1000 (EST)
Date: Fri, 21 Sep 2007 18:08:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Prepare to remove of_platform_driver name
Message-Id: <20070921180817.03418ee4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The name field of of_platform_driver is just copied into the
included device_driver.  By not overriding an already initialised
device_driver name, we can convert the drivers over time to stop using
the of_platform_driver name.

Also we were not copying the owner field from of_platform_driver, so do
the same with it.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/of_platform.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index f70e787..eca8ccc 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -19,11 +19,11 @@
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
 
 #include <asm/errno.h>
 #include <asm/dcr.h>
-#include <asm/of_device.h>
-#include <asm/of_platform.h>
 #include <asm/topology.h>
 #include <asm/pci-bridge.h>
 #include <asm/ppc-pci.h>
@@ -70,7 +70,10 @@ postcore_initcall(of_bus_driver_init);
 int of_register_platform_driver(struct of_platform_driver *drv)
 {
 	/* initialize common driver fields */
-	drv->driver.name = drv->name;
+	if (!drv->driver.name)
+		drv->driver.name = drv->name;
+	if (!drv->driver.owner)
+		drv->driver.owner = drv->owner;
 	drv->driver.bus = &of_platform_bus_type;
 
 	/* register with core */
@@ -385,9 +388,11 @@ static struct of_device_id of_pci_phb_ids[] = {
 };
 
 static struct of_platform_driver of_pci_phb_driver = {
-       .name = "of-pci",
-       .match_table = of_pci_phb_ids,
-       .probe = of_pci_phb_probe,
+	.match_table = of_pci_phb_ids,
+	.probe = of_pci_phb_probe,
+	.driver = {
+		.name = "of-pci",
+	},
 };
 
 static __init int of_pci_phb_init(void)
-- 
1.5.3.2
