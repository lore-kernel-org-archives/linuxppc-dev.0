Return-Path: <gorcunov@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id D2291DDE10
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 06:43:58 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so2139706uge
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 11:43:58 -0800 (PST)
Date: Thu, 29 Nov 2007 22:44:36 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: PPCML <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/5] PPC cleanup: sysdev - do use for_each macro
Message-ID: <20071129194436.GB12123@cvg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Cyrill Gorcunov <gorcunov@gmail.com>

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---

 arch/powerpc/sysdev/fsl_soc.c      |    7 +++----
 arch/powerpc/sysdev/mv64x60_dev.c  |   24 ++++++++++--------------
 arch/powerpc/sysdev/mv64x60_pci.c  |    4 ++--
 arch/powerpc/sysdev/mv64x60_udbg.c |    4 ++--
 arch/powerpc/sysdev/tsi108_dev.c   |    9 ++++-----
 arch/powerpc/sysdev/uic.c          |   17 +++++------------
 6 files changed, 26 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 3ace747..927c238 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1125,13 +1125,12 @@ arch_initcall(fs_enet_of_init);
 
 static int __init fsl_pcmcia_of_init(void)
 {
-	struct device_node *np = NULL;
+	struct device_node *np;
 	/*
 	 * Register all the devices which type is "pcmcia"
 	 */
-	while ((np = of_find_compatible_node(np,
-			"pcmcia", "fsl,pq-pcmcia")) != NULL)
-			    of_platform_device_create(np, "m8xx-pcmcia", NULL);
+	for_each_compatible_node(np, "pcmcia", "fsl,pq-pcmcia")
+		of_platform_device_create(np, "m8xx-pcmcia", NULL);
 	return 0;
 }
 
diff --git a/arch/powerpc/sysdev/mv64x60_dev.c b/arch/powerpc/sysdev/mv64x60_dev.c
index 548a320..304056c 100644
--- a/arch/powerpc/sysdev/mv64x60_dev.c
+++ b/arch/powerpc/sysdev/mv64x60_dev.c
@@ -241,7 +241,7 @@ static int __init mv64x60_eth_device_setup(struct device_node *np, int id)
 
 	/* only register the shared platform device the first time through */
 	if (id == 0 && (err = eth_register_shared_pdev(np)))
-		return err;;
+		return err;
 
 	memset(r, 0, sizeof(r));
 	of_irq_to_resource(np, 0, &r[0]);
@@ -451,22 +451,19 @@ static int __init mv64x60_device_setup(void)
 	int id;
 	int err;
 
-	for (id = 0;
-	     (np = of_find_compatible_node(np, "serial", "marvell,mpsc")); id++)
-		if ((err = mv64x60_mpsc_device_setup(np, id)))
+	id = 0;
+	for_each_compatible_node(np, "serial", "marvell,mpsc")
+		if ((err = mv64x60_mpsc_device_setup(np, id++)))
 			goto error;
 
-	for (id = 0;
-	     (np = of_find_compatible_node(np, "network",
-					   "marvell,mv64x60-eth"));
-	     id++)
-		if ((err = mv64x60_eth_device_setup(np, id)))
+	id = 0;
+	for_each_compatible_node(np, "network", "marvell,mv64x60-eth")
+		if ((err = mv64x60_eth_device_setup(np, id++)))
 			goto error;
 
-	for (id = 0;
-	     (np = of_find_compatible_node(np, "i2c", "marvell,mv64x60-i2c"));
-	     id++)
-		if ((err = mv64x60_i2c_device_setup(np, id)))
+	id = 0;
+	for_each_compatible_node(np, "i2c", "marvell,mv64x60-i2c")
+		if ((err = mv64x60_i2c_device_setup(np, id++)))
 			goto error;
 
 	/* support up to one watchdog timer */
@@ -477,7 +474,6 @@ static int __init mv64x60_device_setup(void)
 		of_node_put(np);
 	}
 
-
 	return 0;
 
 error:
diff --git a/arch/powerpc/sysdev/mv64x60_pci.c b/arch/powerpc/sysdev/mv64x60_pci.c
index 6933f9c..d21ab8f 100644
--- a/arch/powerpc/sysdev/mv64x60_pci.c
+++ b/arch/powerpc/sysdev/mv64x60_pci.c
@@ -164,8 +164,8 @@ static int __init mv64x60_add_bridge(struct device_node *dev)
 
 void __init mv64x60_pci_init(void)
 {
-	struct device_node *np = NULL;
+	struct device_node *np;
 
-	while ((np = of_find_compatible_node(np, "pci", "marvell,mv64x60-pci")))
+	for_each_compatible_node(np, "pci", "marvell,mv64x60-pci")
 		mv64x60_add_bridge(np);
 }
