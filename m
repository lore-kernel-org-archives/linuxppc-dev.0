Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ADFC10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 15:02:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB98221473
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 15:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYqtbsFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB98221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dDDC4ll6zDqDc
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 01:02:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="nYqtbsFv"; 
 dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44d5zf5cd4zDqJ3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 20:20:57 +1000 (AEST)
Received: by mail-wr1-x442.google.com with SMTP id q1so15712970wrp.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NVmL03g/69kkqfLIzfzWYuQgrBWQBk/oveRzpCawG2w=;
 b=nYqtbsFvdqDaq9Z+dgV59ADFSXuYziC+nnDk/gC9YK7sOXzQalG4+KhNAqMGbdqdpJ
 7v1vjGkoVujw8LdBQ2qY95RvmZ5YXGvExwxivsWMmb3aoy2IhOXVRguF0+8pUdEXSZq7
 daRFWAiZn9765pb+UIvLuRN5vET5cAU6sDLLj4K/fLSE7Inm4l4iIC8QCxglHBVclUMF
 S/x8a/nvsZYnsZ4KCnlqL+2QUzfNQuGBQb9+IElq4iyk/1sVzLGlJMaEisxf1Qdk/mmS
 w+BnI2cdN1HuJJbSY1oyHnZXm/4PxMmrbgeIVeN9AftjKaS/PPUUuep7TFlY6t6aosfI
 f3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=NVmL03g/69kkqfLIzfzWYuQgrBWQBk/oveRzpCawG2w=;
 b=PUSlKTngKTycEDJe1P/WL3e/t/b9HltMj6qnv+KlK29XXMRSHPLR/gLlH+7/NKATaw
 ETRF8wDV8fB1pCH0wKT3eqNS2f0iyqWb+e98X+mVSf1N7gqnb6RcF/jBCwHhChsh17Rv
 4i6arAGZ+g38Dp/tLtM/Qx9Nbg+0tlLPwtm+fenX6dE4wuTtkprfQmqlLDmdeavdQ2wB
 JD44hgKFgvP6A6WGL3XP1hRjqaAGkK9bAopiuL3iFuECzuo3Ki3kg1CaykmqTwAcvO33
 /mR3LWHqsK1LYGIKuWrZX7EV1UDxN6Xq7lnbzBjXZHiBVoJ/vrMU0pBML81+aQKD0tBw
 CZNA==
X-Gm-Message-State: APjAAAU0hPjTz6dVS9D7wK7zYyXRiSY3FTD17wSCo0YJSOvBuxiNTD8r
 gmFYn0oURdh20gx64/BozT4=
X-Google-Smtp-Source: APXvYqx3A5BPmwdS6ZMo6XnxwIg+1qK1eBDHM0Dzs76vfsGvc2VF4UbzvmXgRS+JM/YGZpdcNUDp7A==
X-Received: by 2002:adf:f70e:: with SMTP id r14mr18094535wrp.37.1554718854753; 
 Mon, 08 Apr 2019 03:20:54 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id d6sm39336069wrx.62.2019.04.08.03.20.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Apr 2019 03:20:54 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RFC/RFT 2/6] clk: gate: make endian-aware
Date: Mon,  8 Apr 2019 12:20:35 +0200
Message-Id: <20190408102039.6366-3-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20190408102039.6366-1-jonas.gorski@gmail.com>
References: <20190408102039.6366-1-jonas.gorski@gmail.com>
X-Mailman-Approved-At: Tue, 09 Apr 2019 00:55:08 +1000
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Paul Mackerras <paulus@samba.org>,
 Anatolij Gustschin <agust@denx.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Switch clk-gate to the endianness aware accessors to allow big endian
gated clocks on a per device level.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/clk/clk-gate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index f05823cd9b21..0e585ac133c7 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -55,7 +55,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
 		if (set)
 			reg |= BIT(gate->bit_idx);
 	} else {
-		reg = clk_readl(gate->reg);
+		reg = clk_hw_readl(hw, gate->reg);
 
 		if (set)
 			reg |= BIT(gate->bit_idx);
@@ -63,7 +63,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
 			reg &= ~BIT(gate->bit_idx);
 	}
 
-	clk_writel(reg, gate->reg);
+	clk_hw_writel(hw, reg, gate->reg);
 
 	if (gate->lock)
 		spin_unlock_irqrestore(gate->lock, flags);
@@ -88,7 +88,7 @@ int clk_gate_is_enabled(struct clk_hw *hw)
 	u32 reg;
 	struct clk_gate *gate = to_clk_gate(hw);
 
-	reg = clk_readl(gate->reg);
+	reg = clk_hw_readl(hw, gate->reg);
 
 	/* if a set bit disables this clk, flip it before masking */
 	if (gate->flags & CLK_GATE_SET_TO_DISABLE)
-- 
2.13.2

