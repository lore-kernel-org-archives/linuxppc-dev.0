Return-Path: <SRS0=Fnpn=NH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED43C4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Aug 2021 11:36:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5345261A54
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Aug 2021 11:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5345261A54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GpBtl7361z3cTt
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Aug 2021 21:35:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=uiJ+O46L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029;
 helo=mail-pj1-x1029.google.com; envelope-from=cgel.zte@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=uiJ+O46L; dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GpBsm71dCz3bXT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Aug 2021 21:35:07 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id oa17so26010801pjb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Aug 2021 04:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uTWDBNi6gTv/e5E0tvAcisNF+AyHlVmsBNOwg6nhosY=;
 b=uiJ+O46LF9jTBxwtfXWMff33cOA8Ou1xpCH0ZVK+7dXjEgjcJgHspSjXykP/2bYEk3
 8CvEI7yJK7uJQt1d0xW4Lv/CgqsT4Uh6VVjwSLV9Ux/liECea6NzQYGNLIurqx0rYv0H
 LtW5z41qVvSPG/gq5p2LQklYCM84sHmjWQuAWXCSQzZIPJ2XBmWsqftnIS7Sd5rSNrzH
 1PrR8dXoEn6XY4trxBdPXl/1DjWe5XIDEY98vJnsO/l65arpeTRoaBWdU1J0IVs9kjQU
 stqU0hpBDbBhvDBy2WhsulDGbw5x7zke3HfjUSoYuwvm7njhzdJrlUMDIFVGeKGaexxk
 1l+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uTWDBNi6gTv/e5E0tvAcisNF+AyHlVmsBNOwg6nhosY=;
 b=oYqvPWGyofNfxuafwMayQDd2VCUjZWiLi+CfGBM4jHux7j1JRoLZSbjAIIOsdHl/qQ
 jiTWrMSna8DyBBisWvIKg0OT8j3fvzImrUW5uRdj9O3ulwvVy9T4WKXGhyq+nbWJnFOJ
 1gIepKaMlStkNUs7oL2e8d7i+uWnGVxVcGlqEOZJ13iIpl76DEUYAEjCwEGDhhwYrxg+
 bHx5tvdauIULf6aOiOi+pkh6aWxd63Q/tDOWj22xSv2GB/S6awKbLlO8Wyc24BSzmz7G
 Yerx0zIje0DkOu5Wx1mnGgsaMk6ArutnkLfB5fWjy2Mgn7yJMKottBWMNEcgIALPDymS
 X0VQ==
X-Gm-Message-State: AOAM533zB5HfXVS0elFlAFmV1aLG/uQYWeoLZ5xg7EGcRhORmHfJb6SM
 im+Vq1/794ZkMQv9yxq2Bq4=
X-Google-Smtp-Source: ABdhPJzwO6blgdz0F18gt6MsWwZVdFCucyeH3BBL9qX8uGuPL/I7OdXuyzBIis+56p29NRMkXFFIQA==
X-Received: by 2002:a17:90a:8909:: with SMTP id
 u9mr16901957pjn.9.1629113705802; 
 Mon, 16 Aug 2021 04:35:05 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
 by smtp.gmail.com with ESMTPSA id l126sm13677088pgl.14.2021.08.16.04.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Aug 2021 04:35:05 -0700 (PDT)
From: cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To: mpe@ellerman.id.au
Subject: [PATCH linux-next] module: remove duplicate include in interrupt.c
Date: Mon, 16 Aug 2021 04:34:53 -0700
Message-Id: <20210816113453.126939-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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
Cc: Lv Ruyi <lv.ruyi@zte.com.cn>, linux-kernel@vger.kernel.org,
 paulus@samba.org, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Zeal Robot <zealci@zte.com.cn>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Lv Ruyi <lv.ruyi@zte.com.cn>

'asm/interrupt.h' included in 'interrupt.c' is duplicated.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 arch/powerpc/kernel/interrupt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 21bbd615ca41..8a936515e4e4 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -10,7 +10,6 @@
 #include <asm/cputime.h>
 #include <asm/interrupt.h>
 #include <asm/hw_irq.h>
-#include <asm/interrupt.h>
 #include <asm/kprobes.h>
 #include <asm/paca.h>
 #include <asm/ptrace.h>
-- 
2.25.1

