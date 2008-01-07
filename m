Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 4367FDDEDF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 06:06:13 +1100 (EST)
Received: from pd4mr5so.prod.shaw.ca (pd4mr5so-qfe3.prod.shaw.ca [10.0.141.50])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JUA004G0FPIMQE0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 07 Jan 2008 12:05:42 -0700 (MST)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd4mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JUA00D8AFMRVE00@pd4mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 07 Jan 2008 12:04:26 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JUA00DP4FMQXX00@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 07 Jan 2008 12:04:02 -0700 (MST)
Date: Mon, 07 Jan 2008 12:03:59 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC 1/2] mpc5200: Add common clock setting routine
	mpc52xx_set_psc_clkdiv()
In-reply-to: <20080107185849.13535.38262.stgit@trillian.secretlab.ca>
To: dragos.carp@toptica.com, linuxppc-dev@ozlabs.org
Message-id: <20080107190335.13535.29837.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20080107185849.13535.38262.stgit@trillian.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

PSC drivers should not access the CDM registers directly.  Instead provide
a common routine for setting the PSC clock parameters with the required
locking.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/52xx/efika.c          |    3 +
 arch/powerpc/platforms/52xx/lite5200.c       |   10 +--
 arch/powerpc/platforms/52xx/mpc5200_simple.c |    6 +-
 arch/powerpc/platforms/52xx/mpc52xx_common.c |   91 +++++++++++++++++++++-----
 arch/ppc/syslib/mpc52xx_setup.c              |   36 ++++++++++
 include/asm-powerpc/mpc52xx.h                |   13 ++--
 6 files changed, 130 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
index a0da70c..a2068fa 100644
--- a/arch/powerpc/platforms/52xx/efika.c
+++ b/arch/powerpc/platforms/52xx/efika.c
@@ -180,6 +180,9 @@ static void __init efika_setup_arch(void)
 {
 	rtas_initialize();
 
+	/* Map important registers from the internal memory map */
+	mpc52xx_map_common_devices();
+
 	efika_pcisetup();
 
 #ifdef CONFIG_PM
diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index f8ba5f2..42e87b6 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -150,15 +150,15 @@ static void __init lite5200_setup_arch(void)
 	if (ppc_md.progress)
 		ppc_md.progress("lite5200_setup_arch()", 0);
 
-	/* Fix things that firmware should have done. */
-	lite5200_fix_clock_config();
-	lite5200_fix_port_config();
+	/* Map important registers from the internal memory map */
+	mpc52xx_map_common_devices();
 
 	/* Some mpc5200 & mpc5200b related configuration */
 	mpc5200_setup_xlb_arbiter();
 
-	/* Map wdt for mpc52xx_restart() */
-	mpc52xx_map_wdt();
+	/* Fix things that firmware should have done. */
+	lite5200_fix_clock_config();
+	lite5200_fix_port_config();
 
 #ifdef CONFIG_PM
 	mpc52xx_suspend.board_suspend_prepare = lite5200_suspend_prepare;
diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/platforms/52xx/mpc5200_simple.c
index 754aa93..c48b82b 100644
--- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
+++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
@@ -39,12 +39,12 @@ static void __init mpc5200_simple_setup_arch(void)
 	if (ppc_md.progress)
 		ppc_md.progress("mpc5200_simple_setup_arch()", 0);
 
+	/* Map important registers from the internal memory map */
+	mpc52xx_map_common_devices();
+
 	/* Some mpc5200 & mpc5200b related configuration */
 	mpc5200_setup_xlb_arbiter();
 
-	/* Map wdt for mpc52xx_restart() */
-	mpc52xx_map_wdt();
-
 	mpc52xx_setup_pci();
 }
 
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 59346e3..67eba48 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -13,6 +13,7 @@
 #undef DEBUG
 
 #include <linux/kernel.h>
+#include <linux/spinlock.h>
 #include <linux/of_platform.h>
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -24,7 +25,9 @@
  * from interrupt context while node mapping (which calls ioremap())
  * cannot be used at such point.
  */
