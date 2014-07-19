Return-Path: <paulus@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A13DF1A02D3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jul 2014 17:48:03 +1000 (EST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 52DC1140139
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2014 17:48:03 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix bugs in emulate_step()
Date: Sat, 19 Jul 2014 17:47:57 +1000
Message-Id: <1405756077-19935-1-git-send-email-paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes some bugs in emulate_step().  First, the setting of the carry
bit for the arithmetic right-shift instructions was not correct on 64-bit
machines because we were masking with a mask of type int rather than
unsigned long.  Secondly, the sld (shift left doubleword) instruction was
using the wrong instruction field for the register containing the shift
count.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/lib/sstep.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 412dd46..5c09f36 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1198,7 +1198,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 			sh = regs->gpr[rb] & 0x3f;
 			ival = (signed int) regs->gpr[rd];
 			regs->gpr[ra] = ival >> (sh < 32 ? sh : 31);
-			if (ival < 0 && (sh >= 32 || (ival & ((1 << sh) - 1)) != 0))
+			if (ival < 0 && (sh >= 32 || (ival & ((1ul << sh) - 1)) != 0))
 				regs->xer |= XER_CA;
 			else
 				regs->xer &= ~XER_CA;
@@ -1208,7 +1208,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 			sh = rb;
 			ival = (signed int) regs->gpr[rd];
 			regs->gpr[ra] = ival >> sh;
-			if (ival < 0 && (ival & ((1 << sh) - 1)) != 0)
+			if (ival < 0 && (ival & ((1ul << sh) - 1)) != 0)
 				regs->xer |= XER_CA;
 			else
 				regs->xer &= ~XER_CA;
@@ -1216,7 +1216,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 
 #ifdef __powerpc64__
 		case 27:	/* sld */
-			sh = regs->gpr[rd] & 0x7f;
+			sh = regs->gpr[rb] & 0x7f;
 			if (sh < 64)
 				regs->gpr[ra] = regs->gpr[rd] << sh;
 			else
@@ -1235,7 +1235,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 			sh = regs->gpr[rb] & 0x7f;
 			ival = (signed long int) regs->gpr[rd];
 			regs->gpr[ra] = ival >> (sh < 64 ? sh : 63);
-			if (ival < 0 && (sh >= 64 || (ival & ((1 << sh) - 1)) != 0))
+			if (ival < 0 && (sh >= 64 || (ival & ((1ul << sh) - 1)) != 0))
 				regs->xer |= XER_CA;
 			else
 				regs->xer &= ~XER_CA;
@@ -1246,7 +1246,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 			sh = rb | ((instr & 2) << 4);
 			ival = (signed long int) regs->gpr[rd];
 			regs->gpr[ra] = ival >> sh;
-			if (ival < 0 && (ival & ((1 << sh) - 1)) != 0)
+			if (ival < 0 && (ival & ((1ul << sh) - 1)) != 0)
 				regs->xer |= XER_CA;
 			else
 				regs->xer &= ~XER_CA;
-- 
2.0.1
