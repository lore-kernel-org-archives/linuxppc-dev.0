Return-Path: <kari.davidsson@marel.is>
Received: from mail.marel.com (mail.marel.is [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id 9F5B9DDE03
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Mar 2008 22:54:22 +1100 (EST)
Subject: Re: External interrupt type?
From: =?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?= <kari.davidsson@marel.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <1205521536.28630.4.camel@marel2693>
References: <1205521536.28630.4.camel@marel2693>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 15 Mar 2008 11:54:58 +0000
Message-Id: <1205582098.28630.8.camel@marel2693>
Mime-Version: 1.0
Reply-To: kari.davidsson@marel.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

A quick fix with very limited testing is included....
Someone might want to try this out or at least read it over :)
But as they say.. it works for me...

Index: arch/powerpc/platforms/52xx/mpc52xx_pic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/powerpc/platforms/52xx/mpc52xx_pic.c   (revision 172)
+++ arch/powerpc/platforms/52xx/mpc52xx_pic.c   (working copy)
@@ -97,11 +97,28 @@
        io_be_setbit(&intr->ctrl, 27-l2irq);
 }
=20
+static int mpc52xx_extirq_set_type(unsigned int virq, unsigned int
type)
+{
+       int irq;
+       u32 ctrl_reg;
+
+       irq =3D irq_map[virq].hwirq;
+
+       ctrl_reg =3D in_be32(&intr->ctrl);
+       ctrl_reg &=3D ~(0x3 << (22 - irq * 2)); /* Clear the old type */
+       ctrl_reg |=3D (type & 0x3) << (22 -irq * 2);
+
+       out_be32(&intr->ctrl, ctrl_reg);
+
+       return 0;
+}
+
 static struct irq_chip mpc52xx_extirq_irqchip =3D {
        .typename =3D " MPC52xx IRQ[0-3] ",
        .mask =3D mpc52xx_extirq_mask,
        .unmask =3D mpc52xx_extirq_unmask,
        .ack =3D mpc52xx_extirq_ack,
+       .set_type =3D mpc52xx_extirq_set_type,
 };
=20
 /*


rg
kd

On Fri, 2008-03-14 at 19:05 +0000, K=C3=A1ri Dav=C3=AD=C3=B0sson wrote:
> Hello,
>=20
> I am dealing with external interrupts on an custom board of the
> mpc5200b. Kernel is 2.6.24 from kernel.org.
>=20
> I can declare the interrupt in the dts for the board and the
> control register is set correctly, i.e. the correct external interrupt
> is enabled.
>=20
> On the other hand the type is ignored and is always level interrupt
> active low.
>=20
> Is this intended behaviour?
> How can I pass in the interrupt type from the dts to the kernel?
>=20
> I need to have the interrupt as edge interrupt, rising edge type?
>=20
> rg
> kd
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