-static volatile struct mpc52xx_gpt *mpc52xx_wdt = NULL;
+static spinlock_t mpc52xx_lock = SPIN_LOCK_UNLOCKED;
+static struct mpc52xx_gpt __iomem *mpc52xx_wdt;
+static struct mpc52xx_cdm __iomem *mpc52xx_cdm;
 
 /**
  * 	mpc52xx_find_ipb_freq - Find the IPB bus frequency for a device
@@ -93,32 +96,43 @@ mpc5200_setup_xlb_arbiter(void)
 	iounmap(xlb);
 }
 
-static struct of_device_id __init mpc52xx_ids[] = {
-	{ .compatible = "fsl,mpc5200-immr", },
-	{ .compatible = "fsl,lpb", },
-
-	/* depreciated matches; shouldn't be used in new device trees */
-	{ .type = "builtin", .compatible = "mpc5200", }, /* efika */
-	{ .type = "soc", .compatible = "mpc5200", }, /* lite5200 */
-	{}
-};
-
+/**
+ * mpc52xx_declare_of_platform_devices: register internal devices and children
+ *					of the localplus bus to the of_platform
+ *					bus.
+ */
 void __init
 mpc52xx_declare_of_platform_devices(void)
 {
+	const static struct of_device_id mpc52xx_bus_ids[] = {
+		{ .compatible = "fsl,mpc5200-immr", },
+		{ .compatible = "fsl,lpb", },
+		{ .type = "builtin", .compatible = "mpc5200", }, /* efika */
+		{ .type = "soc", .compatible = "mpc5200", }, /* old */
+		{}
+	};
+
 	/* Find every child of the SOC node and add it to of_platform */
-	if (of_platform_bus_probe(NULL, mpc52xx_ids, NULL))
+	if (of_platform_bus_probe(NULL, mpc52xx_bus_ids, NULL))
 		printk(KERN_ERR __FILE__ ": "
 			"Error while probing of_platform bus\n");
 }
 
+/**
+ * mpc52xx_map_common_devices: iomap devices required by common code
+ */
 void __init
-mpc52xx_map_wdt(void)
+mpc52xx_map_common_devices(void)
 {
 	struct device_node *np;
-	struct of_device_id gpt_ids[] = {
+	const static struct of_device_id gpt_ids[] = {
 		{ .compatible = "fsl,mpc5200-gpt", },
-		{ .compatible = "mpc5200-gpt", },
+		{ .compatible = "mpc5200-gpt", }, /* old */
+		{}
+	};
+	const static struct of_device_id cdm_ids[] = {
+		{ .compatible = "fsl,mpc5200-cdm", },
+		{ .compatible = "mpc5200-cdm", }, /* old */
 		{}
 	};
 
@@ -131,11 +145,56 @@ mpc52xx_map_wdt(void)
 		    of_get_property(np, "has-wdt", NULL)) {
 			mpc52xx_wdt = of_iomap(np, 0);
 			of_node_put(np);
-			return;
+			break;
 		}
 	}
+
+	/* Clock Distribution Module, used by PSC clock setting function */
+	np = of_find_matching_node(NULL, cdm_ids);
+	mpc52xx_cdm = of_iomap(np, 0);
+	of_node_put(np);
+}
+
+/**
+ * mpc52xx_set_psc_clkdiv: Set clock divider in the CDM for PSC ports
+ *
+ * @psc_id: id of psc port; must be 1,2,3 or 6
+ * @clkdiv: clock divider value to put into CDM PSC register.
+ */
+int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv)
+{
+	unsigned long flags;
+	u16 __iomem *reg;
+	u32 val;
+	u32 mask;
+	u32 mclken_div;
+
+	if (!mpc52xx_cdm)
+		return -ENODEV;
+
+	mclken_div = 0x8000 | (clkdiv & 0x1FF);
+	switch (psc_id) {
+	  case 1: reg = &mpc52xx_cdm->mclken_div_psc1; mask = 0x20; break;
+	  case 2: reg = &mpc52xx_cdm->mclken_div_psc2; mask = 0x40; break;
+	  case 3: reg = &mpc52xx_cdm->mclken_div_psc3; mask = 0x80; break;
+	  case 6: reg = &mpc52xx_cdm->mclken_div_psc6; mask = 0x10; break;
+	  default:
+	  	return -ENODEV;
+	}
+
+	/* Set the rate and enable the clock */
+	spin_lock_irqsave(&mpc52xx_lock, flags);
+	out_be16(reg, mclken_div);
+	val = in_be32(&mpc52xx_cdm->clk_enables);
+	out_be32(&mpc52xx_cdm->clk_enables, val | mask);
+	spin_unlock_irqrestore(&mpc52xx_lock, flags);
+
+	return 0;
 }
 
