Return-Path: <linuxppc-dev+bounces-23980-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F188C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 00:31:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxCSC0gmrz2yYd;
	Fri, 10 Jul 2026 10:31:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783601821;
	cv=none; b=YwSVyMzc+Pn8Nki7Tvvkt3OhBXuFivdK85vmh5D2qwqZ4SAcWkUm673tuA/Hl9kmzhvkmognIxddhSMkDNOYrUfFtvqIrENh6ah8sTwggUlrBpxZXJDSukTraKKzwSGNlOa+DQGngvK24LZrx4p1fx4YqA7r4m9wvZpD+H+wB+8yyrGW5VA6RJiU3jSP4tnap8Lj9QVxraKhZ/GsC3SM69thJS3bDiLXdDKAFf63NjnjCTdh+BEoJW6T58ulCPnyEeWRiMfP9DqdfSt1NZivR9yudzGouCUoliuuQkDZAO6djzX1R2a/sHdZIGI3I8QfUchQjaDRzllEtl/wzdN9wA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783601821; c=relaxed/relaxed;
	bh=I+Dwerjt9JTfPsh4DxUO05Z7/ESTBj3/frGUVAmciPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kj+CVT3kWYtD2YXrVE1v0HkmSsG0HHgfUxrdw/JRCBe2qBxChlUbP8aAnvlGUJOQRXJJw6KcJcsd8WWqSQ6XJcGLvGLchCo2m97Aep4WVDwG5p5dYUlIYbs2BMaQ1noXoPNp8Ank7QLvPxgN+/LEov8xxAITOaFl4EARs6mA0Ln1P3RK0XSs7bLvQmafp9o3s6EooPP++jifRskoW7w78zm3tEMUhpcLxcdUz6dSKKP5fjjyWDi54cGlh7TbHSEyQMWzeQEh1VcZYF0+6SpvPPZA3H7uju/dRfeluG/GHOc83FQBPF7DrC1OIULHlkjo8mCyGC6wcjhWda0KeC0CKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=yanlonglong@kylinos.cn; receiver=lists.ozlabs.org) smtp.mailfrom=kylinos.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kylinos.cn (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=yanlonglong@kylinos.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 367 seconds by postgrey-1.37 at boromir; Thu, 09 Jul 2026 22:56:58 AEST
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gww2y4kc9z3c9k
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 22:56:57 +1000 (AEST)
X-UUID: a55d5b6c7b9411f1aa26b74ffac11d73-20260709
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:5de5cda1-7cfb-4b74-8811-b5056a8f3c30,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:3df98d8a7e353cf3344612617964cdc6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a55d5b6c7b9411f1aa26b74ffac11d73-20260709
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2011261336; Thu, 09 Jul 2026 20:49:38 +0800
From: longlong yan <yanlonglong@kylinos.cn>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au
Cc: npiggin@gmail.com,
	chleroy@kernel.org,
	ganeshgr@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	longlong yan <yanlonglong@kylinos.cn>
Subject: [PATCH] selftests/powerpc: Check mmap return value in inject-ra-err
Date: Thu,  9 Jul 2026 20:49:18 +0800
Message-ID: <20260709124919.616-1-yanlonglong@kylinos.cn>
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

mmap() in test_ra_error() is not checked for MAP_FAILED. On failure,
the subsequent write *paste_addr = 1 dereferences an invalid pointer
and segfaults. Add a FAIL_IF() check, consistent with the rest of the
function.

Fixes: 0f4ef8a3bf78 ("selftests/powerpc: Add test for real address error handling")
Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
---
 tools/testing/selftests/powerpc/mce/inject-ra-err.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/powerpc/mce/inject-ra-err.c b/tools/testing/selftests/powerpc/mce/inject-ra-err.c
index 94323c34d9a6..0622fd814114 100644
--- a/tools/testing/selftests/powerpc/mce/inject-ra-err.c
+++ b/tools/testing/selftests/powerpc/mce/inject-ra-err.c
@@ -47,6 +47,7 @@ static int test_ra_error(void)
 	FAIL_IF(sigaction(SIGBUS, &act, NULL) != 0);
 
 	paste_addr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0ULL);
+	FAIL_IF(paste_addr == MAP_FAILED);
 
 	/* The following assignment triggers exception */
 	mb();
-- 
2.43.0


