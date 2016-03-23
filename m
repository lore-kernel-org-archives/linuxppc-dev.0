Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVJXH0TqvzDqD5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 16:48:47 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qVJXG4l3Yz9sRB
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Mar 2016 16:48:46 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 23 Mar 2016 15:48:45 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 104192CE8046
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Mar 2016 16:48:40 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2N5mWH16095168
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Mar 2016 16:48:40 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2N5m7j3006542
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Mar 2016 16:48:07 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org
Subject: [PATCH 3/5] powerpc: Fix TAR leak across exec() syscalls
Date: Wed, 23 Mar 2016 16:47:03 +1100
Message-Id: <1458712025-3525-3-git-send-email-cyrilbur@gmail.com>
In-Reply-To: <1458712025-3525-1-git-send-email-cyrilbur@gmail.com>
References: <1458712025-3525-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently start_thread() doesn't sanitise TAR.

The TAR SPR register is a register that can be set and branched to, not
sanitising it presents an information leak to the new executable.

Other SPR registers such as the Performance registers used by perf (and are
managed entirely by perf) as well as the Event Based Branch (EBB) registers are
left alone by design as these fall into the same category as leaving file
descriptors open across exec(), it is up the parent thread to sanitise what it
deems necessary.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/kernel/process.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index d7a9df5..56444a6 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1577,6 +1577,8 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	current->thread.vr_state.vscr.u[3] = 0x00010000; /* Java mode disabled */
 	current->thread.vr_save_area = NULL;
 	current->thread.vrsave = 0;
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+		mtspr(SPRN_VRSAVE, 0);
 	current->thread.used_vr = 0;
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_SPE
@@ -1592,6 +1594,18 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	current->thread.tm_texasr = 0;
 	current->thread.tm_tfiar = 0;
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+#ifdef CONFIG_PPC_BOOK3S_64
+	/*
+	 * Zero out the SPRs.
+	 * Don't touch the ones use by perf, it controls them.
+	 * Don't touch the EBB regs. This falls into the same category of
+	 *   responsibly as open file descriptors across exec(), the parent should
+	 *   sanitise if it feels it would be a problem
+	 */
+	current->thread.tar = 0;
+	if (cpu_has_feature(CPU_FTR_ARCH_206))
+		mtspr(SPRN_TAR, 0);
+#endif /* CONFIG_PPC_BOOK3S_64 */
 }
 EXPORT_SYMBOL(start_thread);
 
-- 
2.7.4
