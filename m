Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29877C4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 08:19:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8572E6104F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 08:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8572E6104F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GgM3L1hSZz3dDg
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 18:19:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=s4jwRYLo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031;
 helo=mail-pj1-x1031.google.com; envelope-from=cgel.zte@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=s4jwRYLo; dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GgK6d21qqz2xfL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Aug 2021 16:52:23 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id j1so6617842pjv.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Aug 2021 23:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GlmMJcvsNL7r2fqrc4Rymp5aSqY0XLGbpUjwdzjt8TE=;
 b=s4jwRYLozfAWXk3CdFQRL+6GIY85SN+v/QOTmDuaxwPo39Q711NlDvjCbBcbulWsLj
 7NiQhtHqqRRe29Xi1RBJD3UjJ5cbPyWJipn3Pwrny3d8dRd8MgVY3Qz61l6zSAGfDXOF
 /ZLk+ROT9+dyKdzKgvCBvUCRWH0Mcq1LKoopZrMjXPrBpjxUJGfs+DBAhH7EWywMVeCQ
 Otz9QF3U3tev21aAlCWh9wGLHsivMRe/DH4+Hhm+a+r2c7JoqeECGkq+L8o7WbZZyA1u
 rfnqC/IEpAS5vpw7CnC9dXkUnoPKt+1uVlNb1Kaup8QZ+QNn7bFb5HQFLtUuklaLpDaK
 v6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GlmMJcvsNL7r2fqrc4Rymp5aSqY0XLGbpUjwdzjt8TE=;
 b=HiYpebL5RdE5wyD3dt8Q6mzrQIvsN2PwRL99bhzaW/qb5bkrdLogzkARAkM6hZ5FpZ
 IuUR96q13XhMbUmL78qhI1Ni9TQj9dKWuqBvDIoqhg6JQnXPmXn3VIvotvQQHyP1J9HJ
 eSbEuDQnhYqc5mwZQ7i3CORS86Oy+A0dsqIZ5q8y6hJj8vjtqae4lmBwPJoIEpMu1+Nd
 RL02WFw8L+SQpE21cOHR/3djhOo17rEZ3rPvSQQT6MlkrFp+BqErdIxFawc5jPoHo5PF
 sslzYfIdwly2UFIDPCoPEwIKO4yYxiwLnha5L1p3WwDMKx1yN8BlusZUkoJ6Gn2Rk1wF
 1Kiw==
X-Gm-Message-State: AOAM5332pVudd9u29LUyy/wtPuZkzYcUu92ySTwGD9Ev2oOluBJtU/su
 lYFpaneImVF9p8lRD1vqtQ0=
X-Google-Smtp-Source: ABdhPJyxRn4WdhDjQJdsYQc6bC6ojEMmWOv6W9V6kigMMmMlKBLxxYaU6M0/n8LxQ0lpTosPugc5vQ==
X-Received: by 2002:aa7:8d10:0:b029:303:8d17:7b8d with SMTP id
 j16-20020aa78d100000b02903038d177b8dmr3690606pfe.26.1628146339294; 
 Wed, 04 Aug 2021 23:52:19 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
 by smtp.gmail.com with ESMTPSA id i18sm6623194pgb.83.2021.08.04.23.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Aug 2021 23:52:18 -0700 (PDT)
From: cgel.zte@gmail.com
X-Google-Original-From: yong.yiran@zte.com.cn
To: mpe@ellerman.id.au
Subject: [PATCH linux-next] powerpc/tm: remove duplicate include in tm-poison.c
Date: Wed,  4 Aug 2021 23:52:55 -0700
Message-Id: <20210805065255.628170-1-yong.yiran@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 05 Aug 2021 18:19:18 +1000
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
Cc: yong.yiran@zte.com.cn, Zeal Robot <zealci@zte.com.cn>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, paulus@samba.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: yong yiran <yong.yiran@zte.com.cn>

'inttypes.h' included in 'tm-poison.c' is duplicated.
Remove all but the first include of inttypes.h from tm-poison.c.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: yong yiran <yong.yiran@zte.com.cn>
---
 tools/testing/selftests/powerpc/tm/tm-poison.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-poison.c b/tools/testing/selftests/powerpc/tm/tm-poison.c
index 29e5f26af7b9..27c083a03d1f 100644
--- a/tools/testing/selftests/powerpc/tm/tm-poison.c
+++ b/tools/testing/selftests/powerpc/tm/tm-poison.c
@@ -20,7 +20,6 @@
 #include <sched.h>
 #include <sys/types.h>
 #include <signal.h>
-#include <inttypes.h>
 
 #include "tm.h"
 
-- 
2.25.1

