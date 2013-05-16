Return-Path: <R65777@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 36CFC2C00E8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 15:30:26 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <galak@kernel.crashing.org>, <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>,
 <stuart.yoder@freescale.com>, <James.Yang@freescale.com>
Subject: [PATCH 2/2 v2] powerpc: restore dbcr0 on user space exit
Date: Thu, 16 May 2013 11:04:32 +0530
Message-ID: <1368682472-4268-3-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1368682472-4268-2-git-send-email-Bharat.Bhushan@freescale.com>
References: <1368682472-4268-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1368682472-4268-2-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On BookE (Branch taken + Single Step) is as same as Branch Taken
on BookS and in Linux we simulate BookS behavior for BookE as well.
When doing so, in Branch taken handling we want to set DBCR0_IC but
we update the current->thread->dbcr0 and not DBCR0.

Now on 64bit the current->thread.dbcr0 (and other debug registers)
is synchronized ONLY on context switch flow. But after handling
Branch taken in debug exception if we return back to user space
without context switch then single stepping change (DBCR0_ICMP)
does not get written in h/w DBCR0 and Instruction Complete exception
does not happen.

This fixes using ptrace reliably on BookE-PowerPC

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
v1->v2
 - Subject line was not having 2/2

 arch/powerpc/kernel/asm-offsets.c |    1 +
 arch/powerpc/kernel/entry_64.S    |   24 ++++++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index b51a97c..1e2f450 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -103,6 +103,7 @@ int main(void)
 #endif /* CONFIG_VSX */
 #ifdef CONFIG_PPC64
 	DEFINE(KSP_VSID, offsetof(struct thread_struct, ksp_vsid));
+	DEFINE(THREAD_DBCR0, offsetof(struct thread_struct, dbcr0));
 #else /* CONFIG_PPC64 */
 	DEFINE(PGDIR, offsetof(struct thread_struct, pgdir));
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 794889b..561630d 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -614,7 +614,9 @@ _GLOBAL(ret_from_except_lite)
 	 * from the interrupt.
 	 */
 #ifdef CONFIG_PPC_BOOK3E
+	ld	r3,PACACURRENT(r13)
 	wrteei	0
+	lwz	r10,(THREAD+THREAD_DBCR0)(r3)
 #else
 	ld	r10,PACAKMSR(r13) /* Get kernel MSR without EE */
 	mtmsrd	r10,1		  /* Update machine state */
@@ -628,15 +630,29 @@ _GLOBAL(ret_from_except_lite)
 
 	/* Check current_thread_info()->flags */
 	andi.	r0,r4,_TIF_USER_WORK_MASK
+	bne	1f
+#ifdef CONFIG_PPC_BOOK3E
+	/*
+	 * Check to see if the dbcr0 register is set up to debug.
+	 * Use the internal debug mode bit to do this.
+	 */
+	andis.	r0,r10,DBCR0_IDM@h
 	beq	restore
-
-	andi.	r0,r4,_TIF_NEED_RESCHED
-	beq	1f
+	mfmsr	r0
+	rlwinm	r0,r0,0,~MSR_DE	/* Clear MSR.DE */
+	mtmsr	r0
+	mtspr	SPRN_DBCR0,r10
+	li	r10, -1
+	mtspr	SPRN_DBSR,r10
+	b	restore
+#endif
+1:	andi.	r0,r4,_TIF_NEED_RESCHED
+	beq	2f
 	bl	.restore_interrupts
 	SCHEDULE_USER
 	b	.ret_from_except_lite
 
-1:	bl	.save_nvgprs
+2:	bl	.save_nvgprs
 	bl	.restore_interrupts
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_notify_resume
-- 
1.5.6.5
