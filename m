Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F834C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 03:04:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83549218CD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 03:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqPqLkxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83549218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448LB95pPWzDqN7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 14:04:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=jniethe5@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="PqPqLkxN"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448L8V2GWlzDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 14:02:47 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id d15so7255951plr.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 19:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JZ4T2HQaHkR1JoJ+z35vkH10CJJqOPeavVeMsAvKDGQ=;
 b=PqPqLkxNJhcpKTmQzwhQBttz/RnUM7ZWArNA/ncAfcCrXZLwzDCB0EXlIKHq4uOYKU
 7oBG7kjcwd+t/Zkk1WP1caZQZ+58HlSEZp+Aw2IaOaP1Mpj7ER8k2wKuoAJ9e6ngTvOD
 psNMWHuWU2lU+CjB6p6xB332zc4ssbkiBoMkwtif8pvD5+p0zz/7r6e+OwSvkcWeTaAs
 /bzKGS6MdZPc+SWPD0xCJIgTXfNdjWlhVOTqB7yGday813K3CSfFrV7pdyCR+0CWG4mY
 pzxT80iIn+/0fGWCZsAjIYckteK185M7w7XvUB70QzmvKCCJF55huFJKTk+Rlg4gS4r9
 MZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JZ4T2HQaHkR1JoJ+z35vkH10CJJqOPeavVeMsAvKDGQ=;
 b=Hna980dfMEzXxA4IwOySXLaksKLCJBBxylDtLRVBfuXtxGLZmpn8nP4kvX8Quyzcub
 I+txqTsmAgNmo5vso+px+DpSmAWPoK71b9dTe8OBgf0X4rDbYrEiK7vY8Tv2XOxspo0g
 2uPEIMU1O1P7WxZts+69ha500UuyY0OxQzudYDvF61aVUZBY4tAdIY5WWVIT/4ykTi5E
 fH92/R8Exw2OGjiCPiVD76ao/yjJmczXsYxv7hfos9ldaTcFY1BjsHs1+D0QNaQQryHr
 fT+j6U23dz0aMmS8u2No2WbIaKn2Y7Piy8GJZzC8eu+3YQ+AufAu5FuDZeuWBT9Zrat/
 s27A==
X-Gm-Message-State: AHQUAuai9k2ETdUGrqLRGIv52qDZ0uTfcqG8jfwIoI6vuNfCnbdvWrd7
 Z9wWJct9TUbLqB4t3cf6829sen6L
X-Google-Smtp-Source: AHgI3Ib6fqupGuArComs6Es/75+LmlPDYngh+QIDf0fGCNyexzDq6W/2LjSGHhszXDz+kGHe5WI34w==
X-Received: by 2002:a17:902:1c9:: with SMTP id
 b67mr23077387plb.176.1551236563559; 
 Tue, 26 Feb 2019 19:02:43 -0800 (PST)
Received: from pasglop.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id p34sm29241255pgb.18.2019.02.26.19.02.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Feb 2019 19:02:42 -0800 (PST)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv: Make opal log only readable by root
Date: Wed, 27 Feb 2019 14:02:29 +1100
Message-Id: <20190227030229.12814-1-jniethe5@gmail.com>
X-Mailer: git-send-email 2.20.1
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
Cc: Jordan Niethe <jniethe5@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently the opal log is globally readable. It is kernel policy to limit
the visibility of physical addresses / kernel pointers to root.
Given this and the fact the opal log may contain this information it would
be better to limit the readability to root.

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-msglog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-msglog.c b/arch/powerpc/platforms/powernv/opal-msglog.c
index acd3206dfae3..06628c71cef6 100644
--- a/arch/powerpc/platforms/powernv/opal-msglog.c
+++ b/arch/powerpc/platforms/powernv/opal-msglog.c
@@ -98,7 +98,7 @@ static ssize_t opal_msglog_read(struct file *file, struct kobject *kobj,
 }
 
 static struct bin_attribute opal_msglog_attr = {
-	.attr = {.name = "msglog", .mode = 0444},
+	.attr = {.name = "msglog", .mode = 0400},
 	.read = opal_msglog_read
 };
 
-- 
2.20.1

