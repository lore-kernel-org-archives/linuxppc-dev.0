Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8D7C10F12
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:16:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4916A2075B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gztGjS1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4916A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jPXd2VXTzDqML
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 20:16:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gztGjS1h"; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jPQm5rxFzDqB4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 20:10:56 +1000 (AEST)
Received: by mail-wr1-x444.google.com with SMTP id y7so21103634wrn.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 03:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=o+W2Q634iC3zR2xiEnI5jQwiq7sivbZ81nwPB9eB+tU=;
 b=gztGjS1hRk4mVTO/iq0Zf3l+AJuYNqz3qjgBMCKMLcEtjTKD1dvxU280eEopc1zqjp
 3mVduNg2l6/zUug56BWIGoXgTufkNUR1/GVyyxNeN/v0wFu5hSzGt9z0pBZrFdjHT2JJ
 FEJBOb31onNhjnwqgxnUDN+Ht3ExstBL4lIlKhhOsIzbsvbedk2DPwC7LDCjnx0hnf3J
 6fGKL1Vy9WALTgeQXrtDvb3HvSuH453GwBjxEeLvHiwKJ1KWfowHFSpApbN/60681UAx
 S7F5tovZ3qcr/9qOTlt2gVrRqjl1AErzJq1UEmFkoH2+C4RrlnByh7gdGymRaUO1IKuX
 6YLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=o+W2Q634iC3zR2xiEnI5jQwiq7sivbZ81nwPB9eB+tU=;
 b=Utjqc3go6HlJv56AMxh6Yqv3tvQFCArRH/Ofu/JKiwtoBtOrhFj3zn4pyaibKPQT/P
 FTNv3cYws5NJkMBk/e0LbMMWPNpov8yUSY+iFXNrZHiC4wngiGMVc6z0Pb/VkMH5LdtL
 QUjgd6IpBBW+lv+UmAHOXCLgaTN2vzCUm22l1EnfM3naXXgpUqG/MxxZsrLbaJa8fQxA
 azLg3qtcJYWE4cP08N6YtzkSmurg+YF406UUmOLepmL345KpZlEC9bWr3QRV9s9hNPFh
 BDcJBE3ghFtw8YDSn9lPPRTb9xlPVj3vsXszaDPKnn7EoMNsvAga4L3e5Q2LdDaHST6T
 Cf6w==
X-Gm-Message-State: APjAAAVyIvkXisUemsgMRRUjnQYANN6ZWmEX8eL20GOgDR6djviSb2Oy
 GBTIUnwtWdYBBVMwUziUEL0=
X-Google-Smtp-Source: APXvYqwjGrmwlbP67cAxOBoWrpPk6FwlPj8xUIyK9GJsk2OjFotgQsFgHX7W7vJb9Un2uuMuRW2EUg==
X-Received: by 2002:a05:6000:1286:: with SMTP id
 f6mr13099948wrx.93.1555323053789; 
 Mon, 15 Apr 2019 03:10:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id d6sm11592214wrp.9.2019.04.15.03.10.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Apr 2019 03:10:53 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org
Subject: [PATCH RFT V2 2/8] clk: fractional-divider: add explicit big endian
 support
Date: Mon, 15 Apr 2019 12:10:40 +0200
Message-Id: <20190415101046.5872-3-jonas.gorski@gmail.com>
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
allow runtime configuration of big endian fractional divider clocks.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
V1 -> V2:
 * newly added patch

 drivers/clk/clk-fractional-divider.c | 22 +++++++++++++++++++---
 include/linux/clk-provider.h         |  4 ++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index fdfe2e423d15..b9988d3b3828 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -13,6 +13,22 @@
 #include <linux/slab.h>
 #include <linux/rational.h>
 
+static inline u32 clk_fd_readl(struct clk_fractional_divider *fd)
+{
+	if (fd->flags & CLK_FRAC_DIVIDER_BIG_ENDIAN)
+		return ioread32be(fd->reg);
+	else
+		return clk_readl(fd->reg);
+}
+
+static inline void clk_fd_writel(struct clk_fractional_divider *fd, u32 val)
+{
+	if (fd->flags & CLK_FRAC_DIVIDER_BIG_ENDIAN)
+		iowrite32be(val, fd->reg);
+	else
+		clk_writel(val, fd->reg);
+}
+
 static unsigned long clk_fd_recalc_rate(struct clk_hw *hw,
 					unsigned long parent_rate)
 {
@@ -27,7 +43,7 @@ static unsigned long clk_fd_recalc_rate(struct clk_hw *hw,
 	else
 		__acquire(fd->lock);
 
-	val = clk_readl(fd->reg);
+	val = clk_fd_readl(fd);
 
 	if (fd->lock)
 		spin_unlock_irqrestore(fd->lock, flags);
@@ -115,10 +131,10 @@ static int clk_fd_set_rate(struct clk_hw *hw, unsigned long rate,
 	else
 		__acquire(fd->lock);
 
-	val = clk_readl(fd->reg);
+	val = clk_fd_readl(fd);
 	val &= ~(fd->mmask | fd->nmask);
 	val |= (m << fd->mshift) | (n << fd->nshift);
-	clk_writel(val, fd->reg);
+	clk_fd_writel(fd, val);
 
 	if (fd->lock)
 		spin_unlock_irqrestore(fd->lock, flags);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7117b8cc0c0c..8c07d810acf5 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -607,6 +607,9 @@ void clk_hw_unregister_fixed_factor(struct clk_hw *hw);
  *	is the value read from the register. If CLK_FRAC_DIVIDER_ZERO_BASED
  *	is set then the numerator and denominator are both the value read
  *	plus one.
+ * CLK_FRAC_DIVIDER_BIG_ENDIAN - By default little endian register accesses are
+ *	used for the divider register.  Setting this flag makes the register
+ *	accesses big endian.
  */
 struct clk_fractional_divider {
 	struct clk_hw	hw;
@@ -627,6 +630,7 @@ struct clk_fractional_divider {
 #define to_clk_fd(_hw) container_of(_hw, struct clk_fractional_divider, hw)
 
 #define CLK_FRAC_DIVIDER_ZERO_BASED		BIT(0)
+#define CLK_FRAC_DIVIDER_BIG_ENDIAN		BIT(1)
 
 extern const struct clk_ops clk_fractional_divider_ops;
 struct clk *clk_register_fractional_divider(struct device *dev,
-- 
2.13.2

