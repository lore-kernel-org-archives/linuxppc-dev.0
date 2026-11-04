Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F20606A31B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=qTLauwyw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKNSl2rz5z2xSF;
	Wed, 04 Nov 2026 22:27:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793778545;
	cv=none; b=V4RNwIBHbym7sCbLnoV/BK/1cpIZDiOvY7E+7HgaopngITmBQd97VZF3/e8uw7wjwBv6YNFN9e5C1hUqDPWaU1gGSWXyIPuxaWkTxu2p3mYkHzU7wyxEvKNCObMr3tZe6boO6qCh/DLX74hYsB9rdcQCXot5GeijFPrOHRdxEM7We3V7MwkvPorEJR5CLsUg+krluUuyoKfsEe77CPw37Oxu5mWiXvOzeMCj9xCeahxKW5DO1Jt7Rb12P7WfF4pIDrVxbmvfipSwGDmiu92xmdW1HpzGcNk/xxFhAz8UGFxDcYfkfqRZjWjokZ4YKMcKyuaerIWM558tu2yR/NrFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793778545; c=relaxed/relaxed;
	bh=Jt9CR1CSRZ6Ktj8I6zQMaT2yOxArWJnQvfIt31B1mLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hq3hfH4ciquFW+6CMsR/vD3PUXp9D71K2RSW0TI39mZj859mGhMcpgXgzzkWUWjA/e32VFxjnZwmco667fffm35BffUCl5J7FCYU9OREstg8hrfMNIQsbY2YhdbFa0uOlWoDqNLsAIVfSBOP4HRItkDLvjwlrn6muqrTdUN+R3n+y44iEs6FtEHe3aV4AmzI9dWvYF1iwOhvD8oqGIPEPxTLyd5ZvdODB9owtt46GYm9iYzOV8tPPuVja9eFnJJ010ZxNoVQtP9cXlVN4Q4kT4ZZdJ80NNT27DULQ14EruecXlrUOjlwZC08amKPzK4iiJ/nYDgAey8mPsflFHxWog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; dkim=pass (1024-bit key; unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=qTLauwyw; dkim-atps=neutral; spf=pass (client-ip=111.22.67.139; helo=cmccmta6.chinamobile.com; envelope-from=zhangchujun@cmss.chinamobile.com; receiver=lists.ozlabs.org) smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=qTLauwyw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cmss.chinamobile.com (client-ip=111.22.67.139; helo=cmccmta6.chinamobile.com; envelope-from=zhangchujun@cmss.chinamobile.com; receiver=lists.ozlabs.org)
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKHdD0sZxz2xDD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 18:49:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=qTLauwywGL8nzOwqWWa4QMWghErEjOfZ4i/hCOK0PxhXdWA62GFbjgRSCyqcpbltz5mT/xBRjFrqn
	 7oA/xSjXEQ43RRZOlZdm3n7Ev14nMmHmDQXStKKy9pUTI8EDxy3G3Ws9woNSShCZnC5CnpCpbPE7il
	 KGNBYLYAVgNeWNWE=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96aeae369b56-a0aba;
	Wed, 04 Nov 2026 15:48:58 +0800 (CST)
X-RM-TRANSID:2ee96aeae369b56-a0aba
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from desktop-eb75daa8a6be458c-20260816004526035 (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66aeae368009-192e2;
	Wed, 04 Nov 2026 15:48:58 +0800 (CST)
X-RM-TRANSID:2ee66aeae368009-192e2
From: zhangchujun <zhangchujun@cmss.chinamobile.com>
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	zhangchujun <zhangchujun@cmss.chinamobile.com>
Subject: [PATCH] selftests/powerpc: ptrace: fix unsigned counter format specifiers
Date: Wed,  4 Nov 2026 15:48:54 +0800
Message-ID: <20261104074854.1955-1-zhangchujun@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The hardware breakpoint counters breaks, needed, breaks1 and
breaks2 are unsigned long long, but perf-hwbreak.c prints them
using signed integer format specifiers.

Use %llu to match their types and avoid interpreting large
counter values as negative numbers.

Signed-off-by: zhangchujun <zhangchujun@cmss.chinamobile.com>

diff --git a/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c b/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
index e374c6b7ace6..5b255c1fa67e 100644
--- a/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
+++ b/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
@@ -277,10 +277,10 @@ static int runtestsingle(int readwriteflag, int exclude_user, int arraytest)
 	if (readwriteflag & HW_BREAKPOINT_W)
 		needed += loop_num;
 	needed = needed * (1 - exclude_user);
-	printf("TESTED: addr:0x%lx brks:% 8lld loops:% 8i rw:%i !user:%i array:%i\n",
+	printf("TESTED: addr:0x%lx brks:% 8llu loops:% 8i rw:%i !user:%i array:%i\n",
 	       (unsigned long int)ptr, breaks, loop_num, readwriteflag, exclude_user, arraytest);
 	if (breaks != needed) {
-		printf("FAILED: 0x%lx brks:%lld needed:%lli %i %i %i\n\n",
+		printf("FAILED: 0x%lx brks:%llu needed:%llu %i %i %i\n\n",
 		       (unsigned long int)ptr, breaks, needed, loop_num, readwriteflag, exclude_user);
 		return 1;
 	}
@@ -324,7 +324,7 @@ static int runtest_dar_outside(void)
 	if (breaks == 0) {
 		printf("TESTED: No overlap\n");
 	} else {
-		printf("FAILED: No overlap: %lld != 0\n", breaks);
+		printf("FAILED: No overlap: %llu != 0\n", breaks);
 		fail = 1;
 	}
 
@@ -339,7 +339,7 @@ static int runtest_dar_outside(void)
 	if (breaks == 2) {
 		printf("TESTED: Partial overlap\n");
 	} else {
-		printf("FAILED: Partial overlap: %lld != 2\n", breaks);
+		printf("FAILED: Partial overlap: %llu != 2\n", breaks);
 		fail = 1;
 	}
 
@@ -354,7 +354,7 @@ static int runtest_dar_outside(void)
 	if (breaks == 2) {
 		printf("TESTED: Partial overlap\n");
 	} else {
-		printf("FAILED: Partial overlap: %lld != 2\n", breaks);
+		printf("FAILED: Partial overlap: %llu != 2\n", breaks);
 		fail = 1;
 	}
 
@@ -369,7 +369,7 @@ static int runtest_dar_outside(void)
 	if (breaks == 0) {
 		printf("TESTED: No overlap\n");
 	} else {
-		printf("FAILED: No overlap: %lld != 0\n", breaks);
+		printf("FAILED: No overlap: %llu != 0\n", breaks);
 		fail = 1;
 	}
 
@@ -384,7 +384,7 @@ static int runtest_dar_outside(void)
 	if (breaks == 2) {
 		printf("TESTED: Full overlap\n");
 	} else {
-		printf("FAILED: Full overlap: %lld != 2\n", breaks);
+		printf("FAILED: Full overlap: %llu != 2\n", breaks);
 		fail = 1;
 	}
 
@@ -437,7 +437,7 @@ static int test_process_multi_diff_addr(void)
 	close(fd2);
 
 	if (breaks1 != 2 || breaks2 != 2) {
-		printf("FAILED: %s: %lld != 2 || %lld != 2\n", desc, breaks1, breaks2);
+		printf("FAILED: %s: %llu != 2 || %llu != 2\n", desc, breaks1, breaks2);
 		return 1;
 	}
 
@@ -482,7 +482,7 @@ static int test_process_multi_same_addr(void)
 	close(fd2);
 
 	if (breaks1 != 2 || breaks2 != 2) {
-		printf("FAILED: %s: %lld != 2 || %lld != 2\n", desc, breaks1, breaks2);
+		printf("FAILED: %s: %llu != 2 || %llu != 2\n", desc, breaks1, breaks2);
 		return 1;
 	}
 
@@ -527,7 +527,7 @@ static int test_process_multi_diff_addr_ro_wo(void)
 	close(fd2);
 
 	if (breaks1 != 1 || breaks2 != 1) {
-		printf("FAILED: %s: %lld != 1 || %lld != 1\n", desc, breaks1, breaks2);
+		printf("FAILED: %s: %llu != 1 || %llu != 1\n", desc, breaks1, breaks2);
 		return 1;
 	}
 
@@ -572,7 +572,7 @@ static int test_process_multi_same_addr_ro_wo(void)
 	close(fd2);
 
 	if (breaks1 != 1 || breaks2 != 1) {
-		printf("FAILED: %s: %lld != 1 || %lld != 1\n", desc, breaks1, breaks2);
+		printf("FAILED: %s: %llu != 1 || %llu != 1\n", desc, breaks1, breaks2);
 		return 1;
 	}
 
@@ -616,7 +616,7 @@ static int test_syswide_multi_diff_addr(void)
 	free(fd2);
 
 	if (breaks1 != 2 || breaks2 != 2) {
-		printf("FAILED: %s: %lld != 2 || %lld != 2\n", desc, breaks1, breaks2);
+		printf("FAILED: %s: %llu != 2 || %llu != 2\n", desc, breaks1, breaks2);
 		return 1;
 	}
 
@@ -660,7 +660,7 @@ static int test_syswide_multi_same_addr(void)
 	free(fd2);
 
 	if (breaks1 != 2 || breaks2 != 2) {
-		printf("FAILED: %s: %lld != 2 || %lld != 2\n", desc, breaks1, breaks2);
+		printf("FAILED: %s: %llu != 2 || %llu != 2\n", desc, breaks1, breaks2);
 		return 1;
 	}
 
@@ -704,7 +704,7 @@ static int test_syswide_multi_diff_addr_ro_wo(void)
 	free(fd2);
 
 	if (breaks1 != 1 || breaks2 != 1) {
-		printf("FAILED: %s: %lld != 1 || %lld != 1\n", desc, breaks1, breaks2);
+		printf("FAILED: %s: %llu != 1 || %llu != 1\n", desc, breaks1, breaks2);
 		return 1;
 	}
 
@@ -748,7 +748,7 @@ static int test_syswide_multi_same_addr_ro_wo(void)
 	free(fd2);
 
 	if (breaks1 != 1 || breaks2 != 1) {
-		printf("FAILED: %s: %lld != 1 || %lld != 1\n", desc, breaks1, breaks2);
+		printf("FAILED: %s: %llu != 1 || %llu != 1\n", desc, breaks1, breaks2);
 		return 1;
 	}
 
@@ -797,7 +797,7 @@ static int runtest_unaligned_512bytes(void)
 	close(fd);
 
 	if (breaks != 2) {
-		printf("FAILED: %s: %lld != 2\n", desc, breaks);
+		printf("FAILED: %s: %llu != 2\n", desc, breaks);
 		return 1;
 	}
 
-- 
2.50.1.windows.1




