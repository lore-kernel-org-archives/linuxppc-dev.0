Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85425C10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 15:04:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E8421473
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 15:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DywZhTaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E8421473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dDGL01sfzDqM1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 01:04:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="DywZhTaQ"; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44d5zf68LGzDqD9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 20:20:57 +1000 (AEST)
Received: by mail-wr1-x444.google.com with SMTP id s15so15619117wra.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8mnGAkNqcxuZE1d5o1rT7GTZ86DBLiU2npJH1dz7dSo=;
 b=DywZhTaQ+ZX7cqT81xN4buH8CasFserd6KDvdKG/o8+XYFMWVMR4VaUVPq3i24vkQW
 boUgCf3jqQTRGP7snfdkIaPyQf3jGFL7zFTFmt8mW03h5H98DukFtCInlQRjbmon0IpT
 cCq1bdnosnbzdC3HQVj9+py+dXK0et1nJw4gPDIZvgySyXHYZqsytjJitNo2WgulUr9q
 QWnPyNK6ESkbX9zrfUHLr/wfQsZ2dxr06btQ/ixUoZEmOGuLIVMvzDt8TjAn/xuxFu+d
 q98nNSzMOqqnMANit2i33EU8fSiWfHNotDuQoayHo+Kut/lAQ6zDSRzCwreKEvkunbch
 2New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8mnGAkNqcxuZE1d5o1rT7GTZ86DBLiU2npJH1dz7dSo=;
 b=XySt6bM6kaPPCP5R71ON2nHlEr32Mqu0hwEhqNTiFnJNz7m6RIWsYp5GZ0ujrNRQg8
 UhKeYVGU1cZ0lEFQnG9B8+1cLipOpY75OGryZO1weO7Ehq3xQPSek/HO+1Q9THWQFEUC
 DRbv/sq4rOZl80NoVddFRKI5YfhHbxeVMMReaxA4VbDx3v1I6uwv6/BEsVWT29AzyH20
 CQ5n5CEd8EGV5bs9nkMZW1UCG+OXsQTUV3WurfyrkQearaWDnceAccVjmAWHgmwcivpN
 927hYZ1V0S/HLsMSa3sQMJDARaNwaegl+yt2O6DrgyUhIh2zn4QL3LQ56hCt9qhzt9eF
 EYyA==
X-Gm-Message-State: APjAAAUXlnB7x0k5FTo0y7D30r89nIp385iZsI+5QP0UlQJrtD+CKjiH
 k8id3yydMeX7P+N2kRdffQw=
X-Google-Smtp-Source: APXvYqw5kDHRzKsb+PuXwdGRHw4C2MsjbCzF5y22PTMSaLYmQHuGk8fBCcINMiKlb6tWmaPbtU9Cow==
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr17629386wrq.94.1554718853687; 
 Mon, 08 Apr 2019 03:20:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id d6sm39336069wrx.62.2019.04.08.03.20.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Apr 2019 03:20:53 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RFC/RFT 1/6] clk: core: add support for generic big endian
 accesses
Date: Mon,  8 Apr 2019 12:20:34 +0200
Message-Id: <20190408102039.6366-2-jonas.gorski@gmail.com>
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

Add a generic flag to mark a clock as big endian register based, and add
accessors following these.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/clk/clk.c            |  1 +
 include/linux/clk-provider.h | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 96053a96fe2f..b706022bb83d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2859,6 +2859,7 @@ static const struct {
 	ENTRY(CLK_IS_CRITICAL),
 	ENTRY(CLK_OPS_PARENT_ENABLE),
 	ENTRY(CLK_DUTY_CYCLE_PARENT),
+	ENTRY(CLK_IS_BIG_ENDIAN),
 #undef ENTRY
 };
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index b7cf80a71293..2c7c17652d75 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -35,6 +35,7 @@
 #define CLK_OPS_PARENT_ENABLE	BIT(12)
 /* duty cycle call may be forwarded to the parent clock */
 #define CLK_DUTY_CYCLE_PARENT	BIT(13)
+#define CLK_IS_BIG_ENDIAN	BIT(14) /* clk registers are big endian */
 
 struct clk;
 struct clk_hw;
@@ -1024,6 +1025,32 @@ static inline void clk_writel(u32 val, u32 __iomem *reg)
 
 #endif	/* platform dependent I/O accessors */
 
+static inline u32 clk_readl_be(u32 __iomem *reg)
+{
+	return ioread32be(reg);
+}
+
+static inline void clk_writel_be(u32 val, u32 __iomem *reg)
+{
+	iowrite32be(val, reg);
+}
+
+static inline u32 clk_hw_readl(struct clk_hw *clk, u32 __iomem *reg)
+{
+	if (clk_hw_get_flags(clk) & CLK_IS_BIG_ENDIAN)
+		return clk_readl_be(reg);
+	else
+		return clk_readl(reg);
+}
+
+static inline void clk_hw_writel(struct clk_hw *clk, u32 val, u32 __iomem *reg)
+{
+	if (clk_hw_get_flags(clk) & CLK_IS_BIG_ENDIAN)
+		clk_writel_be(val, reg);
+	else
+		clk_writel(val, reg);
+}
+
 void clk_gate_restore_context(struct clk_hw *hw);
 
 #endif /* CONFIG_COMMON_CLK */
-- 
2.13.2

