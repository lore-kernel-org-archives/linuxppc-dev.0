Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55933C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 21:17:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0D62147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 21:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0D62147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Jnqx0VN8zDq5v
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 08:17:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=valentin.schneider@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44JCtq4pFtzDqCY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 09:48:19 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A576319BF;
 Mon, 11 Mar 2019 15:48:17 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com
 [10.1.194.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6FC223F59C;
 Mon, 11 Mar 2019 15:48:16 -0700 (PDT)
From: Valentin Schneider <valentin.schneider@arm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] powerpc: entry: Remove unneeded need_resched() loop
Date: Mon, 11 Mar 2019 22:47:46 +0000
Message-Id: <20190311224752.8337-9-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311224752.8337-1-valentin.schneider@arm.com>
References: <20190311224752.8337-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 Mar 2019 08:12:34 +1100
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Since the enabling and disabling of IRQs within preempt_schedule_irq()
is contained in a need_resched() loop, we don't need the outer arch
code loop.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/entry_32.S | 6 +-----
 arch/powerpc/kernel/entry_64.S | 8 +-------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 0768dfd8a64e..ff3fe3824a4a 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -896,11 +896,7 @@ resume_kernel:
 	 */
 	bl	trace_hardirqs_off
 #endif
-1:	bl	preempt_schedule_irq
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r3,TI_FLAGS(r9)
-	andi.	r0,r3,_TIF_NEED_RESCHED
-	bne-	1b
+	bl	preempt_schedule_irq
 #ifdef CONFIG_TRACE_IRQFLAGS
 	/* And now, to properly rebalance the above, we tell lockdep they
 	 * are being turned back on, which will happen when we return
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 435927f549c4..9c86c6826856 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -857,13 +857,7 @@ resume_kernel:
 	 * sure we are soft-disabled first and reconcile irq state.
 	 */
 	RECONCILE_IRQ_STATE(r3,r4)
-1:	bl	preempt_schedule_irq
-
-	/* Re-test flags and eventually loop */
-	CURRENT_THREAD_INFO(r9, r1)
-	ld	r4,TI_FLAGS(r9)
-	andi.	r0,r4,_TIF_NEED_RESCHED
-	bne	1b
+	bl	preempt_schedule_irq
 
 	/*
 	 * arch_local_irq_restore() from preempt_schedule_irq above may
-- 
2.20.1

