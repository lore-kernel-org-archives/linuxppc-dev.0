Return-Path: <bgill@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id DEE5F68673
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Nov 2005 03:52:58 +1100 (EST)
Date: Wed, 2 Nov 2005 10:52:52 -0600 (CST)
From: Becky Bruce <bgill@freescale.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.61.0511021050250.26891@cde-tx32-ldt329.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [PATCH] ppc - fix build warnings in arch/ppc/kernel/traps.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ppc: Fix build warnings in traps.c

The latest updates to bug.h generate build warnings in traps.c in 
arch/ppc.  Fix print format specifiers to account for change of line type  
to long from int.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>

---
commit fdbe8ff0c9719da6bcbe6fedf10fb3d32c09ec92
tree 6330b8c00cd62dab8b58cd8808619cf3a1d44f69
parent 211317f02e1d2ac3ebd5bf139889160c834573da
author Becky Bruce <becky.bruce@freescale.com> Wed, 02 Nov 2005 10:47:59 -0600
committer Becky Bruce <becky.bruce@freescale.com> Wed, 02 Nov 2005 10:47:59 -0600

 arch/ppc/kernel/traps.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
index f265b81..16adde6 100644
--- a/arch/ppc/kernel/traps.c
+++ b/arch/ppc/kernel/traps.c
@@ -606,22 +606,22 @@ int check_bug_trap(struct pt_regs *regs)
 	if (bug->line & BUG_WARNING_TRAP) {
 		/* this is a WARN_ON rather than BUG/BUG_ON */
 #ifdef CONFIG_XMON
-		xmon_printf(KERN_ERR "Badness in %s at %s:%d\n",
+		xmon_printf(KERN_ERR "Badness in %s at %s:%ld\n",
 		       bug->function, bug->file,
 		       bug->line & ~BUG_WARNING_TRAP);
 #endif /* CONFIG_XMON */		
-		printk(KERN_ERR "Badness in %s at %s:%d\n",
+		printk(KERN_ERR "Badness in %s at %s:%ld\n",
 		       bug->function, bug->file,
 		       bug->line & ~BUG_WARNING_TRAP);
 		dump_stack();
 		return 1;
 	}
 #ifdef CONFIG_XMON
-	xmon_printf(KERN_CRIT "kernel BUG in %s at %s:%d!\n",
+	xmon_printf(KERN_CRIT "kernel BUG in %s at %s:%ld!\n",
 	       bug->function, bug->file, bug->line);
 	xmon(regs);
 #endif /* CONFIG_XMON */
-	printk(KERN_CRIT "kernel BUG in %s at %s:%d!\n",
+	printk(KERN_CRIT "kernel BUG in %s at %s:%ld!\n",
 	       bug->function, bug->file, bug->line);
 
 	return 0;
