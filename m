Return-Path: <paul.gortmaker@windriver.com>
Received: from yow-pgortmak-d1.corp.ad.wrs.com (unknown [209.5.119.169])
	by ozlabs.org (Postfix) with ESMTP id 6D5BDDDE9E
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 09:40:46 +1100 (EST)
Date: Thu, 24 Jan 2008 17:40:44 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: reduce code duplication in legacy_serial, add
	UART parent types
Message-ID: <20080124224043.GA418@windriver.com>
References: <200801172335.48817.arnd@arndb.de>
	<12011947821738-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12011947821738-git-send-email-paul.gortmaker@windriver.com>
Cc: scottwood@freescale.com, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message: [PATCH] powerpc: reduce code duplication in legacy_serial, add UART parent types
on 24/01/2008 Paul Gortmaker wrote:

> @@ -31,6 +32,15 @@ static struct legacy_serial_info {
>  	int				irq_check_parent;
>  	phys_addr_t			taddr;
>  } legacy_serial_infos[MAX_LEGACY_SERIAL_PORTS];
> +
> +static struct __init of_device_id parents[] = {

Oops, that should have been __initdata to be 100% correct...

P.

---


From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Thu, 24 Jan 2008 11:59:12 -0500
Subject: [PATCH] powerpc: reduce code duplication in legacy_serial, add UART parent types

The legacy_serial was treating each UART parent in a separate code block.
Rather than continue this trend for the new parent IDs, this condenses
all (soc, tsi, opb, plus two more new types) into one of_device_id array.
The new types are wrs,epld-localbus for the Wind River sbc8560, and a
more generic "simple-bus" as requested by Scott Wood.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/kernel/legacy_serial.c |   45 +++++++++++++---------------------
 1 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 4bfff88..76b862b 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -4,6 +4,7 @@
 #include <linux/serial_core.h>
 #include <linux/console.h>
 #include <linux/pci.h>
+#include <linux/of_device.h>
 #include <asm/io.h>
 #include <asm/mmu.h>
 #include <asm/prom.h>
@@ -31,6 +32,15 @@ static struct legacy_serial_info {
 	int				irq_check_parent;
 	phys_addr_t			taddr;
 } legacy_serial_infos[MAX_LEGACY_SERIAL_PORTS];
+
+static struct __initdata of_device_id parents[] = {
+	{.type = "soc",},
+	{.type = "tsi-bridge",},
+	{.type = "opb", .compatible = "ibm,opb",},
+	{.compatible = "simple-bus",},
+	{.compatible = "wrs,epld-localbus",},
+};
+
 static unsigned int legacy_serial_count;
 static int legacy_serial_console = -1;
 
@@ -306,18 +316,20 @@ void __init find_legacy_serial_ports(void)
 		DBG(" no linux,stdout-path !\n");
 	}
 
-	/* First fill our array with SOC ports */
+	/* Iterate over all the 16550 ports, looking for known parents */
 	for_each_compatible_node(np, "serial", "ns16550") {
-		struct device_node *soc = of_get_parent(np);
-		if (soc && !strcmp(soc->type, "soc")) {
+		struct device_node *parent = of_get_parent(np);
+		if (!parent)
+			continue;
+		if (of_match_node(parents, parent) != NULL) {
 			index = add_legacy_soc_port(np, np);
 			if (index >= 0 && np == stdout)
 				legacy_serial_console = index;
 		}
-		of_node_put(soc);
+		of_node_put(parent);
 	}
 
-	/* First fill our array with ISA ports */
+	/* Next, fill our array with ISA ports */
 	for_each_node_by_type(np, "serial") {
 		struct device_node *isa = of_get_parent(np);
 		if (isa && !strcmp(isa->name, "isa")) {
@@ -328,29 +340,6 @@ void __init find_legacy_serial_ports(void)
 		of_node_put(isa);
 	}
 
-	/* First fill our array with tsi-bridge ports */
-	for_each_compatible_node(np, "serial", "ns16550") {
-		struct device_node *tsi = of_get_parent(np);
-		if (tsi && !strcmp(tsi->type, "tsi-bridge")) {
-			index = add_legacy_soc_port(np, np);
-			if (index >= 0 && np == stdout)
-				legacy_serial_console = index;
-		}
-		of_node_put(tsi);
-	}
-
-	/* First fill our array with opb bus ports */
-	for_each_compatible_node(np, "serial", "ns16550") {
-		struct device_node *opb = of_get_parent(np);
-		if (opb && (!strcmp(opb->type, "opb") ||
-			    of_device_is_compatible(opb, "ibm,opb"))) {
-			index = add_legacy_soc_port(np, np);
-			if (index >= 0 && np == stdout)
-				legacy_serial_console = index;
-		}
-		of_node_put(opb);
-	}
-
 #ifdef CONFIG_PCI
 	/* Next, try to locate PCI ports */
 	for (np = NULL; (np = of_find_all_nodes(np));) {
-- 
1.5.0.rc1.gf4b6c
