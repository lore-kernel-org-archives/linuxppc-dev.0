Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66331C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:18:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D486A2075B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvd99lJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D486A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jPb373K5zDqK9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 20:18:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rvd99lJG"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jPQp5XckzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 20:10:58 +1000 (AEST)
Received: by mail-wm1-x344.google.com with SMTP id a184so19872112wma.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 03:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0DzTJysZxO15MPQ7kqYMW+n479fJgtxXcOuK6TSaMOY=;
 b=rvd99lJGUbu0PxIfKZBydyMyHcMRBVRstZMvv7xY86ibl0HhEWK6WLbj4kToX2g5c+
 kpvz8UEBYyKpYwK/LmVh6c7orT1KPp5CmN+qZahxMfllHlE86MOyWEN8ekUc1XGt3Rgt
 KugqFdGcBiGk24zQ+g4PNL1pGUi14PiLUbHjI/87Ht0TpCldR9JAYf3xKTVRfdJRfPE+
 JgVdX89pzQovf2vyHTytIrczXYVYx1PrgGSnn85RtYZkSIF/BfMt52XT28AM5ucwadWW
 svWpsLin2Fq3UfQIMeA8dLmFF69fFfEetIc3SFWXFJWlSeqsKo/IKEZtXW6ZXdH/0BzI
 f/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0DzTJysZxO15MPQ7kqYMW+n479fJgtxXcOuK6TSaMOY=;
 b=mrJ+MzvsFmre6xMc0FqBJ6IuaessctkS2cbxCmIi2GSP6qWYV2DckWOPJpOWX7NRPr
 spDuffb8IFaLVTq7fIGOYnLLB7JNxlnWqIZ5BOrAlrAZNeyhzpndNdY3ySDKtDgeIdnA
 oTeno3hnD2ATouETdlWogPHM3eOBdFsn4mm7njjHCM58Ib3xmowPn7qEd+Vhg1s6IEfP
 isUwuFKbYFCckCb/Yz/rrgXPdsw2iqaC+HqyFYlNBFv+pNGnUwhPR/7HxTWwNhfjVN89
 vzxx+HTyFFhA+srtbtx7wdX36LwCJxxDPH5FJU4YmFZ16Kqg843SKTF2U3DDB9v0uHHA
 UlNg==
X-Gm-Message-State: APjAAAX2mk2GrQTsKrIIHSA8MzzAT6t5JeexOIUWH67jMc9nKPHma23p
 Z+0kUgTfg0Ioj6C2V6rZA18=
X-Google-Smtp-Source: APXvYqxsvH0Rc7MHGSQ5oXiwFD2EUfMonfSwzm6bqTZnIhCPTVMeStUOT1R7Tz14Ms6g+WEJB2kWAw==
X-Received: by 2002:a05:600c:24f:: with SMTP id
 15mr22249991wmj.48.1555323056233; 
 Mon, 15 Apr 2019 03:10:56 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id d6sm11592214wrp.9.2019.04.15.03.10.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Apr 2019 03:10:55 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org
Subject: [PATCH RFT V2 3/8] clk: gate: add explicit big endian support
Date: Mon, 15 Apr 2019 12:10:41 +0200
Message-Id: <20190415101046.5872-4-jonas.gorski@gmail.com>
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
allow runtime configuration of big endian gated clocks.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
V1 -> V2:
 * switch from global to local flag

 drivers/clk/clk-gate.c       | 22 +++++++++++++++++++---
 include/linux/clk-provider.h |  4 ++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index f05823cd9b21..521e112ef5b5 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -23,6 +23,22 @@
  * parent - fixed parent.  No clk_set_parent support
  */
 
+static inline u32 clk_gate_readl(struct clk_gate *gate)
+{
+	if (gate->flags & CLK_GATE_BIG_ENDIAN)
+		return ioread32be(gate->reg);
+	else
+		return clk_readl(gate->reg);
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

