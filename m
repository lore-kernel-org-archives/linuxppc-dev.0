Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B3BC4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Jul 2021 04:13:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B610B60F12
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Jul 2021 04:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B610B60F12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GZxwt1Y0wz3cLY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Jul 2021 14:13:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=c2o0B9Kg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634;
 helo=mail-pl1-x634.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=c2o0B9Kg; dkim-atps=neutral
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GZxwR0sHrz2xKP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jul 2021 14:13:26 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d1so5414128pll.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jul 2021 21:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ykLFcK2LoxGfjoebG0xxB7A3F0ZqbVKg91Rb/oevwTk=;
 b=c2o0B9Kg46/AKWi9PaN3nAE+4du65LCpfzRyuEmiJbxnUkHOgql/SUTNWGNkX9tnth
 ntI1ZjO/EuPuTfW8uGGO9L+s0yHZjEAV8YixQWDqZJc7C0ln83CRjK0kyPyVv6kcUuXx
 ixhBbMnHnSLPxJc9eZddfefzrMVCRftxJHMxzOO9ecAgwS+lW0OJTvVloMJtxNdyr29Y
 0e/MTYVsBQ45nM0hoM5IrD4ddKCA08ggrip5MKUXjZR3TXEjFFftJ1fAoFzg62tQ9595
 hWKnO0mGkUBDLLXIGDND/Z3raabohucdzRSxIfi7TwW2LcbIXFbIZFdL4ZdTvIpsdbZq
 q1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ykLFcK2LoxGfjoebG0xxB7A3F0ZqbVKg91Rb/oevwTk=;
 b=gKCyHO6bnllmnjwQqH8I3lzD/+yo+z/HjFu3ZOh6mNsJ1ggkBNIFuvC5qs4MJ4qpd0
 /jwwaetG/fwPsfOGyrDyoxV7F4ImhzSNxmbSJqNWq0VFNKwcKGtqPhXU9UkAa2h26Ubu
 YL6JDWVs9lXzE4j4IG9UBc3+SeVGC5ck53jgFU4iYCh22XpZBAcot281Z353Zpw8RIEf
 1I7g1axfZ4s3yojEndo8yf5L0WU1hjvYi26y3IvUs3hnZVo7yGGfw/H3EYlQb5loQMzr
 VW3cBJ6o1hlDDwlwFwGB7AwUlcrEi3vk5v9r39VGzIDGvoRJWy29Zsm0a8UnOj0922cy
 dRSw==
X-Gm-Message-State: AOAM530McAmzSesdXz46Lct3Mdf5SUBKGUZtJ6M8pNQGhveJl3SkeY0N
 BM1FCnKL01DI6crk+bu9qrGebeYA9tA=
X-Google-Smtp-Source: ABdhPJwe5CqvoNy5mLcP7KaBKXXjnhCrErqByzDkwsLZ3Pk61+B2/v4KrR/1KwA085P9/il4mv6IMA==
X-Received: by 2002:a17:90a:9b03:: with SMTP id
 f3mr3084323pjp.184.1627532004630; 
 Wed, 28 Jul 2021 21:13:24 -0700 (PDT)
Received: from tee480.ozlabs.ibm.com (110-175-254-242.static.tpgi.com.au.
 [110.175.254.242])
 by smtp.gmail.com with ESMTPSA id 198sm1617803pfw.21.2021.07.28.21.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jul 2021 21:13:24 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/2] selftests/powerpc: Add missing clobbered register to
 to ptrace TM tests
Date: Thu, 29 Jul 2021 14:13:16 +1000
Message-Id: <20210729041317.366612-1-jniethe5@gmail.com>
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
Cc: Jordan Niethe <jniethe5@gmail.com>, mikey@neuling.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

ISA v3.1 removes TM but includes a synthetic implementation for
backwards compatibility.  With this implementation,  the tests
ptrace-tm-spd-gpr and ptrace-tm-gpr should never be able to make any
forward progress and eventually should be killed by the timeout.
Instead on a P10 running in P9 mode, ptrace_tm_gpr fails like so:

test: ptrace_tm_gpr
tags: git_version:unknown
Starting the child
...
...
GPR[27]: 1 Expected: 2
GPR[28]: 1 Expected: 2
GPR[29]: 1 Expected: 2
GPR[30]: 1 Expected: 2
GPR[31]: 1 Expected: 2
[FAIL] Test FAILED on line 98
failure: ptrace_tm_gpr
selftests:  ptrace-tm-gpr [FAIL]

The problem is in the inline assembly of the child. r0 is loaded with a
value in the child's transaction abort handler but this register is not
included in the clobbers list.  This means it is possible that this
statement:
	cptr[1] = 0;
which is meant to signal the parent to wait may actually use the value
placed into r0 by the inline assembly incorrectly signal the parent to
continue.

By inspection the same problem is present in ptrace-tm-spd-gpr.

Adding r0 to the clobbbers list makes the test fail correctly via a
timeout on a P10 running in P8/P9 compatibility mode.

Suggested-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
 tools/testing/selftests/powerpc/ptrace/ptrace-tm-gpr.c     | 2 +-
 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-gpr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-gpr.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-gpr.c
index 82f7bdc2e5e6..7df7100a29be 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-gpr.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-gpr.c
@@ -57,7 +57,7 @@ void tm_gpr(void)
 		: [gpr_1]"i"(GPR_1), [gpr_2]"i"(GPR_2),
 		[sprn_texasr] "i" (SPRN_TEXASR), [flt_1] "b" (&a),
 		[flt_2] "b" (&b), [cptr1] "b" (&cptr[1])
-		: "memory", "r7", "r8", "r9", "r10",
+		: "memory", "r0", "r7", "r8", "r9", "r10",
 		"r11", "r12", "r13", "r14", "r15", "r16",
 		"r17", "r18", "r19", "r20", "r21", "r22",
 		"r23", "r24", "r25", "r26", "r27", "r28",
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-gpr.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-gpr.c
index ad65be6e8e85..8706bea5d015 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-gpr.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-gpr.c
@@ -65,7 +65,7 @@ void tm_spd_gpr(void)
 		: [gpr_1]"i"(GPR_1), [gpr_2]"i"(GPR_2), [gpr_4]"i"(GPR_4),
 		[sprn_texasr] "i" (SPRN_TEXASR), [flt_1] "b" (&a),
 		[flt_4] "b" (&d)
-		: "memory", "r5", "r6", "r7",
+		: "memory", "r0", "r5", "r6", "r7",
 		"r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
 		"r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
 		"r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31"
-- 
2.25.1

