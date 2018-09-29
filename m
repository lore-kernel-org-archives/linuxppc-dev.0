Return-Path: <SRS0=aJM7=ML=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7A0C43143
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 01:30:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8177D20652
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 01:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="r00Cb0z+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8177D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MWFk3TfNzF3Qw
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 11:30:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="r00Cb0z+";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MW8q2vG4zF3Kq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 11:26:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="r00Cb0z+"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1010)
 id 42MW8p6z8Xz9sBq; Sat, 29 Sep 2018 11:26:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538184378; bh=DG4pWJAYPTjPYnbwLyMKrfAgCjARbjRantbxhe0tWNs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=r00Cb0z+rMhSsYOt29jV5FyWQJTh03dii08/pZL7gqUBjGqOCa5SWexwAo2mVBBgy
 wT9mTEl+HT8EQYezqO7vuvl08G9kSEc72X2sKagAC/vrUYMaYXvidjR/rRnGcYI3Ia
 82ZTSCDO9cPSVZTG2qfMlRwAI5oHNHePEYfQn8IGQCZsAd36NBqLjW0/YEUcFsbYfG
 U3xCkbBSBG8nlpGZ4eV1ZberChKLz1t14Fj6M8ma23WOkT2RNQHAXl67mPPpzwR8s7
 JC1QmWN9OmafZcgGuPfxU5/iVudlKraETN+779JZlNcnfGaxQTRl/2E4Rj4zGteEsG
 I1g58qzd/pLyA==
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com, mikey@neuling.org, oohall@gmail.com
Subject: [PATCH 2/2] powerpc/time: Only cap decrementer when watchdog is
 enabled
Date: Sat, 29 Sep 2018 11:26:07 +1000
Message-Id: <20180929012607.10204-2-anton@ozlabs.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929012607.10204-1-anton@ozlabs.org>
References: <20180929012607.10204-1-anton@ozlabs.org>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

If CONFIG_PPC_WATCHDOG is enabled, we always cap the decrementer to
0x7fffffff. As suggested by Nick, add a run time check of the watchdog
cpumask, so if it is disabled we use the large decrementer.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/time.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 6a1f0a084ca3..3372019f52bd 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -60,6 +60,7 @@
 #include <linux/rtc.h>
 #include <linux/sched/cputime.h>
 #include <linux/processor.h>
+#include <linux/nmi.h>
 #include <asm/trace.h>
 
 #include <asm/io.h>
@@ -575,7 +576,8 @@ void timer_interrupt(struct pt_regs *regs)
 	 * 31 bits, which is about 4 seconds on most systems, which gives
 	 * the watchdog a chance of catching timer interrupt hard lockups.
 	 */
-	if (IS_ENABLED(CONFIG_PPC_WATCHDOG))
+	if (IS_ENABLED(CONFIG_PPC_WATCHDOG) &&
+	    cpumask_test_cpu(smp_processor_id(), &watchdog_cpumask))
 		set_dec(0x7fffffff);
 	else
 		set_dec(decrementer_max);
-- 
2.17.1

