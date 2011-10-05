Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
	[IPv6:2001:470:1f0b:1c35:abcd:42:0:1])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26A27B70C9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Oct 2011 23:31:01 +1100 (EST)
Message-Id: <20111005122747.276456506@linutronix.de>
Date: Wed, 05 Oct 2011 12:30:50 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [patch 2/4] powerpc: wsp: Mark opb cascade handler IRQF_NO_THREAD
References: <20111005122122.553832402@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cascade handlers must run in hard interrupt context.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/wsp/opb_pic.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/powerpc/platforms/wsp/opb_pic.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/wsp/opb_pic.c
+++ linux-2.6/arch/powerpc/platforms/wsp/opb_pic.c
@@ -320,7 +320,8 @@ void __init opb_pic_init(void)
 		}
 
 		/* Attach opb interrupt handler to new virtual IRQ */
-		rc = request_irq(virq, opb_irq_handler, 0, "OPB LS Cascade", opb);
+		rc = request_irq(virq, opb_irq_handler, IRQF_NO_THREAD,
+				 "OPB LS Cascade", opb);
 		if (rc) {
 			printk("opb: request_irq failed: %d\n", rc);
 			continue;
