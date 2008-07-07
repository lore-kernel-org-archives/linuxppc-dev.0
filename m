Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id BD125DEB0F
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 02:25:14 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] legacy-serial: more meaningful names, terminate array
Date: Mon,  7 Jul 2008 11:05:20 -0400
Message-Id: <1215443120-22004-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1215412426.8970.97.camel@pasglop>
References: <1215412426.8970.97.camel@pasglop>
Cc: scottwood@freescale.com, arnd@arndb.de,
	Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Terminate the array of possible legacy serial parents, and
choose more meaningful names for better autopsy value. Fix
and cleanups as suggested by Benjamin Herrenschmidt.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/kernel/ibmebus.c       |    4 ++--
 arch/powerpc/kernel/legacy_serial.c |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index 9971159..58da8f8 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -53,7 +53,7 @@ static struct device ibmebus_bus_device = { /* fake "parent" device */
 struct bus_type ibmebus_bus_type;
 
 /* These devices will automatically be added to the bus during init */
-static struct of_device_id __initdata builtin_matches[] = {
+static struct of_device_id __initdata ibmebus_matches[] = {
 	{ .compatible = "IBM,lhca" },
 	{ .compatible = "IBM,lhea" },
 	{},
@@ -350,7 +350,7 @@ static int __init ibmebus_bus_init(void)
 		return err;
 	}
 
-	err = ibmebus_create_devices(builtin_matches);
+	err = ibmebus_create_devices(ibmebus_matches);
 	if (err) {
 		device_unregister(&ibmebus_bus_device);
 		bus_unregister(&ibmebus_bus_type);
diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 61dd174..4b01c2b 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -33,13 +33,14 @@ static struct legacy_serial_info {
 	phys_addr_t			taddr;
 } legacy_serial_infos[MAX_LEGACY_SERIAL_PORTS];
 
-static struct __initdata of_device_id parents[] = {
+static struct __initdata of_device_id uart_match[] = {
 	{.type = "soc",},
 	{.type = "tsi-bridge",},
 	{.type = "opb", },
 	{.compatible = "ibm,opb",},
 	{.compatible = "simple-bus",},
 	{.compatible = "wrs,epld-localbus",},
+	{},
 };
 
 static unsigned int legacy_serial_count;
@@ -322,7 +323,7 @@ void __init find_legacy_serial_ports(void)
 		struct device_node *parent = of_get_parent(np);
 		if (!parent)
 			continue;
-		if (of_match_node(parents, parent) != NULL) {
+		if (of_match_node(uart_match, parent) != NULL) {
 			index = add_legacy_soc_port(np, np);
 			if (index >= 0 && np == stdout)
 				legacy_serial_console = index;
-- 
1.5.6.6.gd3e97
