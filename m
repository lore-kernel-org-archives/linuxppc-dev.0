Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 0B258B70A9
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Nov 2010 11:24:56 +1100 (EST)
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net
	[192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id DF760186DEF4
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Nov 2010 01:24:53 +0100 (CET)
Received: from igel.home (ppp-88-217-99-182.dynamic.mnet-online.de
	[88.217.99.182])
	by mail.mnet-online.de (Postfix) with ESMTP id 4FDE71C001AC
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Nov 2010 01:24:53 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix PPC_PTRACE_SETHWDEBUG on PPC_BOOK3S
Date: Sun, 28 Nov 2010 01:24:53 +0100
Message-ID: <m2y68expka.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Properly set the DABR_TRANSLATION/DABR_DATA_READ/DABR_DATA_READ bits in
the dabr when setting the debug register via PPC_PTRACE_SETHWDEBUG.  Also
don't reject trigger type of PPC_BREAKPOINT_TRIGGER_READ.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/kernel/ptrace.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index a9b3296..9065369 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1316,6 +1316,10 @@ static int set_dac_range(struct task_struct *child,
 static long ppc_set_hwdebug(struct task_struct *child,
 		     struct ppc_hw_breakpoint *bp_info)
 {
+#ifndef CONFIG_PPC_ADV_DEBUG_REGS
+	unsigned long dabr;
+#endif
+
 	if (bp_info->version != 1)
 		return -ENOTSUPP;
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
@@ -1353,11 +1357,10 @@ static long ppc_set_hwdebug(struct task_struct *child,
 	/*
 	 * We only support one data breakpoint
 	 */
-	if (((bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_RW) == 0) ||
-	    ((bp_info->trigger_type & ~PPC_BREAKPOINT_TRIGGER_RW) != 0) ||
-	    (bp_info->trigger_type != PPC_BREAKPOINT_TRIGGER_WRITE) ||
-	    (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT) ||
-	    (bp_info->condition_mode != PPC_BREAKPOINT_CONDITION_NONE))
+	if ((bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_RW) == 0 ||
+	    (bp_info->trigger_type & ~PPC_BREAKPOINT_TRIGGER_RW) != 0 ||
+	    bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT ||
+	    bp_info->condition_mode != PPC_BREAKPOINT_CONDITION_NONE)
 		return -EINVAL;
 
 	if (child->thread.dabr)
@@ -1366,7 +1369,14 @@ static long ppc_set_hwdebug(struct task_struct *child,
 	if ((unsigned long)bp_info->addr >= TASK_SIZE)
 		return -EIO;
 
-	child->thread.dabr = (unsigned long)bp_info->addr;
+	dabr = (unsigned long)bp_info->addr & ~7UL;
+	dabr |= DABR_TRANSLATION;
+	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
+		dabr |= DABR_DATA_READ;
+	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
+		dabr |= DABR_DATA_WRITE;
+
+	child->thread.dabr = dabr;
 
 	return 1;
 #endif /* !CONFIG_PPC_ADV_DEBUG_DVCS */
-- 
1.7.3.2


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
