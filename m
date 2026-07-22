Return-Path: <linuxppc-dev+bounces-24628-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E57C4452D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 02:36:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4dfT1PlTz2xnK;
	Wed, 22 Jul 2026 12:36:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784687761;
	cv=none; b=B5R7AXA+LBrN1YU+m71UMSkrFW4pub2EBLoQl3hOpvzn+z3DXVaM9cxNIrH8gunRrXYuuXskKz7gH8HsBxhJelQvnTWQ+ynZoNqgWbjaaGjM7SkNXJsY08sHC88UYq8R+xe06hCSclmn2Chcf8+R10XdgLN+O8z9hH5PCx5iwBR53QonrBCf28KPROsTNZxEhohv5ZjRXj5jitM7BUMqQOCujeSSOFbPz2//1pqwbsuPqk4+ezzOfjbDFcZ49Ux+n4Fjyilf9YD/QTvNNO3Bjs+RUDh9JD+3TU/3YTprsd8v+N/eRODDoFpOP9SosKUBn1kEFKTypT60nL1XkpasHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784687761; c=relaxed/relaxed;
	bh=kpNumPAk7arU58YTtiiCmiKmSm5NdgBXQVtGvst1Zes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGxxKdRP57B8bAFlR+U6utU4hwkS2jiTLA8wOX01rN1WAnzu8oKnAvlNAmYlNbvlkwxOsN0vaOdVA+jL60Wxro2Z1ororEUY5Rz4NnVELVtJMx1F1hA/E2/y5/f0poq1Q2BZbkJouatRUOi++qyAlJ0wgM2rOxFchczQoqNSdsNZ4pJFUzgRsnlnwobdsMRnQeNhaNa55X34SDGKAK8YrSJ5Tz0sWdXau1XRAHUSdCauJCemmexd2qtr1d3lZs6ZjrtpRoVxiWBmaxbOfvUOrkkqMF+X0xykzYaszX4LihbF276bMAbk3Rte7z4GzOje/Rlfh/O6qePdFKKycA86bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=yanlonglong@kylinos.cn; receiver=lists.ozlabs.org) smtp.mailfrom=kylinos.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kylinos.cn (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=yanlonglong@kylinos.cn; receiver=lists.ozlabs.org)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4dfR5LVzz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 12:35:58 +1000 (AEST)
X-UUID: e4b83c7e857511f1aa26b74ffac11d73-20260722
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f14f1e8c-c6f0-4d5e-a659-c56a11c2bc67,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:034ad1efaf0e8d13b9263c7cd7dd0407,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e4b83c7e857511f1aa26b74ffac11d73-20260722
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2083707242; Wed, 22 Jul 2026 10:34:42 +0800
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
Subject: [PATCH] selftests/powerpc: use MAP_FAILED instead of (void *)-1 in  tm-signal-context-force-tm
Date: Wed, 22 Jul 2026 10:34:28 +0800
Message-ID: <20260722023428.932-1-yanlonglong@kylinos.cn>
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

mmap() is documented to return MAP_FAILED on error, but
tm-signal-context-force-tm.c compares the return value against
(void *)-1. Replace these with the standard MAP_FAILED macro for
better readability and type safety.

Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
---
 .../testing/selftests/powerpc/tm/tm-signal-context-force-tm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-context-force-tm.c b/tools/testing/selftests/powerpc/tm/tm-signal-context-force-tm.c
index 0a4bc479ae39..5dc0f12f467d 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-context-force-tm.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-force-tm.c
@@ -60,7 +60,7 @@ void usr_signal_handler(int signo, siginfo_t *si, void *uc)
 	ucp->uc_link = mmap(NULL, sizeof(ucontext_t),
 			    PROT_READ | PROT_WRITE,
 			    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-	if (ucp->uc_link == (void *)-1) {
+	if (ucp->uc_link == MAP_FAILED) {
 		perror("Mmap failed");
 		exit(-1);
 	}
@@ -129,7 +129,7 @@ void tm_trap_test(void)
 		ss.ss_size = SIGSTKSZ;
 		ss.ss_flags = 0;
 
-		if (ss.ss_sp == (void *)-1) {
+		if (ss.ss_sp == MAP_FAILED) {
 			perror("mmap error\n");
 			exit(-1);
 		}
-- 
2.43.0


