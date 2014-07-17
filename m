Return-Path: <tomeu.vizoso@gmail.com>
Received: from mail-wg0-x22b.google.com (mail-wg0-x22b.google.com
 [IPv6:2a00:1450:400c:c00::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E20DF1A01C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 00:14:31 +1000 (EST)
Received: by mail-wg0-f43.google.com with SMTP id l18so2096285wgh.26
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 07:14:28 -0700 (PDT)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
To: Mike Turquette <mturquette@linaro.org>
Subject: [PATCH v4 5/6] clk: per-user clock accounting for debug
Date: Thu, 17 Jul 2014 16:13:18 +0200
Message-Id: <1405606399-26608-6-git-send-email-tomeu.vizoso@collabora.com>
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

When a clock has multiple users, the WARNING on imbalance of
enable/disable may not show the guilty party since although they may
have commited the error earlier, the warning is emitted later when some
other user, presumably innocent, disables the clock.

Provide per-user clock enable/disable accounting and disabler tracking
in order to help debug these problems.

Based on previous work by Rabin Vincent <rabin@rab.in>.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/clk/clk.c           | 38 ++++++++++++++++++++++++++++++++++----
 drivers/clk/clk.h           |  3 ++-
 drivers/clk/clkdev.c        | 12 ++++++++----
 include/linux/clk-private.h |  4 ++++
 4 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 095edaa..f1cdc01 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -568,7 +568,8 @@ static int clk_disable_unused(void)
 }
 late_initcall_sync(clk_disable_unused);
 
-struct clk *__clk_create_clk(struct clk_core *clk_core)
+struct clk *__clk_create_clk(struct clk_core *clk_core, const char *dev,
+			     const char *con)
 {
 	struct clk *clk;
 
@@ -581,6 +582,8 @@ struct clk *__clk_create_clk(struct clk_core *clk_core)
 		return ERR_PTR(-ENOMEM);
 
 	clk->core = clk_core;
+	clk->dev_id = dev;
+	clk->con_id = con;
 
 	return clk;
 }
@@ -961,10 +964,25 @@ EXPORT_SYMBOL_GPL(clk_provider_disable);
  */
 void clk_disable(struct clk *clk_user)
 {
+	struct clk_core *clk;
+	unsigned long flags;
+
 	if (IS_ERR_OR_NULL(clk_user))
 		return;
 
-	clk_provider_disable(clk_to_clk_core(clk_user));
+	clk = clk_to_clk_core(clk_user);
+
+	flags = clk_enable_lock();
+	if (!WARN(clk_user->enable_count == 0,
+		  "incorrect disable clk dev %s con %s last disabler %pF\n",
+		  clk_user->dev_id, clk_user->con_id, clk_user->last_disable)) {
+
+		clk_user->last_disable = __builtin_return_address(0);
+		clk_user->enable_count--;
+
+		__clk_disable(clk);
+	}
+	clk_enable_unlock(flags);
 }
 EXPORT_SYMBOL_GPL(clk_disable);
 
@@ -1025,10 +1043,22 @@ EXPORT_SYMBOL_GPL(clk_provider_enable);
  */
 int clk_enable(struct clk *clk_user)
 {
+	struct clk_core *clk;
+	unsigned long flags;
+	int ret;
+
 	if (!clk_user)
 		return 0;
 
-	return clk_provider_enable(clk_to_clk_core(clk_user));
+	clk = clk_to_clk_core(clk_user);
+
+	flags = clk_enable_lock();
+	ret = __clk_enable(clk);
+	if (!ret)
+		clk_user->enable_count++;
+	clk_enable_unlock(flags);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(clk_enable);
 
@@ -1726,7 +1756,7 @@ struct clk *clk_get_parent(struct clk *clk_user)
 	clk = clk_to_clk_core(clk_user);
 	parent = clk_provider_get_parent(clk);
 
-	return __clk_create_clk(parent);
+	return __clk_create_clk(parent, clk_user->dev_id, clk_user->con_id);
 }
 EXPORT_SYMBOL_GPL(clk_get_parent);
 
diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index 3b3068b..49eff38 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -19,5 +19,6 @@ void of_clk_unlock(void);
 #endif
 
 #if defined(CONFIG_COMMON_CLK)
-struct clk *__clk_create_clk(struct clk_core *clk_core);
+struct clk *__clk_create_clk(struct clk_core *clk_core, const char *dev,
+			     const char *con);
 #endif
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 912de48..517a25b 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -76,7 +76,9 @@ struct clk_core *of_clk_provider_get(struct device_node *np, int index)
 
 struct clk *of_clk_get(struct device_node *np, int index)
 {
-	return __clk_create_clk(of_clk_provider_get(np, index));
+	struct clk_core *clk = of_clk_provider_get(np, index);
+
+	return __clk_create_clk(clk, np->full_name, NULL);
 }
 EXPORT_SYMBOL(of_clk_get);
 
@@ -128,7 +130,9 @@ struct clk_core *of_clk_provider_get_by_name(struct device_node *np, const char
  */
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
 {
-	return __clk_create_clk(of_clk_provider_get_by_name(np, name));
+	struct clk_core *clk = of_clk_provider_get_by_name(np, name);
+
+	return __clk_create_clk(clk, np->full_name, NULL);
 }
 EXPORT_SYMBOL(of_clk_get_by_name);
 #endif
@@ -200,7 +204,7 @@ struct clk *clk_get_sys(const char *dev_id, const char *con_id)
 #if defined(CONFIG_COMMON_CLK)
 	struct clk_core *clk = clk_provider_get_sys(dev_id, con_id);
 
-	return __clk_create_clk(clk);
+	return __clk_create_clk(clk, dev_id, con_id);
 #else
 	struct clk_lookup *cl;
 
@@ -242,7 +246,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 #if defined(CONFIG_COMMON_CLK)
 	const char *dev_id = dev ? dev_name(dev) : NULL;
 
-	return __clk_create_clk(clk_provider_get(dev, con_id));
+	return __clk_create_clk(clk_provider_get(dev, con_id), dev_id, con_id);
 #else
 	const char *dev_id = dev ? dev_name(dev) : NULL;
 	struct clk *clk;
diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
index 2c1ece9..9657fc8 100644
--- a/include/linux/clk-private.h
+++ b/include/linux/clk-private.h
@@ -57,6 +57,10 @@ struct clk_core {
 
 struct clk {
 	struct clk_core	*core;
+	unsigned int	enable_count;
+	const char	*dev_id;
+	const char	*con_id;
+	void		*last_disable;
 };
 
 /*
-- 
1.9.3
