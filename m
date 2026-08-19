Return-Path: <linuxppc-dev+bounces-25974-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17791C5DF6D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 10:40:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQ34w2YlCz2yDD;
	Wed, 19 Aug 2026 20:40:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787128642;
	cv=none; b=OxpIi7HBkKlfgR9nJbQYyGJtI6Q/2oI5bsmiJpQY8xO0l+hzIVJUkSOYlSWuQZd18q6n4T0Dw53JPAbW4JsaOQ2Fo43BcAWBm0a4NqHbQgFWVvlC3WYtto/2S6EN6be1DMUma62k8xbvQRMNEq+oXkCt1pBPUAQwVyTUcsVZUFmNBmgp1XJtQKFamoq2Xp1jUVhE6E0h/I100J2IF18+CaGiq6xUtXrUgeAJs+n0yQ1tyAISSaQigXLji3oeoI1RQAcn5HqNYyOXMjU87Gqmeu5mHm0oQJlmDhlNN0Q7zj7a8Bw3ibW+8FJU/5lGQyxJRKG1PwSZd6l14PECkjsQYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787128642; c=relaxed/relaxed;
	bh=AUHqa6ZTBBxbTQOiDq39qKhG9R62ieJKbYeUUydECis=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=J1WMepfe15Iug6176TPKcoO/q82b5f5zuPqaTqTUqEuAhHMvB6y+1bgDBLxfpxeOvtFid2f7NHE1NdZvA7FiCJza+3B8MIrtbeDdoHXDqPqhHVwh+LaKbm26Z1lS/enwLQ9k5O0WaPLKvocV3MlhvqB6R091hrfqVN5luRBM2MHHE2Zb3OTcfL81Zf4JHsfz+ah/nNqb57JPiEsEUFTT1x8U0vl1tBNKPATatJqXS9CK8fng3w5KGl3U4FpATYm7LbDvE2MYdeqb6qYPTgVve0qQId101CtAVHbxeeLAl2sHNe/TVPMxCfruWUNj6nBHYARHEI6c/RENnGPbGviF9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=lijun01@kylinos.cn; receiver=lists.ozlabs.org) smtp.mailfrom=kylinos.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kylinos.cn (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=lijun01@kylinos.cn; receiver=lists.ozlabs.org)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQ0LS5wBTz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 18:37:19 +1000 (AEST)
X-UUID: 02abab5a9ba911f19a56ed5b684f684d-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2b310b67-4c1c-4390-8191-3526b9ddf691,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:7db8b62,CLOUDID:391a9c45edd4eb7726063089e654d37a,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:2,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 02abab5a9ba911f19a56ed5b684f684d-20260819
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 885736861; Wed, 19 Aug 2026 16:36:02 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	linuxppc-dev@lists.ozlabs.org,
	linux-integrity@vger.kernel.org
Subject: [PATCH] char: tpm: Use SIMPLE_DEV_PM_OPS for ibmvtpm power management
Date: Wed, 19 Aug 2026 16:35:47 +0800
Message-Id: <20260819083547.2703228-1-lijun01@kylinos.cn>
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

Replace the manually defined dev_pm_ops structure with the
SIMPLE_DEV_PM_OPS macro to simplify the power management code.
This macro automatically handles CONFIG_PM_SLEEP configuration,
generating the same suspend/resume callbacks while reducing
boilerplate code.Add the value of 'thaw,freeze,poweroff,restore'.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 6fb4d30eb6f6..51c7e2add3d2 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -462,10 +462,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
 	.req_canceled = tpm_ibmvtpm_req_canceled,
 };
 
-static const struct dev_pm_ops tpm_ibmvtpm_pm_ops = {
-	.suspend = tpm_ibmvtpm_suspend,
-	.resume = tpm_ibmvtpm_resume,
-};
+static SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
 
 /**
  * ibmvtpm_crq_get_next - Get next responded crq
-- 
2.25.1


