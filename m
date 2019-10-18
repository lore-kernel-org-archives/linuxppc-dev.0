Return-Path: <SRS0=Uveu=YL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380CECA9EA0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Oct 2019 12:57:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80DD2222C2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Oct 2019 12:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="FSHcuBzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DD2222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46vmJb4MTXzDrRF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Oct 2019 23:57:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::241;
 helo=mail-lj1-x241.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="FSHcuBzP"; dkim-atps=neutral
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46vmCj515rzDrVT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2019 23:52:45 +1100 (AEDT)
Received: by mail-lj1-x241.google.com with SMTP id n14so6089355ljj.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2019 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=76C3KCBVTIWXOJRoGbkicD5UasUbJ5XDGEEs+OOGNvk=;
 b=FSHcuBzPR1mmeL4PACLKsTbqTj+24LBzK/6l+O/Lm/1IrQLP3nhdrLnFf6MSg0yH0g
 HoftTcmnUioa5SuvRouA12dlbveQ/icRsojJyg7o+TA6FzCF4LpHeb/WCkcTlKMjOMFj
 W12H1zsXT9+1u+Ng90qJFYXAQtc1ter6pD6Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=76C3KCBVTIWXOJRoGbkicD5UasUbJ5XDGEEs+OOGNvk=;
 b=E1FRFYQGWw3fwXk5HkD5e1c76FK/oNs0XNay+EXAwSkjIL/TucS2LOvnrl5sTTgO/B
 FJlgqPrbIU/vIaHmaFFKE9m4Itls7xpLYtfYeH+kEfTzwtuRYpIUEw7JzviSB/L0Uee8
 70AOIwH96HmRAT1J9S2Bg+uGGeunwtsuoJWxlpkm0TpR6wiJIOTu74W0nc1t67zFB6+s
 UyM6gEWfp6I+CObx6EO65Uy2Lw2Gt75eub/UPr8OTEkGWHqHXoFSs4/kShRRWDDmdyjj
 Y0nmvvlS6xol7cl64QeEXEVPLd5gJJLxeBVKnl38DdVQ2kMWDGUhVei5tZ7wEBJuWlaF
 Xv8g==
X-Gm-Message-State: APjAAAXm4F/VKSq9H37/Gu+BwWNF6yglB6P/94Z+4jU60CugfJeorvKz
 lDCtNfBBZjf3Asnh+MV90cWKtXABBT185red
X-Google-Smtp-Source: APXvYqwYe6ilX8TDGuGskrpio0qKSxCNGwmNMC2CS8ROsNPpnWHiv5TjxIYmTv9OVkt1GHfcoMvdMg==
X-Received: by 2002:a2e:9112:: with SMTP id m18mr6305431ljg.75.1571403161898; 
 Fri, 18 Oct 2019 05:52:41 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id m17sm7454792lje.0.2019.10.18.05.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 05:52:40 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 1/7] soc: fsl: qe: remove space-before-tab
Date: Fri, 18 Oct 2019 14:52:28 +0200
Message-Id: <20191018125234.21825-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 417df7e19281..6fcbfad408de 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -378,8 +378,8 @@ static int qe_sdma_init(void)
 	}
 
 	out_be32(&sdma->sdebcr, (u32) sdma_buf_offset & QE_SDEBCR_BA_MASK);
- 	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK |
- 					(0x1 << QE_SDMR_CEN_SHIFT)));
+	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK |
+					(0x1 << QE_SDMR_CEN_SHIFT)));
 
 	return 0;
 }
-- 
2.20.1

