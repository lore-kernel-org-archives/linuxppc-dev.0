Return-Path: <R65777@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C36B02C00FB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 14:16:30 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <galak@kernel.crashing.org>, <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>,
 <stuart.yoder@freescale.com>, <james.yang@freescale.com>
Subject: [PATCH 2/2 v3] powerpc: restore dbcr0 on user space exit
Date: Wed, 22 May 2013 09:50:59 +0530
Message-ID: <1369196459-17275-3-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1369196459-17275-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1369196459-17275-1-git-send-email-Bharat.Bhushan@freescale.com>
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

lmbench latency test (lat_syscall) Results are (they varies a little
on each run)

1) ./lat_syscall <action> /dev/shm/uImage

action:	Open	read	write	stat	fstat	null
Before:	3.8618	0.2017	0.2851	1.6789	0.2256	0.0856
After:	3.8580	0.2017	0.2851	1.6955	0.2255	0.0856

1) ./lat_syscall -P 2 -N 10 <action> /dev/shm/uImage
action:	Open	read	write	stat	fstat	null
Before:	4.1388	0.2238	0.3066	1.7106	0.2256	0.0856
After:	4.1413	0.2236	0.3062	1.7107	0.2256	0.0856

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
v2->v3
 - Load PACACURRENT immediately after _MSR(r1), and load DBCR0
   just after "beq resume_kernel 
 - Added lat_sysycal results before and after the patch

v1->v2
 - Subject line was not having 1/2

 arch/powerpc/kernel/asm-offsets.c |    1 +
 arch/powerpc/kernel/entry_64.S    |   28 ++++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

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
index 794889b..5b91d27 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -622,21 +622,41 @@ _GLOBAL(ret_from_except_lite)
 
 	CURRENT_THREAD_INFO(r9, r1)
 	ld	r3,_MSR(r1)
+#ifdef CONFIG_PPC_BOOK3E
+	ld	r10,PACACURRENT(r13)
+#endif /* CONFIG_PPC_BOOK3E */
 	ld	r4,TI_FLAGS(r9)
 	andi.	r3,r3,MSR_PR
 	beq	resume_kernel
+#ifdef CONFIG_PPC_BOOK3E
+	lwz	r3,(THREAD+THREAD_DBCR0)(r10)
+#endif /* CONFIG_PPC_BOOK3E */
 
 	/* Check current_thread_info()->flags */
 	andi.	r0,r4,_TIF_USER_WORK_MASK
+	bne	1f
+#ifdef CONFIG_PPC_BOOK3E
+	/*
+	 * Check to see if the dbcr0 register is set up to debug.
+	 * Use the internal debug mode bit to do this.
+	 */
+	andis.	r0,r3,DBCR0_IDM@h
 	beq	restore
-
-	andi.	r0,r4,_TIF_NEED_RESCHED
-	beq	1f
+	mfmsr	r0
+	rlwinm	r0,r0,0,~MSR_DE	/* Clear MSR.DE */
+	mtmsr	r0
+	mtspr	SPRN_DBCR0,r3
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
1.7.0.4
