Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4DBFBDDF30
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 07:54:48 +1000 (EST)
Date: Thu, 11 Oct 2007 16:54:07 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [RFC] Fixup stfiwx decode bug
Message-ID: <Pine.LNX.4.64.0710111652380.22192@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Can you look over this fix and see if you have any style issues with it.
Its legal for stfiwx to have RA = 0, however we treated it as illegal
since it was in class "XE".

- k

diff --git a/arch/powerpc/math-emu/math.c b/arch/powerpc/math-emu/math.c
index 69058b2..381306b 100644
--- a/arch/powerpc/math-emu/math.c
+++ b/arch/powerpc/math-emu/math.c
@@ -407,11 +407,16 @@ do_mathemu(struct pt_regs *regs)

 	case XE:
 		idx = (insn >> 16) & 0x1f;
-		if (!idx)
-			goto illegal;
-
 		op0 = (void *)&current->thread.fpr[(insn >> 21) & 0x1f];
-		op1 = (void *)(regs->gpr[idx] + regs->gpr[(insn >> 11) & 0x1f]);
+		if (!idx) {
+			if (((insn >> 1) & 0x3ff) == STFIWX)
+				op1 = (void *)(regs->gpr[(insn >> 11) & 0x1f]);
+			else
+				goto illegal;
+		} else {
+			op1 = (void *)(regs->gpr[idx] + regs->gpr[(insn >> 11) & 0x1f]);
+		}
+
 		break;

 	case XEU:
