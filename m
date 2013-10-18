Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4B95A2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 18:38:28 +1100 (EST)
From: Wolfgang Denk <wd@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] [RFC] Emulate "lwsync" to run standard user land on e500 cores
Date: Fri, 18 Oct 2013 09:38:00 +0200
Message-Id: <1382081880-6666-1-git-send-email-wd@denx.de>
Cc: Scott Wood <scottwood@freescale.com>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Default Debian PowerPC doesn't work on e500 because the code contains
"lwsync" instructions, which are unsupported on this core.  As a
result, applications using this will crash with an "unhandled signal 4"
"Illegal instruction" error.

As a work around we add code to emulate this insn.  This is expensive
performance-wise, but allows to run standard user land code.

Signed-off-by: Wolfgang Denk <wd@denx.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>
---
I am aware that the clean solution to the problem is to build user
space with compiler options that match the target architecture.
However, sometimes this is just too much effort.

Also, of course the performance of such an emulation sucks. But the
the occurrence of such instructions is so rare that no significant
slowdown can be oserved.

I'm not sure if this should / could go into mainline.  I'm posting it
primarily so it can be found should anybody else need this.
- wd

 arch/powerpc/kernel/traps.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index f783c93..f330374 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -986,6 +986,13 @@ static int emulate_instruction(struct pt_regs *regs)
 		return 0;
 	}
 
+	/* Emulating the lwsync insn as a sync insn */
+	if (instword == PPC_INST_LWSYNC) {
+		PPC_WARN_EMULATED(lwsync, regs);
+		asm volatile("sync" : : : "memory");
+		return 0;
+	}
+
 	/* Emulate the mcrxr insn.  */
 	if ((instword & PPC_INST_MCRXR_MASK) == PPC_INST_MCRXR) {
 		int shift = (instword >> 21) & 0x1c;
-- 
1.8.3.1
