Return-Path: <SRS0=DFH+=DY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3147C433E7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2020 00:49:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A880321D81
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2020 00:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PdMACSbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A880321D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCktv4TXLzDqwJ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2020 11:49:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--morbo.bounces.google.com
 (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com;
 envelope-from=3qz-kxwukdowacfpcuccuzs.qcazwbilddq-rsjzwghg.cnzopg.cfu@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=PdMACSbF; dkim-atps=neutral
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCks43PhZzDqMk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2020 11:48:05 +1100 (AEDT)
Received: by mail-pf1-x44a.google.com with SMTP id b195so2340609pfb.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2020 17:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=jsPNLKRt0zVT0owId+SX5kSYWOR84snN45v+3a3AfG8=;
 b=PdMACSbFfcgqdAAL0gSxsAQD4S8LWoOWgZOzLX4zHianfpWYE7u71cFGln91BamRuB
 wOut5MrpBl626fI3I/p7Sxoyl/zok3BMWOVssLcxP7V/+kUJmrGmGpbErYn8lz67jQUH
 xiKTETFxSej6pzlzucQzkC08bhJ3IzNsNdqdpQIehHo5bfK24ahWNH4hiAYcEntJpMBI
 uiT6EJEKBW9rjAWS1hOMywMoSYF0Pmw1BfprPxtdP3sEzuQeqiZjHbey+1yhfL/yA5WU
 82DTWh1LMvrEPg5PVVYu2KEJ0hjlf2kebz0WxwK0EHiQSqQTU76Do8fBM39i6pHMfW/8
 WUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=jsPNLKRt0zVT0owId+SX5kSYWOR84snN45v+3a3AfG8=;
 b=bOUuE5T0hJCVxpXs/65QplD2705pJ8bVxecaz2cte/buM59HQKEgYE2hhzk1r2Uejg
 4xHD512O9ERX1elFqYIDvDLRicoAXC6t08q28aZ5EuUso55gKiznUW5Z5gTRZ6PhbUVL
 8Roo9JogvFs91g8jKULgCMmhHRFlLTKSdzFBaw7Afwdj5x2DseovvpjgAdb2/G2hleKb
 46Evo62PasowMPCBWVs9B/+HPyUqfmAlQdMq8lznIoCiAuVPKoyzxntXjmhe7wObTc9k
 95Nex1idEhVQAdB50te5f/fEm8MJ+RSQLkbnVs9urb7u9pjiaha98ytLwd1qKkyFPTCF
 Av0A==
X-Gm-Message-State: AOAM530udHfiY47hmDEqdsxLKkE+TsXOKMfHG5yPIb7SRV0HDJoVk2xZ
 cL5rYtNXPWRaOhJ7K+QJfSAV/k0vj+5PboSOFaGVa1l8VRTQrR+27kEU70j55UDqikZ/Vfnt7+9
 nlWtv6NjuBaPtxZq6XIRUrAuskke7kgd7UcrybUvrnyK0KwDX+oHo6iGBSBdYMagMgo0=
X-Google-Smtp-Source: ABdhPJyujnTqOo0oeIRLZ0m/4nV2sNP8LxrB+GFRw7Gwqe292l9rX4xyV23m/Uq3+m+5rwTPJ9NFj6/+JA==
X-Received: from fawn.svl.corp.google.com
 ([2620:15c:2cd:202:7220:84ff:fe0f:9f6a])
 (user=morbo job=sendgmr) by 2002:a17:90a:c388:: with SMTP id
 h8mr6690265pjt.100.1602895683144; Fri, 16 Oct 2020 17:48:03 -0700 (PDT)
Date: Fri, 16 Oct 2020 17:47:52 -0700
In-Reply-To: <20201017004752.415054-1-morbo@google.com>
Message-Id: <20201017004752.415054-3-morbo@google.com>
Mime-Version: 1.0
References: <20201017004752.415054-1-morbo@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH 2/2] powerpc/boot: Use clang when CC is clang
From: Bill Wendling <morbo@google.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
Cc: Fangrui Song <maskray@google.com>, Alan Modra <amodra@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Bill Wendling <morbo@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The gcc compiler may not be available if CC is clang.

Cc: Fangrui Song <maskray@google.com>
Cc: Alan Modra <amodra@gmail.com>
Signed-off-by: Bill Wendling <morbo@google.com>
---
 arch/powerpc/boot/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index b88fd27a45f0..218f1c9adb5b 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -21,7 +21,11 @@
 all: $(obj)/zImage
 
 ifdef CROSS32_COMPILE
+ifdef CONFIG_CC_IS_CLANG
+    BOOTCC := $(CROSS32_COMPILE)clang
+else
     BOOTCC := $(CROSS32_COMPILE)gcc
+endif
     BOOTAR := $(CROSS32_COMPILE)ar
 else
     BOOTCC := $(CC)
-- 
2.29.0.rc1.297.gfa9743e501-goog

