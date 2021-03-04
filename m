Return-Path: <SRS0=6LlZ=IC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D41C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 03:38:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4AB64DE8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 03:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4AB64DE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Drc5r4YtCz3cxk
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 14:38:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=q026x+6K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::544;
 helo=mail-pg1-x544.google.com; envelope-from=menglong8.dong@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=q026x+6K; dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Drc5M43JTz30NC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Mar 2021 14:37:58 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id g4so18016052pgj.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Mar 2021 19:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lwoBHUochKSoN7y5wxuuHeqVXjjHuR5y3IgAjCllxOw=;
 b=q026x+6KUHrBMJfJZiwK1XhQUrO2/YLwBhRT8ygxRCf9rE9qB7lZOuu+o0FVf2NRVy
 fF78CGKre6JeUiH3ANQxlmFzvNS0SSu0E4bQ6NPJKggcFxzxG61qr1nnlkQDoGMl6qTr
 Rh5aoq5zzvQ6pmTiFcWI8TvOLm8MGGSEiFyVkGx/AWGBsfGdPWsHrZx1s83dZLXygdTp
 NRiTcYxhhSWtgTkJXEdWvlXOsf7kXeOlnfQznw7Z5eIXk7COwDqu2I5Wg4bZj5F9GJIE
 nixKS5KKNqV/urDmL+1U5yPsofGStIfeL41fLbA7Ry7duQ9jtYFgGM9wC85rcY4FPKjy
 iu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lwoBHUochKSoN7y5wxuuHeqVXjjHuR5y3IgAjCllxOw=;
 b=MzXR1OjYphywSiKzpMj9sRfDdqsq9n6kz+rRGYFUwp/bjNUTyWbCN2ibVIICk3aucd
 Iq0H92AqGiP2JTeFTtcxEmDvlXwdY3sZNurLhWEI5+itR2bE9Z/vs8D48i2RB1cyTN45
 R8vC6fRsKwH2spIOIwGHQ4Rf11b4dEgZ10gzCoEOThpYN13s2ldagmWkkZ1FISy9ihrn
 i1w4/T+avY+xhs8DmHxlTJFCz7oO2KnCtG5HfCsp5gGWKai2kplFtgMWxGMBSKRYSX1r
 KF36/mi5GgUY346nC4jtXkRJ+Mj3PnW7yoZ7n/ZyV43hgnaLZECXzK9GxgJzuJc8kJdj
 LHHQ==
X-Gm-Message-State: AOAM530jeDa0n4qBA5hZuxxFH4hj1/EdRX9vZUm4N5o6pJ40+AYaRv11
 RAVBkS8v38EzH09BOUraZwK51vVAFrE=
X-Google-Smtp-Source: ABdhPJyDZVPlwhy/hQc/5twP4MdW4dbJKj65FddlnUK2WW7w2lrPVv3dhEqqDfg0lUUUHUvsyKbFqA==
X-Received: by 2002:a63:eb42:: with SMTP id b2mr1971898pgk.284.1614829075104; 
 Wed, 03 Mar 2021 19:37:55 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
 by smtp.gmail.com with ESMTPSA id m9sm7727382pjl.4.2021.03.03.19.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 19:37:54 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To: mpe@ellerman.id.au
Subject: [PATCH] arch/powerpc/include: remove duplicate include in
 thread_info.h
Date: Wed,  3 Mar 2021 19:37:47 -0800
Message-Id: <20210304033747.189298-1-zhang.yunkai@zte.com.cn>
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
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, npiggin@gmail.com,
 zhang.yunkai@zte.com.cn, paulus@samba.org, aneesh.kumar@linux.ibm.com,
 msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'asm/page.h' included in 'arch/powerpc/include/asm/thread_info.h'
is duplicated.It is also included in 13th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/powerpc/include/asm/thread_info.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 386d576673a1..9d6402402b9b 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -38,7 +38,6 @@
 #ifndef __ASSEMBLY__
 #include <linux/cache.h>
 #include <asm/processor.h>
-#include <asm/page.h>
 #include <asm/accounting.h>
 
 #define SLB_PRELOAD_NR	16U
-- 
2.25.1

