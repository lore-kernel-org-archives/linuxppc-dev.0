Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7Lnh2r7szDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 13:26:16 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id y129so5265310pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 20:26:16 -0700 (PDT)
From: Matt Brown <matthew.brown.dev@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: anton@samba.org
Subject: [PATCH 5/5] powerpc/lib/sstep: Add isel instruction emulation
Date: Thu, 13 Jul 2017 13:25:48 +1000
Message-Id: <20170713032548.451-5-matthew.brown.dev@gmail.com>
In-Reply-To: <20170713032548.451-1-matthew.brown.dev@gmail.com>
References: <20170713032548.451-1-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This add emulation for the isel instruction.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
 arch/powerpc/lib/sstep.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 3228783..bb0e301 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1297,6 +1297,16 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 			regs->gpr[ra] = ~(regs->gpr[rd] & regs->gpr[rb]);
 			goto logical_done;
 
+		case 585:	/* isel */
+			mb = (instr >> 6) & 0x1f; /* bc */
+			val = (regs->ccr >> (mb + 32)) & 1;
+
+			if (val)
+				regs->gpr[rd] = regs->gpr[ra];
+			else
+				regs->gpr[rd] = regs->gpr[rb];
+			goto logical_done;
+
 		case 922:	/* extsh */
 			regs->gpr[ra] = (signed short) regs->gpr[rd];
 			goto logical_done;
-- 
2.9.3
