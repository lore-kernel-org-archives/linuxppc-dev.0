Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
	[IPv6:2001:470:1f0b:1c35:abcd:42:0:1])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 648D3B6F8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Oct 2011 23:31:00 +1100 (EST)
Message-Id: <20111005122747.203589467@linutronix.de>
Date: Wed, 05 Oct 2011 12:30:49 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [patch 1/4] powerpc: 85xx: Mark cascade irq IRQF_NO_THREAD
References: <20111005122122.553832402@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cascade interrupt must run in hard interrupt context.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_cds.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -178,7 +178,7 @@ static irqreturn_t mpc85xx_8259_cascade_
 
 static struct irqaction mpc85xxcds_8259_irqaction = {
 	.handler = mpc85xx_8259_cascade_action,
-	.flags = IRQF_SHARED,
+	.flags = IRQF_SHARED | IRQF_NO_THREAD,
 	.name = "8259 cascade",
 };
 #endif /* PPC_I8259 */
