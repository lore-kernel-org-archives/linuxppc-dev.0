Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id 0A89DDDE2D
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Oct 2007 18:09:27 +1000 (EST)
Date: Sun, 14 Oct 2007 10:09:23 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: galak@kernel.crashing.org
Subject: [PATCH 1/2] clk for mpc52xx: platform part
Message-ID: <20071014080923.GI3000@nd47.coderock.org>
References: <20071014080813.GH3000@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071014080813.GH3000@nd47.coderock.org>
Cc: david-b@pacbell.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

clk.h interface for mpc52xx
Currently only psc_mclks are defined.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 arch/powerpc/platforms/52xx/Makefile         |    2 
 arch/powerpc/platforms/52xx/mpc52xx_clock.c  |  352 +++++++++++++++++++++++++++
 arch/powerpc/platforms/52xx/mpc52xx_common.c |    3 
 include/asm-powerpc/mpc52xx.h                |    2 
 4 files changed, 358 insertions(+), 1 deletion(-)

Index: linux.git/arch/powerpc/platforms/52xx/Makefile
===================================================================
--- linux.git.orig/arch/powerpc/platforms/52xx/Makefile
+++ linux.git/arch/powerpc/platforms/52xx/Makefile
@@ -2,7 +2,7 @@
 # Makefile for 52xx based boards
 #
 ifeq ($(CONFIG_PPC_MERGE),y)
-obj-y				+= mpc52xx_pic.o mpc52xx_common.o
+obj-y				+= mpc52xx_pic.o mpc52xx_common.o mpc52xx_clock.o
 obj-$(CONFIG_PCI)		+= mpc52xx_pci.o
 endif
 
