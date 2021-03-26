Return-Path: <SRS0=j/g1=IY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B127C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 09:47:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A533461A0F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 09:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A533461A0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6HF40HBNz3c23
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 20:47:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=PQmvp/oj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=163.com
 (client-ip=220.181.12.18; helo=m12-18.163.com; envelope-from=zuoqilin1@163.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=PQmvp/oj; dkim-atps=neutral
X-Greylist: delayed 946 seconds by postgrey-1.36 at boromir;
 Fri, 26 Mar 2021 19:12:39 AEDT
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6F8769LGz2yxB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Mar 2021 19:12:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=d3l6H
 qGdyJXY93wZ73zXzrAiqfPlJxIIN1klaPDJxw8=; b=PQmvp/ojhEwMfGvFMP27Y
 v79+PgqiivEL5jBs9TYlnLEx70KDHRGyc5eqnIHwh3p5+Xsh+Zsto4/4Slbtiv3B
 GMC1KXoGgaUEzcIeOV09PWLnA25iqAWSc4NMu2L8JUwcPSdB0mBUo6KGg6XXVHmZ
 bWdOv0LU6PbhdmkqjzjDLQ=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
 by smtp14 (Coremail) with SMTP id EsCowACnpfOZk11gDMb7ag--.3852S2;
 Fri, 26 Mar 2021 15:56:12 +0800 (CST)
From: zuoqilin1@163.com
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org,
	paulus@samba.org
Subject: [PATCH] arch/powerpc: Remove unneeded variable: "ret"
Date: Fri, 26 Mar 2021 15:56:19 +0800
Message-Id: <20210326075619.48-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowACnpfOZk11gDMb7ag--.3852S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur43XF48Aw47Ar1xAFyrJFb_yoWftFXEyw
 n7Gw48Canaqrs3AFnrAr13CFnaqr4kGrs8KFnF9a47X3s8Ja98WwsrGrW7JF48Xw1FyrW3
 WFn8KrnIka4SkjkaLaAFLSUrUUUUnb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUYtKsUUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/xtbBRRxhiVPAKukWbAAAsb
X-Mailman-Approved-At: Fri, 26 Mar 2021 20:46:40 +1100
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
Cc: zuoqilin <zuoqilin@yulong.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: zuoqilin <zuoqilin@yulong.com>

Remove unneeded variable: "ret".

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 arch/powerpc/platforms/pseries/cmm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 45a3a30..95ebb0c 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -475,8 +475,6 @@ static int cmm_reboot_notifier(struct notifier_block *nb,
 static int cmm_memory_cb(struct notifier_block *self,
 			unsigned long action, void *arg)
 {
-	int ret = 0;
-
 	switch (action) {
 	case MEM_GOING_OFFLINE:
 		mutex_lock(&hotplug_mutex);
@@ -493,7 +491,7 @@ static int cmm_memory_cb(struct notifier_block *self,
 		break;
 	}
 
-	return notifier_from_errno(ret);
+	return notifier_from_errno(0);
 }
 
 static struct notifier_block cmm_mem_nb = {
-- 
1.9.1


