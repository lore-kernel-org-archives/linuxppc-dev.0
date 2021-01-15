Return-Path: <SRS0=Y1I/=GS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8964C433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 17:39:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7FB2339E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 17:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7FB2339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DHT2Y33HPzDsgQ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Jan 2021 04:39:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035;
 helo=mail-pj1-x1035.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=MyM30KUS; dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DHRzD51pgzDshC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jan 2021 03:51:36 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id ce17so3223112pjb.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2021 08:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6vo8AmiGX+ifb3NTSudBL/B4dXoNXEYykHe52+RgyYs=;
 b=MyM30KUSpl2wHPwDMxPHk51Oi395Iz2TumdgEZm/lDUMrnqzkc+HdbvUDc7CjfF8IE
 lsFMMBNzQZkIJ/Z3ylXEYOXuMT7wUhis8/cX9srC7OcJ0a+cS/svKwsZIw406u02MtHM
 8On3WFfGsRC5FLrq83+T/nllp1DwWXrVlmkk0h74obMeJOIsqtgJC4Vl3AlDRPOw6b58
 8sWQkwC2wyM+PiaMf/xr8G+hAaxXjMfpl4adUFbDq5aHtLG25gwMD9vLRHAXsp/LGOpE
 EMkupuM4EMZftIG3v5m5qE0J7NKr5hFBHxYiIwTgDWQ3pbdShp8BwInHCmkfT2T0gXfh
 tL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6vo8AmiGX+ifb3NTSudBL/B4dXoNXEYykHe52+RgyYs=;
 b=AIoc3RjV+x+xRmVenMyKkbFnZebpUnAPUx8c1xTj9zpad5ehRpbLJzFZyTot4eLclg
 kTmywTh5w3AdHm/mtUYQeTGx+UXGoUpVvc+Cm/N1GAOMbhOu9nz8B9gPEsnXYM0hy4eC
 7oZtUFgULCvK59zP5d74DT8TnPYncEKxrvr4UbMjC0CD9Ug8OCP5tWFzhA5rTAv0cmTT
 a/UIJVQzFGl8jLoo89JD9ZFi13r5CXU6n+ajV5MCGsuijYPiHz/JSLOHSH4gsistJYWT
 +SxNSNfESCOz+PDpyC0dAoIpLZTy59oBlE7r2mVhjYz9kqKJLaNaTkhSGELK45EQSEv9
 Tdqw==
X-Gm-Message-State: AOAM531mTzk3JuL+ba7xPDfDg7dAQ2j1kbNdBUk6+5Ve0R8yM9etaSBc
 j3qgu2THmo95iUpDaFpNIag9LnqH3iE=
X-Google-Smtp-Source: ABdhPJyYgczVwEueaa4QjXZ2Ab66vEtNEjDptGulQvwBj719FD3celeByklpgq3iOjg2h4h3gPwxlA==
X-Received: by 2002:a17:90a:454e:: with SMTP id
 r14mr11689676pjm.194.1610729493946; 
 Fri, 15 Jan 2021 08:51:33 -0800 (PST)
Received: from bobo.ibm.com ([124.170.13.62])
 by smtp.gmail.com with ESMTPSA id u1sm8455477pjr.51.2021.01.15.08.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Jan 2021 08:51:33 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 19/39] powerpc/cell: tidy up pervasive declarations
Date: Sat, 16 Jan 2021 02:49:52 +1000
Message-Id: <20210115165012.1260253-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210115165012.1260253-1-npiggin@gmail.com>
References: <20210115165012.1260253-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

These are declared in ras.h and defined in ras.c so remove them from
pervasive.h

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/cell/pervasive.c | 1 +
 arch/powerpc/platforms/cell/pervasive.h | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/pervasive.c b/arch/powerpc/platforms/cell/pervasive.c
index 9068edef71f7..5b9a7e9f144b 100644
--- a/arch/powerpc/platforms/cell/pervasive.c
+++ b/arch/powerpc/platforms/cell/pervasive.c
@@ -25,6 +25,7 @@
 #include <asm/cpu_has_feature.h>
 
 #include "pervasive.h"
+#include "ras.h"
 
 static void cbe_power_save(void)
 {
diff --git a/arch/powerpc/platforms/cell/pervasive.h b/arch/powerpc/platforms/cell/pervasive.h
index c6fccad6caee..0da74ab10716 100644
--- a/arch/powerpc/platforms/cell/pervasive.h
+++ b/arch/powerpc/platforms/cell/pervasive.h
@@ -13,9 +13,6 @@
 #define PERVASIVE_H
 
 extern void cbe_pervasive_init(void);
-extern void cbe_system_error_exception(struct pt_regs *regs);
-extern void cbe_maintenance_exception(struct pt_regs *regs);
-extern void cbe_thermal_exception(struct pt_regs *regs);
 
 #ifdef CONFIG_PPC_IBM_CELL_RESETBUTTON
 extern int cbe_sysreset_hack(void);
-- 
2.23.0

