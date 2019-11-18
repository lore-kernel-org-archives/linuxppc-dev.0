Return-Path: <SRS0=h9PY=ZK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABE6C432C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 11:56:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE352068D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 11:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="XwxihX/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE352068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47GnVw1mNtzDqRF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 22:56:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::342;
 helo=mail-wm1-x342.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="XwxihX/g"; dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Gmmh0h8HzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2019 22:23:47 +1100 (AEDT)
Received: by mail-wm1-x342.google.com with SMTP id b17so18332790wmj.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2019 03:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XBMri+/30LVPDwr/Z+UtZHm4sLSriiAUm4o/nxS90ZM=;
 b=XwxihX/gOwrx+y04fM23yehEh+sPis4cGHhlyJmxzkcnYDvy0QGxfaHnzbuslYnP8w
 vPQYU+JOn6T6eUjPcYuJdpGSZpQQ8KopPXBLQLO+Cnq00CmTVfqoGU0TVjG9XsGrTeRI
 3EObzG2+QC760zIH/Z5JnFmsHP9k/oZs5kUPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XBMri+/30LVPDwr/Z+UtZHm4sLSriiAUm4o/nxS90ZM=;
 b=mcVjVugKXHKXneUW0ujRloAmADxeKajIHSP9lh6Lym8IjGE1fY+u5TiMHPQ+v9+U5Q
 4nZbEUC2bmvL4B7FXdfIlilF3VCuDQj1TbH3Yev2kVLUGt+GXP/wlnfggToupOfkfVcL
 AQS94LnThzYb8mQ5Ica+nQTwTCwbr4yeyOS+q5u/Za0+Q/iq6vUZ7QVCSzomwDePOagR
 TI70wtf6TwNlaCKb/NiE/MuaM6wB/m//5ytbZzYX6bF4EW7cgG5K2dyK7UyGxHrJSUyw
 QzIe6RvBdfXcHgId8aT2gLWeJ1rhchNq009xLVQ9ETbZ6gSaPAEtO/3gOGMZz87xJPc8
 2+NQ==
X-Gm-Message-State: APjAAAVKRbl2U2j1HO152KBQWyz4kRFyNACz7wEzi6xoccphvRqyPOR9
 /fl6qIad6p9hNgM4Ec2S2FtNzA==
X-Google-Smtp-Source: APXvYqyofnRzcLiCqR4UEC7wz7/x2pof42n82PY10PtFAILsthfOJbkCddIWyFORHPtQjnOdgXG+Ww==
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr30646195wmc.113.1574076224233; 
 Mon, 18 Nov 2019 03:23:44 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk.
 [5.186.115.54])
 by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 03:23:43 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 11/48] soc: fsl: qe: use qe_ic_cascade_{low,
 high}_mpic also on 83xx
Date: Mon, 18 Nov 2019 12:22:47 +0100
Message-Id: <20191118112324.22725-12-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
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
Cc: Timur Tabi <timur@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The *_ipic and *_mpic handlers are almost identical - the only
difference is that the latter end with an unconditional
chip->irq_eoi() call. Since IPIC does not have ->irq_eoi, we can
reduce some code duplication by calling irq_eoi conditionally.

This is similar to what is already done in mpc8xxx_gpio_irq_cascade().

This leaves the functions slightly misnamed, but that will be fixed in
a subsequent patch.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/platforms/83xx/misc.c |  2 +-
 include/soc/fsl/qe/qe_ic.h         | 24 ++++--------------------
 2 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index f46d7bf3b140..779791c0570f 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -100,7 +100,7 @@ void __init mpc83xx_qe_init_IRQ(void)
 		if (!np)
 			return;
 	}
-	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
+	qe_ic_init(np, 0, qe_ic_cascade_low_mpic, qe_ic_cascade_high_mpic);
 	of_node_put(np);
 }
 
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
index 714a9b890d8d..bfaa233d8328 100644
--- a/include/soc/fsl/qe/qe_ic.h
+++ b/include/soc/fsl/qe/qe_ic.h
@@ -74,24 +74,6 @@ void qe_ic_set_highest_priority(unsigned int virq, int high);
 int qe_ic_set_priority(unsigned int virq, unsigned int priority);
 int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
 
-static inline void qe_ic_cascade_low_ipic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-}
-
-static inline void qe_ic_cascade_high_ipic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-}
-
 static inline void qe_ic_cascade_low_mpic(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
@@ -101,7 +83,8 @@ static inline void qe_ic_cascade_low_mpic(struct irq_desc *desc)
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 
-	chip->irq_eoi(&desc->irq_data);
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
 }
 
 static inline void qe_ic_cascade_high_mpic(struct irq_desc *desc)
@@ -113,7 +96,8 @@ static inline void qe_ic_cascade_high_mpic(struct irq_desc *desc)
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 
-	chip->irq_eoi(&desc->irq_data);
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
 }
 
 static inline void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
-- 
2.23.0

