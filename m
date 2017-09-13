Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsTlN2QCfzDqkx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 14:51:28 +1000 (AEST)
Date: Wed, 13 Sep 2017 14:51:24 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH] powerpc: Fix handling of alignment interrupt on dcbz
 instruction
Message-ID: <20170913045124.GA5071@fergus.ozlabs.ibm.com>
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

This fixes the emulation of the dcbz instruction in the alignment
interrupt handler.  The error was that we were comparing just the
instruction type field of op.type rather than the whole thing,
and therefore the comparison "type != CACHEOP + DCBZ" was always
true.

Fixes: 31bfdb036f12 ("powerpc: Use instruction emulation infrastructure to handle alignment faults")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kernel/align.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 26b9994d27ee..43ef25156480 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -341,7 +341,7 @@ int fix_alignment(struct pt_regs *regs)
 
 	type = op.type & INSTR_TYPE_MASK;
 	if (!OP_IS_LOAD_STORE(type)) {
-		if (type != CACHEOP + DCBZ)
+		if (op.type != CACHEOP + DCBZ)
 			return -EINVAL;
 		PPC_WARN_ALIGNMENT(dcbz, regs);
 		r = emulate_dcbz(op.ea, regs);
-- 
2.11.0
