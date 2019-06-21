Return-Path: <SRS0=Jsh9=UU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD13C43613
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2019 22:58:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632922084E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2019 22:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCPeqPxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632922084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45VvH20yqWzDqgd
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Jun 2019 08:58:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hCPeqPxx"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45VvF36YHYzDqcl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jun 2019 08:56:21 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id 19so4313693pfa.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2019 15:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fM3xXsLMY8U8e4KSY8xhzS5sxrHPrEIacyZ6PTs0d0Q=;
 b=hCPeqPxxQNfVQiwHpwkI4Ghdgl6k11gn6xgQIoZNtkNzL4jLltxCUvlsqHe/KAvA43
 QTL9bdH0WeNg0mOzS8m8J0OLuvSZbhU/dhhLsaQ5GtWnqcbl0rIhPJEISCSN/zQ0nSnZ
 RdAxciYmsaX69NY+jxsuAH2FBOdxKuhVZ2w2z6ps+7fTLPIPYUZ4MWA7laIKUH0MAnhV
 itc0EspncB7gB/8ojA20aoh2x/yGTNkNduFlDrbB+HbgWS9YQ1jKUsDumbRQP5iE/XPg
 YQkXkH1SXBAS+tnJN5RP8iXp0ayoMFk6fjOkmL4z4Yt0e44C3fpRMWDsPwDMJCp/mM3l
 Seng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fM3xXsLMY8U8e4KSY8xhzS5sxrHPrEIacyZ6PTs0d0Q=;
 b=VPYHfgXLgj6D4z9O2k290f7v8G0iahsXvj3iya8zfDqqKF634qgauKRiJpw0hUmJhk
 D4PBR8mb8HCnk2veES54ESoKPO8n0TQsnUu3O7x77XHDJORiYnXAuziiJIsItqJLobdq
 SYSnGvBKjGKBI5Er4GxK3rYnrkJSzFRAl4+6DklK5p8aBOkIDbbq3tZsoAof5s4Gkj6d
 yjMn70PeaLsvpOfQNQLC6wF/6+FfLSdtnXvtVJ9aAtPgFR9wGyW7031uODtwsG1V5mwI
 HhgFv9hv5bB17yVvdXfnrOmvdfaCEc7IVJd0Q//If6d/y3gTr1srg6NYdUZ29LsmT3qa
 TVZA==
X-Gm-Message-State: APjAAAUkpIjgmV/+lL10Rw3f2OATwHX0yr3OtTwh3dKMBzxv+iHfIKPO
 lzyeHON7RBA0+PYozeKaDTxmetEf
X-Google-Smtp-Source: APXvYqypPQqqXAUSdFiShzyaLmTB2My3NR6RWln4hBDI0g391dS3nTI+TR632Rq19ELmQqqXg//Slg==
X-Received: by 2002:a17:90a:a404:: with SMTP id
 y4mr9987823pjp.58.1561157777748; 
 Fri, 21 Jun 2019 15:56:17 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([1.144.146.144])
 by smtp.gmail.com with ESMTPSA id v23sm3744114pff.185.2019.06.21.15.56.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 21 Jun 2019 15:56:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64s/exception: Fix machine check early corrupting AMR
Date: Sat, 22 Jun 2019 08:55:54 +1000
Message-Id: <20190621225554.1913-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The early machine check runs in real mode, so locking is unnecessary.
Worse, the windup does not restore AMR, so this can result in a false
KUAP fault after a recoverable machine check hits inside a user copy
operation.

Fix this similarly to HMI by just avoiding the kuap lock in the
early machine check handler (it will be set by the late handler that
runs in virtual mode if that runs). If the virtual mode handler is
reached, it will lock and restore the AMR.

Fixes: 890274c2dc4c0 ("powerpc/64s: Implement KUAP for Radix MMU")
Cc: Russell Currey <ruscur@russell.cc>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 6b86055e5251..73ba246ca11d 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -315,7 +315,7 @@ TRAMP_REAL_BEGIN(machine_check_common_early)
 	mfspr	r11,SPRN_DSISR		/* Save DSISR */
 	std	r11,_DSISR(r1)
 	std	r9,_CCR(r1)		/* Save CR in stackframe */
-	kuap_save_amr_and_lock r9, r10, cr1
+	/* We don't touch AMR here, we never go to virtual mode */
 	/* Save r9 through r13 from EXMC save area to stack frame. */
 	EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
 	mfmsr	r11			/* get MSR value */
-- 
2.20.1

