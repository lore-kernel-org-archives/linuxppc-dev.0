Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2117C1A08E9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 06:50:31 +1000 (AEST)
Message-Id: <20150713135740.173984169@linutronix.de>
Date: Mon, 13 Jul 2015 20:50:21 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiang Liu <jiang.liu@linux.intel.com>, Julia Lawall <julia.lawall@lip6.fr>
Subject: [patch 14/20] powerpc/mpc52xx: Use irq_set_handler_locked()
References: <20150713135648.540293392@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use irq_set_handler_locked() as it avoids a redundant lookup of the
irq descriptor.

Search and replacement was done with coccinelle.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: tip/arch/powerpc/platforms/52xx/mpc52xx_pic.c
===================================================================
--- tip.orig/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ tip/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -196,7 +196,7 @@ static int mpc52xx_extirq_set_type(struc
 	ctrl_reg |= (type << (22 - (l2irq * 2)));
 	out_be32(&intr->ctrl, ctrl_reg);
 
-	__irq_set_handler_locked(d->irq, handler);
+	irq_set_handler_locked(d, handler);
 
 	return 0;
 }
