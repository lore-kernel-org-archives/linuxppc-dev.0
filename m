Return-Path: <linuxppc-dev+bounces-24630-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A264C44512
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 06:18:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4kbS5Pjvz2y1F;
	Wed, 22 Jul 2026 16:18:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784701124;
	cv=none; b=ct1u4w3z1MJDwWi2AEyNBesrzM84CnHLkSdwiAoatvM4VLwZb2ihsO5RMw7li48hgAQ7Cfl1K7etRvH3jUt4qwABGavXN+0GIgsdfnrBpkHwxcAjJJCCFoZCVvq6b9E3C/Xhs/UxkFva8VDhMX4W85VdtEpgw9VuALvaHHGMboYP9RktCq7zT1GkvOOR9TubCLJ700uygmvBmiwavsXyL5yDyf9E0VE6vMDLTXg3WFCgbcgvc9pQ7jOIsPQ+zxlm/+FzZRMKDXVCODRuV0uhnyZ8qGo8nb1DPFEJRrrWsKVCJ30VBC+2W17knfMoRCJWJ252qpJAYogOgWZI+yQJuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784701124; c=relaxed/relaxed;
	bh=+RY4L5637dtEBGtqU+gxLE6YAXSuSZ/eYjSPe0gHPdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HGraWF63+sMpC4t+Mfpm7oKs173b04s/XVngvZYmu90V1BGtpUnzzAmQgBoXnd4ViPhmNs/eGhJ19RHSCpoqi4hkfshvwY3P3YxvqMKIU6xBoC+2mn4HWPwaJwXVj6r3oKqZC7blyuAneyzcZbb0Eb9lmoVD4Ou2iSwwP0C5YyL70SOONtcfRUXLPW13dYixcf9YXqATfziS3YNckOj7vEN3mCOHCO5fgawiG1QeSQ6luv/oMrrzbP4Mdc+A+rlN+TpUCfQW1JUpGtexvA2s6UT+tbJ7C4grR+cRDrhCIRFB0ptIzHYVTWsMmQ5ntn4S7odZc+Jl2wFigPL+ooeyjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=yanlonglong@kylinos.cn; receiver=lists.ozlabs.org) smtp.mailfrom=kylinos.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kylinos.cn (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=yanlonglong@kylinos.cn; receiver=lists.ozlabs.org)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4kbQ6cLyz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 16:18:41 +1000 (AEST)
X-UUID: 044b22b2859511f1aa26b74ffac11d73-20260722
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ecdad7f1-9146-4cd4-b471-ccd7cf387132,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:3dd24d8d6561eeb933e135cf2820da91,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 044b22b2859511f1aa26b74ffac11d73-20260722
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2048049471; Wed, 22 Jul 2026 14:17:29 +0800
From: longlong yan <yanlonglong@kylinos.cn>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au
Cc: npiggin@gmail.com,
	chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	longlong yan <yanlonglong@kylinos.cn>
Subject: [PATCH] selftests/powerpc: fix typos in tm-signal-stack comment
Date: Wed, 22 Jul 2026 14:17:11 +0800
Message-ID: <20260722061712.948-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
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

Fix three spelling errors in the file header comment:
  - "delievery" -> "delivery"
  - "trelaim" -> "treclaim"
  - "hance" -> "hence"

Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
---
 tools/testing/selftests/powerpc/tm/tm-signal-stack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-stack.c b/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
index 68807aac8dd3..3bc3a2e1526d 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
@@ -2,15 +2,15 @@
 /*
  * Copyright 2015, Michael Neuling, IBM Corp.
  *
- * Test the kernel's signal delievery code to ensure that we don't
- * trelaim twice in the kernel signal delivery code.  This can happen
+ * Test the kernel's signal delivery code to ensure that we don't
+ * treclaim twice in the kernel signal delivery code.  This can happen
  * if we trigger a signal when in a transaction and the stack pointer
  * is bogus.
  *
  * This test case registers a SEGV handler, sets the stack pointer
  * (r1) to NULL, starts a transaction and then generates a SEGV.  The
  * SEGV should be handled but we exit here as the stack pointer is
- * invalid and hance we can't sigreturn.  We only need to check that
+ * invalid and hence we can't sigreturn.  We only need to check that
  * this flow doesn't crash the kernel.
  */
 
-- 
2.43.0


