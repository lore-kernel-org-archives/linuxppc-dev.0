Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHmxN4qVzzF0cw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 13:32:40 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/5] powerpc/xive: Remove incorrect debug code
Date: Fri, 12 Jan 2018 13:28:45 +1100
Message-Id: <20180112022849.30899-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

WORD2 if the TIMA isn't byte accessible and
isn't that useful to know about, take out the
pr_devel statement.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/xive/common.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index a3b8d7d1316e..838ebdbfe4c5 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1269,11 +1269,6 @@ static void xive_setup_cpu(void)
 {
 	struct xive_cpu *xc = __this_cpu_read(xive_cpu);
 
-	/* Debug: Dump the TM state */
-	pr_devel("CPU %d [HW 0x%02x] VT=%02x\n",
-	    smp_processor_id(), hard_smp_processor_id(),
-	    in_8(xive_tima + xive_tima_offset + TM_WORD2));
-
 	/* The backend might have additional things to do */
 	if (xive_ops->setup_cpu)
 		xive_ops->setup_cpu(smp_processor_id(), xc);
-- 
2.14.3
