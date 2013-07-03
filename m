Return-Path: <ra8135@perf2farm5.am.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A0C6D2C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 07:28:28 +1000 (EST)
From: <James.Yang@freescale.com>
To: <benh@kernel.crashing.org>, <scottwood@freescale.com>
Subject: [PATCH] Emulate sync instruction variants
Date: Wed, 3 Jul 2013 16:26:47 -0500
Message-ID: <1372886807-12109-1-git-send-email-James.Yang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: James Yang <James.Yang@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: James Yang <James.Yang@freescale.com>

Reserved fields of the sync instruction have been used for other
instructions (e.g. lwsync).  On processors that do not support variants
of the sync instruction, emulate it by executing a sync to subsume the
effect of the intended instruction.

Signed-off-by: James Yang <James.Yang@freescale.com>
---
 arch/powerpc/include/asm/ppc-opcode.h |    2 ++
 arch/powerpc/kernel/traps.c           |    7 +++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index eccfc16..0142eb2 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -96,6 +96,8 @@
 #define PPC_INST_LSWX			0x7c00042a
 #define PPC_INST_LWARX			0x7c000028
 #define PPC_INST_LWSYNC			0x7c2004ac
+#define PPC_INST_SYNC			0x7c0004ac
+#define PPC_INST_SYNC_MASK		0xfc0007fe
 #define PPC_INST_LXVD2X			0x7c000698
 #define PPC_INST_MCRXR			0x7c000400
 #define PPC_INST_MCRXR_MASK		0xfc0007fe
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index a98adc7..c3ceaa2 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1018,6 +1018,13 @@ static int emulate_instruction(struct pt_regs *regs)
 		return emulate_isel(regs, instword);
 	}
 
+	/* Emulate sync instruction variants */
+	if ((instword & PPC_INST_SYNC_MASK) == PPC_INST_SYNC) {
+		PPC_WARN_EMULATED(sync, regs);
+		asm volatile ("sync");
+		return 0;
+	}
+
 #ifdef CONFIG_PPC64
 	/* Emulate the mfspr rD, DSCR. */
 	if ((((instword & PPC_INST_MFSPR_DSCR_USER_MASK) ==
-- 
1.7.0.4
