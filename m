Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 635A8DDE16
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 14:38:19 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id lAK3cDxv013104
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 21:38:14 -0600
Date: Mon, 19 Nov 2007 21:36:57 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Emulate isel (Integer Select) instruction
Message-ID: <Pine.LNX.4.64.0711192135460.24923@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

isel (Integer Select) is a new user space instruction in the
PowerISA 2.04 spec.  Not all processors implement it so lets emulate
to ensure code built with isel will run everywhere.

---
 arch/powerpc/kernel/traps.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

In my git tree for 2.6.25.

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 59c464e..cad6484 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -622,6 +622,9 @@ static void parse_fpe(struct pt_regs *regs)
 #define INST_POPCNTB		0x7c0000f4
 #define INST_POPCNTB_MASK	0xfc0007fe

+#define INST_ISEL		0x7c00001e
+#define INST_ISEL_MASK		0xfc00003e
+
 static int emulate_string_inst(struct pt_regs *regs, u32 instword)
 {
 	u8 rT = (instword >> 21) & 0x1f;
@@ -707,6 +710,23 @@ static int emulate_popcntb_inst(struct pt_regs *regs, u32 instword)
 	return 0;
 }

+static int emulate_isel(struct pt_regs *regs, u32 instword)
+{
+	u8 rT = (instword >> 21) & 0x1f;
+	u8 rA = (instword >> 16) & 0x1f;
+	u8 rB = (instword >> 11) & 0x1f;
+	u8 BC = (instword >> 6) & 0x1f;
+	u8 bit;
+	unsigned long tmp;
+
+	tmp = (rA == 0) ? 0 : regs->gpr[rA];
+	bit = (regs->ccr >> (31 - BC)) & 0x1;
+
+	regs->gpr[rT] = bit ? tmp : regs->gpr[rB];
+
+	return 0;
+}
+
 static int emulate_instruction(struct pt_regs *regs)
 {
 	u32 instword;
@@ -749,6 +769,11 @@ static int emulate_instruction(struct pt_regs *regs)
 		return emulate_popcntb_inst(regs, instword);
 	}

+	/* Emulate isel (Integer Select) instruction */
+	if ((instword & INST_ISEL_MASK) == INST_ISEL) {
+		return emulate_isel(regs, instword);
+	}
+
 	return -EINVAL;
 }

-- 
1.5.3.4
