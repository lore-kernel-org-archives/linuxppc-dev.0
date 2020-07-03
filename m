Return-Path: <SRS0=ZYlp=AO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA510C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2020 14:20:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68EFC20737
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2020 14:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="lUSRr248"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EFC20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49yxvJ4NpLzDqwn
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Jul 2020 00:20:28 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49yxkH0gHWzDqSG
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jul 2020 00:12:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=lUSRr248; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 49yxkG6QJ9z9sQt; Sat,  4 Jul 2020 00:12:38 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49yxkG5RBnz9sR4; Sat,  4 Jul 2020 00:12:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1593785558;
 bh=15fI55SZP5j6guXIt082X3iCYa/XF1pgK7epjzV0ArQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lUSRr248jcHj/z3CFKM0QhvfAZ3JS/veTjjCjCVR/1wGmrhy4jR+1hnZTZINOjqUa
 627uXmujjRxs5yBCMCve912CLsU0xToJRbDqGh+nn2HKmMXatSxWLYZZYnwDsTeCCS
 d1dThwDWlv/IY90NPAXjM0kbIbjFnEio0vfPkaCf20seS6WLsMovZg55Dpjb2UqLwx
 WFBlk23Y0kICAAIiqdqcjaS4ngPxumGQa5IufaGOl8aLJ8ceyJNZPcIN+KTYSgDiVf
 U66BYbnBqvM1AgMcB2Un2GSxJ1uTWuUJddCPTQ5dgyayKZUuPLlmdlQoOEaES0Uv32
 ibWZsRS0j3QOg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] selftests/powerpc: Update the stack expansion test
Date: Sat,  4 Jul 2020 00:13:25 +1000
Message-Id: <20200703141327.1732550-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703141327.1732550-1-mpe@ellerman.id.au>
References: <20200703141327.1732550-1-mpe@ellerman.id.au>
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
Cc: linux-arch@vger.kernel.org, hughd@google.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Update the stack expansion load/store test to take into account the
new allowance of 4096 bytes below the stack pointer.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 .../selftests/powerpc/mm/stack_expansion_ldst.c        | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c b/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
index 0587e11437f5..95c3f3de16a1 100644
--- a/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
+++ b/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
@@ -186,17 +186,17 @@ static void test_one_type(enum access_type type, unsigned long page_size, unsign
 	// But if we go past the rlimit it should fail
 	assert(test_one(DEFAULT_SIZE, rlim_cur + 1, type) != 0);
 
-	// Above 1MB powerpc only allows accesses within 2048 bytes of
+	// Above 1MB powerpc only allows accesses within 4096 bytes of
 	// r1 for accesses that aren't stdu
-	assert(test_one(1 * _MB + page_size - 128, -2048, type) == 0);
+	assert(test_one(1 * _MB + page_size - 128, -4096, type) == 0);
 #ifdef __powerpc__
-	assert(test_one(1 * _MB + page_size - 128, -2049, type) != 0);
+	assert(test_one(1 * _MB + page_size - 128, -4097, type) != 0);
 #else
-	assert(test_one(1 * _MB + page_size - 128, -2049, type) == 0);
+	assert(test_one(1 * _MB + page_size - 128, -4097, type) == 0);
 #endif
 
 	// By consuming 2MB of stack we test the stdu case
-	assert(test_one(2 * _MB + page_size - 128, -2048, type) == 0);
+	assert(test_one(2 * _MB + page_size - 128, -4096, type) == 0);
 }
 
 static int test(void)
-- 
2.25.1

