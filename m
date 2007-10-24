Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id C6214DDF14
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 04:24:33 +1000 (EST)
Received: from pd3mr5so.prod.shaw.ca (pd3mr5so-qfe3.prod.shaw.ca [10.0.141.12])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQF00CTKHSQYHD0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 24 Oct 2007 12:24:26 -0600 (MDT)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
	by pd3mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JQF00FAJHSO1830@pd3mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 24 Oct 2007 12:24:26 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQF002BAHSNOU20@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 24 Oct 2007 12:24:24 -0600 (MDT)
Date: Wed, 24 Oct 2007 12:24:26 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/2] mpc52xx: add cdm (clock module) helper function for PSCs
In-reply-to: <20071024182308.21194.69416.stgit@trillian.cg.shawcable.net>
To: domen.puncer@telargo.com, linuxppc-dev@ozlabs.org
Message-id: <20071024182426.21194.57761.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071024182308.21194.69416.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Device drivers should not access the CDM registers directly to modify
the clocking.  Instead, provide a helper function for setting the MCLK
value so that the registers can be properly protected from concurent
access.
---

 arch/powerpc/platforms/52xx/efika.c          |    2 
 arch/powerpc/platforms/52xx/lite5200.c       |    1 
 arch/powerpc/platforms/52xx/mpc52xx_common.c |  112 +++++++++++++++++++++++---
 include/asm-powerpc/mpc52xx.h                |    7 ++
 4 files changed, 107 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
