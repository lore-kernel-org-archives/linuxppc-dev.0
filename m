Return-Path: <dmitry.torokhov@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCmQq5g8nzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 12:54:43 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id 194so32583246pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 17:54:43 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 Kumar Gala <galak@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc: make use of for_each_node_by_name() instead of
 open-coding it
Date: Tue, 31 Jan 2017 17:54:37 -0800
Message-Id: <20170201015438.18826-1-dmitry.torokhov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of manually coding the loop with of_find_node_by_name(), let's
switch to the standard macro for iterating over nodes with given name.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/powerpc/platforms/83xx/mpc832x_mds.c | 2 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c | 2 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c | 2 +-
 arch/powerpc/platforms/cell/interrupt.c   | 3 +--
 arch/powerpc/platforms/cell/setup.c       | 3 +--
 arch/powerpc/platforms/cell/spider-pic.c  | 3 +--
 arch/powerpc/platforms/powermac/feature.c | 2 +-
 7 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index bb7b25acf26f..1e92f806ee60 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -75,7 +75,7 @@ static void __init mpc832x_sys_setup_arch(void)
 		par_io_init(np);
 		of_node_put(np);
 
-		for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
+		for_each_node_by_name(np. "ucc")
 			par_io_of_config(np);
 	}
 
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index d7c9b186954d..3dcbe06cf36c 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -204,7 +204,7 @@ static void __init mpc832x_rdb_setup_arch(void)
 		par_io_init(np);
 		of_node_put(np);
 
-		for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
+		for_each_node_by_name(np, "ucc")
 			par_io_of_config(np);
 	}
 #endif				/* CONFIG_QUICC_ENGINE */
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 4fc3051c2b2e..fd44dd03e1f3 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -83,7 +83,7 @@ static void __init mpc836x_mds_setup_arch(void)
 		par_io_init(np);
 		of_node_put(np);
 
-		for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
+		for_each_node_by_name(np, "ucc")
 			par_io_of_config(np);
 #ifdef CONFIG_QE_USB
 		/* Must fixup Par IO before QE GPIO chips are registered. */
diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index a6bbbaba14a3..477a1fdd3ee1 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -315,8 +315,7 @@ static int __init setup_iic(void)
 	struct cbe_iic_regs __iomem *node_iic;
 	const u32 *np;
 
-	for (dn = NULL;
-	     (dn = of_find_node_by_name(dn,"interrupt-controller")) != NULL;) {
+	for_each_node_by_name(dn, "interrupt-controller") {
 		if (!of_device_is_compatible(dn,
 				     "IBM,CBEA-Internal-Interrupt-Controller"))
 			continue;
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index d3543e68efe8..7d31b8d14661 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -192,8 +192,7 @@ static void __init mpic_init_IRQ(void)
 	struct device_node *dn;
 	struct mpic *mpic;
 
-	for (dn = NULL;
-	     (dn = of_find_node_by_name(dn, "interrupt-controller"));) {
+	for_each_node_by_name(dn, "interrupt-controller") {
 		if (!of_device_is_compatible(dn, "CBEA,platform-open-pic"))
 			continue;
 
diff --git a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/platforms/cell/spider-pic.c
index ff924af00e78..a0454b031e6f 100644
--- a/arch/powerpc/platforms/cell/spider-pic.c
+++ b/arch/powerpc/platforms/cell/spider-pic.c
@@ -343,8 +343,7 @@ void __init spider_init_IRQ(void)
 	 * device-tree is bogus anyway) so all we can do is pray or maybe test
 	 * the address and deduce the node-id
 	 */
-	for (dn = NULL;
-	     (dn = of_find_node_by_name(dn, "interrupt-controller"));) {
+	for_each_node_by_name(dn, "interrupt-controller") {
 		if (of_device_is_compatible(dn, "CBEA,platform-spider-pic")) {
 			if (of_address_to_resource(dn, 0, &r)) {
 				printk(KERN_WARNING "spider-pic: Failed\n");
diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 730e48111848..86ce02f15593 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -2641,7 +2641,7 @@ static void __init probe_one_macio(const char *name, const char *compat, int typ
 	phys_addr_t		addr;
 	u64			size;
 
-	for (node = NULL; (node = of_find_node_by_name(node, name)) != NULL;) {
+	for_each_node_by_name(node, name) {
 		if (!compat)
 			break;
 		if (of_device_is_compatible(node, compat))
-- 
2.11.0.483.g087da7b7c-goog
