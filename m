Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109DBC10F12
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:24:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A9020652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+yvan/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A9020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jPk62qypzDqJm
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 20:24:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="V+yvan/Z"; 
 dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jPQy55jczDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 20:11:06 +1000 (AEST)
Received: by mail-wm1-x341.google.com with SMTP id y197so7815852wmd.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 03:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Sj0AUTH1hVgf3wNwVxaR3FGot08SzGps4WY/S0Hmy/E=;
 b=V+yvan/Zm0HTn2scxhSs9EmCYDAt39Twv0oMrtdz/oOUUBDuKQbPtb7FemAjsHjS2P
 X996fb5pDqSUxCSQBxW9CrzN40m9/dOEcY9U/QK7kXH4B6Kx9XzVTgzRZpxf47T65hhu
 U0rM11acTkeBNEgr+u6oyjLo0+JZvaeVQ5RZLgbFQqBOiwT1CnIHU8ZB3CeLy6JrKLsC
 2pFMc6xo8d0tuRJYiGdMdbTsqpxZ30/XnGaf6c/P8UdejTFa+z0Brhum8FiKNp1760J5
 6KvCdxnSdyK5A/d5XeNa1WS5uRNZfFjkWJAsLpy7qcc4BXt4rxAzOVM2R6+fR4LjeARj
 wTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Sj0AUTH1hVgf3wNwVxaR3FGot08SzGps4WY/S0Hmy/E=;
 b=g77WTRY9ZOP6Yr7EZE0mKFoFbaQYbp3fg0n5LtDNXklvJodw3UIGDtqEVAea0rUx1I
 1CnTWiu6tmaIuP0cDncEb9PeOA79j85HR2f1Mlg/9JXafy5ppRwMK9r5K3uYbTc53XDm
 FGWZZ5D79EJPGW04Er2iguw3cwoJ1H1b02/xfQanh1KmMXZYF5EN38GVzdAHXrFP2z5l
 yKNDRdV0g6a4cRMxh49IFz/dsknfHypK7cDIdGplOvb+6F9v533dyohCU2YT+k/f242h
 PWs4QvtWhGZodQ7sTIDaxXAoKlhAEBFAwrdxz91YLzvolt+oqbCjHygpCc42xIZeJHoy
 gyOA==
X-Gm-Message-State: APjAAAUyI/Bi1wV/FuAJknhE40RPqOAJHYhSnmojmXwuRlb5gSCRoCxr
 h8uGfZeBZD/a3X/NAbz3sWE=
X-Google-Smtp-Source: APXvYqw2zXF9I3SOjK4eDyXT/3JKr8GdVdxfKwB3FDSG/F11qD5sT964dRm277f+oBYa2U14U3zytw==
X-Received: by 2002:a1c:a9cb:: with SMTP id s194mr22219969wme.62.1555323064237; 
 Mon, 15 Apr 2019 03:11:04 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id d6sm11592214wrp.9.2019.04.15.03.11.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Apr 2019 03:11:03 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org
Subject: [PATCH RFT V2 7/8] clk: core: remove powerpc special handling
Date: Mon, 15 Apr 2019 12:10:45 +0200
Message-Id: <20190415101046.5872-8-jonas.gorski@gmail.com>
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

Now that the powerpc clocks are properly marked as big endian, we can
remove the special handling for PowerPC.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
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

