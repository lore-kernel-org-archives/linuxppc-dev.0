Return-Path: <B25806@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 12AB2B6FB7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 21:25:27 +1100 (EST)
Received: from mail212-ch1 (localhost [127.0.0.1])	by
 mail212-ch1-R.bigfish.com (Postfix) with ESMTP id 78A7B100134	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 10:25:20 +0000 (UTC)
Received: from CH1EHSMHS004.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.241])	by mail212-ch1.bigfish.com (Postfix) with ESMTP id
 3D2BC30004A	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 10:25:18
 +0000 (UTC)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/3] powerpc/85xx: Add clock driver for PWM
Date: Tue, 10 Jan 2012 18:26:41 +0800
Message-ID: <1326191203-11207-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Plugs into the generic powerpc clock driver in
arch/powerpc/kernel/clock.c

The following subset of clk_interface is implemented:
    clk_get: get clock via name
    clk_put: stubbed
    clk_enable: enable clock
    clk_disable: disable clock
    clk_get_rate: get clock rate in Hz
    clk_set_rate: NULL
    clk_round_rate: NULL
    clk_set_parent: NULL
    clk_get_parent: NULL

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
---
 arch/powerpc/include/asm/clock.h        |   33 +++++++
 arch/powerpc/platforms/85xx/Makefile    |    1 +
 arch/powerpc/platforms/85xx/pwm-clock.c |  161 +++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/include/asm/clock.h
 create mode 100644 arch/powerpc/platforms/85xx/pwm-clock.c

diff --git a/arch/powerpc/include/asm/clock.h b/arch/powerpc/include/asm/clock.h
new file mode 100644
index 0000000..98447eb
--- /dev/null
+++ b/arch/powerpc/include/asm/clock.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ *
+ * Author: Chunhe Lan <Chunhe.Lan@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+struct clk {
+	struct list_head node;
+	const char	*name;		/* unique clock name */
+	const char	*function;	/* function of the clock */
+	struct device	*dev;		/* device associated with function */
+	unsigned int	id:2;		/* clock identification */
+	unsigned long	rate_hz;
+	struct clk	*parent;
+	void            (*mode)(struct clk *clk, int status);
+	u16		users;
+};
+
+extern int clk_register(struct clk *clk);
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index bc5acb9..ba0d0a9 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_P3041_DS)    += p3041_ds.o corenet_ds.o
 obj-$(CONFIG_P3060_QDS)   += p3060_qds.o corenet_ds.o
 obj-$(CONFIG_P4080_DS)    += p4080_ds.o corenet_ds.o
 obj-$(CONFIG_P5020_DS)    += p5020_ds.o corenet_ds.o
+obj-$(CONFIG_FSL_PWM)     += pwm-clock.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
 obj-$(CONFIG_TQM85xx)	  += tqm85xx.o
 obj-$(CONFIG_SBC8560)     += sbc8560.o
diff --git a/arch/powerpc/platforms/85xx/pwm-clock.c b/arch/powerpc/platforms/85xx/pwm-clock.c
new file mode 100644
index 0000000..bba9872
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/pwm-clock.c
@@ -0,0 +1,161 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ *
+ * Implements the clk api defined in include/linux/clk.h
+ *
+ * Author: Chunhe Lan <Chunhe.Lan@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/of_platform.h>
+#include <asm/clk_interface.h>
+#include <asm/clock.h>
+
+static LIST_HEAD(clocks);
+static DEFINE_SPINLOCK(clk_lock);
+
+static struct clk pwm_clk = {
+	.name		= "pwm-clk",
+	.rate_hz	= 0,
+	.users		= 1,		/* always on */
+	.id		= 0,
+};
+
+static struct clk *all_clocks[] __initdata = {
+	&pwm_clk,
+};
+
+/* clocks cannot be de-registered no refcounting necessary */
+static struct clk *fsl_clk_get(struct device *dev, const char *id)
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
+
+static void fsl_clk_put(struct clk *clk)
+{
+}
+
+static void __clk_enable(struct clk *clk)
+{
+	if (clk->parent)
+		__clk_enable(clk->parent);
+	if (clk->users++ == 0 && clk->mode)
+		clk->mode(clk, 1);
+}
+
+static int fsl_clk_enable(struct clk *clk)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&clk_lock, flags);
+	__clk_enable(clk);
+	spin_unlock_irqrestore(&clk_lock, flags);
+
+	return 0;
+}
+
+static void __clk_disable(struct clk *clk)
+{
+	BUG_ON(clk->users == 0);
+
+	if (--clk->users == 0 && clk->mode)
+		clk->mode(clk, 0);
+	if (clk->parent)
+		__clk_disable(clk->parent);
+}
+
+static void fsl_clk_disable(struct clk *clk)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&clk_lock, flags);
+	__clk_disable(clk);
+	spin_unlock_irqrestore(&clk_lock, flags);
+}
+
+static unsigned long fsl_clk_get_rate(struct clk *clk)
+{
+	unsigned long flags;
+	unsigned long rate;
+
+	spin_lock_irqsave(&clk_lock, flags);
+	for (;;) {
+		rate = clk->rate_hz;
+		if (rate || !clk->parent)
+			break;
+		clk = clk->parent;
+	}
+	spin_unlock_irqrestore(&clk_lock, flags);
+
+	return rate;
+}
+
+static struct clk_interface fsl_clk_functions = {
+	.clk_get		= fsl_clk_get,
+	.clk_put		= fsl_clk_put,
+	.clk_enable		= fsl_clk_enable,
+	.clk_disable		= fsl_clk_disable,
+	.clk_get_rate		= fsl_clk_get_rate,
+};
+
+/* Register a new clock */
+int clk_register(struct clk *clk)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&clk_lock, flags);
+	list_add(&clk->node, &clocks);
+	spin_unlock_irqrestore(&clk_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(clk_register);
+
+static int fsl_register_clocks(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(all_clocks); i++)
+		clk_register(all_clocks[i]);
+
+	return 0;
+}
+
+static int __init fsl_clk_init(void)
+{
+	fsl_register_clocks();
+	clk_functions = fsl_clk_functions;
+
+	return 0;
+}
+
+arch_initcall(fsl_clk_init);
-- 
1.5.6.5
