Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 09FBBDDF84
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jun 2007 21:47:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1178892748.9018.13.camel@saruman.qstreams.net>
Subject: Re: 83xx: requesting external interrupts
Date: Fri, 29 Jun 2007 13:34:52 +0200
Message-ID: <1183116892.20673.66.camel@gentoo-jocke.transmode.se>
References: <46434C1E.3020004@cambridgebroadband.com>
	<1178816847.9018.2.camel@saruman.qstreams.net>
	<46443784.3060600@cambridgebroadband.com>
	<1178892748.9018.13.camel@saruman.qstreams.net>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: <bwarren@qstreams.com>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-11 at 10:12 -0400, Ben Warren wrote:
> Alex,
>=20
> On Fri, 2007-05-11 at 10:29 +0100, Alex Zeffertt wrote:
> > Hi,
> >=20
> > Thanks for your reply Ben, but I think my problem is slightly =
different.  It is not
> > that the sense (high/low/rising/falling) of the interrupt is wrong, =
but that the
> > kernel will not allow me to register the handler.
> >=20
> > I've changed my code to:
> >=20
> >      struct device_node *np =3D of_find_node_by_type(NULL, "ipic");
> >      struct irq_host *host =3D irq_find_host(np);
> >      int rc;
> >=20
> >      unsigned int virq =3D irq_find_mapping(host, 5);
> >      set_irq_type(virq, IRQ_TYPE_EDGE_FALLING);
> >      rc =3D request_irq(virq, mpc832xemds_phy_interrupt, =
IRQF_SHARED, "pm5384", dev);
> >=20
> > but the last line still returns a non-zero error code.
> >=20
> > Is there a new way of requesting to install a handler for external =
interrupts?  I
> > can't find any powerpc examples in the kernel tree....
> >=20
> Sorry, I missed a bit of the implementation.  You need to register the
> IRQs before attempting to attach an ISR. Here's some sample code that
> works for me.  You'll probably need different IRQs, based on what your
> board does:
>=20
> /* All external IRQs + Generic timer IRQs must be initialized by BSP =
*/
> const int bsp_irqs[] =3D {48, 17, 18, 19, 20, 21, 22, 23, 90, 78, 84, =
72};
>=20
> Add this to your BSP IRQ init code (void __init xxx_init_IRQs())
>=20
>=20
> 	for (i=3D0;i<sizeof(bsp_irqs)/sizeof(bsp_irqs[0]);i++)
> 		virq =3D irq_create_mapping(NULL, bsp_irqs[i]);
>=20
> That should do it.
>=20
> regards,
> Ben

Hi Ben

I too am adding such a IRQ for my PHY connected to external IRQ2.
The PHY is connetced to UCC2.
I have this in my DTS for the PHY:
	mdio@2320 {
			#address-cells =3D <1>;
			#size-cells =3D <0>;
			reg =3D <2320 18>;
			device_type =3D "mdio";
			compatible =3D "ucc_geth_phy";

			phy1: ethernet-phy@0 {
				interrupt-parent =3D <&ipic>;
				interrupts =3D <12 2>; //EXT IRQ2
				reg =3D <0>; // 0
				device_type =3D "ethernet-phy";
				interface =3D <3>; //ENET_100_MII
			};

Now the things is that the IRQ works with and without the
 /* All external IRQs + Generic timer IRQs must be initialized by BSP */
 const int bsp_irqs[] =3D {48, 17, 18, 19, 20, 21, 22, 23, 90, 78, 84, =
72};
 for (i=3D0;i<sizeof(bsp_irqs)/sizeof(bsp_irqs[0]);i++)
	virq =3D irq_create_mapping(NULL, bsp_irqs[i]);
code in my bsp. There is one difference though.
Printing the irq num in phy_interrupt:
static irqreturn_t phy_interrupt(int irq, void *dev_id)
{
	struct net_device *dev =3D (struct net_device *)dev_id;
	struct ucc_geth_private *ugeth =3D netdev_priv(dev);

	ugeth_vdbg("%s: IN", __FUNCTION__);
	printk(KERN_ERR "PHY IRQ:%d \n", irq);

Shows a difference:
with the bsp code added it prints:
PHY IRQ:18
and when I remove the bsp code it prints:
PHY IRQ:19

So what is correct, should I add the bsp code or not?

 Jocke
