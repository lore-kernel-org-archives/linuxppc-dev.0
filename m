Return-Path: <SRS0=byMz=YS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C861CA9EA0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 13:23:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE49921D71
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 13:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Z3uV0Rfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE49921D71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4704Z72fmKzDqd3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Oct 2019 00:23:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::243;
 helo=mail-lj1-x243.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="Z3uV0Rfd"; dkim-atps=neutral
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4703dC0CX1zDqXm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2019 23:41:18 +1100 (AEDT)
Received: by mail-lj1-x243.google.com with SMTP id q78so2550495lje.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2019 05:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z5OaxQ59kkoON55cfbSWL0VwoPhm02TOWjYAIOsAYR4=;
 b=Z3uV0RfdqSBBGI7kMp681IHDKiMMw34rS+1vg8ANAi2/RP7D8d5hz7qGr7OAQMasdQ
 E/yrP8KoCcF3Gs8xHW0QTxgNeUgESRT7h8oBi5SRnTslm9x4QgJdl3jlOny6kJ+YAnmz
 uj1IKo2rVkGcWirVH0ntdIuyn4x2gOnoOg8N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z5OaxQ59kkoON55cfbSWL0VwoPhm02TOWjYAIOsAYR4=;
 b=TNnthtIOheh72vzJ7t/x8ZYH+qwleMjNB2nbB50moF8STiZ+cu4Ap1JAeTlBSztkHG
 gP1TnsqTh/a+otTjn5/qMCC0V51xgEqjCuDhYa2dH32//I+9QeWxmTMilj+fRN5dR+Bf
 bmt3W8qRAFlgITWs6QwTXwDAeXsFVaBqcYYEcO1t0ueszenM/qR9yfB1EulyBL59plGK
 Gp4/4lImZ0S04+ZYSCVv2Wp8j7laNfbUfxI+AMYsEkThpkS44zVFBBXt/kgK5uxw6G+4
 ziY12FjV8S11+yJSN0tsv562j7x6e+YpBAskCe8i7UY+uqOrcJMC2qZeSWehvo/ptgh3
 fvIQ==
X-Gm-Message-State: APjAAAVfG8YJNneEgyeB65AGpBfEo85YturIaT7efgz7gkh9ify2IUEe
 pY87DmpBYYqH/9hHedLJ1DMWvw==
X-Google-Smtp-Source: APXvYqzNAB0qiRvZa363YM70OsmO/XrxBScuKvT6WflQox4bqMptOwRaqET29Bl5ng2YUS1roZ66tg==
X-Received: by 2002:a2e:98d8:: with SMTP id s24mr2307434ljj.72.1572007275425; 
 Fri, 25 Oct 2019 05:41:15 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 05:41:15 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 10/23] soc: fsl: qe: use qe_ic_cascade_{low,
 high}_mpic also on 83xx
Date: Fri, 25 Oct 2019 14:40:45 +0200
Message-Id: <20191025124058.22580-11-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025124058.22580-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
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
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
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
 drivers/soc/fsl/qe/qe_ic.c         | 24 ++++--------------------
 include/soc/fsl/qe/qe_ic.h         |  2 --
 3 files changed, 5 insertions(+), 23 deletions(-)

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
 
diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index a847b2672e90..0ff802816c0c 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -402,24 +402,6 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
 
-void qe_ic_cascade_low_ipic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-}
-
-void qe_ic_cascade_high_ipic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-}
-
 void qe_ic_cascade_low_mpic(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
@@ -429,7 +411,8 @@ void qe_ic_cascade_low_mpic(struct irq_desc *desc)
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 
-	chip->irq_eoi(&desc->irq_data);
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
 }
 
 void qe_ic_cascade_high_mpic(struct irq_desc *desc)
@@ -441,7 +424,8 @@ void qe_ic_cascade_high_mpic(struct irq_desc *desc)
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 
-	chip->irq_eoi(&desc->irq_data);
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
 }
 
 void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
index f3492eb13052..fb10a7606acc 100644
--- a/include/soc/fsl/qe/qe_ic.h
+++ b/include/soc/fsl/qe/qe_ic.h
@@ -74,8 +74,6 @@ void qe_ic_set_highest_priority(unsigned int virq, int high);
 int qe_ic_set_priority(unsigned int virq, unsigned int priority);
 int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
 
-void qe_ic_cascade_low_ipic(struct irq_desc *desc);
-void qe_ic_cascade_high_ipic(struct irq_desc *desc);
 void qe_ic_cascade_low_mpic(struct irq_desc *desc);
 void qe_ic_cascade_high_mpic(struct irq_desc *desc);
 void qe_ic_cascade_muxed_mpic(struct irq_desc *desc);
-- 
2.23.0

