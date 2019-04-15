Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9799FC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:26:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 159B42075B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIlJe2iO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159B42075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jPmJ6QhmzDqH6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 20:26:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="PIlJe2iO"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jPR164fXzDqG0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 20:11:09 +1000 (AEST)
Received: by mail-wr1-x443.google.com with SMTP id y7so21104575wrn.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 03:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NL96trJbiwYCBdqnquCsPKm1HUfK4513ScI5kVI9UD8=;
 b=PIlJe2iOhXwvyxtXNx0Or4odI/mFDMxzmnrNfovensv1XvcqjKcZh/wuhKn28gFGOS
 ftumgTRmAW4nh+j7IDu318XOGA4kIFbFWoy0hCJ+XUgn6sb3vHGwSwcIRXDWfHscx0QX
 cfOYh5EPfF6sCO3XugPwXuw2nvBE+ieAkTKrNzLdLkp48bGiI3bpTFC1zlY5UCwZSMVh
 R8RlHWMhlFmKV0b7sKbgHIhu8ZOJAO1szJM6hcgF3jBqlctfS1o9LM+v3WESprq634aA
 +O+fihtjJt9azIvQh3p+DgrEoKJJ1EnUi42rJC19uAcHZnIDG8fj1SpEe3BlxwjETlkv
 XiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=NL96trJbiwYCBdqnquCsPKm1HUfK4513ScI5kVI9UD8=;
 b=hjxly55wrUeIu9iESovUwoWHlnnDQTXiGVadCmumHq9VTGLoTgPt2nv5T3TC7+yxFk
 VdLPA4J7HFXNeei6K0Vxx9JA7DkpeNcuRjxzLuniNB3Ab5z/x0Jgyrxs2hIYHC0uw3Nz
 +ASRx8NwuXYKHEEKE9GjsuZ2pXkhCb614tk9CZaBIKDa6Qf7OwI1hh4cWxJVYaLT1OmB
 VFw19oF5sDqJwrkFTKNO6AWd+G287TEJP+k3zZWJ5gElkAZGmJbQJ1+rn17lyLE/PXA2
 uvEYRlLxqck/VhS/hA1ThBmbm2f86HpepR6875oGdHyZ8DassNoqDe+ad+aEq+LYaTqM
 YcTA==
X-Gm-Message-State: APjAAAXnfFBZYIDp6uEQpRgmaaM4lgp34mPBGO8mAu42hEqXWyp0/9aQ
 oWb8kxIizOjWdqquaIFxoRQ=
X-Google-Smtp-Source: APXvYqwlhiXEcQf7qfIC0HInLTEYTS6FRF6Wi4NVfwfUY1rWDTwJ8PH1PbpnikjHSQLQkx9p/iqcAg==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr41212394wro.2.1555323066409; 
 Mon, 15 Apr 2019 03:11:06 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id d6sm11592214wrp.9.2019.04.15.03.11.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Apr 2019 03:11:05 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org
Subject: [PATCH RFT V2 8/8] clk: core: replace clk_{readl, writel} with {readl,
 writel}
Date: Mon, 15 Apr 2019 12:10:46 +0200
Message-Id: <20190415101046.5872-9-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20190415101046.5872-1-jonas.gorski@gmail.com>
References: <20190415101046.5872-1-jonas.gorski@gmail.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>,
 Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Michal Simek <michal.simek@xilinx.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>, Paul Mackerras <paulus@samba.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Now that clk_{readl,writel} is just an alias for {readl,writel}, we can
