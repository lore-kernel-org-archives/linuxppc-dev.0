Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B988C10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 15:05:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9928121473
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 15:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvSZzgqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9928121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dDJL0G1pzDq9b
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 01:05:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=jonas.gorski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="CvSZzgqT"; 
 dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44d5zg535lzDqD9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 20:21:03 +1000 (AEST)
Received: by mail-wm1-x341.google.com with SMTP id y197so14099490wmd.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 03:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8d4+YOFpkrO0DI3J1F6jt29ItFJWGxGJfwQOSXJrk3Y=;
 b=CvSZzgqTYVThKj0KYm2VCJHtbpg34B6q/tDBx1AJj/5ME2Gj2H5Yw5ZwIzvv3YfKYV
 /Pu4l/yo8gECqCWdYXmece7AvG/MNDk7icUgQE//bIyF8GZos+j/KDMAns8Nlq8xv0ZU
 ZdYe7gyoO1IZWNQbTAbbEdalrQHd79JIXwkkzxlbDlwbKslRwZxXNC8r/ELLtPZesIzr
 QtqZD75Df0MkE6wbLu/CSKjyOxtTYB4ouvNXRrzHc6TDlyyhTDZvaM/8mYnQDQnL8O9H
 /gcWJzl1WI5pdwXcjrv2y1ehUjqpQmhMIo4J+9qnPxA9UA1DgPPYDCmQZ5TrZo+Ix3Ow
 mgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8d4+YOFpkrO0DI3J1F6jt29ItFJWGxGJfwQOSXJrk3Y=;
 b=M3dusjk6u4vuWbj9FWwan4hhG/3xDbAdVFdX6zJgcU25vrdqP95MMZUHamuixdfcXn
 3wLtb4pNK3lpAX4KM8VX4jttVAuVAMaMCyREx7DBOFmclELAFaj6nSdJeQEdhRi7R/qc
 RFXhfH4I76kugfq7nlGsVf7C/AsC2z777hyGeW8kyL9rAtrDB2mO0fasF6eTlTQlL8i/
 4lNkjU91yC89EIV2Ry7sX5Ti/XDoAGabRADnZ+fuBoie9mIwOOZo4QnkkOKHuvu2A18Q
 DFkmR+XKvLBVIgu+qrQTFqT/CD4w/w5fmIjj8gf9M9UolCRuBl5iKFUUNvckZJ0Wv7xg
 K4cQ==
X-Gm-Message-State: APjAAAVseuLXgGvT1GF5VBpAtLKVJqMiKmKOR+TdZBIdIDTdOu76S80s
 jPJqdXKFvzsLqV22sRLV8e8=
X-Google-Smtp-Source: APXvYqzzoBCdlgNEMB3F1Oldh1igkRdDt3NwP6IMwi/KUg5s8MlWW9wTLX+0gcAoVGXL97HfI+w21g==
X-Received: by 2002:a1c:b646:: with SMTP id g67mr18014054wmf.125.1554718860361; 
 Mon, 08 Apr 2019 03:21:00 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
 by smtp.gmail.com with ESMTPSA id d6sm39336069wrx.62.2019.04.08.03.20.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Apr 2019 03:20:59 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-clk@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RFC/RFT 6/6] clk: core: remove powerpc special handling
Date: Mon,  8 Apr 2019 12:20:39 +0200
Message-Id: <20190408102039.6366-7-jonas.gorski@gmail.com>
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

Now that the powerpc clocks are properly marked as big endian, we can
remove the special handling for PowerPC.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 include/linux/clk-provider.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 2c7c17652d75..6755befb6cee 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -999,20 +999,6 @@ static inline int of_clk_detect_critical(struct device_node *np, int index,
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
@@ -1023,8 +1009,6 @@ static inline void clk_writel(u32 val, u32 __iomem *reg)
 	writel(val, reg);
 }
 
-#endif	/* platform dependent I/O accessors */
-
 static inline u32 clk_readl_be(u32 __iomem *reg)
 {
 	return ioread32be(reg);
-- 
2.13.2

