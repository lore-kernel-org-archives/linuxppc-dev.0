Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AD4C10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 15:07:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2120021473
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 15:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d17i09sr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2120021473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dDLG1dhZzDq9b
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 01:07:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="d17i09sr"; 
 dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44d5zh00HKzDqF0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 20:21:00 +1000 (AEST)
Received: by mail-wm1-x342.google.com with SMTP id v14so14056759wmf.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 03:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uos6Ss4ukbBTFHAWbjMX+2nhjoQLM7lIBz4DiklN5mM=;
 b=d17i09sroO1+C8AnLcntaK5z4ZZl5PI/HhpnTM5AwjEf0+Xt5dZFPZzmoOP6DcAFx7
 bgpQhjwSXHQ7XZyB+WSomVPsLl1Q77MdG4r5H8PW0ousSNEiZYBv4sRrpTN6phuq05Ei
 fkVDQWpH54nWEqu5xEzUeaHGSN6fbca1qUKH0mB87cWxQ5VnO3f1BvvtfKHphi2k6tQg
 orVnZCizLIbuD6fmhZtXxzsiuEHBHBIea5dQ2yXck7XVX1SfR6Au0m+C1+YuHi6nIsCH
 HB3Sb3anmwVg8MZxlA+//VSxf8c1mHJ28xLb7wm3+vI167mf5hJG8ab0UG/v9KXXJMeN
 MJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uos6Ss4ukbBTFHAWbjMX+2nhjoQLM7lIBz4DiklN5mM=;
 b=JTkhObWeK6PVBvTrNylUZTuXM/pr7dIlIlbXnrOt02QsDH+YGlP5laIRYQ4CaQgm1v
 Ztv/4sFs7pk4RQKxnsQ755WY8mTI7wK4wJXfltoQu5MGZaee6IyBd0hUuVsHeeG1BMJJ
 HkvX32qPXFsrU7/P2z9k+dcM7gUZ0foPa6YLsKLVSuDG6vvKmuzqpAYq1dS6nBGgnGCt
 Hfwid6It1WzoyEL+BUSY8vIfYQ3twZvMREZK4aL9wuEKF4inU+Zyw6MP3BXQ7OF/QrCo
 XjsUUVu94iveNHq14AuiaZh82sC9O7EeskXetfrTenkR5C52Qm61d0TcjAW19Bh1fqit
 bPog==
X-Gm-Message-State: APjAAAX9U1jCSZJCUh6MThVvQ8grN8R20SML1x72v0BUMvjfa5pNXvyJ
 9HJDVhtSkvo6/noDmDoVK+M=
X-Google-Smtp-Source: APXvYqy/e+I3FKRmUAEVmK3w9u/9ZjxjvsC+m463esRFcYln100KieuofO9WNZlnXC6P+AXSXH5itA==
X-Received: by 2002:a1c:208c:: with SMTP id g134mr17366615wmg.70.1554718857505; 
 Mon, 08 Apr 2019 03:20:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id d6sm39336069wrx.62.2019.04.08.03.20.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Apr 2019 03:20:56 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RFC/RFT 4/6] clk: mux: make endian aware
Date: Mon,  8 Apr 2019 12:20:37 +0200
Message-Id: <20190408102039.6366-5-jonas.gorski@gmail.com>
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

Switch clk-mux to the endianness aware accessors to allow big endian
mux clocks on a per device level.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/clk/clk-mux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 2ad2df2e8909..4a02db06eb29 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -73,7 +73,7 @@ static u8 clk_mux_get_parent(struct clk_hw *hw)
 	struct clk_mux *mux = to_clk_mux(hw);
 	u32 val;
 
-	val = clk_readl(mux->reg) >> mux->shift;
+	val = clk_hw_readl(hw, mux->reg) >> mux->shift;
 	val &= mux->mask;
 
 	return clk_mux_val_to_index(hw, mux->table, mux->flags, val);
@@ -94,12 +94,12 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	if (mux->flags & CLK_MUX_HIWORD_MASK) {
 		reg = mux->mask << (mux->shift + 16);
 	} else {
-		reg = clk_readl(mux->reg);
+		reg = clk_hw_readl(hw, mux->reg);
 		reg &= ~(mux->mask << mux->shift);
 	}
 	val = val << mux->shift;
 	reg |= val;
-	clk_writel(reg, mux->reg);
+	clk_hw_writel(hw, reg, mux->reg);
 
 	if (mux->lock)
 		spin_unlock_irqrestore(mux->lock, flags);
-- 
2.13.2