switch all users of clk_* to use the accessors directly and remove the
helpers.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
V1 -> V2:
 * newly added patch

 drivers/clk/clk-divider.c               |  4 ++--
 drivers/clk/clk-fractional-divider.c    |  4 ++--
 drivers/clk/clk-gate.c                  |  4 ++--
 drivers/clk/clk-multiplier.c            |  4 ++--
 drivers/clk/clk-mux.c                   |  4 ++--
 drivers/clk/clk-xgene.c                 |  6 +++---
 drivers/clk/hisilicon/clk-hisi-phase.c  |  4 ++--
 drivers/clk/imx/clk-divider-gate.c      | 20 ++++++++++----------
 drivers/clk/imx/clk-sccg-pll.c          | 12 ++++++------
 drivers/clk/nxp/clk-lpc18xx-ccu.c       |  6 +++---
 drivers/clk/nxp/clk-lpc18xx-cgu.c       | 24 ++++++++++++------------
 drivers/clk/rockchip/clk-ddr.c          |  2 +-
 drivers/clk/rockchip/clk-half-divider.c |  6 +++---
 drivers/clk/tegra/clk-tegra124.c        |  4 ++--
 drivers/clk/tegra/clk-tegra210.c        |  6 +++---
 drivers/clk/zynq/clkc.c                 |  6 +++---
 drivers/clk/zynq/pll.c                  | 18 +++++++++---------
 include/linux/clk-provider.h            | 15 ---------------
 18 files changed, 67 insertions(+), 82 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index ff791a7a5e9e..bb49dbf05a64 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -30,7 +30,7 @@ static inline u32 clk_div_readl(struct clk_divider *divider)
 	if (divider->flags & CLK_DIVIDER_BIG_ENDIAN)
 		return ioread32be(divider->reg);
 	else
-		return clk_readl(divider->reg);
+		return readl(divider->reg);
 }
 
 static inline void clk_div_writel(struct clk_divider *divider, u32 val)
@@ -38,7 +38,7 @@ static inline void clk_div_writel(struct clk_divider *divider, u32 val)
 	if (divider->flags & CLK_DIVIDER_BIG_ENDIAN)
 		iowrite32be(val, divider->reg);
 	else
-		clk_writel(val, divider->reg);
+		writel(val, divider->reg);
 }
 
 #define div_mask(width)	((1 << (width)) - 1)
diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index b9988d3b3828..99133554466f 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -18,7 +18,7 @@ static inline u32 clk_fd_readl(struct clk_fractional_divider *fd)
 	if (fd->flags & CLK_FRAC_DIVIDER_BIG_ENDIAN)
 		return ioread32be(fd->reg);
 	else
-		return clk_readl(fd->reg);
+		return readl(fd->reg);
 }
 
 static inline void clk_fd_writel(struct clk_fractional_divider *fd, u32 val)
@@ -26,7 +26,7 @@ static inline void clk_fd_writel(struct clk_fractional_divider *fd, u32 val)
 	if (fd->flags & CLK_FRAC_DIVIDER_BIG_ENDIAN)
 		iowrite32be(val, fd->reg);
 	else
-		clk_writel(val, fd->reg);
+		writel(val, fd->reg);
 }
 
 static unsigned long clk_fd_recalc_rate(struct clk_hw *hw,
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 521e112ef5b5..bd201eaa99df 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -28,7 +28,7 @@ static inline u32 clk_gate_readl(struct clk_gate *gate)
 	if (gate->flags & CLK_GATE_BIG_ENDIAN)
 		return ioread32be(gate->reg);
 	else
-		return clk_readl(gate->reg);
+		return readl(gate->reg);
 }
 
 static inline void clk_gate_writel(struct clk_gate *gate, u32 val)
@@ -36,7 +36,7 @@ static inline void clk_gate_writel(struct clk_gate *gate, u32 val)
 	if (gate->flags & CLK_GATE_BIG_ENDIAN)
 		iowrite32be(val, gate->reg);
 	else
