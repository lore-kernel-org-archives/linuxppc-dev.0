Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C0A59DDE20
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 13:34:18 +1000 (EST)
Date: Tue, 4 Sep 2007 21:41:09 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] powerpc: Remove unused platform_machine_check()
Message-ID: <20070905024109.GA27139@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove leftover cruft from ARCH=ppc.
    
There are no users of platform_machine_check() in ARCH=powerpc, and none
should be added (they should use ppc_md.machine_check_handler instead).
    
Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index d8502e3..ccfc99d 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -324,15 +324,6 @@ static inline int check_io_access(struct pt_regs *regs)
 #define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
 #endif
 
-/*
- * This is "fall-back" implementation for configurations
- * which don't provide platform-specific machine check info
- */
-void __attribute__ ((weak))
-platform_machine_check(struct pt_regs *regs)
-{
-}
-
 void machine_check_exception(struct pt_regs *regs)
 {
 	int recover = 0;
@@ -480,12 +471,6 @@ void machine_check_exception(struct pt_regs *regs)
 	}
 #endif /* CONFIG_4xx */
 
-	/*
-	 * Optional platform-provided routine to print out
-	 * additional info, e.g. bus error registers.
-	 */
-	platform_machine_check(regs);
-
 	if (debugger_fault_handler(regs))
 		return;
 	die("Machine check", regs, SIGBUS);
