Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMLzt4nndzDqkp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 18:16:58 +1100 (AEDT)
Date: Wed, 25 Oct 2017 18:16:53 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>,
 Nick Piggin <npiggin@au1.ibm.com>
Subject: [PATCH] powerpc: Fix check for copy/paste instructions in alignment
 handler
Message-ID: <20171025071653.GB25140@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 07d2a628bc00 ("powerpc/64s: Avoid cpabort in context switch
when possible", 2017-06-09) changed the definition of PPC_INST_COPY
and in so doing inadvertently broke the check for copy/paste
instructions in the alignment fault handler.  The check currently
matches no instructions.

This fixes it by ANDing both sides of the comparison with the mask.

Fixes: 07d2a628bc00 ("powerpc/64s: Avoid cpabort in context switch
when possible")
Reported-by: Markus Trippelsdorf <markus@trippelsdorf.de>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
Should go to 4.13 stable as well, and will probably apply there
with fuzz.

 arch/powerpc/kernel/align.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 43ef251..3e6c074 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -332,7 +332,7 @@ int fix_alignment(struct pt_regs *regs)
 	 * when pasting to a co-processor. Furthermore, paste_last is the
 	 * synchronisation point for preceding copy/paste sequences.
 	 */
-	if ((instr & 0xfc0006fe) == PPC_INST_COPY)
+	if ((instr & 0xfc0006fe) == (PPC_INST_COPY & 0xfc0006fe))
 		return -EIO;
 
 	r = analyse_instr(&op, regs, instr);
-- 
2.7.4
