Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id DB2FFDDEC2
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 01:25:35 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/7] powerpc: use for_each in legacy_serial
Date: Mon,  7 Jan 2008 09:25:26 -0500
Message-Id: <11997159331132-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <11997159321859-git-send-email-paul.gortmaker@windriver.com>
References: <11997159321859-git-send-email-paul.gortmaker@windriver.com>
Message-Id: <ef7d84e06c45289f51f35845ccaa63bbf31827db.1199715362.git.paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use for_each to iterate over device tree nodes in legacy_serial.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/kernel/legacy_serial.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index b9cae6b..a17a5d0 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -307,7 +307,7 @@ void __init find_legacy_serial_ports(void)
 	}
 
 	/* First fill our array with SOC ports */
-	for (np = NULL; (np = of_find_compatible_node(np, "serial", "ns16550")) != NULL;) {
+	for_each_compatible_node(np, "serial", "ns16550") {
 		struct device_node *soc = of_get_parent(np);
 		if (soc && !strcmp(soc->type, "soc")) {
 			index = add_legacy_soc_port(np, np);
@@ -317,8 +317,8 @@ void __init find_legacy_serial_ports(void)
 		of_node_put(soc);
 	}
 
-	/* First fill our array with ISA ports */
-	for (np = NULL; (np = of_find_node_by_type(np, "serial"));) {
+	/* Next, fill our array with ISA ports */
+	for_each_node_by_type(np, "serial") {
 		struct device_node *isa = of_get_parent(np);
 		if (isa && !strcmp(isa->name, "isa")) {
 			index = add_legacy_isa_port(np, isa);
@@ -328,8 +328,8 @@ void __init find_legacy_serial_ports(void)
 		of_node_put(isa);
 	}
 
-	/* First fill our array with tsi-bridge ports */
-	for (np = NULL; (np = of_find_compatible_node(np, "serial", "ns16550")) != NULL;) {
+	/* Next, fill our array with tsi-bridge ports */
+	for_each_compatible_node(np, "serial", "ns16550") {
 		struct device_node *tsi = of_get_parent(np);
 		if (tsi && !strcmp(tsi->type, "tsi-bridge")) {
 			index = add_legacy_soc_port(np, np);
@@ -339,8 +339,8 @@ void __init find_legacy_serial_ports(void)
 		of_node_put(tsi);
 	}
 
-	/* First fill our array with opb bus ports */
-	for (np = NULL; (np = of_find_compatible_node(np, "serial", "ns16550")) != NULL;) {
+	/* Next, fill our array with opb bus ports */
+	for_each_compatible_node(np, "serial", "ns16550") {
 		struct device_node *opb = of_get_parent(np);
 		if (opb && (!strcmp(opb->type, "opb") ||
 			    of_device_is_compatible(opb, "ibm,opb"))) {
-- 
1.5.0.rc1.gf4b6c
