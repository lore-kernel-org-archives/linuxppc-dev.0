Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8531CC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 11:24:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C77214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 11:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loX2vGZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C77214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lGwW0zmdzDqRP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 21:24:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="loX2vGZN"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lGfN038wzDqQw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 21:12:28 +1000 (AEST)
Received: by mail-wr1-x443.google.com with SMTP id w16so2506986wrl.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 04:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CAbZ+B2Pzaew/uxTUQeDlxYznykRwsRk9BK/GJ+9CDQ=;
 b=loX2vGZN6vibeeQ7n9V6YuPhstSvX3tKKZX4RjVFaMo2Ku/65hfoQztilLTk2lDNbI
 WuDyCKuUyzze2ZvjiLZU2taa644c+JZFQIxKrHSjPiyfPWCk8NiBzr+1F2D1AVSxzeEl
 IthDHbKNj6KZT2dByQh088trw15H8k5Ese5F4nO2B2gWj+mjX+sL+rLBdQoGRdV19yRm
 RhEKYC0a3ieHR5ORIhCD9uBs+hDUJs/ta4J0Yjt8xZsbZCtzZln8D7S7nsoJ4rtRJevT
 BbL6hnhZTXSU+batyvtaUspx0TtKhShkwRl4bQl5lYdIy5ylElunRHFLor1foeeIyF+U
 zHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CAbZ+B2Pzaew/uxTUQeDlxYznykRwsRk9BK/GJ+9CDQ=;
 b=ernwiGsotD3qp5cDNh4XVQlAU/9TyLMIOdvgU+rFiBkMA15oIiAGgHIszlea/FYYV1
 ao8igdBKyVFsyf9Z4LofpEefpNI1yCElLCDYz1RbKN8dN6GhxF4dpUcGUccq+LNNA20b
 sonpjUdIZJ5JPHNkNYVbOq36hU5Ln/TN6rdY2FxwRJ5hr1upN2QI/m2vPFhUaH8ys9qH
 AL3PaMHFzBn/LkqAA1HCAAAJZ+RUvFQqIU76mYz55+5SMlkagsc1EqsyJ2ioaeSRVt/o
 nX3FEXvIUHz762/GSjL50JnSkyGRbY4OCoZl3/X8EbOZXyEt03mrpouEWxgkzhoJ/v0c
 6yKg==
X-Gm-Message-State: APjAAAUneadDS6m9x3ssV7mT/0MTXn7beERfn7p1/ZMds5DxzMnHy1JR
 8aHT8PaUm6XV01UxxBm+Ct8=
X-Google-Smtp-Source: APXvYqzsBnyWaFRQQofw/q/jVVAit0cci7zyLWs75NRW7NfZ6sxZCdX620fTKMUfrtw+uuDHkkxuAQ==
X-Received: by 2002:adf:ec0a:: with SMTP id x10mr60641120wrn.193.1555585944841; 
 Thu, 18 Apr 2019 04:12:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id z63sm2005594wme.30.2019.04.18.04.12.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Apr 2019 04:12:24 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org
Subject: [PATCH RFT V3 7/8] clk: core: remove powerpc special handling
Date: Thu, 18 Apr 2019 13:12:10 +0200
Message-Id: <20190418111211.10474-8-jonas.gorski@gmail.com>
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

Now that the powerpc clocks are properly marked as big endian, we can
remove the special handling for PowerPC.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
V2 -> V3:
 * no actual changes
V1 -> V2:
 * no actual changes

 include/linux/clk-provider.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index f82cda41e1a8..479e616ce7f5 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1001,20 +1001,6 @@ static inline int of_clk_detect_critical(struct device_node *np, int index,
  * for improved portability across platforms
  */
 
-#if IS_ENABLED(CONFIG_PPC)
-
-static inline u32 clk_readl(u32 __iomem *reg)
-{
-	return ioread32be(reg);
-}
-
-static inline void clk_writel(u32 val, u32 __iomem *reg)
-{
-	iowrite32be(val, reg);
-}
-
-#else	/* platform dependent I/O accessors */
-
 static inline u32 clk_readl(u32 __iomem *reg)
 {
 	return readl(reg);
@@ -1025,8 +1011,6 @@ static inline void clk_writel(u32 val, u32 __iomem *reg)
 	writel(val, reg);
 }
 
-#endif	/* platform dependent I/O accessors */
-
 void clk_gate_restore_context(struct clk_hw *hw);
 
 #endif /* CONFIG_COMMON_CLK */
-- 
2.13.2

