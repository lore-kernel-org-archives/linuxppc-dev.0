Return-Path: <linuxppc-dev+bounces-19441-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678A7FEEF51
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 14:32:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqpZ045FKz2yhv;
	Wed, 08 Apr 2026 00:32:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775572344;
	cv=none; b=GLeanSsQbGwPt03sGSVZBC18Ta1+WHXYCcVKRUEG1Lk1PgdxZ5hkhmZNPBuU9x5gJEvS7eelLOHC5xXQoKshQsIPUdHPsOvZ+j0mrNeQ1ht28SpAMY73pf5KV1YM0DrY5gvCEhqITn8jqjxIL0G3VsoZNgZI7NN0lFfz0Z7zCnv6Zd9Zl+3qbDiuMD5m53xxiNzQ71UibHz+BND+ntQpi3IdSQRPmCdfBu8A0REU09mf6L/K67kIvHKMNEQ3VB9idwH47H7tgv2031ow/vjNvUostZUvmTqLA2QN5jTgwYZpmoTwhoXHokOk6Jvqul2EzmA51DBQfb61oEcbaro9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775572344; c=relaxed/relaxed;
	bh=PY3ak4gklrB7dT78Kl3RlnvUvqFrPFBtFQWCDk/TdtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4ciLaYMPCO2c1LUlGMYL8VgB+Nfov/xZwzhxmr3ZF2woObdh1CTWoFxI9dDFGe95V2QEfm5LqZerUkiVqe0YvPtc6I81UIZ1XJQSpgNicsNOu9a21zg1/6NNXCpNQRiZ838qnXJQeKVHKQvdRyy4GOJDzulOo5VoTVjw10dGCTsf4Dy5A053MSyKzM7B3x77JE9bsdiCmXmS/e0Le25mpJ+PmXyyFeNJUFOngQ5CR+0P0hTqq9oYQWqYcOukRpRQvzEoNKE8+KIgIYiyevdHuEaJlMuh0bZPMZLxzOBrz+TQlp0HeBNe3KhuVSE3NB1ei7ZaTojFsyvJzNFgo5xdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lAjfUGxN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lAjfUGxN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqpYz6hntz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 00:32:23 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2aaf43014d0so35899155ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 07:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775572341; x=1776177141; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PY3ak4gklrB7dT78Kl3RlnvUvqFrPFBtFQWCDk/TdtE=;
        b=lAjfUGxNctIdomhNd8q/owhLMsF14WyV3YBY0oQPhHxYLYA6tTZIg3ijNs5jK5xMGJ
         cyxPVRpiE6dOXuE1SxgOLtRyQBlw/co/cXr/1UuzxPG96ZDO/XaDI0iMgXesMJfmGHQ7
         xL4Ta9lWvzOQye3RNxjvSvlZlLj3c4v1HNJMINzQ4hw6rhEgwPv4Ac1iae58TtHWX8g9
         9oyfXUbqHFF/ZY8i+hn/ebZ6HpkMKI5wj5K8g+p3WouLGCSVDnvMYsN7ydDJYbXzHsnT
         0bJDzGVfm2bcpKgIQCLn9GevlksBEngyTQ3zc+3vMeM1a76liH1X7QMOTxvON9zS3BEe
         ykug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572341; x=1776177141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PY3ak4gklrB7dT78Kl3RlnvUvqFrPFBtFQWCDk/TdtE=;
        b=c4ANdXCISs+ivqoRPU3J+0Y6c97Br73allC0/LkUqRHqkc7wIQMczQUVg26aX2fso8
         H9hbPW+pSg05pOxVCSP5a6Qo7E4xL0qyTHRakkvLkFAHFyHChv2Q2t24r53NAnc4yadv
         dvLIH0QcVvYwEpHW3WVktuJpA04HEMdLUOingBCYqGTTha1u5Ss/jT7yGfkonBt8wEYh
         WYCWkZ8VAE32F5V0L9N76hrm1+u+sllrqm+6FWyWlO4H/0KKW4vRDexvm1LH/lzM0Eqz
         pFnvzWmdpI4xOe1Okmq2jawyx5WWmDhHwYISvLqxfpcWrgeQUZynUo/Y5c++QqSRCKxr
         wGwg==
