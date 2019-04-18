Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7EAC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 11:19:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C530214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 11:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h60nmFi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C530214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lGpz2pLKzDqRB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 21:19:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="h60nmFi5"; 
 dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lGfG5hb5zDqQh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 21:12:22 +1000 (AEST)
Received: by mail-wm1-x341.google.com with SMTP id w15so2420337wmc.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 04:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=a8sDOmAMJdu2EjIPFYny65MP6zKmI8GdE/EZa2fTsNo=;
 b=h60nmFi5x2mIN/rBCI88YsQNzZAQChgujE7vqDW4RpmUC5hruX4p3eUa4w4aaRI8eX
 X7CmxifbK2cNxi9jSYxLOHFTmnyX2+z84gYa30T133er5WFF6Y4nvO4Y6ACx7TCbnTGB
 5ox7B4sBdmOSI07NYDtofhhHIyiTpZR+RBsjPycDIHPmRV2Bu5iuh5hL+fARNNpBzrUM
 s1bF/fHrSMSq2weBWdaZLHNU9AdUqZ7Cl+qtc2/7bIcAWcARbttYgmTrCRMSVzindJwT
 gQPfdSQS7hKUHBC8DYhwzNmJT0XLtwcQaz8Fn7cCE6kQVRDUOk8nRVyiKalt9K13tHtT
 zHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=a8sDOmAMJdu2EjIPFYny65MP6zKmI8GdE/EZa2fTsNo=;
 b=MbY2LoIVe2W+AgHYKup30fGPhR7RUlkd5Zpxiaa6F2e/M8juOVeO+woSFz3LGXG97m
 mw7qYe6G5AC1+LzTV6VFCNz6Tls1yFe5G+CAHnAIWBeMbqz6fk3I4ctNbh26pS94cTKd
 gc8t/X8Itk6BZUqzAXsNFPrXGHNFM72+drvyS7T98+QobF6HtpcqNMV7cUN6ZFRU9AQr
 wVwsZqvQovTG4ikP8Xe8staQ9xZV10g31kPR3JykqWbODHif/NZyr/TClSkBorU/TagM
 eARsvBnad0bOPu6h21rrzYTEm6VoH1oJ5UX4CZoYFNaVgBz9msezHtTJ6bE2ttBSkgLG
 Osjg==
X-Gm-Message-State: APjAAAUGtMlMp0iLztz5VkKQ6sEDtU9ieVhRR+I0CAqUMk36oMSS1DaY
 /saafZCDOfdGpvU7ImaGah4=
X-Google-Smtp-Source: APXvYqxyQgWCnYZxnIVZG7lXRdM+1OaUMj/QeKDR9GD2ugSYxk4ihhxM90/Ax0/RONbbDMhql3/YrA==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr2649663wmk.108.1555585940115; 
 Thu, 18 Apr 2019 04:12:20 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id z63sm2005594wme.30.2019.04.18.04.12.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Apr 2019 04:12:19 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org
Subject: [PATCH RFT V3 4/8] clk: multiplier: add explicit big endian support
Date: Thu, 18 Apr 2019 13:12:07 +0200
Message-Id: <20190418111211.10474-5-jonas.gorski@gmail.com>
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
allow runtime configuration of big endian multiplier clocks.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
V2 -> V3:
 * drop unneeded else in clk_mult_readl
V1 -> V2:
 * switch from global to local flag

 drivers/clk/clk-multiplier.c | 22 +++++++++++++++++++---
 include/linux/clk-provider.h |  4 ++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-multiplier.c b/drivers/clk/clk-multiplier.c
index 3c86f859c199..77327df9bf32 100644
--- a/drivers/clk/clk-multiplier.c
+++ b/drivers/clk/clk-multiplier.c
@@ -11,6 +11,22 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 
+static inline u32 clk_mult_readl(struct clk_multiplier *mult)
+{
+	if (mult->flags & CLK_MULTIPLIER_BIG_ENDIAN)
+		return ioread32be(mult->reg);
+
+	return clk_readl(mult->reg);
+}
+
+static inline void clk_mult_writel(struct clk_multiplier *mult, u32 val)
+{
+	if (mult->flags & CLK_MULTIPLIER_BIG_ENDIAN)
+		iowrite32be(val, mult->reg);
+	else
+		clk_writel(val, mult->reg);
+}
+
 static unsigned long __get_mult(struct clk_multiplier *mult,
 				unsigned long rate,
 				unsigned long parent_rate)
@@ -27,7 +43,7 @@ static unsigned long clk_multiplier_recalc_rate(struct clk_hw *hw,
 	struct clk_multiplier *mult = to_clk_multiplier(hw);
 	unsigned long val;
 
-	val = clk_readl(mult->reg) >> mult->shift;
+	val = clk_mult_readl(mult) >> mult->shift;
 	val &= GENMASK(mult->width - 1, 0);
 
 	if (!val && mult->flags & CLK_MULTIPLIER_ZERO_BYPASS)
@@ -118,10 +134,10 @@ static int clk_multiplier_set_rate(struct clk_hw *hw, unsigned long rate,
 	else
 		__acquire(mult->lock);
 
-	val = clk_readl(mult->reg);
+	val = clk_mult_readl(mult);
 	val &= ~GENMASK(mult->width + mult->shift - 1, mult->shift);
 	val |= factor << mult->shift;
-	clk_writel(val, mult->reg);
+	clk_mult_writel(mult, val);
 
 	if (mult->lock)
 		spin_unlock_irqrestore(mult->lock, flags);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 8576c2dbc639..9df78e3fb62b 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -667,6 +667,9 @@ void clk_hw_unregister_fractional_divider(struct clk_hw *hw);
  *	leaving the parent rate unmodified.
  * CLK_MULTIPLIER_ROUND_CLOSEST - Makes the best calculated divider to be
  *	rounded to the closest integer instead of the down one.
+ * CLK_MULTIPLIER_BIG_ENDIAN - By default little endian register accesses are
+ *	used for the multiplier register.  Setting this flag makes the register
+ *	accesses big endian.
  */
 struct clk_multiplier {
 	struct clk_hw	hw;
@@ -681,6 +684,7 @@ struct clk_multiplier {
 
 #define CLK_MULTIPLIER_ZERO_BYPASS		BIT(0)
 #define CLK_MULTIPLIER_ROUND_CLOSEST	BIT(1)
+#define CLK_MULTIPLIER_BIG_ENDIAN		BIT(2)
 
 extern const struct clk_ops clk_multiplier_ops;
 
-- 
2.13.2

