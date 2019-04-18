Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D7DC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 11:18:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8309214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 11:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha7eC9dC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8309214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lGnC46RFzDqR7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 21:18:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ha7eC9dC"; 
 dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lGfF1jXQzDqQh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 21:12:21 +1000 (AEST)
Received: by mail-wm1-x341.google.com with SMTP id z11so2345151wmi.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 04:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1+9nJK1Db2lO9Wy+wl5d5tDXTM6Ik02w576iY7MCnxU=;
 b=ha7eC9dC9yJ9uOyYhddr+sfovKYz+R1+Pml66seQaXCE7mLV/rsMJgccTUEnqDkGI2
 7XK8TmlfXSvYCzNz+f5bGZXSSYr7qGUcvuZuPbQ66rR1At1NkWLF4LWsXouPRDVyqKv5
 O1IrxOq6QOig6eExpNlSQd/Q4RB5znyCbqiL7uyuoWlW1bNjF9kvmCqhnPxZxhdC3nWu
 iWAMgBwYg9iP9i0POH5G9+RZoT0QpNoJ+fyy0/08vCHl6JR2Ws94b+d6ayAlWsAjOTJw
 /GHCT1hN1aVyJQJhslI/5SPB/YifrC3VvtQpjvEyYLlacODMOJYc2Nr5gHiH6bcrkdJa
 drhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1+9nJK1Db2lO9Wy+wl5d5tDXTM6Ik02w576iY7MCnxU=;
 b=XnKLwr/M4tD33FA7taEGALgqhBdAPg4FLQNjyXVp58nmsuoD8KU+rQj+6pC1iv6ZPP
 WBwWcg8saT3WmPv20o/+ghpnXpCEekgaeMiOHRVkBSfp2IpihMIDW2qcawtSfU9wYn84
 QYDJhqJ/QmS1WVMzljRwM625l28U7dGQBq4J10u9f9ftxqSm1qxEQOalPtKZ5HpHeSQU
 RxnpkkDOEenRvHzSpYAF2I0cRQy5mJIXxZD0KsoMxEXJbD8wjVYnDBn9IcYDVyGzuruh
 4BqiTS271+5vMwumvugXntd/zX24ZpRWBrfsytq8XjilGkXMlOK6O+q5bf/4rh1rtkTi
 a9dQ==
X-Gm-Message-State: APjAAAW2X+VYAACV8iGDQhPyUgdGJ+CTCUzcw4hAoLA9JGj8i6r5kKbp
 qURelx2j+e8mDlvP3ZZYhhE=
X-Google-Smtp-Source: APXvYqxJs+G3NOyqcEh489pdgO7urfXXmfd1Hav4NVN4L0GbWSK0G3CZBbUOhXitaAImb+p9xxUdVw==
X-Received: by 2002:a05:600c:2055:: with SMTP id
 p21mr2771224wmg.118.1555585938600; 
 Thu, 18 Apr 2019 04:12:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id z63sm2005594wme.30.2019.04.18.04.12.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Apr 2019 04:12:18 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org
Subject: [PATCH RFT V3 3/8] clk: gate: add explicit big endian support
Date: Thu, 18 Apr 2019 13:12:06 +0200
Message-Id: <20190418111211.10474-4-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20190418111211.10474-1-jonas.gorski@gmail.com>
References: <20190418111211.10474-1-jonas.gorski@gmail.com>
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

Add a clock specific flag to switch register accesses to big endian, to
allow runtime configuration of big endian gated clocks.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
V2 -> V3:
 * drop unneeded else in clk_gate_readl
V1 -> V2:
 * switch from global to local flag

 drivers/clk/clk-gate.c       | 22 +++++++++++++++++++---
 include/linux/clk-provider.h |  4 ++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index f05823cd9b21..6ced7b1f5585 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -23,6 +23,22 @@
  * parent - fixed parent.  No clk_set_parent support
  */
 
+static inline u32 clk_gate_readl(struct clk_gate *gate)
+{
+	if (gate->flags & CLK_GATE_BIG_ENDIAN)
+		return ioread32be(gate->reg);
+
+	return clk_readl(gate->reg);
+}
+
+static inline void clk_gate_writel(struct clk_gate *gate, u32 val)
+{
+	if (gate->flags & CLK_GATE_BIG_ENDIAN)
+		iowrite32be(val, gate->reg);
+	else
+		clk_writel(val, gate->reg);
+}
+
 /*
  * It works on following logic:
  *
@@ -55,7 +71,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
 		if (set)
 			reg |= BIT(gate->bit_idx);
 	} else {
-		reg = clk_readl(gate->reg);
+		reg = clk_gate_readl(gate);
 
 		if (set)
 			reg |= BIT(gate->bit_idx);
@@ -63,7 +79,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
 			reg &= ~BIT(gate->bit_idx);
 	}
 
-	clk_writel(reg, gate->reg);
+	clk_gate_writel(gate, reg);
 
 	if (gate->lock)
 		spin_unlock_irqrestore(gate->lock, flags);
@@ -88,7 +104,7 @@ int clk_gate_is_enabled(struct clk_hw *hw)
 	u32 reg;
 	struct clk_gate *gate = to_clk_gate(hw);
 
-	reg = clk_readl(gate->reg);
+	reg = clk_gate_readl(gate);
 
 	/* if a set bit disables this clk, flip it before masking */
 	if (gate->flags & CLK_GATE_SET_TO_DISABLE)
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 8c07d810acf5..8576c2dbc639 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -348,6 +348,9 @@ void of_fixed_clk_setup(struct device_node *np);
  *	of this register, and mask of gate bits are in higher 16-bit of this
  *	register.  While setting the gate bits, higher 16-bit should also be
  *	updated to indicate changing gate bits.
+ * CLK_GATE_BIG_ENDIAN - by default little endian register accesses are used for
+ *	the gate register.  Setting this flag makes the register accesses big
+ *	endian.
  */
 struct clk_gate {
 	struct clk_hw hw;
@@ -361,6 +364,7 @@ struct clk_gate {
 
 #define CLK_GATE_SET_TO_DISABLE		BIT(0)
 #define CLK_GATE_HIWORD_MASK		BIT(1)
+#define CLK_GATE_BIG_ENDIAN		BIT(2)
 
 extern const struct clk_ops clk_gate_ops;
 struct clk *clk_register_gate(struct device *dev, const char *name,
-- 
2.13.2

