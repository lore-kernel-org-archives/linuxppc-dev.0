Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjzfn1XqwzDqYs
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 09:51:29 +1000 (AEST)
Date: Fri, 1 Sep 2017 09:51:23 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 19/17] powerpc: Wrap register number correctly for string
 load/store instructions
Message-ID: <20170831235123.GA5644@fergus.ozlabs.ibm.com>
References: <1504066360-30128-1-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504066360-30128-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman reported that emulate_loadstore() was trying to
access element 32 of regs->gpr[], which doesn't exist, when
emulating a string store instruction.  This is because the string
load and store instructions (lswi, lswx, stswi and stswx) are
defined to wrap around from register 31 to register 0 if the number
of bytes being loaded or stored is sufficiently large.  This wrapping
was not implemented in the emulation code.  To fix it, we mask the
register number after incrementing it.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Fixes: c9f6f4ed95d4 ("powerpc: Implement emulation of string loads and stores")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/lib/sstep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 2f6897c..c406611 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -2865,7 +2865,8 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 				v32 = byterev_4(v32);
 			regs->gpr[rd] = v32;
 			ea += 4;
-			++rd;
+			/* reg number wraps from 31 to 0 for lsw[ix] */
+			rd = (rd + 1) & 0x1f;
 		}
 		break;
 
@@ -2934,7 +2935,8 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 			if (err)
 				break;
 			ea += 4;
-			++rd;
+			/* reg number wraps from 31 to 0 for stsw[ix] */
+			rd = (rd + 1) & 0x1f;
 		}
 		break;
 
-- 
2.7.4
