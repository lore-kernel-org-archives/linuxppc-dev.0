Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB46C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:22:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BAC2075B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 10:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi8BP0Az"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BAC2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jPhV41qczDqH6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 20:22:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qi8BP0Az"; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jPQw5QbwzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 20:11:04 +1000 (AEST)
Received: by mail-wr1-x444.google.com with SMTP id y7so21104254wrn.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 03:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1utUG9oo11jNXQpQkS4fRJ6SG9XxN3l3dVfTXDmhkww=;
 b=Qi8BP0AzvIj0CLEGzLnz/Oj66x7Dup5/AB4St3neDWs+l/i0yiEZGoj2S4lnmAo91j
 6/Qv4T6XF36DDGNKBw+wk0oFjNaEZQipRQAFa25p/OHpCu/QtsYR1hcziqSoKRGMFM9K
 LCDXH/dTI5b0GTYpzcbOvk4ZRiG/pKpdi7ZvbIEGE5ISd8pPn04AmqjSYmOwOHhQ/pyo
 iSrtKlnKUuDzZUg6NFMOpDFbl737JjXPmWD/NW671VrdazNDzygD6zM8hh+3A1v2/wy8
 MYN6yFc7198iiPRhhsd3HyhW8VLm+sFt6x6mgoeq7p7W2zSzm99BSUO+VEsNocKqwZ/m
 08Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1utUG9oo11jNXQpQkS4fRJ6SG9XxN3l3dVfTXDmhkww=;
 b=BxxFjZiltPiTqLqCewPfssRv9Nk0e/GmrmFldN3vDISzhSiWZLTjfU/mcIYsIlyMsv
 96v+9BslOheHHumRdOxsdKOxf6wHglkmzoeUdN6ITk7LVmEggjpU33WyqEV1wvqr4WZV
 0MiJsXEbs+Lki+OQk0+NZpIkC3DVOrjGccZiZ0sMPTSU2SQj8bUdSljpShvkN8PFDesm
 F20VerOuwlInq5lspQAhFu6SJipzGbKBNhRgw9xZDIz3vzmqcdwbmN5agzuBRPZuanLo
 qyn3Co/9yFNTgwVo9kYCmP20HBiBedyJJIYpNMinZCyxPFnosyM7e8Fqj8DIMw+Te/at
 Xkag==
X-Gm-Message-State: APjAAAXSrIJoDzHR25WtUfH2L3kCwN9btPz87vPn3JHUVRToSgJAJxhm
 Yp3I67ZbbAQV+C2dzhVV8Ao=
X-Google-Smtp-Source: APXvYqzDXCPaXtO/0J6yWiR1mbQTpGNquiOsxi0UOZGLzVVoYvpAf+tZqDLVoX6afIm4E1NjyaPrJQ==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr25387wrw.68.1555323062247;
 Mon, 15 Apr 2019 03:11:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id d6sm11592214wrp.9.2019.04.15.03.11.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Apr 2019 03:11:01 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org
Subject: [PATCH RFT V2 6/8] powerpc/512x: mark clocks as big endian
Date: Mon, 15 Apr 2019 12:10:44 +0200
Message-Id: <20190415101046.5872-7-jonas.gorski@gmail.com>
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

These clocks' registers are accessed as big endian, so mark them as
such.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
V1 -> V2:
 * switch from global to local flags

 arch/powerpc/platforms/512x/clock-commonclk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index b3097fe6441b..0072330350fa 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -240,7 +240,8 @@ static inline struct clk *mpc512x_clk_divider(
 	u32 __iomem *reg, u8 pos, u8 len, int divflags)
 {
 	return clk_register_divider(NULL, name, parent_name, clkflags,
-				    reg, pos, len, divflags, &clklock);
+				    reg, pos, len,
+				    divflags | CLK_DIVIDER_BIG_ENDIAN, &clklock);
 }
 
 static inline struct clk *mpc512x_clk_divtable(
@@ -250,7 +251,7 @@ static inline struct clk *mpc512x_clk_divtable(
 {
 	u8 divflags;
 
-	divflags = 0;
+	divflags = CLK_DIVIDER_BIG_ENDIAN;
 	return clk_register_divider_table(NULL, name, parent_name, 0,
 					  reg, pos, len, divflags,
 					  divtab, &clklock);
@@ -261,10 +262,12 @@ static inline struct clk *mpc512x_clk_gated(
 	u32 __iomem *reg, u8 pos)
 {
 	int clkflags;
+	u8 gateflags;
 
 	clkflags = CLK_SET_RATE_PARENT;
+	gateflags = CLK_GATE_BIG_ENDIAN;
 	return clk_register_gate(NULL, name, parent_name, clkflags,
-				 reg, pos, 0, &clklock);
+				 reg, pos, gateflags, &clklock);
 }
 
 static inline struct clk *mpc512x_clk_muxed(const char *name,
@@ -275,7 +278,7 @@ static inline struct clk *mpc512x_clk_muxed(const char *name,
 	u8 muxflags;
 
 	clkflags = CLK_SET_RATE_PARENT;
-	muxflags = 0;
+	muxflags = CLK_MUX_BIG_ENDIAN;
 	return clk_register_mux(NULL, name,
 				parent_names, parent_count, clkflags,
 				reg, pos, len, muxflags, &clklock);
-- 
2.13.2

