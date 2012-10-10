Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 695362C0087
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2012 07:56:57 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: 52xx: nop out unsupported critical IRQs
Date: Wed, 10 Oct 2012 22:56:33 +0200
Message-Id: <1349902593-16431-1-git-send-email-w.sang@pengutronix.de>
Cc: John Bonesio <bones@secretlab.ca>, Anatolij Gustschin <agust@denx.de>,
 Wolfram Sang <w.sang@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, when booting MPC52xx based platforms, we get:

        mpc52xx_irqhost_map: invalid irq: virq=16, l1=0, l2=3
        irq: irq-16==>hwirq-0x3 mapping failed: -22
        [WARNing skipped]

The warning is wrong since the mapping itself is valid. However, there is no
support for that type of IRQ currently. Print a proper warning and bind the irq
to a no_irq chip.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: John Bonesio <bones@secretlab.ca>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 8520b58..703ad42 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -372,6 +372,11 @@ static int mpc52xx_irqhost_map(struct irq_domain *h, unsigned int virq,
 	case MPC52xx_IRQ_L1_MAIN: irqchip = &mpc52xx_main_irqchip; break;
 	case MPC52xx_IRQ_L1_PERP: irqchip = &mpc52xx_periph_irqchip; break;
 	case MPC52xx_IRQ_L1_SDMA: irqchip = &mpc52xx_sdma_irqchip; break;
+	case MPC52xx_IRQ_L1_CRIT:
+		pr_warn("%s: Critical IRQ #%d is unsupported! Nopping it.\n",
+			__func__, l2irq);
+		irq_set_chip(virq, &no_irq_chip);
+		return 0;
 	default:
 		pr_err("%s: invalid irq: virq=%i, l1=%i, l2=%i\n",
 		       __func__, virq, l1irq, l2irq);
-- 
1.7.10.4
