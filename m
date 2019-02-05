Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACBEC282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 11:50:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE9B2080D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 11:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE9B2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v2vC3bS4zDqLy
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 22:50:15 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v2Vy06JdzDqHn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 22:32:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43v2Vx5jjDz9sMx; Tue,  5 Feb 2019 22:32:41 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43v2Vx4NK2z9sNL; Tue,  5 Feb 2019 22:32:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v16 07/21] powerpc: call_do_[soft]irq() takes a pointer to the
 stack
Date: Tue,  5 Feb 2019 22:32:05 +1100
Message-Id: <20190205113219.17903-8-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205113219.17903-1-mpe@ellerman.id.au>
References: <20190205113219.17903-1-mpe@ellerman.id.au>
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Christophe Leroy <christophe.leroy@c-s.fr>

The purpose of the pointer given to call_do_softirq() and
call_do_irq() is to point the new stack. Currently that's the same
thing as the thread_info, but won't be with THREAD_INFO_IN_TASK.

So change the parameter to void* and rename it 'sp'.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
[mpe: Split out of larger patch]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/irq.h | 4 ++--
 arch/powerpc/kernel/misc_32.S  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index ee39ce56b2a2..2efbae8d93be 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -63,8 +63,8 @@ extern struct thread_info *hardirq_ctx[NR_CPUS];
 extern struct thread_info *softirq_ctx[NR_CPUS];
 
 extern void irq_ctx_init(void);
-extern void call_do_softirq(struct thread_info *tp);
-extern void call_do_irq(struct pt_regs *regs, struct thread_info *tp);
+void call_do_softirq(void *sp);
+void call_do_irq(struct pt_regs *regs, void *sp);
 extern void do_IRQ(struct pt_regs *regs);
 extern void __init init_IRQ(void);
 extern void __do_irq(struct pt_regs *regs);
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 02b8cdd73792..242f0c88010e 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -60,7 +60,7 @@ _GLOBAL(call_do_softirq)
 	blr
 
 /*
- * void call_do_irq(struct pt_regs *regs, struct thread_info *irqtp);
+ * void call_do_irq(struct pt_regs *regs, void *sp);
  */
 _GLOBAL(call_do_irq)
 	mflr	r0
-- 
2.20.1

