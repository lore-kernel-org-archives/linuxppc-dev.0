Return-Path: <ra8135@perf2farm5.am.freescale.net>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1E84A2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jul 2013 07:18:58 +1000 (EST)
From: James Yang <James.Yang@freescale.com>
To: <benh@kernel.crashing.org>, <scottwood@freescale.com>
Subject: [PATCH v2] powerpc/math-emu: fix load/store indexed emulation
Date: Thu, 4 Jul 2013 16:18:44 -0500
Message-ID: <1372972724-28767-1-git-send-email-James.Yang@freescale.com>
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

Load/store indexed instructions where the index register RA=R0, such
as "lfdx f1,0,r3", are not illegal.

Load/store indexed with update instructions where the index register
RA=R0, such as "lfdux f1,0,r3", are invalid, and, to be consistent
with existing math-emu behavior for other invalid instruction forms,
will signal as illegal.

Signed-off-by: James Yang <James.Yang@freescale.com>
---
 arch/powerpc/math-emu/math.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/math-emu/math.c b/arch/powerpc/math-emu/math.c
index 164d559..eabce90 100644
--- a/arch/powerpc/math-emu/math.c
+++ b/arch/powerpc/math-emu/math.c
@@ -410,21 +410,16 @@ do_mathemu(struct pt_regs *regs)
 	case XE:
 		idx = (insn >> 16) & 0x1f;
 		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
-		if (!idx) {
-			if (((insn >> 1) & 0x3ff) == STFIWX)
-				op1 = (void *)(regs->gpr[(insn >> 11) & 0x1f]);
-			else
-				goto illegal;
-		} else {
-			op1 = (void *)(regs->gpr[idx] + regs->gpr[(insn >> 11) & 0x1f]);
-		}
-
+		op1 = (void *)((idx ? regs->gpr[idx] : 0)
+				+ regs->gpr[(insn >> 11) & 0x1f]);
 		break;
 
 	case XEU:
 		idx = (insn >> 16) & 0x1f;
+		if (!idx)
+			goto illegal;
 		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
-		op1 = (void *)((idx ? regs->gpr[idx] : 0)
+		op1 = (void *)(regs->gpr[idx]
 				+ regs->gpr[(insn >> 11) & 0x1f]);
 		break;
 
-- 
1.7.0.4
