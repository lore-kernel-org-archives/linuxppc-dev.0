Return-Path: <SRS0=byMz=YS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FF6CA9EA0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 13:49:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C6620679
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 13:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="J6UXGh2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C6620679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4705872WxvzDqnc
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Oct 2019 00:49:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::241;
 helo=mail-lj1-x241.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="J6UXGh2w"; dkim-atps=neutral
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4703dQ0zXgzDqd3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2019 23:41:30 +1100 (AEDT)
Received: by mail-lj1-x241.google.com with SMTP id c4so2516293lja.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2019 05:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R3SaCctQ33G0LqzlxkoZQqgVXIOLmGcZ9QAc4BskcDk=;
 b=J6UXGh2wqwAc/+LZXDTKvF+WwOwD8qwr2FNWm47poYQ8yc8qW2mTPT0FRMZguXjutf
 c8DuE0S0rSMO8D8ykEDKzSp+ZeTtkwJJx2JS6QDezvAfV+MvPc4M3VUtiDWMtzXvxVFn
 +oi5/ChWZGObNUyC4Kq+YiDjBVfDbrRcmEavk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R3SaCctQ33G0LqzlxkoZQqgVXIOLmGcZ9QAc4BskcDk=;
 b=UTtH8uwOWLyHG4n5/hEfZcpmQtVREORndE3hvJFtG9AHluLaly72GAyHBEYAEsaHoL
 zu1jH3GIeyPayajI5uRzLrOyl/x2b6io4+KxQDWHfdTNxfJJOKv7dW4oSeFSgH0ZHeXa
 FLvQSKZRGsjLt9gA53vRknM697J5n3g4DyRo4i2jJtuZlmWhIjVVYS6M6yoKQDTFzMrL
 dCqbI1B6HEfegTczog8fM+e2rVGPv5shQxghFgQzlD7ceXlYzfmvzqrIgSZ/rSxe5NuA
 cFgYK6bGOf1iOiCY834KoD4W//9LdAjiRn4JAXIFmTeTmv1RXiLBc+DOJ9xEfOektKlH
 lxiA==
X-Gm-Message-State: APjAAAVZQXq2StRNYkxZmyMXFMj2GEIGDgevfBe893y0YfOpnTsVt8mS
 qzkk/L6hyi+PT+kUUAwBCMCUBw==
X-Google-Smtp-Source: APXvYqxP7naa1DeBshE45tVgmMrsPdv0NnSq2X2IndFsFfhsb895JAiwuYIede4Uh4vXem9QRAO5EQ==
X-Received: by 2002:a2e:9117:: with SMTP id m23mr2391175ljg.82.1572007284671; 
 Fri, 25 Oct 2019 05:41:24 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 05:41:24 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 17/23] soc: fsl: qe: make qe_ic_cascade_* static
Date: Fri, 25 Oct 2019 14:40:52 +0200
Message-Id: <20191025124058.22580-18-linux@rasmusvillemoes.dk>
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

Now that the references from arch/powerpc/ are gone, these are only
referenced from inside qe_ic.c, so make them static.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 6 +++---
 include/soc/fsl/qe/qe_ic.h | 4 ----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 545eb67094d1..e20f1205c0df 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -402,7 +402,7 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
 
-void qe_ic_cascade_low(struct irq_desc *desc)
+static void qe_ic_cascade_low(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
@@ -415,7 +415,7 @@ void qe_ic_cascade_low(struct irq_desc *desc)
 		chip->irq_eoi(&desc->irq_data);
 }
 
-void qe_ic_cascade_high(struct irq_desc *desc)
+static void qe_ic_cascade_high(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
@@ -428,7 +428,7 @@ void qe_ic_cascade_high(struct irq_desc *desc)
 		chip->irq_eoi(&desc->irq_data);
 }
 
-void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
+static void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq;
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
index 8ec21a3bd859..43e4ce95c6a0 100644
--- a/include/soc/fsl/qe/qe_ic.h
+++ b/include/soc/fsl/qe/qe_ic.h
@@ -67,8 +67,4 @@ void qe_ic_set_highest_priority(unsigned int virq, int high);
 int qe_ic_set_priority(unsigned int virq, unsigned int priority);
 int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
 
-void qe_ic_cascade_low(struct irq_desc *desc);
-void qe_ic_cascade_high(struct irq_desc *desc);
-void qe_ic_cascade_muxed_mpic(struct irq_desc *desc);
-
 #endif /* _ASM_POWERPC_QE_IC_H */
-- 
2.23.0

