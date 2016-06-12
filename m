Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rS1KN5h7pzDqfb
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jun 2016 13:16:40 +1000 (AEST)
From: Scott Wood <oss@buserror.net>
To: Russell King <linux@armlinux.org.uk>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, yuantian.tang@nxp.com, leoyang.li@nxp.com,
 xiaofeng.ren@nxp.com, Scott Wood <scottwood@freescale.com>
Date: Sat, 11 Jun 2016 22:16:25 -0500
Message-Id: <1465701386-6220-1-git-send-email-oss@buserror.net>
Subject: [RESEND PATCH 1/2] clk: Add consumer APIs for discovering possible
 parent clocks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>

Commit fc4a05d4b0eb ("clk: Remove unused provider APIs") removed
__clk_get_num_parents() and clk_hw_get_parent_by_index(), leaving only
true provider API versions that operate on struct clk_hw.

qoriq-cpufreq needs these functions in order to determine the options
it has for calling clk_set_parent() and thus populate the cpufreq
table, so revive them as legitimate consumer APIs.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Previously sent as http://patchwork.ozlabs.org/patch/519803/

Russell, could you please either ACK this or comment, as CLK API
maintainer?

 drivers/clk/clk.c   | 19 +++++++++++++++++++
 include/linux/clk.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d584004..d61a3fe 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -290,6 +290,12 @@ struct clk_hw *__clk_get_hw(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(__clk_get_hw);
 
+unsigned int clk_get_num_parents(struct clk *clk)
+{
+	return !clk ? 0 : clk->core->num_parents;
+}
+EXPORT_SYMBOL_GPL(clk_get_num_parents);
+
 unsigned int clk_hw_get_num_parents(const struct clk_hw *hw)
 {
 	return hw->core->num_parents;
@@ -358,6 +364,19 @@ static struct clk_core *clk_core_get_parent_by_index(struct clk_core *core,
 	return core->parents[index];
 }
 
+struct clk *clk_get_parent_by_index(struct clk *clk, unsigned int index)
+{
+	struct clk_core *parent;
+
+	if (!clk)
+		return NULL;
+
+	parent = clk_core_get_parent_by_index(clk->core, index);
+
+	return !parent ? NULL : parent->hw->clk;
+}
+EXPORT_SYMBOL_GPL(clk_get_parent_by_index);
+
 struct clk_hw *
 clk_hw_get_parent_by_index(const struct clk_hw *hw, unsigned int index)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 0df4a51..937de0e 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -392,6 +392,26 @@ int clk_set_parent(struct clk *clk, struct clk *parent);
 struct clk *clk_get_parent(struct clk *clk);
 
 /**
+ * clk_get_parent_by_index - get a possible parent clock by index
+ * @clk: clock source
+ * @index: index into the array of possible parents of this clock
+ *
+ * Returns struct clk corresponding to the requested possible
+ * parent clock source, or NULL.
+ */
+struct clk *clk_get_parent_by_index(struct clk *clk,
+				    unsigned int index);
+
+/**
+ * clk_get_num_parents - get number of possible parents
+ * @clk: clock source
+ *
+ * Returns the number of possible parents of this clock,
+ * which can then be enumerated using clk_get_parent_by_index().
+ */
+unsigned int clk_get_num_parents(struct clk *clk);
+
+/**
  * clk_get_sys - get a clock based upon the device name
  * @dev_id: device name
  * @con_id: connection ID
@@ -461,6 +481,17 @@ static inline struct clk *clk_get_parent(struct clk *clk)
 	return NULL;
 }
 
+struct clk *clk_get_parent_by_index(struct clk *clk,
+				    unsigned int index)
+{
+	return NULL;
+}
+
+unsigned int clk_get_num_parents(struct clk *clk)
+{
+	return 0;
+}
+
 #endif
 
 /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
-- 
2.5.0
