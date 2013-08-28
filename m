Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id 434522C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 00:19:25 +1000 (EST)
Date: Wed, 28 Aug 2013 16:19:17 +0200
Message-Id: <201308281419.r7SEJHS0012038@localhost.localdomain>
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc/mpc8xx: Clearer Oops message for Software Emulation
 Exception
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch modifies the Oops message in case of Software Emulation Exception.
The existing message is quite confusing because it refers to FPU Emulation
while most often the issue is due to either a non supported instruction
(not necessarily FPU related) or a stale instruction due to HW issues.
The new message tries to be more generic in order to make the user understand
that the Oops is due to something wrong with an instruction, not necessarily
due to an FPU instruction.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

diff -ur linux-3.11-rc6/arch/powerpc/kernel/traps.c linux/arch/powerpc/kernel/traps.c
--- linux-3.11-rc6/arch/powerpc/kernel/traps.c	2013-08-25 15:20:33.000000000 +0200
+++ linux/arch/powerpc/kernel/traps.c	2013-08-25 15:31:29.000000000 +0200
@@ -1476,7 +1476,8 @@
 
 	if (!user_mode(regs)) {
 		debugger(regs);
-		die("Kernel Mode Software FPU Emulation", regs, SIGFPE);
+		die("Kernel Mode Unimplemented Instruction or SW FPU Emulation",
+			regs, SIGFPE);
 	}
 
 #ifdef CONFIG_MATH_EMULATION
