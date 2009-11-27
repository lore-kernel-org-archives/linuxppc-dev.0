Return-Path: <stefani@seibold.net>
Received: from www84.your-server.de (www84.your-server.de [213.133.104.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 61BA31007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 20:28:33 +1100 (EST)
Subject: [PATCH] fix PPC floating point debug
From: Stefani Seibold <stefani@seibold.net>
To: linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="ISO-8859-15"
Date: Fri, 27 Nov 2009 09:59:00 +0100
Message-ID: <1259312340.9648.6.camel@wall-e>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PPC architecture is unable to debug applications using hardware
floating point, because it would not save the floating point registers.

After returning from the debugger, the contents of register was
modified. This patch fix this bug.

Signed-off-by: Stefani Seibold <stefani@seibold.net>
---
 traps.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.32-rc5/arch/powerpc/kernel/traps.c.orig	2009-11-27 09:47:37.989943124 +0100
+++ linux-2.6.32-rc5/arch/powerpc/kernel/traps.c	2009-11-27 09:47:41.088330825 +0100
@@ -559,6 +559,8 @@ void instruction_breakpoint_exception(st
 		return;
 	if (debugger_iabr_match(regs))
 		return;
+	if (regs->msr & MSR_FP)
+		giveup_fpu(current);
 	_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
 }
 
@@ -577,6 +579,8 @@ void __kprobes single_step_exception(str
 	if (debugger_sstep(regs))
 		return;
 
+	if (regs->msr & MSR_FP)
+		giveup_fpu(current);
 	_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
 }
 
@@ -834,6 +838,8 @@ void __kprobes program_check_exception(s
 			regs->nip += 4;
 			return;
 		}
+		if (regs->msr & MSR_FP)
+			giveup_fpu(current);
 		_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
 		return;
 	}
