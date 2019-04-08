Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CC1C10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 14:58:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B1221473
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 14:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sq2r5Vov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B1221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dD7k6jdLzDqM5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 00:58:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="sq2r5Vov"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44d5zf5MxzzDqF0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 20:20:59 +1000 (AEST)
Received: by mail-wr1-x443.google.com with SMTP id w1so15709650wrp.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 03:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hTUtY+IM6B2DQhgBPY5XhL9p0M/rApXoH/mpj/PDFoY=;
 b=sq2r5Vov8P/Semw1Ej8fJQpWocfFSHJjaD6v9pTnKlD9IUt0Sv5vC7anT6Lup8riNV
 vIMEsdznzok4BIYIOFfhVJx0lj+HAiw1EyRwVBCdRGDvdcy9zz44Oq/UmzAHXdYqwRl+
 kmm0oNVTSxhVM8izxxpJpVNH1aB5s5TPAtVyFSIoVfPrezbfvdiGVTQSWsNqYKFcS+TE
 k70Kn/DEpWc3IBdIQ8esaa06Ra9yqmljfOb5U5q6M9BL5un0bqSc/KvTNnLMYkw8HRGk
 4gKwci7LlwyyTBLI2AxFOgE8WoaXXJtGk7q9hl/gDn49hjWglcnCSocxkXkuWzYeqIsk
 MkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hTUtY+IM6B2DQhgBPY5XhL9p0M/rApXoH/mpj/PDFoY=;
 b=IvHsJo9RTFzwB7WaRx+e3czhs6kE++oVw6tLfi3LvqtuUfZfFzMLQkSK8N7dMlLNEO
 G5Irg13qKtLymC4g0Ta3IrpJS43WslWxKhgAA4RyjUJyU8JhBkQzcAnTijQHR6md5zv1
 gn55qkOS0IdI6RPAtvmmt/1rEzor0TnJfVVOJxAJCk8amm5SzUjJ4JypY3oBGmNBCnqM
 Vq5zuRzn4vjCY6QtwhcVWLtxrY+8t5a3JKUIu94mVIfjK7VyGaAYNCR6C9mSOUFio2n6
 LomvJmJ226JVwnLkAJr5J4qCyu8P+tl+cZW8dIWSxTDRZoyYbPih7c03SebOr4LX2trq
 jKSQ==
X-Gm-Message-State: APjAAAUIol6mBvQi/l2gy66sdI+rlJX2at4LUAsaFFbyilec1WWWiu9I
 Io40R9Ya6J4I5iAFWHVSAtU=
X-Google-Smtp-Source: APXvYqxXMOOiznr7X3UgEMH3uwv3ba77V/uKMP6Ele1Ewr+54acgQAGzE5rfU/YLFKoCMJe0+N0Tqw==
X-Received: by 2002:adf:f101:: with SMTP id r1mr18583435wro.251.1554718856058; 
 Mon, 08 Apr 2019 03:20:56 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id d6sm39336069wrx.62.2019.04.08.03.20.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Apr 2019 03:20:55 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RFC/RFT 3/6] clk: divider: make endian aware
Date: Mon,  8 Apr 2019 12:20:36 +0200
Message-Id: <20190408102039.6366-4-jonas.gorski@gmail.com>
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

Switch clk-divider to the endianness aware accessors to allow big endian
divider clocks on a per device level.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/clk/clk-divider.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index e5a17265cfaf..63cb8617a007 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -135,7 +135,7 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
 	struct clk_divider *divider = to_clk_divider(hw);
 	unsigned int val;
 
-	val = clk_readl(divider->reg) >> divider->shift;
+	val = clk_hw_readl(hw, divider->reg) >> divider->shift;
 	val &= clk_div_mask(divider->width);
 
 	return divider_recalc_rate(hw, parent_rate, val, divider->table,
@@ -370,7 +370,7 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
 		u32 val;
 
-		val = clk_readl(divider->reg) >> divider->shift;
+		val = clk_hw_readl(hw, divider->reg) >> divider->shift;
 		val &= clk_div_mask(divider->width);
 
 		return divider_ro_round_rate(hw, rate, prate, divider->table,
@@ -420,11 +420,11 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
 		val = clk_div_mask(divider->width) << (divider->shift + 16);
 	} else {
-		val = clk_readl(divider->reg);
+		val = clk_hw_readl(hw, divider->reg);
 		val &= ~(clk_div_mask(divider->width) << divider->shift);
 	}
 	val |= (u32)value << divider->shift;
-	clk_writel(val, divider->reg);
+	clk_hw_writel(hw, val, divider->reg);
 
 	if (divider->lock)
 		spin_unlock_irqrestore(divider->lock, flags);
-- 
2.13.2

