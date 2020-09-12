Return-Path: <SRS0=BVGK=CV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DFFC433E2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2020 11:27:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83854208FE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2020 11:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B7Pu6ciA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83854208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BpVht3vrkzDr7s
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2020 21:27:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::441;
 helo=mail-pf1-x441.google.com; envelope-from=keescook@chromium.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=B7Pu6ciA; dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BpVH63gwtzDqmY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2020 21:08:34 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id l126so9081277pfd.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2020 04:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A/DJWaOGDg8TnLfPzYOmd0dx0QQlX1IuvmauX5MM/z4=;
 b=B7Pu6ciAM9Wj8FHsJTVw46Ua5S9hrVltSsm5GGaS80TxiMZMNP4Qchvzd+nfqOXIU1
 CHHjGHFwSGw6mUCZfJJDYG/a3j1+8UwQZY/t6O8DeOFsvbaU2KZs+7xn2lyBMtJ97Y3C
 3z/bEjC9kfU9Qffz2o59RBia8wGEjG4xeBAXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A/DJWaOGDg8TnLfPzYOmd0dx0QQlX1IuvmauX5MM/z4=;
 b=I1UtuaXzSk1E5id+WZELmXJlVNsMm4XjNatI5gS1acoCNL3qqfdjq9MItJIX4fwRDU
 CoZY9jsW1FU5v8QFoBdVQaH1tizMdCOghdZmFxC+xfYZOg0Xr9tmUEDRlU7Dqg6jfgjC
 WdnCNibKll/pGIl5WoJdZFEVPTvl74VvNAMytdUH+JbRUD2qXSVjUkQkntel2m+H4NZy
 rqrk+/gPDgHLpU3slMnjO+6mT7ujp0ApkaK9IQxP9qrZTIYIXwHI/wCp06h4gilUVqiP
 s2WCp50HitoPRmJtQjXHO4o/Qgez57eo4LGiWjIMJNReTIJar3MthNgbRrgZTI+B05Ty
 gu6A==
X-Gm-Message-State: AOAM531dqevs8a0TAYTb9YhM2B0PE083Amm8nYC+tao4yDLYua+EobKO
 9L8/AGhdnxWSctaLmlI9nV56g2oSDZFxDPYf
X-Google-Smtp-Source: ABdhPJymdaGehFfmWOF8pjaRXGA9IFueCBtSZeu4mHAGimcnmquUAgmxx02n5nOMGKgTrLGxVr5RwQ==
X-Received: by 2002:a62:301:0:b029:13c:1611:6587 with SMTP id
 1-20020a6203010000b029013c16116587mr5993137pfd.4.1599908912736; 
 Sat, 12 Sep 2020 04:08:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id x192sm4807719pfc.142.2020.09.12.04.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 04:08:27 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] selftests/seccomp: Avoid redundant register flushes
Date: Sat, 12 Sep 2020 04:08:15 -0700
Message-Id: <20200912110820.597135-11-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200912110820.597135-1-keescook@chromium.org>
References: <20200912110820.597135-1-keescook@chromium.org>
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
Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
 Will Drewry <wad@chromium.org>, Kees Cook <keescook@chromium.org>,
 linux-xtensa@linux-xtensa.org, linux-mips@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, Max Filippov <jcmvbkbc@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Christian Brauner <christian@brauner.io>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When none of the registers have changed, don't flush them back. This can
happen if the architecture uses a non-register way to change the syscall
(e.g. arm64) , and a return value hasn't been written.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index d9346121b89b..2790d9cd50f4 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1859,11 +1859,12 @@ int get_syscall(struct __test_metadata *_metadata, pid_t tracee)
 void change_syscall(struct __test_metadata *_metadata,
 		    pid_t tracee, int syscall, int result)
 {
-	ARCH_REGS regs;
+	ARCH_REGS orig, regs;
 
 	EXPECT_EQ(0, ARCH_GETREGS(regs)) {
 		return;
 	}
+	orig = regs;
 
 	SYSCALL_NUM_SET(regs, syscall);
 
@@ -1876,7 +1877,8 @@ void change_syscall(struct __test_metadata *_metadata,
 #endif
 
 	/* Flush any register changes made. */
-	EXPECT_EQ(0, ARCH_SETREGS(regs));
+	if (memcmp(&orig, &regs, sizeof(orig)) != 0)
+		EXPECT_EQ(0, ARCH_SETREGS(regs));
 }
 
 void tracer_seccomp(struct __test_metadata *_metadata, pid_t tracee,
-- 
2.25.1

