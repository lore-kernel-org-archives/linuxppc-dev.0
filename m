Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE714DE911
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 01:30:01 +1000 (EST)
Received: from octopus.labnet.pengutronix.de ([10.1.1.3])
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <rsc@pengutronix.de>) id 1Jln6Y-0003H1-AX
	for linuxppc-dev@ozlabs.org; Tue, 15 Apr 2008 17:29:55 +0200
Received: from rsc by octopus.labnet.pengutronix.de with local (Exim 4.69)
	(envelope-from <rsc@pengutronix.de>) id 1Jln6Y-00036K-98
	for linuxppc-dev@ozlabs.org; Tue, 15 Apr 2008 17:29:54 +0200
Date: Tue, 15 Apr 2008 17:29:54 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: mpc5200: add interrupt type function
Message-ID: <20080415152954.GX13814@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sascha Hauer <s.hauer@pengutronix.de>

Add a set_type function for external (GPIO) interrupts.

Signed-off-by: Juergen Beisert <j.beisert@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

---
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |   38 ++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

Index: arch/powerpc/platforms/52xx/mpc52xx_pic.c
===================================================================
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c.orig	2008-04-15 11:25:29.000000000 +0200
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c	2008-04-15 11:25:39.000000000 +0200
@@ -18,6 +18,7 @@
 
 #undef DEBUG
 
+#include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/of.h>
 #include <asm/io.h>
@@ -109,11 +110,48 @@
 	io_be_setbit(&intr->ctrl, 27-l2irq);
 }
 
+static int mpc52xx_extirq_set_type(unsigned int virq, unsigned int flow_type)
+{
+	u32 ctrl_reg, type;
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d flow_type=%d\n", __func__, irq, l2irq, flow_type);
+
+	switch (flow_type) {
+	case IRQF_TRIGGER_HIGH:
+		type = 0;
+		break;
+	case IRQF_TRIGGER_RISING:
+		type = 1;
+		break;
+	case IRQF_TRIGGER_FALLING:
+		type = 2;
+		break;
+	case IRQF_TRIGGER_LOW:
+		type = 3;
+		break;
+	default:
+		type = 0;
+	}
+
+	ctrl_reg = in_be32(&intr->ctrl);
+	ctrl_reg &= ~(0x3 << (22 - (l2irq * 2)));
+	ctrl_reg |= (type << (22 - (l2irq * 2)));
+	out_be32(&intr->ctrl, ctrl_reg);
+
+	return 0;
+}
+
 static struct irq_chip mpc52xx_extirq_irqchip = {
 	.typename = " MPC52xx IRQ[0-3] ",
 	.mask = mpc52xx_extirq_mask,
 	.unmask = mpc52xx_extirq_unmask,
 	.ack = mpc52xx_extirq_ack,
+	.set_type = mpc52xx_extirq_set_type,
 };
 
 /*
