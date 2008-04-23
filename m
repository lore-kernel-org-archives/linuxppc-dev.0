Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A7DE2DE2A2
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 06:37:49 +1000 (EST)
Date: Wed, 23 Apr 2008 15:33:49 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [POWERPC] Cleanup asm-offset.c
Message-ID: <Pine.LNX.4.64.0804231529380.5418@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Removed TI_EXECDOMAIN define as its not used anywhere
* Use STACK_INT_FRAME_SIZE to allow common define of INT_FRAME_SIZE
* Define TI_CPU on both ppc32 & ppc64 (removes an ifdef).

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/asm-offsets.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 292c6d8..adf1d09 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -93,10 +93,7 @@ int main(void)
 	DEFINE(TI_LOCAL_FLAGS, offsetof(struct thread_info, local_flags));
 	DEFINE(TI_PREEMPT, offsetof(struct thread_info, preempt_count));
 	DEFINE(TI_TASK, offsetof(struct thread_info, task));
-#ifdef CONFIG_PPC32
-	DEFINE(TI_EXECDOMAIN, offsetof(struct thread_info, exec_domain));
 	DEFINE(TI_CPU, offsetof(struct thread_info, cpu));
-#endif /* CONFIG_PPC32 */

 #ifdef CONFIG_PPC64
 	DEFINE(DCACHEL1LINESIZE, offsetof(struct ppc64_caches, dline_size));
@@ -165,13 +162,9 @@ int main(void)

 	/* Interrupt register frame */
 	DEFINE(STACK_FRAME_OVERHEAD, STACK_FRAME_OVERHEAD);
-#ifndef CONFIG_PPC64
-	DEFINE(INT_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs));
-#else /* CONFIG_PPC64 */
+	DEFINE(INT_FRAME_SIZE, STACK_INT_FRAME_SIZE);
+#ifdef CONFIG_PPC64
 	DEFINE(SWITCH_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs));
-	/* 288 = # of volatile regs, int & fp, for leaf routines */
-	/* which do not stack a frame.  See the PPC64 ABI.       */
-	DEFINE(INT_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) + 288);
 	/* Create extra stack space for SRR0 and SRR1 when calling prom/rtas. */
 	DEFINE(PROM_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) + 16);
 	DEFINE(RTAS_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) + 16);
-- 
1.5.4.1
