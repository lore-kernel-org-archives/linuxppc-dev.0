Return-Path: <SRS0=Uveu=YL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF93CA9EA0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Oct 2019 13:00:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45862089C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Oct 2019 13:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="KFyP8ivf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45862089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46vmNt4SfgzDrdV
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Oct 2019 00:00:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::142;
 helo=mail-lf1-x142.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="KFyP8ivf"; dkim-atps=neutral
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46vmCk4mk0zDrVb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2019 23:52:47 +1100 (AEDT)
Received: by mail-lf1-x142.google.com with SMTP id q12so4613800lfc.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2019 05:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b/kYsXKDEeEBcA1fCE+mpoBIaUoXu8b4ge6C0aEmGGA=;
 b=KFyP8ivfbpHtepeGzrcdL51yIH0E0bUb8X+4a2KH0HGN4QWsIwbhQQBDFzpw8B4QAS
 RbUd93jPl4MuGJetIgGZbsZyOKrmZfbazbh3U8W4NiWpzrx9at5H+K/9lL3NoBdPWnbx
 iTRZaQAOW1xXsH1h45p9Y3RpNKZaeJif7ZIvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b/kYsXKDEeEBcA1fCE+mpoBIaUoXu8b4ge6C0aEmGGA=;
 b=g0eHg3cQBV4ujF4qlMWAyjCdtjxG3eOsmknCML5OngcNrR19FztdTZT2cee+ycVLu3
 KuCBTrPOBe3eF3FCyzxXxBOsEpTrGSaObg0F8nNMI3ytTqNgAW4KGXRjF2jwOxDk+fxK
 opjp3U34UZCTE1NFOFMj57kxupOicLmj7EfHP6vbgfBohwnyuCps1yHm5Jvjokq6h48R
 BzUMbGQ5SZ6wUH02qyXtDzt0EqSwFim40tsqIIHvhVbKdEJI/kxwZ1N9ZkqfMW9Wbqal
 u1o+P0N6xMqQ8/dLZVfa0/LQ8D5t/6iy3fZn1JZUxsLYs5irfxikO+jIv5U9NVvoN8X9
 0WFg==
X-Gm-Message-State: APjAAAV0oYbl6wU8gTqq61kVdlFzqauFRVgNeiLV4pAhoe53V97LXiq4
 rXa1BWTHZvIMoQOP4kfqKOHgXQ==
X-Google-Smtp-Source: APXvYqwfp2OR81F0L53trJi7RZb+gW5SZ6EFdq5/LmCgN8KPrYOURZTPP/LvsMtj32ugvHQiRs800Q==
X-Received: by 2002:a05:6512:71:: with SMTP id
 i17mr5903293lfo.68.1571403163737; 
 Fri, 18 Oct 2019 05:52:43 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id m17sm7454792lje.0.2019.10.18.05.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 05:52:42 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 2/7] soc: fsl: qe: drop volatile qualifier of struct
 qe_ic::regs
Date: Fri, 18 Oct 2019 14:52:29 +0200
Message-Id: <20191018125234.21825-3-linux@rasmusvillemoes.dk>
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

The actual io accessors (e.g. in_be32) implicitly add a volatile
qualifier to their address argument. Remove volatile from the struct
definition and the qe_ic_(read/write) helpers, in preparation for
switching from the ppc-specific io accessors to generic ones.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 4 ++--
 drivers/soc/fsl/qe/qe_ic.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 9bac546998d3..9694569dcc76 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -171,12 +171,12 @@ static struct qe_ic_info qe_ic_info[] = {
 		},
 };
 
-static inline u32 qe_ic_read(volatile __be32  __iomem * base, unsigned int reg)
+static inline u32 qe_ic_read(__be32  __iomem * base, unsigned int reg)
 {
 	return in_be32(base + (reg >> 2));
 }
 
-static inline void qe_ic_write(volatile __be32  __iomem * base, unsigned int reg,
+static inline void qe_ic_write(__be32  __iomem * base, unsigned int reg,
 			       u32 value)
 {
 	out_be32(base + (reg >> 2), value);
diff --git a/drivers/soc/fsl/qe/qe_ic.h b/drivers/soc/fsl/qe/qe_ic.h
index 08c695672a03..9420378d9b6b 100644
--- a/drivers/soc/fsl/qe/qe_ic.h
+++ b/drivers/soc/fsl/qe/qe_ic.h
@@ -72,7 +72,7 @@
 
 struct qe_ic {
 	/* Control registers offset */
-	volatile u32 __iomem *regs;
+	u32 __iomem *regs;
 
 	/* The remapper for this QEIC */
 	struct irq_domain *irqhost;
-- 
2.20.1

