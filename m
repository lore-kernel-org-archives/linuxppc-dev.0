Return-Path: <SRS0=xZg/=UV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4784CC43613
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Jun 2019 14:36:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A0B20675
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Jun 2019 14:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6PvuNcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A0B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45WJ6B601LzDq69
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Jun 2019 00:36:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="k6PvuNcw"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45WGLG2gL2zDqbv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jun 2019 23:17:10 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id n2so4668240pgp.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jun 2019 06:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=stxIr1PnwC2QkcH2LT0SwyGjHSLC6dh3wKnrxCFwJC0=;
 b=k6PvuNcwhA8+dhknzTKkx/Jz2zbwFhAOHMgtRccwLyt6wKVq99qC+IOHtIO2eb46m4
 YtDLdOETcD/RGFs1kaav5C2XuWhMCMZFTgk23mQErlV6VV7NTJyZ0a+jt5N3yxxTWe7E
 7MMqb6QJXhPvoARFyQKWhRHcO0UBFeGjx8856mQtAcSLniZolZwgOE4xMsTPDckQDQ9R
 QvynXYgMz7kOuRzwmLJ3dPmDYnndNZzPF+tydJke03fP++eU2CDAKgJE2BMCPx9VOb05
 uDUgDZiE3GgCNUCCArK0nH7sfSPPyDF8+UcGNFC8ohCuHDS/QldQShy71LV/uNksID9D
 Ccdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=stxIr1PnwC2QkcH2LT0SwyGjHSLC6dh3wKnrxCFwJC0=;
 b=EK6OXsEe6El7Nj3/oki4HKJztlK2AQcIgPoc36pynUEw/3M/DoKVXiH57op7GrewHK
 euelpAXnvk/Zo0teS0IAY9cFgdR9NU6gG51r2W8W7H2JiymwIHy907Sdz1gu0IxZgf/k
 bkycKU+oLmD8PPBhb1RSc1P3PNVRgQqSe0TiwHQUgjGo8uyjM3XGOyRYQNcketpk+h6U
 D3TnhcXWGvM5qkq92KmUYUjxHyse4wCF97hMRxENPWvP/LbuhpbD5AsAFZ8Of8kTjoCR
 oH+zTcVNA57nM9OmSmGCvRX9x98ETOMCHCYUDxSBGuc8oQ9cGeYhtvTsB4qbgwRozFmb
 WNPg==
X-Gm-Message-State: APjAAAVVQCKM2QQWao912vZqf9T5CRqOcYj/YKwUe9Es+fbhb26bFHzN
 JlcfTAYfVW9p39tabxh3cqRjn5FfGHc=
X-Google-Smtp-Source: APXvYqzZAmC1/Q1hFR5xP7n9A/oTuuGTSke3ppukO1BxDllbEzXz3g3hguSNzk/oe2oo1wsDcIwW0A==
X-Received: by 2002:a17:90a:36e4:: with SMTP id
 t91mr12649848pjb.22.1561209428362; 
 Sat, 22 Jun 2019 06:17:08 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([1.144.136.2])
 by smtp.gmail.com with ESMTPSA id n1sm5192471pgv.15.2019.06.22.06.17.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 22 Jun 2019 06:17:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 25/25] powerpc/64s/exception: move paca save area offsets
 into exception-64s.S
Date: Sat, 22 Jun 2019 23:15:35 +1000
Message-Id: <20190622131535.20996-26-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190622131535.20996-1-npiggin@gmail.com>
References: <20190622131535.20996-1-npiggin@gmail.com>
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

No generated code change. File is change is in bug table line numbers.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 17 +++--------------
 arch/powerpc/kernel/exceptions-64s.S     | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index dc6a5ccac965..2e919253a075 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -32,22 +32,11 @@
  */
 #include <asm/feature-fixups.h>
 
-/* PACA save area offsets (exgen, exmc, etc) */
-#define EX_R9		0
-#define EX_R10		8
-#define EX_R11		16
-#define EX_R12		24
-#define EX_R13		32
-#define EX_DAR		40
-#define EX_DSISR	48
-#define EX_CCR		52
-#define EX_CFAR		56
-#define EX_PPR		64
+/* PACA save area size in u64 units (exgen, exmc, etc) */
 #if defined(CONFIG_RELOCATABLE)
-#define EX_CTR		72
-#define EX_SIZE		10	/* size in u64 units */
+#define EX_SIZE		10
 #else
-#define EX_SIZE		9	/* size in u64 units */
+#define EX_SIZE		9
 #endif
 
 /*
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index af8939582ffd..f51b3a5fd110 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -21,6 +21,28 @@
 #include <asm/feature-fixups.h>
 #include <asm/kup.h>
 
+/* PACA save area offsets (exgen, exmc, etc) */
+#define EX_R9		0
+#define EX_R10		8
+#define EX_R11		16
+#define EX_R12		24
+#define EX_R13		32
+#define EX_DAR		40
+#define EX_DSISR	48
+#define EX_CCR		52
+#define EX_CFAR		56
+#define EX_PPR		64
+#if defined(CONFIG_RELOCATABLE)
+#define EX_CTR		72
+.if EX_SIZE != 10
+	.error "EX_SIZE is wrong"
+.endif
+#else
+.if EX_SIZE != 9
+	.error "EX_SIZE is wrong"
+.endif
+#endif
+
 /*
  * We're short on space and time in the exception prolog, so we can't
  * use the normal LOAD_REG_IMMEDIATE macro to load the address of label.
-- 
2.20.1

