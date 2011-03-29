Return-Path: <tglx@linutronix.de>
Received: from linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1801AB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Mar 2011 07:37:34 +1100 (EST)
Message-Id: <20110329203313.963157647@linutronix.de>
Date: Tue, 29 Mar 2011 20:37:28 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [patch 1/1] powerpc: cell: Use handle_edge_eoi_irq for real
Cc: mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Missed one instance when moving that to the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: michael@ellerman.id.au
Cc: mingo@elte.hu
---
 arch/powerpc/platforms/cell/interrupt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-tip/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/cell/interrupt.c
+++ linux-2.6-tip/arch/powerpc/platforms/cell/interrupt.c
@@ -244,7 +244,7 @@ static int iic_host_map(struct irq_host 
 		break;
 	case IIC_IRQ_TYPE_IOEXC:
 		irq_set_chip_and_handler(virq, &iic_ioexc_chip,
-					 handle_iic_irq);
+					 handle_edge_eoi_irq);
 		break;
 	default:
 		irq_set_chip_and_handler(virq, &iic_chip, handle_edge_eoi_irq);
