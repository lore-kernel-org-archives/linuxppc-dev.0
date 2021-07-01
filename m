Return-Path: <SRS0=ZiU1=LZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44290C11F67
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 12:52:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827D8613FE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 12:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827D8613FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cdjrlc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GFymg017Tz3bTh
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 22:52:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=cdjrlc.com (client-ip=183.3.226.173; helo=qq.com;
 envelope-from=wangborong@cdjrlc.com; receiver=<UNKNOWN>)
X-Greylist: delayed 64 seconds by postgrey-1.36 at boromir;
 Thu, 01 Jul 2021 22:52:30 AEST
Received: from qq.com (smtpbg551.qq.com [183.3.226.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GFymG6s9Jz2ymN
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jul 2021 22:52:30 +1000 (AEST)
X-QQ-mid: bizesmtp34t1625143869t3i3nq03
Received: from localhost.localdomain (unknown [182.148.13.55])
 by esmtp6.qq.com (ESMTP) with 
 id ; Thu, 01 Jul 2021 20:51:07 +0800 (CST)
X-QQ-SSF: 0100000000800030B000B00A0000000
X-QQ-FEAT: t5mnTZTTCFeiPWU/OhvvZsxrc8tP+EEDaPod+tKJ092DO7dk3bByzAqv1Qzzm
 hHR43sKAqPWSZkcjOsXUTJt7z2CH2KesOtIVPZvzchEl8F/0/O5x/ZzvCHORyq4svZjIcq0
 hfenTeYswyxotkoNrpGCuN8egV38/l1SCPnZtno5K5khVUwNsTFH7xAXZTjLr/GRQx8mQt9
 31uamDbKgFWfMgUrEa9gSXVfoff+T3K8FgHIqx2TsV95O/y4CSPUmhcbgJg4HF2+zF34WPc
 Oebven09p4zeA/2MQFwiFrut5SheqGuP2+Rvd+m9Xx6IGdYxm5rDQC+CwsbE8X5n7SqKuxN
 2IUE0aMnt03eDj5i5nOf0Ao4OSZ1A==
X-QQ-GoodBg: 0
From: Jason Wang <wangborong@cdjrlc.com>
To: jk@ozlabs.org
Subject: [PATCH] sched: Use WARN_ON
Date: Thu,  1 Jul 2021 20:50:46 +0800
Message-Id: <20210701125046.43018-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
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
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
 Jason Wang <wangborong@cdjrlc.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The BUG_ON macro simplifies the if condition followed by BUG, but it
will lead to the kernel crashing. Therefore, we can try using WARN_ON
instead of if condition followed by BUG.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/powerpc/platforms/cell/spufs/sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index 369206489895..0f218d9e5733 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -904,8 +904,8 @@ static noinline void spusched_tick(struct spu_context *ctx)
 	struct spu_context *new = NULL;
 	struct spu *spu = NULL;
 
-	if (spu_acquire(ctx))
-		BUG();	/* a kernel thread never has signals pending */
+	/* a kernel thread never has signals pending */
+	WARN_ON(spu_acquire(ctx));
 
 	if (ctx->state != SPU_STATE_RUNNABLE)
 		goto out;
-- 
2.32.0