X-Gm-Message-State: AOJu0YxAQhDKShxHY0RzMPB7NX1jPo15zKISoqsqprDFMVjcX6GeCj2t
	IPdmDJn/Q7VSrJ8vodwu4dp//+5IDEcuKROSnlhGSiyzbwk5t8F5Qrke9frc9w==
X-Gm-Gg: AeBDievuIPqg4sFc8bYJX6T1Gqx77gGcBiikIBedCdZqYHnVXAyHaO8EOx3Nofc0Z8r
	DhQwjYqnZU+fK4/vW+p0AlQJCo2yWJFtw3p0eLTzxYQ3kiGWwvZhpEqamj79tY7cjcFlvOWan8d
	v9q/7R9cxDf0YOzkmyCdIXO6tcV/TkhRQJ6cABP6/edjlKatTFhVaUUe82ov28gSBsmTwrt3e9w
	w6daG/oFBMXF8fktgRxdsKZFpWoevgowf+l1y3tEYQST2o97h6M4Ubvsx3cuYQs946iemmuqRNa
	U9gPbZehmEOZxjTkrCqf8qYUS1RsGBmT2MJ691wvDFb/zmXvhFnm80WyoxXOT4N/HfAArFCq5zb
	583cTKWUhNMPhHFPMtkVV51DgZ14dVs47kK3yS/5tBu+lj220krErB+0SGWqGN1TkjG3/H/I9Pm
	n+GixgOkcNrU6naDKugYBhxNAVuvHkUy6xKxL+g39LkttSpCf9Z37SId0lMXiv
X-Received: by 2002:a17:903:8c5:b0:2b2:4d36:7aa with SMTP id d9443c01a7336-2b281932d71mr188155645ad.35.1775572341300;
        Tue, 07 Apr 2026 07:32:21 -0700 (PDT)
Received: from Mac.localdomain.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbc58sm181201525ad.78.2026.04.07.07.32.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Apr 2026 07:32:20 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v1 6/6] pseries/papr-hvpipe: Simplify error handling in papr_hvpipe_init()
Date: Tue,  7 Apr 2026 20:01:40 +0530
Message-ID: <15828cd5a57af373fa2e7025bdb7ef0d0a1143bb.1775569027.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1775569027.git.ritesh.list@gmail.com>
References: <cover.1775569027.git.ritesh.list@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove such 3 levels of nesting patterns to check success return values
from function calls.

ret = enable_hvpipe_IRQ()
    if (!ret)
	    ret = set_hvpipe_sys_param(1)
	        if (!ret)
		    ret = misc_register()

Instead just bail out to "out*:" labels, in case of any error. This
simplifies the init flow.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 26 +++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index f41f5c0a8418..03ec004a6701 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -768,23 +768,27 @@ static int __init papr_hvpipe_init(void)
 	}

 	ret = enable_hvpipe_IRQ();
-	if (!ret) {
-		ret = set_hvpipe_sys_param(1);
-		if (!ret)
-			ret = misc_register(&papr_hvpipe_dev);
-	}
+	if (ret)
+		goto out_wq;

-	if (!ret) {
-		pr_info("hvpipe feature is enabled\n");
-		hvpipe_feature = true;
-		return 0;
-	}
+	ret = set_hvpipe_sys_param(1);
+	if (ret)
+		goto out_wq;

-	pr_err("hvpipe feature is not enabled %d\n", ret);
+	ret = misc_register(&papr_hvpipe_dev);
+	if (ret)
+		goto out_wq;
+
+	pr_info("hvpipe feature is enabled\n");
+	hvpipe_feature = true;
+	return 0;
+
+out_wq:
 	destroy_workqueue(papr_hvpipe_wq);
 out:
 	kfree(papr_hvpipe_work);
 	papr_hvpipe_work = NULL;
+	pr_err("hvpipe feature is not enabled %d\n", ret);
 	return ret;
 }
 machine_device_initcall(pseries, papr_hvpipe_init);
--
2.39.5


