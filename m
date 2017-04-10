Return-Path: <srs0=5cae=3s=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1gKZ0vzSzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 16:30:26 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w1gKZ0DX2z8w25
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 16:30:26 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w1gKY2Zhjz9s7p
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 16:30:25 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 1/3] powerpc/xive: Don't call cpu_online() on an invalid
 CPU number
Date: Mon, 10 Apr 2017 16:29:59 +1000
Message-Id: <20170410063001.7235-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the interrupt didn't have a selected target yet, we could
call cpu_online() and do other cpumask tests with cpu #-1 which
would result in random outcomes.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/xive/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 9201819..dbd0f45 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -656,7 +656,8 @@ static int xive_irq_set_affinity(struct irq_data *d,
 	/* If existing target is already in the new mask, and is
 	 * online then do nothing.
 	 */
-	if (cpu_online(xd->target) &&
+	if (xd->target != XIVE_INVALID_TARGET &&
+	    cpu_online(xd->target) &&
 	    cpumask_test_cpu(xd->target, cpumask))
 		return IRQ_SET_MASK_OK;
 
-- 
2.9.3
