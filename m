Return-Path: <SRS0=aJM7=ML=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C05C43143
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 01:28:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD75206B8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 01:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="ZZSbboqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD75206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MWCF3rQwzF3MR
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 11:28:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="ZZSbboqS";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MW8n3zKJzF3Kq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 11:26:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="ZZSbboqS"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1010)
 id 42MW8n31KTz9sBJ; Sat, 29 Sep 2018 11:26:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538184377; bh=FhvoFDJzKxG9KqArYl5tJR+7AfMXVtuw1PTHwXHVEow=;
 h=From:To:Cc:Subject:Date:From;
 b=ZZSbboqS0cigY9BnoB3yoDuJQOLY5RHDgU6IZOcmnkpfc0QqnQxgE2NMo2q1vOp0I
 uLqFeq6Zv1S4BxJWRH5dzXMotq2KohALQcmGW9BXYmQCeS+bTS58j3/m3X6bipTAbq
 ZkLyzjTO4SNnUtbT25fXmtgWpBpwlGe3EzhsqbrN+JvcccNwGhMKoTY6c76Wy1l7Zl
 AGLW6JCGeK5EZEbeJVNxLinHWXHDuDjX/0K76atKUmqXhRAvFHfNUOTDQte/zM9tIX
 WRn4fBfZk7jMmhroVBw93qvhfFFZVqCPhvWKOT/ZiDoZrXGXEGrKIii027k0R0gGfF
 GIB7rVdqGqdsg==
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com, mikey@neuling.org, oohall@gmail.com
Subject: [PATCH 1/2] powerpc/time: Use clockevents_register_device(),
 fixing an issue with large decrementer
Date: Sat, 29 Sep 2018 11:26:06 +1000
Message-Id: <20180929012607.10204-1-anton@ozlabs.org>
X-Mailer: git-send-email 2.17.1
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

We currently cap the decrementer clockevent at 4 seconds, even on systems
with large decrementer support. Fix this by converting the code to use
clockevents_register_device() which calculates the upper bound based on
the max_delta passed in.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/time.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 70f145e02487..6a1f0a084ca3 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -984,10 +984,10 @@ static void register_decrementer_clockevent(int cpu)
 	*dec = decrementer_clockevent;
 	dec->cpumask = cpumask_of(cpu);
 
+	clockevents_config_and_register(dec, ppc_tb_freq, 2, decrementer_max);
+
 	printk_once(KERN_DEBUG "clockevent: %s mult[%x] shift[%d] cpu[%d]\n",
 		    dec->name, dec->mult, dec->shift, cpu);
-
-	clockevents_register_device(dec);
 }
 
 static void enable_large_decrementer(void)
@@ -1035,18 +1035,7 @@ static void __init set_decrementer_max(void)
 
 static void __init init_decrementer_clockevent(void)
 {
-	int cpu = smp_processor_id();
-
-	clockevents_calc_mult_shift(&decrementer_clockevent, ppc_tb_freq, 4);
-
-	decrementer_clockevent.max_delta_ns =
-		clockevent_delta2ns(decrementer_max, &decrementer_clockevent);
-	decrementer_clockevent.max_delta_ticks = decrementer_max;
-	decrementer_clockevent.min_delta_ns =
-		clockevent_delta2ns(2, &decrementer_clockevent);
-	decrementer_clockevent.min_delta_ticks = 2;
-
-	register_decrementer_clockevent(cpu);
+	register_decrementer_clockevent(smp_processor_id());
 }
 
 void secondary_cpu_time_init(void)
-- 
2.17.1