Index: linux.git/arch/powerpc/platforms/52xx/mpc52xx_clock.c
===================================================================
--- /dev/null
+++ linux.git/arch/powerpc/platforms/52xx/mpc52xx_clock.c
@@ -0,0 +1,352 @@
+/*
+ * arch/powerpc/platforms/52xx/mpc52xx_clock.c
+ * based on linux/arch/arm/mach-at91/clock.c
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/spinlock.h>
+#include <linux/clk.h>
+
+#include <asm/io.h>
+#include <asm/mpc52xx.h>
+#include <asm/clk_interface.h>
+
+
+struct clk {
+	struct list_head node;
+	const char	*name;		/* unique clock name */
+	struct device_node *of_node;	/* device node associated with this clock */
+	const char	*function;	/* clock function */
+	unsigned long	rate_hz;
+	struct clk	*parent;
+	void		(*mode)(struct clk *, int);
+	u16		users;
+	int		cdm_id;		/* == bit number in datasheet, or 0 */
+	long		(*set_rate)(struct clk *, unsigned long rate, int round_only);
+};
+
+#define CDM_ID_PSC3 24
+#define CDM_ID_PSC2 25
+#define CDM_ID_PSC1 26
+#define CDM_ID_PSC6 27
+
+static long psc_set_rate(struct clk *clk, unsigned long rate, int round_only);
+
+static struct clk clk_system = {
+	.name		= "system",
+	.rate_hz	= 528000000,	/* default if there's no system-frequency in dts */
+	.users		= 1,		/* always on */
+};
+static struct clk clk_psc1 = {
+	.name		= "psc1_mclk",
+	.cdm_id		= CDM_ID_PSC1,
+	.parent		= &clk_system,
+	.set_rate	= psc_set_rate,
+};
+static struct clk clk_psc2 = {
+	.name		= "psc2_mclk",
+	.cdm_id		= CDM_ID_PSC2,
+	.parent		= &clk_system,
+	.set_rate	= psc_set_rate,
+};
+static struct clk clk_psc3 = {
+	.name		= "psc3_mclk",
+	.cdm_id		= CDM_ID_PSC3,
+	.parent		= &clk_system,
+	.set_rate	= psc_set_rate,
+};
+static struct clk clk_psc6 = {
+	.name		= "psc6_mclk",
+	.cdm_id		= CDM_ID_PSC6,
+	.parent		= &clk_system,
+	.set_rate	= psc_set_rate,
+};
+
+
+
+static LIST_HEAD(clocks);
+static DEFINE_SPINLOCK(clk_lock);
+
+static struct mpc52xx_cdm __iomem *cdm;
+static DEFINE_SPINLOCK(cdm_lock);
+
+
+static long psc_set_rate(struct clk *clk, unsigned long rate, int round_only)
+{
+	u16 mclkdiv;
+	u16 __iomem *divreg;
+
+	/* pick a divider that will get the closest clock */
+	mclkdiv = (clk->parent->rate_hz + rate/2) / rate - 1;
+
+	/* trim to closest possible. or should we return an error? */
+	mclkdiv = min(mclkdiv, (u16)0x1ff);
+	mclkdiv = max(mclkdiv, (u16)1);
+
+	rate = clk->parent->rate_hz / (mclkdiv + 1);
+	mclkdiv |= 0x8000;	/* enable (this is not clk_enable!) */
+
+	if (round_only)
+		return rate;
+
+	if (clk->cdm_id == CDM_ID_PSC1)
+		divreg = &cdm->mclken_div_psc1;
+	else if (clk->cdm_id == CDM_ID_PSC2)
+		divreg = &cdm->mclken_div_psc2;
+	else if (clk->cdm_id == CDM_ID_PSC3)
+		divreg = &cdm->mclken_div_psc3;
+	else if (clk->cdm_id == CDM_ID_PSC6)
+		divreg = &cdm->mclken_div_psc6;
+	else
+		return -ENODEV;
+
+	out_be16(divreg, mclkdiv);
+
+	return 0;
+}
+
+/* clocks cannot be de-registered no refcounting necessary */
+static struct clk *mpc52xx_clk_get(struct device *dev, const char *id)
+{
+	struct clk *clk;
+
+	list_for_each_entry(clk, &clocks, node) {
+		if (strcmp(id, clk->name) == 0)
+			return clk;
+		if (clk->function && strcmp(id, clk->function) == 0 && dev &&
+				dev->archdata.of_node == clk->of_node)
+			return clk;
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+
+static void mpc52xx_clock_associate(const char *id, struct device_node *of_node,
+		const char *function)
+{
+	struct clk *clk = mpc52xx_clk_get(NULL, id);
+
+	if (IS_ERR(clk))
+		return;
+
+	clk->function = function;
+	clk->of_node = of_node;
+}
+
+static void mpc52xx_clk_put(struct clk *clk)
+{
+}
+
+
+static void clk_mode_cdm(int cdm_id, int enabled)
+{
+	unsigned long flags;
+	u32 clk_enables;
+
+	if (cdm_id < 12 || cdm_id > 31) {
+		printk(KERN_ERR "%s: %i invalid cdm_id: %i\n", __func__, __LINE__, cdm_id);
+		return;
+	}
+
+	spin_lock_irqsave(&cdm_lock, flags);
+	clk_enables = in_be32(&cdm->clk_enables);
+	if (enabled)
+		clk_enables |= 1 << (31-cdm_id);
+	else
+		clk_enables &= ~(1 << (31-cdm_id));
+
+	out_be32(&cdm->clk_enables, clk_enables);
+	spin_unlock_irqrestore(&cdm_lock, flags);
+}
+
+static void __clk_enable(struct clk *clk)
+{
+	if (clk->parent)
+		__clk_enable(clk->parent);
+	if (clk->users++ == 0 && clk->mode) {
+		if (clk->cdm_id)
+			clk_mode_cdm(clk->cdm_id, 1);
+		else
+			clk->mode(clk, 1);
+	}
+}
+
+static int mpc52xx_clk_enable(struct clk *clk)
+{
+	unsigned long	flags;
+
+	spin_lock_irqsave(&clk_lock, flags);
+	__clk_enable(clk);
+	spin_unlock_irqrestore(&clk_lock, flags);
+	return 0;
+}
+
+static void __clk_disable(struct clk *clk)
+{
+	BUG_ON(clk->users == 0);
+	if (--clk->users == 0 && clk->mode) {
+		if (clk->cdm_id)
+			clk_mode_cdm(clk->cdm_id, 0);
+		else
+			clk->mode(clk, 0);
+	}
+	if (clk->parent)
+		__clk_disable(clk->parent);
+}
+
+static void mpc52xx_clk_disable(struct clk *clk)
+{
+	unsigned long	flags;
+
+	spin_lock_irqsave(&clk_lock, flags);
+	__clk_disable(clk);
+	spin_unlock_irqrestore(&clk_lock, flags);
+}
+
+static unsigned long mpc52xx_clk_get_rate(struct clk *clk)
+{
+	unsigned long	flags;
+	unsigned long	rate;
+
+	spin_lock_irqsave(&clk_lock, flags);
+	for (;;) {
+		rate = clk->rate_hz;
+		if (rate || !clk->parent)
+			break;
+		clk = clk->parent;
+	}
+	spin_unlock_irqrestore(&clk_lock, flags);
+	return rate;
+}
+
+static long mpc52xx_clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned long flags;
+	long ret;
+
+	if (!clk->set_rate)
+		return -EINVAL;
+
+	spin_lock_irqsave(&clk_lock, flags);
+	ret = clk->set_rate(clk, rate, 1);
+	spin_unlock_irqrestore(&clk_lock, flags);
+
+	return ret;
+}
+
+static int mpc52xx_clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned long flags;
+	int ret;
+
+	if (!clk->set_rate)
+		return -EINVAL;
+	if (clk->users)
+		return -EBUSY;
+
+	spin_lock_irqsave(&clk_lock, flags);
+	clk->rate_hz = clk->set_rate(clk, rate, 1);
+	ret = clk->set_rate(clk, rate, 0);
+	spin_unlock_irqrestore(&clk_lock, flags);
+
+	return ret;
+}
+
+static struct clk *mpc52xx_clk_get_parent(struct clk *clk)
+{
+	return clk->parent;
+}
+
+static int mpc52xx_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	unsigned long	flags;
+
+	if (clk->users)
+		return -EBUSY;
+	spin_lock_irqsave(&clk_lock, flags);
+
+	clk->rate_hz = parent->rate_hz;
+	clk->parent = parent;
+
+	spin_unlock_irqrestore(&clk_lock, flags);
+	return 0;
+}
+
+
+
+static struct clk *const mpc5200_clocks[] __initdata = {
+	&clk_system,
+	&clk_psc1,
+	&clk_psc2,
+	&clk_psc3,
+	&clk_psc6,
+};
+
+int __init mpc52xx_clock_init(void)
+{
+	int i;
+	struct device_node *np, *child = NULL;
+	const unsigned int *fp;
+
+	/* map Clock Distribution Module registers */
+	cdm = mpc52xx_find_and_map("mpc5200-cdm");
+	if (!cdm) {
+		printk(KERN_ERR "%s: %i couldn't map mpc5200-cdm\n", __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	/* register clocks */
+	for (i = 0; i < ARRAY_SIZE(mpc5200_clocks); i++)
+		list_add_tail(&mpc5200_clocks[i]->node, &clocks);
+
+
+	/* get clk_system rate from device tree */
+	np = of_find_node_by_type(NULL, "soc");
+	if (!np)
+		return 0;
+
+	fp = of_get_property(np, "system-frequency", NULL);
+	if (fp && *fp)
+		clk_system.rate_hz = *fp;
+
+	/* associate psc_mclks with device_nodes */
+	while ((child = of_get_next_child(np, child))) {
+		if (of_device_is_compatible(child, "mpc5200-psc")) {
+			char clock[10];
+			int ci = -1;
+			const int *pci;
+
+			pci = of_get_property(child, "cell-index", NULL);
+			if (pci)
+				ci = *pci;
+			if (ci < 0 || ci > 5 || ci == 3 || ci == 4) {
+				printk(KERN_ALERT "%s: %i psc node '%s' has invalid "
+						"cell-index: %i\n", __func__, __LINE__,
+						child->name, ci);
+				continue;
+			}
+
+			snprintf(clock, 10, "psc%i_mclk", ci + 1);
+			mpc52xx_clock_associate(clock, child, "psc_mclk");
+		}
+	}
+	of_node_put(np);
+
+	/* register clocks */
+	clk_functions = (struct clk_interface) {
+		.clk_get	= mpc52xx_clk_get,
+		.clk_enable	= mpc52xx_clk_enable,
+		.clk_disable	= mpc52xx_clk_disable,
+		.clk_get_rate	= mpc52xx_clk_get_rate,
+		.clk_put	= mpc52xx_clk_put,
+		.clk_round_rate	= mpc52xx_clk_round_rate,
+		.clk_set_rate	= mpc52xx_clk_set_rate,
+		.clk_set_parent	= mpc52xx_clk_set_parent,
+		.clk_get_parent	= mpc52xx_clk_get_parent,
+	};
+	return 0;
+}
Index: linux.git/arch/powerpc/platforms/52xx/mpc52xx_common.c
===================================================================
--- linux.git.orig/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ linux.git/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -101,6 +101,9 @@ mpc5200_setup_xlb_arbiter(void)
 	 */
 	out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_PLDIS);
 
+	/* setup clk system */
+	mpc52xx_clock_init();
+
 	iounmap(xlb);
 }
 
Index: linux.git/include/asm-powerpc/mpc52xx.h
===================================================================
--- linux.git.orig/include/asm-powerpc/mpc52xx.h
+++ linux.git/include/asm-powerpc/mpc52xx.h
@@ -274,5 +274,7 @@ extern char saved_sram[0x4000]; /* reuse
 #endif
 #endif /* CONFIG_PM */
 
+extern int __init mpc52xx_clock_init(void);
+
 #endif /* __ASM_POWERPC_MPC52xx_H__ */
 
