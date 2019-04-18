Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4619DC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 11:21:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B39EF214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 11:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoZ60qYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39EF214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lGsF3ZlWzDqDV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 21:21:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SoZ60qYe"; 
 dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lGfJ2VY0zDqQh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 21:12:24 +1000 (AEST)
Received: by mail-wm1-x341.google.com with SMTP id h18so2435470wml.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 04:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LWVDRq3wPJtqLVuL8GILzgU6+gx9+RFydNdVEdr68+U=;
 b=SoZ60qYeBe4qwv1VMxxgH13aew4p66WqDIfl03PxZ+J05obKjr+9jLEObRmpDBLHsb
 hNFYIf+9KO4WhjJcqRO4Y04q4jlwIT6vJY3gCrG4eVyBHJklVx+n7EFoxwtd6q1yJz1o
 38IWgk+eGK5VHghpm8QaRDsX+3gLjT625J92LgcIWSiM8pSm9A5XiSRNM7if6AOpaICc
 yp7X00DDoDip2BkA9kna2VA+JYJ4vTUaEw8llyqNz2SVo3/hGGP4tZqV5y0wJxKd3O/H
 PvXEih0Y2UvVlxriEUWcDBm3oW5ShknpkVwruitBQEGvG3xZlSfhRsG2x5Fa4+3C6g3f
 IpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=LWVDRq3wPJtqLVuL8GILzgU6+gx9+RFydNdVEdr68+U=;
 b=erQa1JdTyQlBHHeWTKgwZcALlkGFCfsuKH/7b2n1XeJHjF2/2uyLlTXV5y7v7gcAjw
 RyGHiSKmL+l245GaE6c+wFnlZNhNr7tVS4FZPjv3PWkgnjlhWh8mHPuvJBzgvyjqCt1o
 MAv9uiJBDjKtAuKYSZUUSdo/OwP3jzZtULWaz7Olv1vzt8v3LfFJ4t8RhKNLm2t4XlZw
 qK9Jyd8M2jS+lxZPxRR7rbJ6I0TlcFw7F2MGht3depUFrkzqRMCRgnDI05o+8eGyBYO6
 oNosqrJTrybvm2Nks9UDJgFPrJm9e+R80FXzPb4b1H0AwLZf190VMTO6M/K6t2rLWFwl
 Jz6g==
X-Gm-Message-State: APjAAAVRE7bkDTYRzy85V5aMeVjCS0zJLAkRZmrlQy5LRHk8v6DMby2F
 TnaFJGJjgHMNvmj7V7TZyt4=
X-Google-Smtp-Source: APXvYqwKd5imwQ9tx9WLxEfWpd7Dn8I3vL36mwTDaErx27W2X8tFwiWgG4+QiGXq0JcOtMzgpkFrXQ==
X-Received: by 2002:a1c:e1c5:: with SMTP id y188mr2663908wmg.39.1555585941683; 
 Thu, 18 Apr 2019 04:12:21 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id z63sm2005594wme.30.2019.04.18.04.12.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Apr 2019 04:12:21 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org
Subject: [PATCH RFT V3 5/8] clk: mux: add explicit big endian support
Date: Thu, 18 Apr 2019 13:12:08 +0200
Message-Id: <20190418111211.10474-6-jonas.gorski@gmail.com>
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
allow runtime configuration of big endian mux clocks.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
V2 -> V3:
 * drop unneeded else in clk_mux_readl
V1 -> V2:
 * switch from global to local flag

 drivers/clk/clk-mux.c        | 22 +++++++++++++++++++---
 include/linux/clk-provider.h |  4 ++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 2ad2df2e8909..61ad331b7ff4 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -23,6 +23,22 @@
  * parent - parent is adjustable through clk_set_parent
  */
 
+static inline u32 clk_mux_readl(struct clk_mux *mux)
+{
+	if (mux->flags & CLK_MUX_BIG_ENDIAN)
+		return ioread32be(mux->reg);
+
+	return clk_readl(mux->reg);
+}
+
+static inline void clk_mux_writel(struct clk_mux *mux, u32 val)
+{
+	if (mux->flags & CLK_MUX_BIG_ENDIAN)
+		iowrite32be(val, mux->reg);
+	else
+		clk_writel(val, mux->reg);
+}
+
 int clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int flags,
 			 unsigned int val)
 {
@@ -73,7 +89,7 @@ static u8 clk_mux_get_parent(struct clk_hw *hw)
 	struct clk_mux *mux = to_clk_mux(hw);
 	u32 val;
 
-	val = clk_readl(mux->reg) >> mux->shift;
+	val = clk_mux_readl(mux) >> mux->shift;
 	val &= mux->mask;
 
 	return clk_mux_val_to_index(hw, mux->table, mux->flags, val);
@@ -94,12 +110,12 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	if (mux->flags & CLK_MUX_HIWORD_MASK) {
 		reg = mux->mask << (mux->shift + 16);
 	} else {
-		reg = clk_readl(mux->reg);
+		reg = clk_mux_readl(mux);
 		reg &= ~(mux->mask << mux->shift);
 	}
 	val = val << mux->shift;
 	reg |= val;
-	clk_writel(reg, mux->reg);
+	clk_mux_writel(mux, reg);
 
 	if (mux->lock)
 		spin_unlock_irqrestore(mux->lock, flags);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 9df78e3fb62b..f82cda41e1a8 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -510,6 +510,9 @@ void clk_hw_unregister_divider(struct clk_hw *hw);
  * 	.get_parent clk_op.
  * CLK_MUX_ROUND_CLOSEST - Use the parent rate that is closest to the desired
  *	frequency.
+ * CLK_MUX_BIG_ENDIAN - By default little endian register accesses are used for
+ *	the mux register.  Setting this flag makes the register accesses big
+ *	endian.
  */
 struct clk_mux {
 	struct clk_hw	hw;
@@ -528,6 +531,7 @@ struct clk_mux {
 #define CLK_MUX_HIWORD_MASK		BIT(2)
 #define CLK_MUX_READ_ONLY		BIT(3) /* mux can't be changed */
 #define CLK_MUX_ROUND_CLOSEST		BIT(4)
+#define CLK_MUX_BIG_ENDIAN		BIT(5)
 
 extern const struct clk_ops clk_mux_ops;
 extern const struct clk_ops clk_mux_ro_ops;
-- 
2.13.2

