Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15398C67863
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 07:54:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53FE62081B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 07:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zsKdmC3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FE62081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42g2bf3j1MzDrPn
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 18:54:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zsKdmC3s";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=baylibre.com
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=clabbe@baylibre.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="zsKdmC3s"; 
 dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42g2B44Cn7zDqq0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 18:36:12 +1100 (AEDT)
Received: by mail-wm1-x341.google.com with SMTP id y140-v6so13325721wmd.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 00:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9XvifWIVMLJuaC7p+Q4aHgeSVhuEGRb41PplzjfoOeA=;
 b=zsKdmC3sWrpIJ8EWu/GkW0SRR28b3qhMi3gTtdcam5oBQc8ilfdA6tr73Meirv53X7
 8HmhymsWT/Sm4Nqul938thyny9nRFzc91kfmNT/cMtzZu8Z0x8CBH/9F8lI9RWAETCni
 I/Iqyw+OyQLmVbaJtmjO17Oa7nlCCFOweEKfCIjEUzT5LGYj5eyrzcCAX0MWmPS5/uhu
 EU42pRAGHbgCC5jpK6qpt0Rsc1NlV+dYegqSuc5CJiQ3Sl2Rrub5c8W8awJa2O6NdI4u
 YvWfuAj0ujLYzOIfJ1NV1XXjss4skD87rIftxq/b+4zrIyyDvxTc4us2XgxY3PXmZvxM
 sTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9XvifWIVMLJuaC7p+Q4aHgeSVhuEGRb41PplzjfoOeA=;
 b=IaLCeD9ZWul2iqcWuwXvGeYjBsTUJFTxE1UilZpxcP8QS2H+wyBBUPgYtBNhtQJuUo
 d1RGOrnPsY8ibu7IFPXqwMpbDVJFgc8KJ5NlieL5A1nRckhjr6gT3zhUs01I2fC2Tq1P
 +bJV7myjYhsV1Z/P3/IehZPYlH3Jrlvj3aXJpC9MG0BKJl6ePQPgUWABecs8Q+cTMplj
 7KZmVgFXmLTDgCoH2lCGin3QSJDxkPwRd1iikoLSFWdQL5VTA/+WiDQOJpqFlD9oZql4
 yhhlVf4hjM0DuAsm8ZG/+MrvqwVC7VckZHE9FdHqndOLqD1iQQGRcWATyPkuI93muLiR
 Z3KA==
X-Gm-Message-State: AGRZ1gIKzZS6gbohxH2FGqRy+dhHbUA1ESQNVgYrAt8JZzQpadJMVZaK
 LUzjvETo8fVIxOijTuX7vArQtw==
X-Google-Smtp-Source: AJdET5dJVREjq1d49GF0tpTa8ysMRo4t1Wv0JmvMGCs/cIdU7lQzho//rY/qods5Hpprh4oUU+GRZw==
X-Received: by 2002:a1c:2501:: with SMTP id
 l1-v6mr1457395wml.133.1540366569886; 
 Wed, 24 Oct 2018 00:36:09 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
 by smtp.googlemail.com with ESMTPSA id
 b139-v6sm6254351wmd.36.2018.10.24.00.36.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 24 Oct 2018 00:36:09 -0700 (PDT)
From: Corentin Labbe <clabbe@baylibre.com>
To: Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
 airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au,
 benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
 galak@kernel.crashing.org, joabreu@synopsys.com, khilman@baylibre.com,
 matthias.bgg@gmail.com, maxime.ripard@bootlin.com, michal.lkml@markovi.net,
 mpe@ellerman.id.au, mporter@kernel.crashing.org, narmstrong@baylibre.com,
 nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
 peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
 wens@csie.org
Subject: [PATCH v3 7/7] net: stmmac: dwmac-meson8b: use xxxsetbits_le32
Date: Wed, 24 Oct 2018 07:35:53 +0000
Message-Id: <1540366553-18541-8-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-mediatek@lists.infradead.org,
 Corentin Labbe <clabbe@baylibre.com>, linux-amlogic@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, cocci@systeme.lip6.fr,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch convert meson stmmac glue driver to use all xxxsetbits_le32 functions.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 56 ++++++++-----------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index c5979569fd60..abcf65588576 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -23,6 +23,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/stmmac.h>
