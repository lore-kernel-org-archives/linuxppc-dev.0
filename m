Return-Path: <linuxppc-dev+bounces-23341-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F74C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 02:01:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grKr35VZZz2yb9;
	Thu, 02 Jul 2026 12:01:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782957699;
	cv=none; b=LE642LYC2WiTLL8nvbJ0VkRJfaVehofL1FqWb2BZAQpvaLfHceCR5706DkNwRh9oi7zIuoO3GPoATcdRq5H05P7fgWvG0brOJ1UupA2xoqUOfYDPhe1GenlG0EMNWCd/VWS3Jy6gSF9+wJ0yccnp3fGbTb5Rkh9BH4IvcB39rom5ruzAHoSen0OX70OG9DlUzK2HOszCEklZwnJJpQVFmXLja+9dA8wB8fEZBmpP7jA3xDvbA/lF+bR9fxURiSwa6JAYeAJTlYrNTPbMfYhtMDBrspmPY7u8FB4TgQJH4f75NfyC+ZaBBpOQcmimE4wTnbiK3t1ICZWR+FW994Twuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782957699; c=relaxed/relaxed;
	bh=OsaKjnJ3wjWLU3qED3Odb0+hMaLfeNeSvAT8EPjIcAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J1ho4kMGPd+ENGaaHmEU3gj4ZTnI4XgHUkpoNpoqqk+2DqJqXh7GymkZQLU0CwBVwbrTbr/1/RRgvw4aoiuRqSECz9i7innqT4DPVQPukgcpV7kQ1bqQx7qTdUaAgtiH0/ZEXWX6WFkwAQ13e5EAtkb0E1CEwEmb/WQhWmeTMho8eLGFgiBPl6USIQd7/AhYnfzqj5rx9nqR4OLR/87T5pznoVlL09Rk0wB9dDpiGzfxELML2pOYPzTFLVDhnkhhonc7ztL3g4WJfFEc6ih9lAeRm20q4UTc7IMBbbUtTXk5Ihs9/4NwIXCk8MGCL0p2Xq3FyF1Ztf3Ph0jTNDwKLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=wangyan01@kylinos.cn; receiver=lists.ozlabs.org) smtp.mailfrom=kylinos.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kylinos.cn (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=wangyan01@kylinos.cn; receiver=lists.ozlabs.org)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grKr165FMz2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 12:01:36 +1000 (AEST)
X-UUID: c9a5ed1c75b911f1aa26b74ffac11d73-20260702
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:482f08d6-d2e1-4284-8059-2826892ba946,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:482f08d6-d2e1-4284-8059-2826892ba946,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:2facea0f041050c930e77639e015769e,BulkI
	D:260701203554XPBJRPLK,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|102|127|
	136|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,
	Bulk:41,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c9a5ed1c75b911f1aa26b74ffac11d73-20260702
X-User: wangyan01@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <wangyan01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 886953087; Thu, 02 Jul 2026 10:00:23 +0800
From: Wang Yan <wangyan01@kylinos.cn>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Yan <wangyan01@kylinos.cn>
Subject: [PATCH v2] selftests/powerpc/tm: fix spelling errors in comments
Date: Thu,  2 Jul 2026 09:59:59 +0800
Message-Id: <20260702015959.370633-1-wangyan01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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


