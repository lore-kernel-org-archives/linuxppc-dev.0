Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BE2C10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 14:56:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD332147A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 14:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBKVd9DP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD332147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dD5r5gntzDqLW
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 00:56:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rBKVd9DP"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44d5zf1J4YzDqD9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 20:21:01 +1000 (AEST)
Received: by mail-wm1-x344.google.com with SMTP id c1so13660734wml.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 03:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AefBW/AvMar/umpkSgBRCO6SDsmqV5F3Ia9cimceqxI=;
 b=rBKVd9DPN9C+GpT4mA+99KIovJ/1lf/0okwLnzSckfuq9z+AlsO3MVB80fkDjmZfyp
 18yWGCqSSFJZpykilQm/w+KHTVOYmtOefiKgFUgS8pUf7Fze69TT3Up0HqrTOX5cq9f7
 j63WmBuk6Zw8bIlkIc4Nz4JNiSRS30SNfeHKdW37JH41FbowYzPfVmkUvqjCk4BUdzzC
 pi3Cmhqwg4gt5Q4eh6qTsDLjb5fQqtwuCz88sEjREWSJ6dzC+ROhvPo0UGOar5EcwKZT
 bxlHYp/n76TDy6XpwOwyJMOXKwSz9NgyHzj49odmJt2LD35JjJuMQZoVuZ61Rue4rc4l
 w+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AefBW/AvMar/umpkSgBRCO6SDsmqV5F3Ia9cimceqxI=;
 b=pvmogJmnRxrTzFwsQy1/Cn+AFPVMIbXaDpqIfe9kK6n8IOwitimmVDQH4tgmmvmxiB
 oE/59FEO79Bd5SOOcRaFaGSfUi0GEDGH46u67Zd6PkTS2+k5T8/wR+ZqlK1UQ3KtDiWt
 7e3wYuIGM26Q8VyRuUg1TI+ez6B6UJmgIsbfG6uh3yYfGpD7/3wzAyMUI6jT47eHPsW/
 cpB6x7F11WfluGExS6XbDBgeaTw59sp8j5DnXjs3olOWbtX389KtolOpa5+EYtAHXClG
 3D3yAt5gkpt+zE+jaLzMoyu7p6yREiKA5hwiRAS5QxQPEfxVv4ife87KUfwB58noLjRw
 jOyA==
X-Gm-Message-State: APjAAAUMIvYMRy7X7VicSxlw/w1UgslCk4ASKKk4xG4Z/SSQRtEz4c1H
 RF7eUCScj8dN7w+GMns0FR4=
X-Google-Smtp-Source: APXvYqyV30JZzAhFnNQyJv71EJs1kxMjta4LpfNnB+rvTsETu8FlIbM5jEnyxcRN8oeWMEaWfdqT2A==
X-Received: by 2002:a1c:be0e:: with SMTP id o14mr15950501wmf.11.1554718858833; 
 Mon, 08 Apr 2019 03:20:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id d6sm39336069wrx.62.2019.04.08.03.20.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Apr 2019 03:20:58 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RFC/RFT 5/6] powerpc/512x: mark clocks as big endian
Date: Mon,  8 Apr 2019 12:20:38 +0200
Message-Id: <20190408102039.6366-6-jonas.gorski@gmail.com>
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

These clocks' registers are accessed as big endian, so mark them as
such.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/powerpc/platforms/512x/clock-commonclk.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index b3097fe6441b..af86a65128f1 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -239,8 +239,9 @@ static inline struct clk *mpc512x_clk_divider(
 	const char *name, const char *parent_name, u8 clkflags,
 	u32 __iomem *reg, u8 pos, u8 len, int divflags)
 {
-	return clk_register_divider(NULL, name, parent_name, clkflags,
-				    reg, pos, len, divflags, &clklock);
+	return clk_register_divider(NULL, name, parent_name,
+				    clkflags | CLK_IS_BIG_ENDIAN, reg, pos, len,
+				    divflags, &clklock);
 }
 
 static inline struct clk *mpc512x_clk_divtable(
@@ -248,10 +249,12 @@ static inline struct clk *mpc512x_clk_divtable(
 	u32 __iomem *reg, u8 pos, u8 len,
 	const struct clk_div_table *divtab)
 {
+	int clkflags;
 	u8 divflags;
 
+	clkflags = CLK_IS_BIG_ENDIAN;
 	divflags = 0;
-	return clk_register_divider_table(NULL, name, parent_name, 0,
+	return clk_register_divider_table(NULL, name, parent_name, clkflags,
 					  reg, pos, len, divflags,
 					  divtab, &clklock);
 }
@@ -262,7 +265,7 @@ static inline struct clk *mpc512x_clk_gated(
 {
 	int clkflags;
 
-	clkflags = CLK_SET_RATE_PARENT;
+	clkflags = CLK_SET_RATE_PARENT | CLK_IS_BIG_ENDIAN;
 	return clk_register_gate(NULL, name, parent_name, clkflags,
 				 reg, pos, 0, &clklock);
 }
@@ -274,7 +277,7 @@ static inline struct clk *mpc512x_clk_muxed(const char *name,
 	int clkflags;
 	u8 muxflags;
 
-	clkflags = CLK_SET_RATE_PARENT;
+	clkflags = CLK_SET_RATE_PARENT | CLK_IS_BIG_ENDIAN;
 	muxflags = 0;
 	return clk_register_mux(NULL, name,
 				parent_names, parent_count, clkflags,
-- 
2.13.2

