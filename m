Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6DC16DE108
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 05:44:19 +1100 (EST)
Message-Id: <20090310184154.535895939@linutronix.de>
Date: Tue, 10 Mar 2009 18:43:58 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Subject: [patch 1/1] powerpc: remove setup_irq(NULL action) in ksi8560
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

setup_irq(0, NULL) is broken as setup_irq() dereferences action
unconditionally.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
CC: Kumar Gala <galak@kernel.crashing.org>
CC: Linux PPC Development <linuxppc-dev@ozlabs.org>
---
 arch/powerpc/platforms/85xx/ksi8560.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-2.6-tip/arch/powerpc/platforms/85xx/ksi8560.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/85xx/ksi8560.c
+++ linux-2.6-tip/arch/powerpc/platforms/85xx/ksi8560.c
@@ -106,8 +106,6 @@ static void __init ksi8560_pic_init(void
 	cpm2_pic_init(np);
 	of_node_put(np);
 	set_irq_chained_handler(irq, cpm2_cascade);
-
-	setup_irq(0, NULL);
 #endif
 }
 