index a0da70c..0e3b1ac 100644
--- a/arch/powerpc/platforms/52xx/efika.c
+++ b/arch/powerpc/platforms/52xx/efika.c
@@ -180,6 +180,8 @@ static void __init efika_setup_arch(void)
 {
 	rtas_initialize();
 
+	mpc52xx_setup_clocks();
+
 	efika_pcisetup();
 
 #ifdef CONFIG_PM
diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index 25d2bfa..7665e60 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -143,6 +143,7 @@ static void __init lite5200_setup_arch(void)
 	lite5200_fix_port_config();
 
 	/* Some mpc5200 & mpc5200b related configuration */
+	mpc5200_setup_clocks();
 	mpc5200_setup_xlb_arbiter();
 
 	/* Map wdt for mpc52xx_restart() */
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 9850685..ced046b 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -14,6 +14,7 @@
 
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
+#include <linux/spinlock.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/mpc52xx.h>
@@ -26,6 +27,20 @@
  */
 static volatile struct mpc52xx_gpt *mpc52xx_wdt = NULL;
 
+/*
+ * Location of clock distibution module.  The device regs are mapped at
+ * board init time to eliminate runtime lookups.  All access to these
+ * registers is protected with the mpc52xx_cdm_lock spinlock
+ */
+static void __iomem *mpc52xx_cdm_regs = NULL;
+static spinlock_t mpc52xx_cdm_lock = SPIN_LOCK_UNLOCKED;
+
+/*
+ * Cached clock values
+ */
+static unsigned int mpc52xx_system_freq;
+static unsigned int mpc52xx_ipb_freq;
+
 static void __iomem *
 mpc52xx_map_node(struct device_node *ofn)
 {
@@ -74,26 +89,92 @@ EXPORT_SYMBOL(mpc52xx_find_and_map_path);
 unsigned int
 mpc52xx_find_ipb_freq(struct device_node *node)
 {
-	struct device_node *np;
-	const unsigned int *p_ipb_freq = NULL;
+	return mpc52xx_ipb_freq;
+}
+EXPORT_SYMBOL(mpc52xx_find_ipb_freq);
 
-	of_node_get(node);
-	while (node) {
-		p_ipb_freq = of_get_property(node, "bus-frequency", NULL);
-		if (p_ipb_freq)
-			break;
+/*
+ * Clock support for PSCs
+ */
+struct mpc52xx_cdm_psc_clk_params {
+	int div_reg;
+	int enable;
+};
 
-		np = of_get_parent(node);
-		of_node_put(node);
-		node = np;
-	}
-	if (node)
-		of_node_put(node);
+static struct mpc52xx_cdm_psc_clk_params mpc52xx_cdm_psc_clk_params[] = {
+	[0] = { .div_reg = MPC52xx_CDM_MCLKEN_DIV_PSC1_OFF, .enable = 0x20 },
+	[1] = { .div_reg = MPC52xx_CDM_MCLKEN_DIV_PSC2_OFF, .enable = 0x40 },
+	[2] = { .div_reg = MPC52xx_CDM_MCLKEN_DIV_PSC3_OFF, .enable = 0x80 },
+	[5] = { .div_reg = MPC52xx_CDM_MCLKEN_DIV_PSC6_OFF, .enable = 0x10 },
+};
+
+/**
+ * mpc52xx_cdm_set_psc_clk: Set input MCLK for a PSC
+ * @psc: id of PSC, based at 0
+ * @freq_hz: desired frequency
+ */
+int mpc52xx_cdm_set_psc_clk(int psc, u32 freq_hz)
+{
+	struct mpc52xx_cdm_psc_clk_params *params;
+	unsigned long flags;
+	u16 mclken_div;
+	u32 reg;
+
+	if (!mpc52xx_cdm_regs)
+		return -ENODEV;
 
-	return p_ipb_freq ? *p_ipb_freq : 0;
+	/* Calculate the parameters */
+	params = &mpc52xx_cdm_psc_clk_params[psc];
+	mclken_div = 0x8000 | (((mpc52xx_system_freq / freq_hz) - 1) & 0x1FF);
+
+	spin_lock_irqsave(&mpc52xx_cdm_lock, flags);
+
+	/* disable the clock before modifying frequency */
+	reg = in_be32(mpc52xx_cdm_regs + MPC52xx_CDM_CLK_ENABLES_OFF);
+	reg &= ~params->enable;
+
+	/* Set the new speed */
+	out_be16(mpc52xx_cdm_regs + params->div_reg, mclken_div);
+
+	/* Set the enable bit */
+	reg |= params->enable;
+	out_be32(mpc52xx_cdm_regs + MPC52xx_CDM_CLK_ENABLES_OFF, reg);
+
+	spin_unlock_irqrestore(&mpc52xx_cdm_lock, flags);
+
+	return 0;
 }
-EXPORT_SYMBOL(mpc52xx_find_ipb_freq);
+EXPORT_SYMBOL_GPL(mpc52xx_cdm_set_psc_clk);
 
+/**
+ * mpc5200_setup_clocks: called by platform code to setup clock frequencies
+ */
+void mpc5200_setup_clocks(void)
+{
+	struct device_node *node;
+	const unsigned int *prop = NULL;
+
+	node = of_find_compatible_node(NULL, NULL, "fsl,mpc5200");
+	if (!node)
+		node = of_find_compatible_node(NULL, NULL, "mpc5200");
+	if (!node) {
+		printk(KERN_ERR"mpc5200_setup_clocks: could not find soc node\n");
+		return;
+	}
+
+	prop = of_get_property(node, "system-frequency", NULL);
+	if (prop)
+		mpc52xx_system_freq = *prop;
+	
+	prop = of_get_property(node, "bus-frequency", NULL);
+	if (prop)
+		mpc52xx_ipb_freq = *prop;
+	of_node_put(node);
+
+	mpc52xx_cdm_regs = mpc52xx_find_and_map("fsl,mpc5200-cdm");
+	if (!mpc52xx_cdm_regs)
+		mpc52xx_cdm_regs = mpc52xx_find_and_map("mpc5200-cdm");
+}
 
 /*
  * Configure the XLB arbiter settings to match what Linux expects.
@@ -176,3 +257,4 @@ mpc52xx_restart(char *cmd)
 
 	while (1);
 }
+
diff --git a/include/asm-powerpc/mpc52xx.h b/include/asm-powerpc/mpc52xx.h
index fcb2ebb..08eb714 100644
--- a/include/asm-powerpc/mpc52xx.h
+++ b/include/asm-powerpc/mpc52xx.h
@@ -208,6 +208,7 @@ struct mpc52xx_cdm {
 	u16 fd_counters;	/* CDM + 0x12  reg4 byte2,3 */
 
 	u32 clk_enables;	/* CDM + 0x14  reg5 */
+#define MPC52xx_CDM_CLK_ENABLES_OFF	0x14
 
 	u8 osc_disable;		/* CDM + 0x18  reg6 byte0 */
 	u8 reserved0[3];	/* CDM + 0x19  reg6 byte1,2,3 */
@@ -228,15 +229,19 @@ struct mpc52xx_cdm {
 
 	u16 reserved4;		/* CDM + 0x28  reg10 byte0,1 */
 	u16 mclken_div_psc1;	/* CDM + 0x2a  reg10 byte2,3 */
+#define MPC52xx_CDM_MCLKEN_DIV_PSC1_OFF	0x2a
 
 	u16 reserved5;		/* CDM + 0x2c  reg11 byte0,1 */
 	u16 mclken_div_psc2;	/* CDM + 0x2e  reg11 byte2,3 */
+#define MPC52xx_CDM_MCLKEN_DIV_PSC2_OFF	0x2e
 
 	u16 reserved6;		/* CDM + 0x30  reg12 byte0,1 */
 	u16 mclken_div_psc3;	/* CDM + 0x32  reg12 byte2,3 */
+#define MPC52xx_CDM_MCLKEN_DIV_PSC3_OFF	0x32
 
 	u16 reserved7;		/* CDM + 0x34  reg13 byte0,1 */
 	u16 mclken_div_psc6;	/* CDM + 0x36  reg13 byte2,3 */
+#define MPC52xx_CDM_MCLKEN_DIV_PSC6_OFF	0x36
 };
 
 #endif /* __ASSEMBLY__ */
@@ -251,6 +256,8 @@ struct mpc52xx_cdm {
 extern void __iomem * mpc52xx_find_and_map(const char *);
 extern void __iomem * mpc52xx_find_and_map_path(const char *path);
 extern unsigned int mpc52xx_find_ipb_freq(struct device_node *node);
+extern int mpc52xx_cdm_set_psc_clk(int psc, u32 freq_hz);
+extern void mpc5200_setup_clocks(void);
 extern void mpc5200_setup_xlb_arbiter(void);
 extern void mpc52xx_declare_of_platform_devices(void);
 
