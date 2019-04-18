Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B291DC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 11:23:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2698E214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 11:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nh5HIHVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2698E214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lGtr1tyPzDqQs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 21:23:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="nh5HIHVL"; 
 dkim-atps=neutral
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lGfL44xvzDqQs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 21:12:25 +1000 (AEST)
Received: by mail-wm1-x343.google.com with SMTP id q16so2307724wmj.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 04:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7rH6QiINrW20jZKJQ9mHqe+acRM5fOnj0AeCibP7tdo=;
 b=nh5HIHVL+iaMdKswN/1VECmDUAsvHer42OH6xA6YeVOt3d002kWpK+8tVEU4/in2sy
 5dKDBE0cey7kqrFDpfMO9f2GNGGciWLsaXPzGG5fpfNXIV46BQuprg2U/dfRr+SaKvKG
 2yJHHGxOHyPy63rbRNTvLcc9MPEgztaTgQAV2YL2xDVvDy7ObSO056yCjBo1aXfpBuvg
 BjEcCn3yfXbhUT76eTLUj9z4tvQlF6gSLkKfR1JH6sUbmEfBLB9FrL5wOeT5Ct/o1ITQ
 2mdgTcHGVqAQEdNoOPkWSmDTYz9HZ/rTiZ0sZ3NTGb93M2Qo5auH+q/CRrbv707/QE+t
 +46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7rH6QiINrW20jZKJQ9mHqe+acRM5fOnj0AeCibP7tdo=;
 b=Vae+32ljdgKBzuxbfmtyL//ZISMZYJpqGq1MuqHZKddWxKk5046GwLGG2Ei/1jLYES
 2+7BvWgxVpp8lNnCC8ZCXRLmEdjqcuUsOiQxtPu1rT5+/LY67jWpXBGSU9T5pWbB2HoY
 j1lKBDS3Y/rRLs8VkAxHUXUpoDasEqiw2jLkTkt6VDrS5XlSNQ4KroYf/KatAhVkGZ+5
 SP58uMaAwqBU64YBxYC9B2wR+LlUdtL/mtiaMMVDFl4iHQXHQYt6IDfWO9ZwTNf41Jx/
 0vJlK9/vzdArUlChhISsfv9nNXet33E/+Z30ak/FtGSDvJphGsoV0mQzkvSWeCZbY+4A
 xvtA==
X-Gm-Message-State: APjAAAVsXh4kaCygsZynw1b4QWcWkrz5JVkqITS5Vtuwevp7MSLLZzaC
 6B238t8hDL26rVU/SoO48yE=
X-Google-Smtp-Source: APXvYqyqtoymM85mY8yDZvpZvH8yQ3m231qFQRM7gMJHvVMU6OFaUJjhJvrdys5NJLtR6ZDHgzO3fw==
X-Received: by 2002:a1c:43c2:: with SMTP id q185mr2724953wma.53.1555585943326; 
 Thu, 18 Apr 2019 04:12:23 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id z63sm2005594wme.30.2019.04.18.04.12.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Apr 2019 04:12:22 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org
Subject: [PATCH RFT V3 6/8] powerpc/512x: mark clocks as big endian
Date: Thu, 18 Apr 2019 13:12:09 +0200
Message-Id: <20190418111211.10474-7-jonas.gorski@gmail.com>
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

These clocks' registers are accessed as big endian, so mark them as
such.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
V2 -> V3:
 * slightly rework to avoid a line >80 chars
V1 -> V2:
 * switch from global to local flags

 arch/powerpc/platforms/512x/clock-commonclk.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index b3097fe6441b..af265ae40a61 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -239,6 +239,7 @@ static inline struct clk *mpc512x_clk_divider(
 	const char *name, const char *parent_name, u8 clkflags,
 	u32 __iomem *reg, u8 pos, u8 len, int divflags)
 {
+	divflags |= CLK_DIVIDER_BIG_ENDIAN;
 	return clk_register_divider(NULL, name, parent_name, clkflags,
 				    reg, pos, len, divflags, &clklock);
 }
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

