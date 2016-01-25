Return-Path: <oohall@gmail.com>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A508F1A03F9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 17:56:14 +1100 (AEDT)
Received: by mail-pa0-x22a.google.com with SMTP id yy13so75951873pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jan 2016 22:56:14 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH] Fix fall-through from case 30 (rld*) to case 31
Date: Mon, 25 Jan 2016 17:55:52 +1100
Message-Id: <1453704952-11197-1-git-send-email-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I think this bug can only be triggered if the instruction to
simulate is malformed. The switch in the else case only handles
the zero and one case, but it extracts bits 4:1 from the
instruction word so it may be other values. It's pretty minor, but
a bug is a bug.

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