-		clk_writel(val, gate->reg);
+		writel(val, gate->reg);
 }
 
 /*
diff --git a/drivers/clk/clk-multiplier.c b/drivers/clk/clk-multiplier.c
index fb032f7dd407..a433442a1fa6 100644
--- a/drivers/clk/clk-multiplier.c
+++ b/drivers/clk/clk-multiplier.c
@@ -16,7 +16,7 @@ static inline u32 clk_mult_readl(struct clk_multiplier *mult)
 	if (mult->flags & CLK_MULTIPLIER_BIG_ENDIAN)
 		return ioread32be(mult->reg);
 	else
-		return clk_readl(mult->reg);
+		return readl(mult->reg);
 }
 
 static inline void clk_mult_writel(struct clk_multiplier *mult, u32 val)
@@ -24,7 +24,7 @@ static inline void clk_mult_writel(struct clk_multiplier *mult, u32 val)
 	if (mult->flags & CLK_MULTIPLIER_BIG_ENDIAN)
 		iowrite32be(val, mult->reg);
 	else
-		clk_writel(val, mult->reg);
+		writel(val, mult->reg);
 }
 
 static unsigned long __get_mult(struct clk_multiplier *mult,
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 47f6f4f55f08..9ae3a4c17ed5 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -28,7 +28,7 @@ static inline u32 clk_mux_readl(struct clk_mux *mux)
 	if (mux->flags & CLK_MUX_BIG_ENDIAN)
 		return ioread32be(mux->reg);
 	else
-		return clk_readl(mux->reg);
+		return readl(mux->reg);
 }
 
 static inline void clk_mux_writel(struct clk_mux *mux, u32 val)
@@ -36,7 +36,7 @@ static inline void clk_mux_writel(struct clk_mux *mux, u32 val)
 	if (mux->flags & CLK_MUX_BIG_ENDIAN)
 		iowrite32be(val, mux->reg);
 	else
-		clk_writel(val, mux->reg);
+		writel(val, mux->reg);
 }
 
 int clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int flags,
diff --git a/drivers/clk/clk-xgene.c b/drivers/clk/clk-xgene.c
index 531b030d4d4e..d975465fe2a8 100644
--- a/drivers/clk/clk-xgene.c
+++ b/drivers/clk/clk-xgene.c
@@ -262,7 +262,7 @@ static unsigned long xgene_clk_pmd_recalc_rate(struct clk_hw *hw,
 	else
 		__acquire(fd->lock);
 
-	val = clk_readl(fd->reg);
+	val = readl(fd->reg);
 
 	if (fd->lock)
 		spin_unlock_irqrestore(fd->lock, flags);
@@ -333,10 +333,10 @@ static int xgene_clk_pmd_set_rate(struct clk_hw *hw, unsigned long rate,
 	else
 		__acquire(fd->lock);
 
-	val = clk_readl(fd->reg);
+	val = readl(fd->reg);
 	val &= ~fd->mask;
 	val |= (scale << fd->shift);
-	clk_writel(val, fd->reg);
+	writel(val, fd->reg);
 
 	if (fd->lock)
 		spin_unlock_irqrestore(fd->lock, flags);
diff --git a/drivers/clk/hisilicon/clk-hisi-phase.c b/drivers/clk/hisilicon/clk-hisi-phase.c
index 5fdc267bb2da..ba6afad66a2b 100644
--- a/drivers/clk/hisilicon/clk-hisi-phase.c
+++ b/drivers/clk/hisilicon/clk-hisi-phase.c
@@ -75,10 +75,10 @@ static int hisi_clk_set_phase(struct clk_hw *hw, int degrees)
 
 	spin_lock_irqsave(phase->lock, flags);
 
-	val = clk_readl(phase->reg);
+	val = readl(phase->reg);
 	val &= ~phase->mask;
 	val |= regval << phase->shift;
-	clk_writel(val, phase->reg);
+	writel(val, phase->reg);
 
 	spin_unlock_irqrestore(phase->lock, flags);
 
diff --git a/drivers/clk/imx/clk-divider-gate.c b/drivers/clk/imx/clk-divider-gate.c
index df1f8429fe16..2a8352a316c7 100644
--- a/drivers/clk/imx/clk-divider-gate.c
+++ b/drivers/clk/imx/clk-divider-gate.c
@@ -29,7 +29,7 @@ static unsigned long clk_divider_gate_recalc_rate_ro(struct clk_hw *hw,
 	struct clk_divider *div = to_clk_divider(hw);
 	unsigned int val;
 
-	val = clk_readl(div->reg) >> div->shift;
+	val = readl(div->reg) >> div->shift;
 	val &= clk_div_mask(div->width);
 	if (!val)
 		return 0;
@@ -51,7 +51,7 @@ static unsigned long clk_divider_gate_recalc_rate(struct clk_hw *hw,
 	if (!clk_hw_is_enabled(hw)) {
 		val = div_gate->cached_val;
 	} else {
-		val = clk_readl(div->reg) >> div->shift;
+		val = readl(div->reg) >> div->shift;
 		val &= clk_div_mask(div->width);
 	}
 
@@ -87,10 +87,10 @@ static int clk_divider_gate_set_rate(struct clk_hw *hw, unsigned long rate,
 	spin_lock_irqsave(div->lock, flags);
 
 	if (clk_hw_is_enabled(hw)) {
-		val = clk_readl(div->reg);
+		val = readl(div->reg);
 		val &= ~(clk_div_mask(div->width) << div->shift);
 		val |= (u32)value << div->shift;
-		clk_writel(val, div->reg);
+		writel(val, div->reg);
 	} else {
 		div_gate->cached_val = value;
 	}
@@ -114,9 +114,9 @@ static int clk_divider_enable(struct clk_hw *hw)
 
 	spin_lock_irqsave(div->lock, flags);
 	/* restore div val */
