Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id CCF15DDE20
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 05:32:29 +1100 (EST)
Received: from pd4mr1so.prod.shaw.ca
	(pd4mr1so-qfe3.prod.shaw.ca [10.0.141.212]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JUA00KLJE5IF6D0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 07 Jan 2008 11:32:06 -0700 (MST)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
	by pd4mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JUA008B8E5G3BA0@pd4mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 07 Jan 2008 11:32:06 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0JUA0006OE5C8Y80@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 07 Jan 2008 11:32:03 -0700 (MST)
Date: Mon, 07 Jan 2008 11:27:24 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] mpc5200: eliminate mpc52xx_*_map_*() functions.
To: linuxppc-dev@ozlabs.org
Message-id: <20080107182636.12429.12714.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

mpc5200 platform code defines a bunch of map functions which duplicate the
functionality of of_iomap().  Remove them and use of_iomap() instead.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

If there are no objections to this one, I'll be putting it in my 5200 tree
and asking Paulus to pull it in the next day or so

Cheers,
g.

 arch/powerpc/platforms/52xx/lite5200.c       |   10 ++++-
 arch/powerpc/platforms/52xx/lite5200_pm.c    |    6 +++
 arch/powerpc/platforms/52xx/mpc52xx_common.c |   51 +++++---------------------
 arch/powerpc/platforms/52xx/mpc52xx_pic.c    |    8 +++-
 arch/powerpc/platforms/52xx/mpc52xx_pm.c     |    8 +++-
 drivers/spi/mpc52xx_psc_spi.c                |    9 ++++-
 include/asm-powerpc/mpc52xx.h                |    2 -
 7 files changed, 40 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index ce903be..5a8d190 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -42,10 +42,13 @@
 static void __init
 lite5200_fix_clock_config(void)
 {
+	struct device_node *np;
 	struct mpc52xx_cdm  __iomem *cdm;
 
 	/* Map zones */
-	cdm = mpc52xx_find_and_map("mpc5200-cdm");
+	np = of_find_compatible_node(NULL, NULL, "mpc5200-cdm");
+	cdm = of_iomap(np, 0);
+	of_node_put(np);
 	if (!cdm) {
 		printk(KERN_ERR "%s() failed; expect abnormal behaviour\n",
 		       __FUNCTION__);
@@ -74,10 +77,13 @@ lite5200_fix_clock_config(void)
 static void __init
 lite5200_fix_port_config(void)
 {
+	struct device_node *np;
 	struct mpc52xx_gpio __iomem *gpio;
 	u32 port_config;
 
-	gpio = mpc52xx_find_and_map("mpc5200-gpio");
+	np = of_find_compatible_node(NULL, NULL, "mpc5200-gpio");
+	gpio = of_iomap(np, 0);
+	of_node_put(np);
 	if (!gpio) {
 		printk(KERN_ERR "%s() failed. expect abnormal behavior\n",
 		       __FUNCTION__);
diff --git a/arch/powerpc/platforms/52xx/lite5200_pm.c b/arch/powerpc/platforms/52xx/lite5200_pm.c
index ffa14af..c3ada1e 100644
--- a/arch/powerpc/platforms/52xx/lite5200_pm.c
+++ b/arch/powerpc/platforms/52xx/lite5200_pm.c
@@ -42,6 +42,8 @@ static int lite5200_pm_set_target(suspend_state_t state)
 
 static int lite5200_pm_prepare(void)
 {
+	struct device_node *np;
+
 	/* deep sleep? let mpc52xx code handle that */
 	if (lite5200_pm_target_state == PM_SUSPEND_STANDBY)
 		return mpc52xx_pm_prepare();
@@ -50,7 +52,9 @@ static int lite5200_pm_prepare(void)
 		return -EINVAL;
 
 	/* map registers */
-	mbar = mpc52xx_find_and_map("mpc5200");
+	np = of_find_compatible_node(NULL, NULL, "mpc5200");
+	mbar = of_iomap(np, 0);
+	of_node_put(np);
 	if (!mbar) {
 		printk(KERN_ERR "%s:%i Error mapping registers\n", __func__, __LINE__);
 		return -ENOSYS;
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 9bdbee4..90a4cec 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -26,45 +26,6 @@
  */
 static volatile struct mpc52xx_gpt *mpc52xx_wdt = NULL;
 
-static void __iomem *
-mpc52xx_map_node(struct device_node *ofn)
-{
-	const u32 *regaddr_p;
-	u64 regaddr64, size64;
-
-	if (!ofn)
-		return NULL;
-
-	regaddr_p = of_get_address(ofn, 0, &size64, NULL);
-	if (!regaddr_p) {
-		of_node_put(ofn);
-		return NULL;
-	}
-
-	regaddr64 = of_translate_address(ofn, regaddr_p);
-
-	of_node_put(ofn);
-
-	return ioremap((u32)regaddr64, (u32)size64);
-}
-
-void __iomem *
-mpc52xx_find_and_map(const char *compatible)
-{
-	return mpc52xx_map_node(
-		of_find_compatible_node(NULL, NULL, compatible));
-}
-
-EXPORT_SYMBOL(mpc52xx_find_and_map);
-
-void __iomem *
-mpc52xx_find_and_map_path(const char *path)
-{
-	return mpc52xx_map_node(of_find_node_by_path(path));
-}
-
-EXPORT_SYMBOL(mpc52xx_find_and_map_path);
-
 /**
  * 	mpc52xx_find_ipb_freq - Find the IPB bus frequency for a device
  * 	@node:	device node
@@ -101,9 +62,12 @@ EXPORT_SYMBOL(mpc52xx_find_ipb_freq);
 void __init
 mpc5200_setup_xlb_arbiter(void)
 {
+	struct device_node *np;
 	struct mpc52xx_xlb  __iomem *xlb;
 
-	xlb = mpc52xx_find_and_map("mpc5200-xlb");
+	np = of_find_compatible_node(NULL, NULL, "mpc5200-xlb");
+	xlb = of_iomap(np, 0);
+	of_node_put(np);
 	if (!xlb) {
 		printk(KERN_ERR __FILE__ ": "
 			"Error mapping XLB in mpc52xx_setup_cpu().  "
@@ -156,16 +120,19 @@ mpc52xx_map_wdt(void)
 	for_each_compatible_node(np, NULL, "fsl,mpc5200-gpt") {
 		has_wdt = of_get_property(np, "fsl,has-wdt", NULL);
 		if (has_wdt) {
-			mpc52xx_wdt = mpc52xx_map_node(np);
+			mpc52xx_wdt = of_iomap(np, 0);
+			of_node_put(np);
 			return;
 		}
 	}
 	for_each_compatible_node(np, NULL, "mpc5200-gpt") {
 		has_wdt = of_get_property(np, "has-wdt", NULL);
 		if (has_wdt) {
-			mpc52xx_wdt = mpc52xx_map_node(np);
+			mpc52xx_wdt = of_iomap(np, 0);
+			of_node_put(np);
 			return;
 		}
+
 	}
 }
 
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 61100f2..07e8987 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -364,16 +364,18 @@ void __init mpc52xx_init_irq(void)
 {
 	u32 intr_ctrl;
 	struct device_node *picnode;
+	struct device_node *np;
 
 	/* Remap the necessary zones */
 	picnode = of_find_compatible_node(NULL, NULL, "mpc5200-pic");
-
-	intr = mpc52xx_find_and_map("mpc5200-pic");
+	intr = of_iomap(picnode, 0);
 	if (!intr)
 		panic(__FILE__	": find_and_map failed on 'mpc5200-pic'. "
 				"Check node !");
 
-	sdma = mpc52xx_find_and_map("mpc5200-bestcomm");
+	np = of_find_compatible_node(NULL, NULL, "mpc5200-bestcomm");
+	sdma = of_iomap(np, 0);
+	of_node_put(np);
 	if (!sdma)
 		panic(__FILE__	": find_and_map failed on 'mpc5200-bestcomm'. "
 				"Check node !");
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pm.c b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
index 7ffa7ba..52f0277 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pm.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
@@ -59,10 +59,14 @@ int mpc52xx_set_wakeup_gpio(u8 pin, u8 level)
 
 int mpc52xx_pm_prepare(void)
 {
+	struct device_node *np;
+
 	/* map the whole register space */
-	mbar = mpc52xx_find_and_map("mpc5200");
+	np = of_find_compatible_node(NULL, NULL, "mpc5200");
+	mbar = of_iomap(np, 0);
+	of_node_put(np);
 	if (!mbar) {
-		printk(KERN_ERR "%s:%i Error mapping registers\n", __func__, __LINE__);
+		pr_err("mpc52xx_pm_prepare(): could not map registers\n");
 		return -ENOSYS;
 	}
 	/* these offsets are from mpc5200 users manual */
diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 7051e6c..d398c93 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -330,6 +330,7 @@ static void mpc52xx_psc_spi_cleanup(struct spi_device *spi)
 
 static int mpc52xx_psc_spi_port_config(int psc_id, struct mpc52xx_psc_spi *mps)
 {
+	struct device_node *np;
 	struct mpc52xx_cdm __iomem *cdm;
 	struct mpc52xx_gpio __iomem *gpio;
 	struct mpc52xx_psc __iomem *psc = mps->psc;
@@ -338,8 +339,12 @@ static int mpc52xx_psc_spi_port_config(int psc_id, struct mpc52xx_psc_spi *mps)
 	int ret = 0;
 
 #if defined(CONFIG_PPC_MERGE)
-	cdm = mpc52xx_find_and_map("mpc5200-cdm");
-	gpio = mpc52xx_find_and_map("mpc5200-gpio");
+	np = of_find_compatible_node(NULL, NULL, "mpc5200-cdm");
+	cdm = of_iomap(np, 0);
+	of_node_put(np);
+	np = of_find_compatible_node(NULL, NULL, "mpc5200-gpio");
+	gpio = of_iomap(np, 0);
+	of_node_put(np);
 #else
 	cdm = ioremap(MPC52xx_PA(MPC52xx_CDM_OFFSET), MPC52xx_CDM_SIZE);
 	gpio = ioremap(MPC52xx_PA(MPC52xx_GPIO_OFFSET), MPC52xx_GPIO_SIZE);
diff --git a/include/asm-powerpc/mpc52xx.h b/include/asm-powerpc/mpc52xx.h
index d7efbe0..1c48c6d 100644
--- a/include/asm-powerpc/mpc52xx.h
+++ b/include/asm-powerpc/mpc52xx.h
@@ -248,8 +248,6 @@ struct mpc52xx_cdm {
 
 #ifndef __ASSEMBLY__
 
-extern void __iomem * mpc52xx_find_and_map(const char *);
-extern void __iomem * mpc52xx_find_and_map_path(const char *path);
 extern unsigned int mpc52xx_find_ipb_freq(struct device_node *node);
 extern void mpc5200_setup_xlb_arbiter(void);
 extern void mpc52xx_declare_of_platform_devices(void);
