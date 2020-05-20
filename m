Return-Path: <SRS0=ax18=7C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A3CC433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 11:37:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6DE20671
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 11:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="IdAz4bRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6DE20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49RrLz56drzDqmd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 21:36:59 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49RqwL4cnqzDqjY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2020 21:17:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=IdAz4bRc; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 49RqwK4NjHz9sTC; Wed, 20 May 2020 21:17:21 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49RqwK23kHz9sT6; Wed, 20 May 2020 21:17:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1589973441;
 bh=17pqlchEpm0gO1uJgAmcNjbr8Oyq/kguM5YIOGlsEFs=;
 h=From:To:Subject:Date:From;
 b=IdAz4bRcHtqdrjax85ST2HB9JXO5+G696txHiSKH5K+RgS0VlkwOj8ZNQfZaXl+JC
 aYANg39ad2h0CdfqbW0yERe0A+yJDDC0Tr4Ao5zzdHWTqyRsor/wceVNxTCJIHpKKg
 PCzPlBdeK+Vtfu4KpilMCWvfwXKNygDqDRUY3BzAQI3d019As7KRRaKLyWDfY4PGTU
 mldMUa2/iQ1TwvfCk/mglBsp9Tiyuo54kLivkIUoRAGwoZg7/oeSK1EqsMmZu6SOlZ
 b19Oe4TRQi1CffG69yhPBQMU5xhiqvroABwa7wLWKK9Ydd7A+gkp/h8dAvl1ZQuDiq
 lJpRKMyYlY+6g==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/xmon: Show task->thread.regs in process display
Date: Wed, 20 May 2020 21:17:40 +1000
Message-Id: <20200520111740.953679-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Show the address of the tasks regs in the process listing in xmon. The
regs should always be on the stack page that we also print the address
of, but it's still helpful not to have to find them by hand.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index de585204d1d2..fb135f2cd6b0 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3185,8 +3185,8 @@ static void show_task(struct task_struct *tsk)
 		(tsk->exit_state & EXIT_DEAD) ? 'E' :
 		(tsk->state & TASK_INTERRUPTIBLE) ? 'S' : '?';
 
-	printf("%px %016lx %6d %6d %c %2d %s\n", tsk,
-		tsk->thread.ksp,
+	printf("%16px %16lx %16px %6d %6d %c %2d %s\n", tsk,
+	        tsk->thread.ksp, tsk->thread.regs,
 		tsk->pid, rcu_dereference(tsk->parent)->pid,
 		state, task_cpu(tsk),
 		tsk->comm);
@@ -3309,7 +3309,7 @@ static void show_tasks(void)
 	unsigned long tskv;
 	struct task_struct *tsk = NULL;
 
-	printf("     task_struct     ->thread.ksp    PID   PPID S  P CMD\n");
+	printf("     task_struct     ->thread.ksp    ->thread.regs    PID   PPID S  P CMD\n");
 
 	if (scanhex(&tskv))
 		tsk = (struct task_struct *)tskv;
-- 
2.25.1

