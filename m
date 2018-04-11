Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LXQF39YHzDqRk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 15:19:01 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc/xive: Fix trying to "push" an already active pool
 VP
Date: Wed, 11 Apr 2018 15:17:59 +1000
Message-Id: <20180411051801.30194-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When setting up a CPU, we "push" (activate) a pool VP for it.

However it's an error to do so if it already has an active
pool VP.

This happens when doing soft CPU hotplug on powernv since we
don't tear down the CPU on unplug. The HW flags the error which
gets captured by the diagnostics.

Fix this by making sure to "pull" out any already active pool
first.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/xive/native.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index d22aeb0b69e1..b48454be5b98 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -389,6 +389,10 @@ static void xive_native_setup_cpu(unsigned int cpu, struct xive_cpu *xc)
 	if (xive_pool_vps == XIVE_INVALID_VP)
 		return;
 
+	/* Check if pool VP already active, if it is, pull it */
+	if (in_be32(xive_tima + TM_QW2_HV_POOL + TM_WORD2) & TM_QW2W2_VP)
+		in_be64(xive_tima + TM_SPC_PULL_POOL_CTX);
+
 	/* Enable the pool VP */
 	vp = xive_pool_vps + cpu;
 	pr_debug("CPU %d setting up pool VP 0x%x\n", cpu, vp);
-- 
2.14.3