+#include <linux/setbits.h>
 
 #include "stmmac_platform.h"
 
@@ -75,18 +76,6 @@ struct meson8b_dwmac_clk_configs {
 	struct clk_gate		rgmii_tx_en;
 };
 
-static void meson8b_dwmac_mask_bits(struct meson8b_dwmac *dwmac, u32 reg,
-				    u32 mask, u32 value)
-{
-	u32 data;
-
-	data = readl(dwmac->regs + reg);
-	data &= ~mask;
-	data |= (value & mask);
-
-	writel(data, dwmac->regs + reg);
-}
-
 static struct clk *meson8b_dwmac_register_clk(struct meson8b_dwmac *dwmac,
 					      const char *name_suffix,
 					      const char **parent_names,
@@ -192,14 +181,13 @@ static int meson8b_set_phy_mode(struct meson8b_dwmac *dwmac)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* enable RGMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_RGMII_MODE,
-					PRG_ETH0_RGMII_MODE);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0, PRG_ETH0_RGMII_MODE,
+				PRG_ETH0_RGMII_MODE);
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		/* disable RGMII mode -> enables RMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_RGMII_MODE, 0);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0, PRG_ETH0_RGMII_MODE,
+				0);
 		break;
 	default:
 		dev_err(dwmac->dev, "fail to set phy-mode %s\n",
@@ -218,15 +206,15 @@ static int meson_axg_set_phy_mode(struct meson8b_dwmac *dwmac)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* enable RGMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_EXT_PHY_MODE_MASK,
-					PRG_ETH0_EXT_RGMII_MODE);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0,
+				PRG_ETH0_EXT_PHY_MODE_MASK,
+				PRG_ETH0_EXT_RGMII_MODE);
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		/* disable RGMII mode -> enables RMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_EXT_PHY_MODE_MASK,
-					PRG_ETH0_EXT_RMII_MODE);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0,
+				PRG_ETH0_EXT_PHY_MODE_MASK,
+				PRG_ETH0_EXT_RMII_MODE);
 		break;
 	default:
 		dev_err(dwmac->dev, "fail to set phy-mode %s\n",
@@ -255,11 +243,11 @@ static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* only relevant for RMII mode -> disable in RGMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_INVERTED_RMII_CLK, 0);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0,
+				PRG_ETH0_INVERTED_RMII_CLK, 0);
 
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_TXDLY_MASK,
-					tx_dly_val << PRG_ETH0_TXDLY_SHIFT);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0, PRG_ETH0_TXDLY_MASK,
+				tx_dly_val << PRG_ETH0_TXDLY_SHIFT);
 
 		/* Configure the 125MHz RGMII TX clock, the IP block changes
 		 * the output automatically (= without us having to configure
@@ -287,13 +275,13 @@ static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
 
 	case PHY_INTERFACE_MODE_RMII:
 		/* invert internal clk_rmii_i to generate 25/2.5 tx_rx_clk */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_INVERTED_RMII_CLK,
-					PRG_ETH0_INVERTED_RMII_CLK);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0,
+				PRG_ETH0_INVERTED_RMII_CLK,
+				PRG_ETH0_INVERTED_RMII_CLK);
 
 		/* TX clock delay cannot be configured in RMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_TXDLY_MASK,
-					0);
+		clrsetbits_le32(dwmac->regs + PRG_ETH0, PRG_ETH0_TXDLY_MASK,
+				0);
 
 		break;
 
@@ -304,8 +292,8 @@ static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
 	}
 
 	/* enable TX_CLK and PHY_REF_CLK generator */
-	meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_TX_AND_PHY_REF_CLK,
-				PRG_ETH0_TX_AND_PHY_REF_CLK);
+	clrsetbits_le32(dwmac->regs + PRG_ETH0, PRG_ETH0_TX_AND_PHY_REF_CLK,
+			PRG_ETH0_TX_AND_PHY_REF_CLK);
 
 	return 0;
 }
-- 
2.18.1

