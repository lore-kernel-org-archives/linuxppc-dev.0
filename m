Return-Path: <linuxppc-dev+bounces-23307-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DE3C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 12:51:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gr0JW2tmyz2xKh;
	Wed, 01 Jul 2026 22:51:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782909801;
	cv=none; b=eKDxq1/IDwKk7E7hH9ViG7TSteAmLrP3nFGI7blADOWCgLzfspQE+BoNuMBOM/G46ACXZIjwWq3L+J9ha+3OiyAxpwzTmDoK5ejgfz7zMfNWy79P3+doL1ZtyVbNC1VNTwtMYzjjLhP42vKwf4r0RmB9zxkN4I9AehicgnJx29XV1LJj7eH/spR3unf6rSVzUhKg6aUjQv/Vjks4V7ibt9K30evFXVqTIgTGt4pXnL926HQb8G5XZMejHYutY56WKVhCrPs9phoRNw/1OVfJHSKZFyoJNkCpyuhMa+4nEDpkOhSYEnBH7ElWmYlaxPsGIgi6cP2xNF9iJGYdeyN7cg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782909801; c=relaxed/relaxed;
	bh=OsaKjnJ3wjWLU3qED3Odb0+hMaLfeNeSvAT8EPjIcAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jVi/9xUdorku/um1jx9CGAzNTxYCNRuQscPF+vR3IomUPrfAuwvO3NwFgE5rCmOvSUezah/1tFNJBoo0pymlwIjWpHxdkoElW4xG64qjVaCwcLKxHITFY8bhI2k5ENsMRCxmzcFTYb/0WryZCmRgRd/8hhhDL/8o6M9ycZQQ7W/Xcnr8sG1cAoqhrfq6i/zQZy0dPe6OTQQVOwsPqwKDThngLuLTVJFozlMstSQAM4ksER6iBuB4C1OXXNRDjjfUB4Zcyi9phi6rbSAIqajMI/mtLEHr8Zmu3vLh6eSD07O2oxgYtScBWGqbfFgUOSx1K6dtP56GYFvKW8Rs2Xg3wA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=wangyan01@kylinos.cn; receiver=lists.ozlabs.org) smtp.mailfrom=kylinos.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kylinos.cn (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=wangyan01@kylinos.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 367 seconds by postgrey-1.37 at boromir; Wed, 01 Jul 2026 22:43:19 AEST
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gr06v1rLnz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 22:43:18 +1000 (AEST)
X-UUID: 65f38664754911f1aa26b74ffac11d73-20260701
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED
	DN_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:bf6aa7eb-c6be-4800-b028-9e96df855f36,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:40
X-CID-INFO: VERSION:1.3.12,REQID:bf6aa7eb-c6be-4800-b028-9e96df855f36,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:40
X-CID-META: VersionHash:e7bac3a,CLOUDID:84bc37e833540559da5696d077a9fe87,BulkI
	D:260701203554XPBJRPLK,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|136|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT
	:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP
	:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 65f38664754911f1aa26b74ffac11d73-20260701
X-User: wangyan01@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <wangyan01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1205726795; Wed, 01 Jul 2026 20:35:52 +0800
From: Wang Yan <wangyan01@kylinos.cn>
To: Shuah Khan <shuah@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Wang Yan <wangyan01@kylinos.cn>
Subject: [PATCH 6/6] selftests/powerpc/tm: fix spelling errors in comments
Date: Wed,  1 Jul 2026 20:35:20 +0800
Message-Id: <20260701123520.271580-7-wangyan01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260701123520.271580-1-wangyan01@kylinos.cn>
References: <20260701123520.271580-1-wangyan01@kylinos.cn>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix three spelling mistakes in powerpc TM selftest comments:
  - "delievery" -> "delivery" (powerpc/tm/tm-signal-stack.c)
  - "sucess" -> "success" (powerpc/tm/tm-tar.c)
  - "becuase" -> "because" (powerpc/tm/tm-signal-msr-resv.c)

Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
---
 tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c | 2 +-
 tools/testing/selftests/powerpc/tm/tm-signal-stack.c    | 2 +-
 tools/testing/selftests/powerpc/tm/tm-tar.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c b/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
index 4a61e9bd12b4..8aee18819603 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
@@ -42,7 +42,7 @@ void signal_usr1(int signum, siginfo_t *info, void *uc)
 #else
 	ucp->uc_mcontext.uc_regs->gregs[PT_MSR] |= (7ULL);
 #endif
-	/* Should segv on return becuase of invalid context */
+	/* Should segv on return because of invalid context */
 	segv_expected = 1;
 }
 
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-stack.c b/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
index 68807aac8dd3..7b323679437d 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
@@ -52,7 +52,7 @@ int tm_signal_stack()
 
 	/*
 	 * The flow here is:
-	 * 1) register a signal handler (so signal delievery occurs)
+	 * 1) register a signal handler (so signal delivery occurs)
 	 * 2) make stack pointer (r1) = NULL
 	 * 3) start transaction
 	 * 4) cause segv
diff --git a/tools/testing/selftests/powerpc/tm/tm-tar.c b/tools/testing/selftests/powerpc/tm/tm-tar.c
index f2a9137f3c1e..ea420caa3961 100644
--- a/tools/testing/selftests/powerpc/tm/tm-tar.c
+++ b/tools/testing/selftests/powerpc/tm/tm-tar.c
@@ -50,7 +50,7 @@ int test_tar(void)
 			"bne	2b;"
 			"tend.;"
 
-			/* Transaction sucess! TAR should be 3 */
+			/* Transaction success! TAR should be 3 */
 			"mfspr  7, %[tar];"
 			"ori	%[res], 7, 4;"  // res = 3|4 = 7
 			"b	4f;"
-- 
2.25.1