-	val = clk_readl(div->reg);
+	val = readl(div->reg);
 	val |= div_gate->cached_val << div->shift;
-	clk_writel(val, div->reg);
+	writel(val, div->reg);
 
 	spin_unlock_irqrestore(div->lock, flags);
 
@@ -133,10 +133,10 @@ static void clk_divider_disable(struct clk_hw *hw)
 	spin_lock_irqsave(div->lock, flags);
 
 	/* store the current div val */
-	val = clk_readl(div->reg) >> div->shift;
+	val = readl(div->reg) >> div->shift;
 	val &= clk_div_mask(div->width);
 	div_gate->cached_val = val;
-	clk_writel(0, div->reg);
+	writel(0, div->reg);
 
 	spin_unlock_irqrestore(div->lock, flags);
 }
@@ -146,7 +146,7 @@ static int clk_divider_is_enabled(struct clk_hw *hw)
 	struct clk_divider *div = to_clk_divider(hw);
 	u32 val;
 
-	val = clk_readl(div->reg) >> div->shift;
+	val = readl(div->reg) >> div->shift;
 	val &= clk_div_mask(div->width);
 
 	return val ? 1 : 0;
@@ -206,7 +206,7 @@ struct clk_hw *imx_clk_divider_gate(const char *name, const char *parent_name,
 	div_gate->divider.hw.init = &init;
 	div_gate->divider.flags = CLK_DIVIDER_ONE_BASED | clk_divider_flags;
 	/* cache gate status */
-	val = clk_readl(reg) >> shift;
+	val = readl(reg) >> shift;
 	val &= clk_div_mask(width);
 	div_gate->cached_val = val;
 
diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-pll.c
index 9dfd03a95557..991bbe63f156 100644
--- a/drivers/clk/imx/clk-sccg-pll.c
+++ b/drivers/clk/imx/clk-sccg-pll.c
@@ -348,7 +348,7 @@ static unsigned long clk_sccg_pll_recalc_rate(struct clk_hw *hw,
 
 	temp64 = parent_rate;
 
-	val = clk_readl(pll->base + PLL_CFG0);
+	val = readl(pll->base + PLL_CFG0);
 	if (val & SSCG_PLL_BYPASS2_MASK) {
 		temp64 = parent_rate;
 	} else if (val & SSCG_PLL_BYPASS1_MASK) {
@@ -371,10 +371,10 @@ static int clk_sccg_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	u32 val;
 
 	/* set bypass here too since the parent might be the same */
-	val = clk_readl(pll->base + PLL_CFG0);
+	val = readl(pll->base + PLL_CFG0);
 	val &= ~SSCG_PLL_BYPASS_MASK;
 	val |= FIELD_PREP(SSCG_PLL_BYPASS_MASK, setup->bypass);
-	clk_writel(val, pll->base + PLL_CFG0);
+	writel(val, pll->base + PLL_CFG0);
 
 	val = readl_relaxed(pll->base + PLL_CFG2);
 	val &= ~(PLL_DIVF1_MASK | PLL_DIVF2_MASK);
@@ -395,7 +395,7 @@ static u8 clk_sccg_pll_get_parent(struct clk_hw *hw)
 	u32 val;
 	u8 ret = pll->parent;
 
-	val = clk_readl(pll->base + PLL_CFG0);
+	val = readl(pll->base + PLL_CFG0);
 	if (val & SSCG_PLL_BYPASS2_MASK)
 		ret = pll->bypass2;
 	else if (val & SSCG_PLL_BYPASS1_MASK)
@@ -408,10 +408,10 @@ static int clk_sccg_pll_set_parent(struct clk_hw *hw, u8 index)
 	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
 	u32 val;
 
-	val = clk_readl(pll->base + PLL_CFG0);
+	val = readl(pll->base + PLL_CFG0);
 	val &= ~SSCG_PLL_BYPASS_MASK;
 	val |= FIELD_PREP(SSCG_PLL_BYPASS_MASK, pll->setup.bypass);
-	clk_writel(val, pll->base + PLL_CFG0);
+	writel(val, pll->base + PLL_CFG0);
 
 	return clk_sccg_pll_wait_lock(pll);
 }
diff --git a/drivers/clk/nxp/clk-lpc18xx-ccu.c b/drivers/clk/nxp/clk-lpc18xx-ccu.c
index 27781b49eb82..5969f620607a 100644
--- a/drivers/clk/nxp/clk-lpc18xx-ccu.c
+++ b/drivers/clk/nxp/clk-lpc18xx-ccu.c
@@ -142,7 +142,7 @@ static int lpc18xx_ccu_gate_endisable(struct clk_hw *hw, bool enable)
 	 * Divider field is write only, so divider stat field must
 	 * be read so divider field can be set accordingly.
 	 */
-	val = clk_readl(gate->reg);
+	val = readl(gate->reg);
 	if (val & LPC18XX_CCU_DIVSTAT)
 		val |= LPC18XX_CCU_DIV;
 
@@ -155,12 +155,12 @@ static int lpc18xx_ccu_gate_endisable(struct clk_hw *hw, bool enable)
 		 * and the next write should clear the RUN bit.
 		 */
 		val |= LPC18XX_CCU_AUTO;
-		clk_writel(val, gate->reg);
+		writel(val, gate->reg);
 
 		val &= ~LPC18XX_CCU_RUN;
 	}
 
-	clk_writel(val, gate->reg);
+	writel(val, gate->reg);
 
 	return 0;
 }
