Return-Path: <wei.zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7542BDDDF5
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 14:14:13 +1100 (EST)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org, galak@kernel.crashing.org
Subject: [PATCH] Add irq host and hwirq pair fields to output when showing
	interrupts.
Date: Tue, 13 Mar 2007 11:19:28 +0800
Message-Id: <1173755968459-git-send-email-wei.zhang@freescale.com>
Sender: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, r54964@freescale.com
Reply-To: Zhang Wei <wei.zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
---
 arch/powerpc/kernel/irq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 919fbf5..2a30ffd 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -194,7 +194,7 @@ #else
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #endif /* CONFIG_SMP */
 		if (desc->chip)
-			seq_printf(p, " %s ", desc->chip->typename);
+			seq_printf(p, " (%3d) @%s ", (irq_map[i].host->revmap_type == IRQ_HOST_MAP_LEGACY) ? i : virq_to_hw(i), desc->chip->typename);
 		else
 			seq_puts(p, "  None      ");
 		seq_printf(p, "%s", (desc->status & IRQ_LEVEL) ? "Level " : "Edge  ");
-- 
1.4.0
