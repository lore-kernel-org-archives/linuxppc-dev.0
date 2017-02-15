Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNZJl3HBLzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 20:49:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: benh@kernel.crashing.org,
	dja@axtens.net
Subject: [PATCH] powerpc: Document irq enable/disable toggle in migrate_irqs()
Date: Wed, 15 Feb 2017 20:49:54 +1100
Message-Id: <1487152194-19382-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This code is undocumented and unclear, and we've already had one patch
sent to remove it because it's "paradoxical and unnecessary". So
document it to save our future selves from puzzling over it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index a018f5cae899..c1b5fe753e1f 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -476,6 +476,14 @@ void migrate_irqs(void)
 
 	free_cpumask_var(mask);
 
+	/*
+	 * Depending on the details of the interrupt controller, it's possible
+	 * that one of the interrupts we just migrated away from this CPU is
+	 * actually already pending on this CPU. If we leave it in that state
+	 * the interrupt will never be EOI'ed, and will never fire again. So
+	 * temporarily enable interrupts here, to allow any pending interrupt to
+	 * be received (and EOI'ed), before we take this CPU offline.
+	 */
 	local_irq_enable();
 	mdelay(1);
 	local_irq_disable();
-- 
2.7.4
