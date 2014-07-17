Return-Path: <tomeu.vizoso@gmail.com>
Received: from mail-we0-x236.google.com (mail-we0-x236.google.com
 [IPv6:2a00:1450:400c:c03::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B3021A01E6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 00:14:41 +1000 (EST)
Received: by mail-we0-f182.google.com with SMTP id k48so1957263wev.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 07:14:38 -0700 (PDT)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
To: Mike Turquette <mturquette@linaro.org>
Subject: [PATCH v4 6/6] clk: Add floor and ceiling constraints to clock rates
Date: Thu, 17 Jul 2014 16:13:19 +0200
Message-Id: <1405606399-26608-7-git-send-email-tomeu.vizoso@collabora.com>
In-Reply-To: <1405606399-26608-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1405606399-26608-1-git-send-email-tomeu.vizoso@collabora.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 Prashant Gaikwad <pgaikwad@nvidia.com>, Tony Lindgren <tony@atomide.com>,
 Tomasz Figa <t.figa@samsung.com>, alsa-devel@alsa-project.org,
 Jaroslav Kysela <perex@perex.cz>, Thierry Reding <thierry.reding@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Daniel Walker <dwalker@fifo99.com>, linux-arch@vger.kernel.org,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>,
 Russell King <linux@arm.linux.org.uk>,
 =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
 Takashi Iwai <tiwai@suse.de>, Michal Simek <michal.simek@xilinx.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Kevin Hilman <khilman@deeprootsystems.com>,
 linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com,
 Viresh Kumar <viresh.linux@gmail.com>, David Brown <davidb@codeaurora.org>,
 Anatolij Gustschin <agust@denx.de>, Dinh Nguyen <dinguyen@altera.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org,
 spear-devel@list.st.com, Barry Song <baohua@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org,
 Ben Dooks <ben-linux@fluff.org>, linux-tegra@vger.kernel.org,
 linux-omap@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
 Shawn Guo <shawn.guo@freescale.com>, Paul Walmsley <paul@pwsan.com>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 rabin@rab.in, Bryan Huntsman <bryanh@codeaurora.org>,
 Santosh Shilimkar <santosh.shilimkar@ti.com>,
 =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>, linux-media@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds a way for clock consumers to set maximum and minimum rates. This can be
used for thermal drivers to set ceiling rates, or by misc. drivers to set
floor rates to assure a minimum performance level.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/clk/clk.c           | 103 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk.h           |   1 +
 drivers/clk/clkdev.c        |   2 +-
 include/linux/clk-private.h |   1 +
 include/linux/clk.h         |  18 ++++++++
 5 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f1cdc01..90db677 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -23,6 +23,19 @@
 
 #include "clk.h"
 
+enum constraint_type {
+	CONSTRAINT_FLOOR,
+	CONSTRAINT_CEILING,
+};
+
+struct rate_constraint {
+	struct hlist_node	node;
+	const char		*dev_id;
+	const char		*con_id;
+	enum constraint_type	type;
+	unsigned long		rate;
+};
+
 static DEFINE_SPINLOCK(enable_lock);
 static DEFINE_MUTEX(prepare_lock);
 
@@ -1653,6 +1666,7 @@ static void clk_change_rate(struct clk_core *clk)
 int clk_provider_set_rate(struct clk_core *clk, unsigned long rate)
 {
 	struct clk_core *top, *fail_clk;
+	struct rate_constraint *constraint;
 	int ret = 0;
 
 	if (!clk)
@@ -1661,6 +1675,17 @@ int clk_provider_set_rate(struct clk_core *clk, unsigned long rate)
 	/* prevent racing with updates to the clock topology */
 	clk_prepare_lock();
 
+	hlist_for_each_entry(constraint, &clk->rate_constraints, node) {
+		switch (constraint->type) {
+		case CONSTRAINT_FLOOR:
+			rate = max(rate, constraint->rate);
+			break;
+		case CONSTRAINT_CEILING:
+			rate = min(rate, constraint->rate);
+			break;
+		}
+	}
+
 	/* bail early if nothing to do */
 	if (rate == clk_provider_get_rate(clk))
 		goto out;
@@ -1727,6 +1752,65 @@ int clk_set_rate(struct clk *clk_user, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(clk_set_rate);
 
+static struct rate_constraint *__ensure_constraint(struct clk *clk_user,
+						   enum constraint_type type)
+{
+	struct clk_core *clk = clk_to_clk_core(clk_user);
+	struct rate_constraint *constraint = NULL;
+	bool found = false;
+
+	hlist_for_each_entry(constraint, &clk->rate_constraints, node) {
+		if (constraint->dev_id == clk_user->dev_id &&
+		    constraint->con_id == clk_user->con_id &&
+		    constraint->type == type)
+			found = true;
+	}
+
+	if (!found) {
+		constraint = kzalloc(sizeof(*constraint), GFP_KERNEL);
+		if (!constraint)
+			return NULL;
+		hlist_add_head(&constraint->node, &clk->rate_constraints);
+	}
+
+	return constraint;
+}
+
+static int __clk_set_constraint(struct clk *clk_user, unsigned long rate,
+				enum constraint_type type)
+{
+	struct clk_core *clk = clk_to_clk_core(clk_user);
+	struct rate_constraint *constraint;
+	int ret;
+
+	clk_prepare_lock();
+
+	constraint = __ensure_constraint(clk_user, type);
+	if (!constraint)
+		return -ENOMEM;
+
+	constraint->rate = rate;
+
+	/* Update the rate so the new constraint is taken into account */
+	ret = clk_provider_set_rate(clk, clk_provider_get_rate(clk));
+
+	clk_prepare_unlock();
+
+	return ret;
+}
+
+int clk_set_floor_rate(struct clk *clk_user, unsigned long rate)
+{
+	return __clk_set_constraint(clk_user, rate, CONSTRAINT_FLOOR);
+}
+EXPORT_SYMBOL_GPL(clk_set_floor_rate);
+
+int clk_set_ceiling_rate(struct clk *clk_user, unsigned long rate)
+{
+	return __clk_set_constraint(clk_user, rate, CONSTRAINT_CEILING);
+}
+EXPORT_SYMBOL_GPL(clk_set_ceiling_rate);
+
 struct clk_core *clk_provider_get_parent(struct clk_core *clk)
 {
 	struct clk_core *parent;
@@ -2072,6 +2156,8 @@ int __clk_init(struct device *dev, struct clk_core *clk)
 			}
 	 }
 
+	INIT_HLIST_HEAD(&clk->rate_constraints);
+
 	/*
 	 * optional platform-specific magic
 	 *
@@ -2508,6 +2594,23 @@ int clk_notifier_unregister(struct clk *clk_user, struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(clk_notifier_unregister);
 
+void __clk_free_clk(struct clk *clk_user)
+{
+	struct clk_core *clk = clk_to_clk_core(clk_user);
+	struct rate_constraint *constraint;
+	struct hlist_node *tmp;
+
+	hlist_for_each_entry_safe(constraint, tmp, &clk->rate_constraints, node) {
+		if (constraint->dev_id == clk_user->dev_id &&
+		    constraint->con_id == clk_user->con_id) {
+			hlist_del(&constraint->node);
+			kfree(constraint);
+		}
+	}
+
+	kfree(clk_user);
+}
+
 #ifdef CONFIG_OF
 /**
  * struct of_clk_provider - Clock provider registration structure
diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index 49eff38..005deb3 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -21,4 +21,5 @@ void of_clk_unlock(void);
 #if defined(CONFIG_COMMON_CLK)
 struct clk *__clk_create_clk(struct clk_core *clk_core, const char *dev,
 			     const char *con);
+void __clk_free_clk(struct clk *clk_user);
 #endif
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 517a25b..8a6a398 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -269,7 +269,7 @@ void clk_put(struct clk *clk)
 #if defined(CONFIG_COMMON_CLK)
 	clk_core_t *core = clk_to_clk_core(clk);
 
-	kfree(clk);
+	__clk_free_clk(clk);
 	__clk_put(core);
 #else
 	__clk_put(clk);
diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
index 9657fc8..a8279e1 100644
--- a/include/linux/clk-private.h
+++ b/include/linux/clk-private.h
@@ -48,6 +48,7 @@ struct clk_core {
 	unsigned long		accuracy;
 	struct hlist_head	children;
 	struct hlist_node	child_node;
+	struct hlist_head	rate_constraints;
 	unsigned int		notifier_count;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry		*dentry;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index f46a2eb..066b100 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -275,6 +275,24 @@ long clk_round_rate(struct clk *clk, unsigned long rate);
 int clk_set_rate(struct clk *clk, unsigned long rate);
 
 /**
+ * clk_set_floor_rate - set a minimum clock rate for a clock source
+ * @clk: clock source
+ * @rate: desired minimum clock rate in Hz
+ *
+ * Returns success (0) or negative errno.
+ */
+int clk_set_floor_rate(struct clk *clk, unsigned long rate);
+
+/**
+ * clk_set_ceiling_rate - set a maximum clock rate for a clock source
+ * @clk: clock source
+ * @rate: desired maximum clock rate in Hz
+ *
+ * Returns success (0) or negative errno.
+ */
+int clk_set_ceiling_rate(struct clk *clk, unsigned long rate);
+
+/**
  * clk_set_parent - set the parent clock source for this clock
  * @clk: clock source
  * @parent: parent clock source
-- 
1.9.3