diff --git a/drivers/clk/nxp/clk-lpc18xx-cgu.c b/drivers/clk/nxp/clk-lpc18xx-cgu.c
index 2531174b399e..f5bc8bd192b7 100644
--- a/drivers/clk/nxp/clk-lpc18xx-cgu.c
+++ b/drivers/clk/nxp/clk-lpc18xx-cgu.c
@@ -352,9 +352,9 @@ static unsigned long lpc18xx_pll0_recalc_rate(struct clk_hw *hw,
 	struct lpc18xx_pll *pll = to_lpc_pll(hw);
 	u32 ctrl, mdiv, msel, npdiv;
 
-	ctrl = clk_readl(pll->reg + LPC18XX_CGU_PLL0USB_CTRL);
-	mdiv = clk_readl(pll->reg + LPC18XX_CGU_PLL0USB_MDIV);
-	npdiv = clk_readl(pll->reg + LPC18XX_CGU_PLL0USB_NP_DIV);
+	ctrl = readl(pll->reg + LPC18XX_CGU_PLL0USB_CTRL);
+	mdiv = readl(pll->reg + LPC18XX_CGU_PLL0USB_MDIV);
+	npdiv = readl(pll->reg + LPC18XX_CGU_PLL0USB_NP_DIV);
 
 	if (ctrl & LPC18XX_PLL0_CTRL_BYPASS)
 		return parent_rate;
@@ -415,25 +415,25 @@ static int lpc18xx_pll0_set_rate(struct clk_hw *hw, unsigned long rate,
 	m |= lpc18xx_pll0_msel2seli(m) << LPC18XX_PLL0_MDIV_SELI_SHIFT;
 
 	/* Power down PLL, disable clk output and dividers */
-	ctrl = clk_readl(pll->reg + LPC18XX_CGU_PLL0USB_CTRL);
+	ctrl = readl(pll->reg + LPC18XX_CGU_PLL0USB_CTRL);
 	ctrl |= LPC18XX_PLL0_CTRL_PD;
 	ctrl &= ~(LPC18XX_PLL0_CTRL_BYPASS | LPC18XX_PLL0_CTRL_DIRECTI |
 		  LPC18XX_PLL0_CTRL_DIRECTO | LPC18XX_PLL0_CTRL_CLKEN);
-	clk_writel(ctrl, pll->reg + LPC18XX_CGU_PLL0USB_CTRL);
+	writel(ctrl, pll->reg + LPC18XX_CGU_PLL0USB_CTRL);
 
 	/* Configure new PLL settings */
-	clk_writel(m, pll->reg + LPC18XX_CGU_PLL0USB_MDIV);
-	clk_writel(LPC18XX_PLL0_NP_DIVS_1, pll->reg + LPC18XX_CGU_PLL0USB_NP_DIV);
+	writel(m, pll->reg + LPC18XX_CGU_PLL0USB_MDIV);
+	writel(LPC18XX_PLL0_NP_DIVS_1, pll->reg + LPC18XX_CGU_PLL0USB_NP_DIV);
 
 	/* Power up PLL and wait for lock */
 	ctrl &= ~LPC18XX_PLL0_CTRL_PD;
-	clk_writel(ctrl, pll->reg + LPC18XX_CGU_PLL0USB_CTRL);
+	writel(ctrl, pll->reg + LPC18XX_CGU_PLL0USB_CTRL);
 	do {
 		udelay(10);
-		stat = clk_readl(pll->reg + LPC18XX_CGU_PLL0USB_STAT);
+		stat = readl(pll->reg + LPC18XX_CGU_PLL0USB_STAT);
 		if (stat & LPC18XX_PLL0_STAT_LOCK) {
 			ctrl |= LPC18XX_PLL0_CTRL_CLKEN;
-			clk_writel(ctrl, pll->reg + LPC18XX_CGU_PLL0USB_CTRL);
+			writel(ctrl, pll->reg + LPC18XX_CGU_PLL0USB_CTRL);
 
 			return 0;
 		}
@@ -458,8 +458,8 @@ static unsigned long lpc18xx_pll1_recalc_rate(struct clk_hw *hw,
 	bool direct, fbsel;
 	u32 stat, ctrl;
 
-	stat = clk_readl(pll->reg + LPC18XX_CGU_PLL1_STAT);
-	ctrl = clk_readl(pll->reg + LPC18XX_CGU_PLL1_CTRL);
+	stat = readl(pll->reg + LPC18XX_CGU_PLL1_STAT);
+	ctrl = readl(pll->reg + LPC18XX_CGU_PLL1_CTRL);
 
 	direct = (ctrl & LPC18XX_PLL1_CTRL_DIRECT) ? true : false;
 	fbsel = (ctrl & LPC18XX_PLL1_CTRL_FBSEL) ? true : false;
diff --git a/drivers/clk/rockchip/clk-ddr.c b/drivers/clk/rockchip/clk-ddr.c
index ebce5260068b..09ede6920593 100644
--- a/drivers/clk/rockchip/clk-ddr.c
+++ b/drivers/clk/rockchip/clk-ddr.c
@@ -82,7 +82,7 @@ static u8 rockchip_ddrclk_get_parent(struct clk_hw *hw)
 	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
 	u32 val;
 
-	val = clk_readl(ddrclk->reg_base +
+	val = readl(ddrclk->reg_base +
 			ddrclk->mux_offset) >> ddrclk->mux_shift;
 	val &= GENMASK(ddrclk->mux_width - 1, 0);
 
diff --git a/drivers/clk/rockchip/clk-half-divider.c b/drivers/clk/rockchip/clk-half-divider.c
index b8da6e799423..784b81e1ea7c 100644
--- a/drivers/clk/rockchip/clk-half-divider.c
+++ b/drivers/clk/rockchip/clk-half-divider.c
@@ -24,7 +24,7 @@ static unsigned long clk_half_divider_recalc_rate(struct clk_hw *hw,
 	struct clk_divider *divider = to_clk_divider(hw);
 	unsigned int val;
 
-	val = clk_readl(divider->reg) >> divider->shift;
+	val = readl(divider->reg) >> divider->shift;
 	val &= div_mask(divider->width);
 	val = val * 2 + 3;
 
@@ -124,11 +124,11 @@ static int clk_half_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
 		val = div_mask(divider->width) << (divider->shift + 16);
 	} else {
-		val = clk_readl(divider->reg);
+		val = readl(divider->reg);
 		val &= ~(div_mask(divider->width) << divider->shift);
 	}
 	val |= value << divider->shift;
-	clk_writel(val, divider->reg);
+	writel(val, divider->reg);
 
 	if (divider->lock)
 		spin_unlock_irqrestore(divider->lock, flags);
diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index df0018f7bf7e..abc0c4bea740 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -1466,9 +1466,9 @@ static void __init tegra124_132_clock_init_pre(struct device_node *np)
 	tegra_pmc_clk_init(pmc_base, tegra124_clks);
 
 	/* For Tegra124 & Tegra132, PLLD is the only source for DSIA & DSIB */
-	plld_base = clk_readl(clk_base + PLLD_BASE);
+	plld_base = readl(clk_base + PLLD_BASE);
 	plld_base &= ~BIT(25);
-	clk_writel(plld_base, clk_base + PLLD_BASE);
+	writel(plld_base, clk_base + PLLD_BASE);
 }
 
 /**
diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index 7545af763d7a..ed3c7df75d1e 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -3557,7 +3557,7 @@ static void __init tegra210_clock_init(struct device_node *np)
 	if (!clks)
 		return;
 
-	value = clk_readl(clk_base + SPARE_REG0) >> CLK_M_DIVISOR_SHIFT;
+	value = readl(clk_base + SPARE_REG0) >> CLK_M_DIVISOR_SHIFT;
 	clk_m_div = (value & CLK_M_DIVISOR_MASK) + 1;
 
 	if (tegra_osc_clk_init(clk_base, tegra210_clks, tegra210_input_freq,
@@ -3574,9 +3574,9 @@ static void __init tegra210_clock_init(struct device_node *np)
 	tegra_pmc_clk_init(pmc_base, tegra210_clks);
 
 	/* For Tegra210, PLLD is the only source for DSIA & DSIB */
-	value = clk_readl(clk_base + PLLD_BASE);
+	value = readl(clk_base + PLLD_BASE);
 	value &= ~BIT(25);
-	clk_writel(value, clk_base + PLLD_BASE);
+	writel(value, clk_base + PLLD_BASE);
 
 	tegra_clk_apply_init_table = tegra210_clock_apply_init_table;
 
diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index d7b53ac8ad11..4b9d5c14c400 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -158,7 +158,7 @@ static void __init zynq_clk_register_fclk(enum zynq_clk fclk,
 	clks[fclk] = clk_register_gate(NULL, clk_name,
 			div1_name, CLK_SET_RATE_PARENT, fclk_gate_reg,
 			0, CLK_GATE_SET_TO_DISABLE, fclk_gate_lock);
-	enable_reg = clk_readl(fclk_gate_reg) & 1;
+	enable_reg = readl(fclk_gate_reg) & 1;
 	if (enable && !enable_reg) {
 		if (clk_prepare_enable(clks[fclk]))
 			pr_warn("%s: FCLK%u enable failed\n", __func__,
@@ -287,7 +287,7 @@ static void __init zynq_clk_setup(struct device_node *np)
 			SLCR_IOPLL_CTRL, 4, 1, 0, &iopll_lock);
 
 	/* CPU clocks */
-	tmp = clk_readl(SLCR_621_TRUE) & 1;
+	tmp = readl(SLCR_621_TRUE) & 1;
 	clk = clk_register_mux(NULL, "cpu_mux", cpu_parents, 4,
 			CLK_SET_RATE_NO_REPARENT, SLCR_ARM_CLK_CTRL, 4, 2, 0,
 			&armclk_lock);
@@ -510,7 +510,7 @@ static void __init zynq_clk_setup(struct device_node *np)
 			&dbgclk_lock);
 
 	/* leave debug clocks in the state the bootloader set them up to */
-	tmp = clk_readl(SLCR_DBG_CLK_CTRL);
+	tmp = readl(SLCR_DBG_CLK_CTRL);
 	if (tmp & DBG_CLK_CTRL_CLKACT_TRC)
 		if (clk_prepare_enable(clks[dbg_trc]))
 			pr_warn("%s: trace clk enable failed\n", __func__);
diff --git a/drivers/clk/zynq/pll.c b/drivers/clk/zynq/pll.c
index 00d72fb5c036..800b70ee19b3 100644
--- a/drivers/clk/zynq/pll.c
+++ b/drivers/clk/zynq/pll.c
@@ -90,7 +90,7 @@ static unsigned long zynq_pll_recalc_rate(struct clk_hw *hw,
 	 * makes probably sense to redundantly save fbdiv in the struct
 	 * zynq_pll to save the IO access.
 	 */
-	fbdiv = (clk_readl(clk->pll_ctrl) & PLLCTRL_FBDIV_MASK) >>
+	fbdiv = (readl(clk->pll_ctrl) & PLLCTRL_FBDIV_MASK) >>
 			PLLCTRL_FBDIV_SHIFT;
 
 	return parent_rate * fbdiv;
@@ -112,7 +112,7 @@ static int zynq_pll_is_enabled(struct clk_hw *hw)
 
 	spin_lock_irqsave(clk->lock, flags);
 
-	reg = clk_readl(clk->pll_ctrl);
+	reg = readl(clk->pll_ctrl);
 
 	spin_unlock_irqrestore(clk->lock, flags);
 
@@ -138,10 +138,10 @@ static int zynq_pll_enable(struct clk_hw *hw)
 	/* Power up PLL and wait for lock */
 	spin_lock_irqsave(clk->lock, flags);
 
-	reg = clk_readl(clk->pll_ctrl);
+	reg = readl(clk->pll_ctrl);
 	reg &= ~(PLLCTRL_RESET_MASK | PLLCTRL_PWRDWN_MASK);
-	clk_writel(reg, clk->pll_ctrl);
-	while (!(clk_readl(clk->pll_status) & (1 << clk->lockbit)))
+	writel(reg, clk->pll_ctrl);
+	while (!(readl(clk->pll_status) & (1 << clk->lockbit)))
 		;
 
 	spin_unlock_irqrestore(clk->lock, flags);
@@ -168,9 +168,9 @@ static void zynq_pll_disable(struct clk_hw *hw)
 	/* shut down PLL */
 	spin_lock_irqsave(clk->lock, flags);
 
-	reg = clk_readl(clk->pll_ctrl);
+	reg = readl(clk->pll_ctrl);
 	reg |= PLLCTRL_RESET_MASK | PLLCTRL_PWRDWN_MASK;
-	clk_writel(reg, clk->pll_ctrl);
+	writel(reg, clk->pll_ctrl);
 
 	spin_unlock_irqrestore(clk->lock, flags);
 }
@@ -223,9 +223,9 @@ struct clk *clk_register_zynq_pll(const char *name, const char *parent,
 
 	spin_lock_irqsave(pll->lock, flags);
 
-	reg = clk_readl(pll->pll_ctrl);
+	reg = readl(pll->pll_ctrl);
 	reg &= ~PLLCTRL_BPQUAL_MASK;
-	clk_writel(reg, pll->pll_ctrl);
+	writel(reg, pll->pll_ctrl);
 
 	spin_unlock_irqrestore(pll->lock, flags);
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 479e616ce7f5..46d5fc3057b5 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -996,21 +996,6 @@ static inline int of_clk_detect_critical(struct device_node *np, int index,
 }
 #endif /* CONFIG_OF */
 
-/*
- * wrap access to peripherals in accessor routines
- * for improved portability across platforms
- */
-
-static inline u32 clk_readl(u32 __iomem *reg)
-{
-	return readl(reg);
-}
-
-static inline void clk_writel(u32 val, u32 __iomem *reg)
-{
-	writel(val, reg);
-}
-
 void clk_gate_restore_context(struct clk_hw *hw);
 
 #endif /* CONFIG_COMMON_CLK */
-- 
2.13.2

