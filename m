Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A93C22C0080
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Jan 2013 21:49:43 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [v0][PATCH 1/1] powerpc/book3e: disable interrupt after
 preempt_schedule_irq
Date: Sun, 6 Jan 2013 18:49:34 +0800
Message-ID: <1357469374-25719-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preempt case current arch_local_irq_restore() from
preempt_schedule_irq() may enable hard interrupt but we really
should disable interrupts when we return from the interrupt,
and so that we don't get interrupted after loading SRR0/1.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/entry_64.S |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index e9a906c..4e1de34 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -662,6 +662,19 @@ resume_kernel:
 	ld	r4,TI_FLAGS(r9)
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	bne	1b
+
+	/*
+	 * arch_local_irq_restore() from preempt_schedule_irq above may
+	 * enable hard interrupt but we really should disable interrupts
+	 * when we return from the interrupt, and so that we don't get
+	 * interrupted after loading SRR0/1.
+	 */
+#ifdef CONFIG_PPC_BOOK3E
+	wrteei	0
+#else
+	ld	r10,PACAKMSR(r13) /* Get kernel MSR without EE */
+	mtmsrd	r10,1		  /* Update machine state */
+#endif /* CONFIG_PPC_BOOK3E */
 #endif /* CONFIG_PREEMPT */
 
 	.globl	fast_exc_return_irq
-- 
1.7.9.5
