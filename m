Return-Path: <SRS0=8MEZ=VA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB67C4646D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jul 2019 16:28:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8169218A6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jul 2019 16:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lpi16Um+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8169218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45f64Q4kSXzDqP8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jul 2019 02:28:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=huangfq.daxian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lpi16Um+"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45f61x3z5lzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2019 02:26:45 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id z75so1505945pgz.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jul 2019 09:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=3g1NPTpHubI6UBPHHSrwuj9B0Mvaq5SdPi446COAutU=;
 b=Lpi16Um+2HDw6EpOFzaDh/ha6DuFnuLiVnpC8jYCkBevu+vjkQmNLCCJ8/V8DQmPGp
 Yt2mlOjTTDjFZ6UjUlpchFY4NnB3yYafzbQbeFYPTvpQZUX9iNggf8uyIRWFiv83jal1
 LuvL4576Ej8K7yjZ5CW/5iobwwU4BVbBRfPOTvpMFzvQbhYxoyQRIneVyFjGxKgmUKiR
 lRH9Dardl2+lQGPfYEpg32k3GrHeFcSi1YanaSzTChwzWXIifwq2VV8tvUz0cVIzHnHW
 C69abrB+WXiJi0YZMOy+jYF6Bqn6OBbVJEq71kdA+7G3Ksw2OGiOA3Iwik0HyR9B/qLD
 Lcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=3g1NPTpHubI6UBPHHSrwuj9B0Mvaq5SdPi446COAutU=;
 b=WFObHAAEUXZhFBiJpYm775xyv1tNxK3s6rtBdG1wemTsN/91RJ90bN8DRxOUIPNnAo
 Z3HD53sOC7YZsGYxeRU9oGWIVnouxIDQcF3eRDrmfrY7NCcm/cFGnmrWmAsBPxY4p7K0
 Gka0kSC7A0gOT2r+98uXEF5YP8QVIQgFpaX+d0z36EZNFv1shjRSeko06pC9bhX217zM
 lz2GHpe2kCZCcKVs/WCYfhQxFaVbIbYr8ZMK6lD16/o0bNYfcBX/8GcAJWzDEkiLoDb/
 MMBhAUec+/9cKtpKyAR1oevHF1Bp+HCK61L76d973Xu+ByJ77FoQ+U0sLrVMO7oOkcYx
 KgAQ==
X-Gm-Message-State: APjAAAVG1iAINl9ParRJG5FLpHpj11QZww384OdKhzb4yawvjlF0kg+V
 XUvhC0GJ0JJP63yJVt6P92w=
X-Google-Smtp-Source: APXvYqwW9eDsp+QIoqr176fiv+07AjcIW+bAxLt0Lkz5UIac14TsIJnr4/CokE6zq7nSHAMynY800w==
X-Received: by 2002:a63:1f1f:: with SMTP id f31mr8416587pgf.353.1562171202147; 
 Wed, 03 Jul 2019 09:26:42 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
 by smtp.googlemail.com with ESMTPSA id e11sm6585890pfm.35.2019.07.03.09.26.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 09:26:41 -0700 (PDT)
From: Fuqian Huang <huangfq.daxian@gmail.com>
To: 
Subject: [PATCH v2 02/35] powerpc: Add an allocation failure check
Date: Thu,  4 Jul 2019 00:26:34 +0800
Message-Id: <20190703162634.31953-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Fuqian Huang <huangfq.daxian@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add an allocation failure check.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Split into two patches

 arch/powerpc/platforms/pseries/dlpar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 437a74173db2..7488e40f5e47 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -385,6 +385,8 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog)
 
 	hp_errlog_copy = kmalloc(sizeof(struct pseries_hp_errorlog),
 				 GFP_KERNEL);
+	if (!hp_errlog_copy)
+	      return;
 	memcpy(hp_errlog_copy, hp_errlog, sizeof(struct pseries_hp_errorlog));
 
 	work = kmalloc(sizeof(struct pseries_hp_work), GFP_KERNEL);
-- 
2.11.0

