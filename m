Return-Path: <SRS0=Ib4m=W7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75433C3A5A7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 12:46:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E29EC21883
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 12:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9qqdBZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29EC21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Nk925wsBzDqBW
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 22:46:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="p9qqdBZ7"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Nj3R4p6CzDqm9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Sep 2019 21:56:51 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id m3so11100417pgv.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Sep 2019 04:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JylisJigf++gS53W7lIrlmBxjjoi1jcxpjv+BCIE3+4=;
 b=p9qqdBZ7WR4BrPkq98NAHPQrkiWvh5JvuriBj/Xiu0u/fbKNbgadGyh4A8RM75/K+S
 Rj0Bjq1ME30ixuRZiRIbcK5KlpAyjuuSw3fJJh+8+QPVw+HTli0A2pnI+cKgDc36eYj+
 Sm/gPrtqd5/1DbEc6rNCIjfwAJmQNfd2DocdAqsunlwW0AeHkz/AO5LIjIU/E1xTpmbY
 KQIia5rRNMTt+0+AD+lJre2CKf1keRS1lQD2k4AYc9OwGuUv1nASnM7lmEXjqT9xxMil
 rnZfBb6mrRqfgN/AACBdaHLnCedgdNbIysNFaKKFcdE4UlSPGlXjFnw9E3z4Og2s2TRw
 vfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JylisJigf++gS53W7lIrlmBxjjoi1jcxpjv+BCIE3+4=;
 b=MsAXIApnNK8jZyYTZ3oknWEvn19fK/9tnomoxPdX0rSnPPOfbXUs7aUIyuII04u0Ok
 K0/7F7muAzz5/TWUD6aQLZGAvfc4bpsyBMBReSrRxcMsihOMuKVqtcdGVB4dxg2wRhP2
 rIztOUulgd5nf48iwi3IWrPkya/Pq3eG6BaYrSzz9bA8sfYjbhqbYiWExmEkJfcO5tdA
 bMJP6/jvgWoQzcXpmT0THuCiiZr6EnSVujMQgtYSVpvZG+YbVmfWOQHLDynerH/jK02I
 47xw0Oadx6fmfPoUQsANVxvdDZ2lNIUJ4P6dZIMgkV6WJOgvjZVDHX/I8yzaVDKksjgl
 +0pw==
X-Gm-Message-State: APjAAAUBVCF66xTnNdR7R+K+8dgz6vvAe9SOeQ7w6xjB9ap9PkZgJ/da
 qQzg5QA89vEH1eW6zjkHnzBBB2GJ
X-Google-Smtp-Source: APXvYqwSZmBX3B9BN/NEHjWddbMhvO3r9nGJQDYIwO7GzEY26U+5tlvKUqEUxS0soSbcXrxNXqww1w==
X-Received: by 2002:a65:64c4:: with SMTP id t4mr32244989pgv.298.1567598209484; 
 Wed, 04 Sep 2019 04:56:49 -0700 (PDT)
Received: from bobo.local0.net ([203.63.189.78])
 by smtp.gmail.com with ESMTPSA id g18sm19554789pgm.9.2019.09.04.04.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 04:56:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 17/20] powerpc/64s/exception: re-inline some handlers
Date: Wed,  4 Sep 2019 21:55:32 +1000
Message-Id: <20190904115535.18559-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190904115535.18559-1-npiggin@gmail.com>
References: <20190904115535.18559-1-npiggin@gmail.com>
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

The reduction in interrupt entry size allows some handlers to be
re-inlined.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 04359ff5d336..696aa19592e2 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1178,7 +1178,7 @@ INT_DEFINE_BEGIN(data_access)
 INT_DEFINE_END(data_access)
 
 EXC_REAL_BEGIN(data_access, 0x300, 0x80)
-	GEN_INT_ENTRY data_access, virt=0, ool=1
+	GEN_INT_ENTRY data_access, virt=0
 EXC_REAL_END(data_access, 0x300, 0x80)
 EXC_VIRT_BEGIN(data_access, 0x4300, 0x80)
 	GEN_INT_ENTRY data_access, virt=1
@@ -1208,7 +1208,7 @@ INT_DEFINE_BEGIN(data_access_slb)
 INT_DEFINE_END(data_access_slb)
 
 EXC_REAL_BEGIN(data_access_slb, 0x380, 0x80)
-	GEN_INT_ENTRY data_access_slb, virt=0, ool=1
+	GEN_INT_ENTRY data_access_slb, virt=0
 EXC_REAL_END(data_access_slb, 0x380, 0x80)
 EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x80)
 	GEN_INT_ENTRY data_access_slb, virt=1
@@ -1464,7 +1464,7 @@ INT_DEFINE_BEGIN(decrementer)
 INT_DEFINE_END(decrementer)
 
 EXC_REAL_BEGIN(decrementer, 0x900, 0x80)
-	GEN_INT_ENTRY decrementer, virt=0, ool=1
+	GEN_INT_ENTRY decrementer, virt=0
 EXC_REAL_END(decrementer, 0x900, 0x80)
 EXC_VIRT_BEGIN(decrementer, 0x4900, 0x80)
 	GEN_INT_ENTRY decrementer, virt=1
-- 
2.22.0

