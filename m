Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DED9C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:14:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853CD206BA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Znubu+SB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853CD206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jPVq2jsHzDqLG
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 20:14:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Znubu+SB"; 
 dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jPQm4rkSzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 20:10:56 +1000 (AEST)
Received: by mail-wm1-x342.google.com with SMTP id w15so19619144wmc.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 03:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cSD6PBow7v0W8TwFUmI5O2Pxk6CBw7ocNAAJAAXdWg8=;
 b=Znubu+SBnrloeNAT8sZMfuxqeFCVL60+47/i85ZzPS2cuhM8KEu6rEJmwddEvfM/hN
 8OMOgxgRo3C+7g+dQ9yMUA7FD3kUFXHByFUZmOD1FfqUpnaQYevYG6u+3orpJtLY7MDi
 fXKlHkpbpnv57up630V0jzQwAEm+nNyB+6hKhhhYfGlZ28qMJitYKjLQDvBIMXjs13VA
 sSuRsFrhSiVlJlmJIxdqNl9kOo0nwazv/ZkUTF3o/jkzKn9qJZItZMEGF41KR9bfzSYD
 SfSYhh6daMKDFH3gI22x6lXl8KGapgnYmxc0N9yrtXYfkZczK37KlYK0gSEqilvOYkwL
 5tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cSD6PBow7v0W8TwFUmI5O2Pxk6CBw7ocNAAJAAXdWg8=;
 b=IBt9AmFSSIbShMaopXA4Kaz5uruvseX/Mpz9SXNA962AOXlNYKboC2QpWA+KUmj6hN
 C3I7yjetZofgZQtxNxBV6q3OKWFET12d5lvjHrzYRAH0pOjPLIvLXOGvJQtJmMLL+Aoo
 iah2KQ7ybddPGorV0xmxuQq8ytvqHkOM+HvTRlpCRc8AgpkJK7ekyfcQuQ1S9cugXFJC
 gQfqbj4ItMVRaXq4FnfqMPxAqvOsSUmAACGUpP+Xf578r11HYt4ckQbZMvjLziPvEkHq
 k4rsCkWn422v8iFtjztU/nWQ594Oe8vZB9dLyrgtk+W2wOqtKXr5BcaGr/HL4nu5NNk3
 RV0Q==
X-Gm-Message-State: APjAAAU6ero6uVp8Yesxab6hYFeNG8YCL0gCiMbcAPVi5XpsaxVFJFCv
 RyKvW/AeUiLa2HE9uF0TlHs=
X-Google-Smtp-Source: APXvYqzNxdl1PhIO1oOobESMBfrW0DrNzXt6hIBogeVrQpk/WjkC/3DOHfN+kDsMgbMux6PsbVAqxA==
X-Received: by 2002:a7b:cd95:: with SMTP id y21mr21860173wmj.29.1555323052152; 
 Mon, 15 Apr 2019 03:10:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id d6sm11592214wrp.9.2019.04.15.03.10.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Apr 2019 03:10:51 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org
Subject: [PATCH RFT V2 1/8] clk: divider: add explicit big endian support
Date: Mon, 15 Apr 2019 12:10:39 +0200
Message-Id: <20190415101046.5872-2-jonas.gorski@gmail.com>
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

Add a clock specific flag to switch register accesses to big endian, to
allow runtime configuration of big endian divider clocks.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
V1 -> V2:
 * switch from global to local flag

 drivers/clk/clk-divider.c    | 26 ++++++++++++++++++++++----
 include/linux/clk-provider.h |  4 ++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index e5a17265cfaf..ff791a7a5e9e 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -25,6 +25,24 @@
  * parent - fixed parent.  No clk_set_parent support
  */
 
+static inline u32 clk_div_readl(struct clk_divider *divider)
+{
+	if (divider->flags & CLK_DIVIDER_BIG_ENDIAN)
+		return ioread32be(divider->reg);
+	else
+		return clk_readl(divider->reg);
+}
+
+static inline void clk_div_writel(struct clk_divider *divider, u32 val)
+{
+	if (divider->flags & CLK_DIVIDER_BIG_ENDIAN)
+		iowrite32be(val, divider->reg);
+	else
+		clk_writel(val, divider->reg);
+}
+
+#define div_mask(width)	((1 << (width)) - 1)
+
 static unsigned int _get_table_maxdiv(const struct clk_div_table *table,
 				      u8 width)
 {
@@ -135,7 +153,7 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
 	struct clk_divider *divider = to_clk_divider(hw);
 	unsigned int val;
 
-	val = clk_readl(divider->reg) >> divider->shift;
+	val = clk_div_readl(divider) >> divider->shift;
 	val &= clk_div_mask(divider->width);
 
 	return divider_recalc_rate(hw, parent_rate, val, divider->table,
@@ -370,7 +388,7 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
 		u32 val;
 
-		val = clk_readl(divider->reg) >> divider->shift;
+		val = clk_div_readl(divider->reg) >> divider->shift;
 		val &= clk_div_mask(divider->width);
 
 		return divider_ro_round_rate(hw, rate, prate, divider->table,
@@ -420,11 +438,11 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
 		val = clk_div_mask(divider->width) << (divider->shift + 16);
 	} else {
-		val = clk_readl(divider->reg);
+		val = clk_div_readl(divider->reg);
 		val &= ~(clk_div_mask(divider->width) << divider->shift);
 	}
 	val |= (u32)value << divider->shift;
-	clk_writel(val, divider->reg);
+	clk_div_writel(divider, val);
 
 	if (divider->lock)
 		spin_unlock_irqrestore(divider->lock, flags);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index db21437c77e2..7117b8cc0c0c 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -416,6 +416,9 @@ struct clk_div_table {
  * CLK_DIVIDER_MAX_AT_ZERO - For dividers which are like CLK_DIVIDER_ONE_BASED
  *	except when the value read from the register is zero, the divisor is
  *	2^width of the field.
+ * CLK_DIVIDER_BIG_ENDIAN - By default little endian register accesses are used
+ *	for the divider register.  Setting this flag makes the register accesses
+ *	big endian.
  */
 struct clk_divider {
 	struct clk_hw	hw;
@@ -437,6 +440,7 @@ struct clk_divider {
 #define CLK_DIVIDER_ROUND_CLOSEST	BIT(4)
 #define CLK_DIVIDER_READ_ONLY		BIT(5)
 #define CLK_DIVIDER_MAX_AT_ZERO		BIT(6)
+#define CLK_DIVIDER_BIG_ENDIAN		BIT(7)
 
 extern const struct clk_ops clk_divider_ops;
 extern const struct clk_ops clk_divider_ro_ops;
-- 
2.13.2

