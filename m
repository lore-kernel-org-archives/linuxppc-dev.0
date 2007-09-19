Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EBE6CDDE1E
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 00:54:29 +1000 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org,
 "S. Fricke" <silvio.fricke@gmail.com>
Date: Wed, 19 Sep 2007 16:54:19 +0200
References: <20070919115952.GF5682@sfrouter>
In-Reply-To: <20070919115952.GF5682@sfrouter>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_cgT8GossQ4mMkCp"
Message-Id: <200709191654.20368.jbe@pengutronix.de>
Subject: Re: Configuration-Problem ext-interrupt on mpc52xx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_cgT8GossQ4mMkCp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Silvio,

On Wednesday 19 September 2007 13:59, S. Fricke wrote:
> how can i configure an "ext interrupt" to high-level? I want a interrupti=
on
> on IRQ2, but I checked with an oscilloscope that the pin has a low state
> and I needs a high state.
>
> I have tried, after I got the irq (with irq_of_parse_and_map), set it with
>
>     set_irq_type(irq, IRQ_TYPE_LEVEL_HIGH);
>
> But I think it is a system-configuration (irq_desc) and no
> device-configuration.

Try with the attached patch.

Regards,
Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9

--Boundary-00=_cgT8GossQ4mMkCp
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="mpc52xx_extirq_set_type.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mpc52xx_extirq_set_type.diff"

---
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |   38 ++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

Index: arch/powerpc/platforms/52xx/mpc52xx_pic.c
===================================================================
--- arch/powerpc/platforms/52xx/mpc52xx_pic.c.orig
+++ arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -25,6 +25,7 @@
 #include <linux/stddef.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <linux/hardirq.h>
 
 #include <asm/io.h>
@@ -107,11 +108,48 @@ static void mpc52xx_extirq_ack(unsigned 
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

--Boundary-00=_cgT8GossQ4mMkCp--
