Return-Path: <SRS0=QEr8=ZU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85DBC432C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Nov 2019 16:54:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683C421771
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Nov 2019 16:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="h5Ofrh1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683C421771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47P3f71DDTzDr5h
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Nov 2019 03:54:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::141;
 helo=mail-lf1-x141.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="h5Ofrh1l"; dkim-atps=neutral
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47P13F4hxrzDqsw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2019 01:58:01 +1100 (AEDT)
Received: by mail-lf1-x141.google.com with SMTP id r15so17325574lff.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Nov 2019 06:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A3LxCwaWF3+EjSkH3Z11+aFYy5ZGZLaMI8GPoISP0aQ=;
 b=h5Ofrh1lS1SdvEU2TywQndew2wv/s6SlshVIlXBQI587u1AT3EXJXpyq2oJdPtVTHA
 ffPQYYcE3fOicrEVwVc9YzvRFsFG48tQ72uf4CxV3GNrG6HUW7b3FV+oHlayfUO2uleS
 drOU4bl3A8RKImHPPcr3Gta017yms39ACmP2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A3LxCwaWF3+EjSkH3Z11+aFYy5ZGZLaMI8GPoISP0aQ=;
 b=BTe5punCx99dJiVtqkejyQy7W9vZVbH2b4FxBUga5yj+67ZHboc9MeiwvmSAogNIXk
 K5PODCaX/94XcS/Zz0uLHH+fWJQuSac9IFKuWUWISGqGi87gz/AHpidRpiGX1yd5PbDJ
 mQCwMyg/ZhtO6OKYGmRaqtJbzMDRCsQP8yMkI06M5k4jO8zAOq6nbJNcgyqi70PbDsD+
 ND0FfsxStMkVOmxw1gOMf46IIZcGPLrCbTltbFIR9rFyBkOtBU1Fz/N6a1/uFydbYHIZ
 2eizUmQAUuQQ2B4061+H/bCqwQNL6VwAmK0i/AijJ+hhG20ASjXXsd+jBVgG4ndldozz
 0dUg==
X-Gm-Message-State: APjAAAVaafdjraCpMoULuFJfcOE2mDql3G9DGOYJLpo3Upw/G0uDldH+
 lGfar5eU/H26pcz/QhPaa61lYA==
X-Google-Smtp-Source: APXvYqyficCStsKpAiJlZ+/UQRHEGEEI0ZQvcoo+FRiOWz4LSGBEVSlvdyU5SdjwjnSIc9iZd4E/Rg==
X-Received: by 2002:a19:c3ca:: with SMTP id t193mr19540921lff.40.1574953078637; 
 Thu, 28 Nov 2019 06:57:58 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2019 06:57:58 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 41/49] soc: fsl: qe: drop use of IS_ERR_VALUE in
 qe_sdma_init()
Date: Thu, 28 Nov 2019 15:55:46 +0100
Message-Id: <20191128145554.1297-42-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
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

Now that qe_muram_alloc() returns s32, adapt qe_sdma_init() and avoid
another few IS_ERR_VALUE() uses.

Reviewed-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index ec511840db3c..5bf279c679ef 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -365,16 +365,16 @@ EXPORT_SYMBOL(qe_put_snum);
 static int qe_sdma_init(void)
 {
 	struct sdma __iomem *sdma = &qe_immr->sdma;
-	static unsigned long sdma_buf_offset = (unsigned long)-ENOMEM;
+	static s32 sdma_buf_offset = -ENOMEM;
 
 	if (!sdma)
 		return -ENODEV;
 
 	/* allocate 2 internal temporary buffers (512 bytes size each) for
 	 * the SDMA */
-	if (IS_ERR_VALUE(sdma_buf_offset)) {
+	if (sdma_buf_offset < 0) {
 		sdma_buf_offset = qe_muram_alloc(512 * 2, 4096);
-		if (IS_ERR_VALUE(sdma_buf_offset))
+		if (sdma_buf_offset < 0)
 			return -ENOMEM;
 	}
 
-- 
2.23.0