+/**
+ * mpc52xx_restart: ppc_md->restart hook for mpc5200 using the watchdog timer
+ */
 void
 mpc52xx_restart(char *cmd)
 {
diff --git a/arch/ppc/syslib/mpc52xx_setup.c b/arch/ppc/syslib/mpc52xx_setup.c
index ecfa2c0..791fc8d 100644
--- a/arch/ppc/syslib/mpc52xx_setup.c
+++ b/arch/ppc/syslib/mpc52xx_setup.c
@@ -16,6 +16,7 @@
  */
 
 
+#include <linux/spinlock.h>
 #include <asm/io.h>
 #include <asm/time.h>
 #include <asm/mpc52xx.h>
@@ -275,3 +276,38 @@ int mpc52xx_match_psc_function(int psc_idx, const char *func)
 
 	return 0;
 }
+
+int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv)
+{
+	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+	struct mpc52xx_cdm __iomem *cdm;
+	unsigned long flags;
+	u16 mclken_div;
+	u16 __iomem *reg;
+	u32 mask;
+
+	cdm = ioremap(MPC52xx_PA(MPC52xx_CDM_OFFSET), MPC52xx_CDM_SIZE);
+	if (!cdm) {
+		printk(KERN_ERR __FILE__ ": Error mapping CDM\n");
+		return -ENODEV
+	}
+
+	mclken_div = 0x8000 | (clkdiv & 0x1FF);
+	switch (psc_id) {
+	  case 1: reg = &cdm->mclken_div_psc1; mask = 0x20; break;
+	  case 2: reg = &cdm->mclken_div_psc2; mask = 0x40; break;
+	  case 3: reg = &cdm->mclken_div_psc3; mask = 0x80; break;
+	  case 6: reg = &cdm->mclken_div_psc6; mask = 0x10; break;
+	  default:
+	  	return -ENODEV;
+	}
+
+	/* Set the rate and enable the clock */
+	spin_lock_irqsave(&lock, flags);
+	out_be16(reg, mclken_div);
+	out_be32(&cdm->clk_enables, in_be32(&cdm->clk_enables) | mask);
+	spin_unlock_irqrestore(&lock, flags);
+
+	iounmap(cdm);
+	return 0;
+}
diff --git a/include/asm-powerpc/mpc52xx.h b/include/asm-powerpc/mpc52xx.h
index 1c48c6d..c7a0710 100644
--- a/include/asm-powerpc/mpc52xx.h
+++ b/include/asm-powerpc/mpc52xx.h
@@ -248,13 +248,19 @@ struct mpc52xx_cdm {
 
 #ifndef __ASSEMBLY__
 
+/* mpc52xx_common.c */
 extern unsigned int mpc52xx_find_ipb_freq(struct device_node *node);
-extern void mpc5200_setup_xlb_arbiter(void);
-extern void mpc52xx_declare_of_platform_devices(void);
+extern void __init mpc5200_setup_xlb_arbiter(void);
+extern void __init mpc52xx_declare_of_platform_devices(void);
+extern void __init mpc52xx_map_common_devices(void);
+extern int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv);
+extern void mpc52xx_restart(char *cmd);
 
+/* mpc52xx_pic.c */
 extern void mpc52xx_init_irq(void);
 extern unsigned int mpc52xx_get_irq(void);
 
+/* mpc52xx_pci.c */
 #ifdef CONFIG_PCI
 extern int __init mpc52xx_add_bridge(struct device_node *node);
 extern void __init mpc52xx_setup_pci(void);
@@ -262,9 +268,6 @@ extern void __init mpc52xx_setup_pci(void);
 static inline void mpc52xx_setup_pci(void) { }
 #endif
 
-extern void __init mpc52xx_map_wdt(void);
-extern void mpc52xx_restart(char *cmd);
-
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_PM
