Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mg6h40dKzF1KG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 15:37:16 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>,
 Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>,
 Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, mikey@neuling.org
Subject: [PATCH 1/2] powerpc/ptrace: Fix enforcement of DAWR contraints
Date: Thu, 17 May 2018 15:37:14 +1000
Message-Id: <20180517053715.24011-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Back when we first introduced the DAWR in this commit:
  4ae7ebe952 powerpc: Change hardware breakpoint to allow longer ranges

We screwed up the constraint making it a 1024 byte boundary rather
than a 512. This makes the check overly permissive. Fortunately GDB is
the only real user and it always did they right thing, so we never
noticed.

This fixes the constraint to 512 bytes.

Signed-off-by: Michael Neuling <mikey@neuling.org>
cc: <stable@vger.kernel.org> # v3.9+
---
 arch/powerpc/kernel/hw_breakpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 4c1012b80d..80547dad37 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -178,8 +178,8 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	if (cpu_has_feature(CPU_FTR_DAWR)) {
 		length_max = 512 ; /* 64 doublewords */
 		/* DAWR region can't cross 512 boundary */
-		if ((bp->attr.bp_addr >> 10) != 
-		    ((bp->attr.bp_addr + bp->attr.bp_len - 1) >> 10))
+		if ((bp->attr.bp_addr >> 9) !=
+		    ((bp->attr.bp_addr + bp->attr.bp_len - 1) >> 9))
 			return -EINVAL;
 	}
 	if (info->len >
-- 
2.14.1