diff --git a/arch/powerpc/sysdev/mv64x60_udbg.c b/arch/powerpc/sysdev/mv64x60_udbg.c
index 367e7b1..35c77c7 100644
--- a/arch/powerpc/sysdev/mv64x60_udbg.c
+++ b/arch/powerpc/sysdev/mv64x60_udbg.c
@@ -85,10 +85,10 @@ static void mv64x60_udbg_init(void)
 	if (!stdout)
 		return;
 
-	for (np = NULL;
-	     (np = of_find_compatible_node(np, "serial", "marvell,mpsc")); )
+	for_each_compatible_node(np, "serial", "marvell,mpsc") {
 		if (np == stdout)
 			break;
+	}
 
 	of_node_put(stdout);
 	if (!np)
diff --git a/arch/powerpc/sysdev/tsi108_dev.c b/arch/powerpc/sysdev/tsi108_dev.c
index a113d80..be2808a 100644
--- a/arch/powerpc/sysdev/tsi108_dev.c
+++ b/arch/powerpc/sysdev/tsi108_dev.c
@@ -66,14 +66,12 @@ EXPORT_SYMBOL(get_vir_csrbase);
 static int __init tsi108_eth_of_init(void)
 {
 	struct device_node *np;
-	unsigned int i;
+	unsigned int i = 0;
 	struct platform_device *tsi_eth_dev;
 	struct resource res;
 	int ret;
 
-	for (np = NULL, i = 0;
-	     (np = of_find_compatible_node(np, "network", "tsi108-ethernet")) != NULL;
-	     i++) {
+	for_each_compatible_node(np, "network", "tsi108-ethernet") {
 		struct resource r[2];
 		struct device_node *phy, *mdio;
 		hw_info tsi_eth_data;
@@ -98,7 +96,7 @@ static int __init tsi108_eth_of_init(void)
 			__FUNCTION__,r[1].name, r[1].start, r[1].end);
 
 		tsi_eth_dev =
-		    platform_device_register_simple("tsi-ethernet", i, &r[0],
+		    platform_device_register_simple("tsi-ethernet", i++, &r[0],
 						    1);
 
 		if (IS_ERR(tsi_eth_dev)) {
@@ -154,6 +152,7 @@ static int __init tsi108_eth_of_init(void)
 unreg:
 	platform_device_unregister(tsi_eth_dev);
 err:
+	of_node_put(np);
 	return ret;
 }
 
diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index 5149716..815d6db 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -326,28 +326,23 @@ void __init uic_init_tree(void)
 	const u32 *interrupts;
 
 	/* First locate and initialize the top-level UIC */
-
-	np = of_find_compatible_node(NULL, NULL, "ibm,uic");
-	while (np) {
+	for_each_compatible_node(np, NULL, "ibm,uic") {
 		interrupts = of_get_property(np, "interrupts", NULL);
-		if (! interrupts)
+		if (!interrupts)
 			break;
-
-		np = of_find_compatible_node(np, NULL, "ibm,uic");
 	}
 
 	BUG_ON(!np); /* uic_init_tree() assumes there's a UIC as the
 		      * top-level interrupt controller */
 	primary_uic = uic_init_one(np);
-	if (! primary_uic)
+	if (!primary_uic)
 		panic("Unable to initialize primary UIC %s\n", np->full_name);
 
 	irq_set_default_host(primary_uic->irqhost);
 	of_node_put(np);
 
 	/* The scan again for cascaded UICs */
-	np = of_find_compatible_node(NULL, NULL, "ibm,uic");
-	while (np) {
+	for_each_compatible_node(np, NULL, "ibm,uic") {
 		interrupts = of_get_property(np, "interrupts", NULL);
 		if (interrupts) {
 			/* Secondary UIC */
@@ -355,7 +350,7 @@ void __init uic_init_tree(void)
 			int ret;
 
 			uic = uic_init_one(np);
-			if (! uic)
+			if (!uic)
 				panic("Unable to initialize a secondary UIC %s\n",
 				      np->full_name);
 
@@ -373,8 +368,6 @@ void __init uic_init_tree(void)
 
 			/* FIXME: setup critical cascade?? */
 		}
-
-		np = of_find_compatible_node(np, NULL, "ibm,uic");
 	}
 }
 
-- 
1.5.3.5
