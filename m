Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B08731A000B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 17:32:57 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id w128so7826484pfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 22:32:57 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: andrew.donnellan@au1.ibm.com,
	Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH v2] powerpc/sstep.c - Fix emulation fall-through
Date: Tue, 16 Feb 2016 17:31:53 +1100
Message-Id: <1455604313-13818-1-git-send-email-oohall@gmail.com>
In-Reply-To: <56C27479.8080808@au1.ibm.com>
References: <56C27479.8080808@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a switch fallthough in instr_analyze() which can cause
an invalid instruction to be emulated as a different, valid,
instruction. The rld* (opcode 30) case extracts a sub-opcode from
bits 3:1 of the instruction word. However, the only valid values
of this field a 001 and 000. These cases are correctly handled,
but the others are not which causes execution to fall through
into case 31.

Breaking out of the switch causes the instruction to be marked as
unknown and allows the caller to deal with the invalid instruction
in a manner consistent with other invalid instructions.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/lib/sstep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index dc885b3..e25f73c 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -925,6 +925,7 @@ int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			}
 		}
 #endif
+	break; /* illegal instruction */
 
 	case 31:
 		switch ((instr >> 1) & 0x3ff) {
-- 
2.5.0
