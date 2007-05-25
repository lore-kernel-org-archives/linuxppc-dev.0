Return-Path: <domen@coderock.org>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id 0578FDDED7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 May 2007 18:45:43 +1000 (EST)
Date: Fri, 25 May 2007 10:45:39 +0200
From: Domen Puncer <domen@coderock.org>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: [RFC 2/3] Re: [PATCH] mpc52xx_psc_spi: fix it for CONFIG_PPC_MERGE
Message-ID: <20070525084539.GB23149@nd47.coderock.org>
References: <20070516073707.GD9667@nd47.coderock.org>
	<464ABE97.7090603@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <464ABE97.7090603@246tNt.com>
Cc: Dragos Carp <dragos.carp@toptica.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	domen.puncer@telargo.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 16/05/07 10:19 +0200, Sylvain Munaut wrote:
>  - You do read/write/modify operation on CDM shared register
> (clk_enables) from a driver, you should have added something in common
> 52xx code to do theses with proper locking.
>  - MPC52xx_PA(MPC52xx_PSCx_OFFSET(...)) ??? You should get that from the
> resource of the platform_device. This macro is just there for early
> console stuff.
>  - You can get f_system from the device tree instead of just assuming
> it's 512 MHz. It probably need to be done the same way it's done to find
> ipb_freq.
>  - Would have been nice to be able to somehow configure MCLK rather than
> #define it

[ trimming spi-devel from cc: ]


Use clk.h interface for mpc52xx.
Parse device tree for Fsystem, or leave it default 528 (yes, not 512).

Currently only psc_mclks are defined.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 arch/powerpc/platforms/52xx/Makefile |    2 
 arch/powerpc/platforms/52xx/clock.c  |  311 +++++++++++++++++++++++++++++++++++
 2 files changed, 312 insertions(+), 1 deletion(-)

Index: work-powerpc.git/arch/powerpc/platforms/52xx/Makefile
===================================================================
--- work-powerpc.git.orig/arch/powerpc/platforms/52xx/Makefile
+++ work-powerpc.git/arch/powerpc/platforms/52xx/Makefile
@@ -2,7 +2,7 @@
 # Makefile for 52xx based boards
 #
 ifeq ($(CONFIG_PPC_MERGE),y)
-obj-y				+= mpc52xx_pic.o mpc52xx_common.o
+obj-y				+= mpc52xx_pic.o mpc52xx_common.o clock.o
 obj-$(CONFIG_PCI)		+= mpc52xx_pci.o
 obj-$(CONFIG_PPC_BESTCOMM) 	+= bestcomm.o
 obj-$(CONFIG_FEC_MPC52xx)	+= sdma_fec_rx_task.o sdma_fec_tx_task.o fec.o
Index: work-powerpc.git/arch/powerpc/platforms/52xx/clock.c
===================================================================
--- /dev/null
+++ work-powerpc.git/arch/powerpc/platforms/52xx/clock.c
@@ -0,0 +1,311 @@
+/*
+ * arch/powerpc/platforms/52xx/clock.c
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
+
+
+struct clk {
+	struct list_head node;
+	const char	*name;		/* unique clock name */
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
+long psc_set_rate(struct clk *clk, unsigned long rate, int round_only);
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
+long psc_set_rate(struct clk *clk, unsigned long rate, int round_only)
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
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	struct clk *clk;
+
+	list_for_each_entry(clk, &clocks, node) {
+		if (strcmp(id, clk->name) == 0)
+			return clk;
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+EXPORT_SYMBOL(clk_get);
+
+void clk_put(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_put);
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
+int clk_enable(struct clk *clk)
+{
+	unsigned long	flags;
+
+	spin_lock_irqsave(&clk_lock, flags);
+	__clk_enable(clk);
+	spin_unlock_irqrestore(&clk_lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL(clk_enable);
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
+void clk_disable(struct clk *clk)
+{
+	unsigned long	flags;
+
+	spin_lock_irqsave(&clk_lock, flags);
+	__clk_disable(clk);
+	spin_unlock_irqrestore(&clk_lock, flags);
+}
+EXPORT_SYMBOL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
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
+EXPORT_SYMBOL(clk_get_rate);
+
+long clk_round_rate(struct clk *clk, unsigned long rate)
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
+EXPORT_SYMBOL(clk_round_rate);
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
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
+EXPORT_SYMBOL(clk_set_rate);
+
+struct clk *clk_get_parent(struct clk *clk)
+{
+	return clk->parent;
+}
+EXPORT_SYMBOL(clk_get_parent);
+
+int clk_set_parent(struct clk *clk, struct clk *parent)
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
+EXPORT_SYMBOL(clk_set_parent);
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
+static int __init mpc5200_clock_init(void)
+{
+	int i;
+	unsigned int fsystem = 0;
+	struct device_node *np;
+
+	/* get clk_system rate from device tree */
+	np = of_find_node_by_type(NULL, "soc");
+	if (np) {
+		const unsigned int *fp =
+			of_get_property(np, "system-frequency", NULL);
+		if (fp)
+			fsystem = *fp;
+		of_node_put(np);
+	}
+	if (fsystem)
+		clk_system.rate_hz = fsystem;
+
+	cdm = mpc52xx_find_and_map("mpc5200-cdm");
+	if (!cdm) {
+		printk(KERN_ERR "%s: %i couldn't map mpc5200-cdm\n", __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	/* Register the PMC's standard clocks */
+	for (i = 0; i < ARRAY_SIZE(mpc5200_clocks); i++)
+		list_add_tail(&mpc5200_clocks[i]->node, &clocks);
+
+	return 0;
+}
+
+arch_initcall(mpc5200_clock_init);
