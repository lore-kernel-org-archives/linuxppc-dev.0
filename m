Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id 5ABF6B7CCD
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Feb 2010 09:40:45 +1100 (EST)
Received: by gxk28 with SMTP id 28so1506436gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2010 14:40:44 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <38677d6a-3f33-483c-8fbe-5f5c46d70140@VA3EHSMHS027.ehs.local>
References: <38677d6a-3f33-483c-8fbe-5f5c46d70140@VA3EHSMHS027.ehs.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Feb 2010 15:40:24 -0700
Message-ID: <fa686aa41002111440x699b6b1ck97b14002ee9fe7b1@mail.gmail.com>
Subject: Re: [PATCH] [V5] net: emaclite: adding MDIO and phy lib support
To: John Linn <john.linn@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sadanand Mutyala <Sadanand.Mutyala@xilinx.com>, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org, jgarzik@pobox.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 11, 2010 at 3:12 PM, John Linn <john.linn@xilinx.com> wrote:
> These changes add MDIO and phy lib support to the driver as the
> IP core now supports the MDIO bus.
>
> The MDIO bus and phy are added as a child to the emaclite in the device
> tree as illustrated below.
>
> mdio {
> =A0 =A0 =A0 =A0#address-cells =3D <1>;
> =A0 =A0 =A0 =A0#size-cells =3D <0>;
> =A0 =A0 =A0 =A0phy0: phy@7 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,88e1111";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <7>;
> =A0 =A0 =A0 =A0} ;
> }
>
> Signed-off-by: Sadanand Mutyala <Sadanand.Mutyala@xilinx.com>
> Signed-off-by: John Linn <john.linn@xilinx.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

I've noticed one more problem below, but I'm okay with this being
merged as-is and fixed up with a follow-on patch later.

g.

> +/**
> + * xemaclite_mdio_setup - Register mii_bus for the Emaclite device
> + * @lp: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Pointer to the Emaclite device pr=
ivate data
> + * @ofdev: =A0 =A0 Pointer to OF device structure
> + *
> + * This function enables MDIO bus in the Emaclite device and registers a
> + * mii_bus.
> + *
> + * Return: =A0 =A0 0 upon success or a negative error upon failure
> + */
> +static int xemaclite_mdio_setup(struct net_local *lp, struct device *dev=
)
> +{
> + =A0 =A0 =A0 struct mii_bus *bus;
> + =A0 =A0 =A0 int rc;
> + =A0 =A0 =A0 struct resource res;
> + =A0 =A0 =A0 struct device_node *np =3D of_get_parent(lp->phy_node);
> +
> + =A0 =A0 =A0 /* Don't register the MDIO bus if the phy_node or its paren=
t node
> + =A0 =A0 =A0 =A0* can't be found.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!np)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;

This doesn't make sense.  The MDIO bus registration should not be
conditional on whether or not this particular xemaclite instance has a
phy on this particular bus.  Instead of following the mac
--(phandle)--> phy-device --(parent)--> mdio node linkage, this
function should look at the mac nodes children to find the mdio node.

In fact, now that I think about it, the code is actually dangerous,
because it may try and register a different mdio bus node as its own.

> +
> + =A0 =A0 =A0 /* Enable the MDIO bus by asserting the enable bit in MDIO =
Control
> + =A0 =A0 =A0 =A0* register.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 out_be32(lp->base_addr + XEL_MDIOCTRL_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0XEL_MDIOCTRL_MDIOEN_MASK);
> +
> + =A0 =A0 =A0 bus =3D mdiobus_alloc();
> + =A0 =A0 =A0 if (!bus)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 of_address_to_resource(np, 0, &res);
> + =A0 =A0 =A0 snprintf(bus->id, MII_BUS_ID_SIZE, "%.8llx",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long)res.start);
> + =A0 =A0 =A0 bus->priv =3D lp;
> + =A0 =A0 =A0 bus->name =3D "Xilinx Emaclite MDIO";
> + =A0 =A0 =A0 bus->read =3D xemaclite_mdio_read;
> + =A0 =A0 =A0 bus->write =3D xemaclite_mdio_write;
> + =A0 =A0 =A0 bus->reset =3D xemaclite_mdio_reset;
> + =A0 =A0 =A0 bus->parent =3D dev;
> + =A0 =A0 =A0 bus->irq =3D lp->mdio_irqs; /* preallocated IRQ table */
> +
> + =A0 =A0 =A0 lp->mii_bus =3D bus;
> +
> + =A0 =A0 =A0 rc =3D of_mdiobus_register(bus, np);
> + =A0 =A0 =A0 if (rc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_register;
> +
> + =A0 =A0 =A0 return 0;
> +
> +err_register:
> + =A0 =A0 =A0 mdiobus_free(bus);
> + =A0 =A0 =A0 return rc;
> +}


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
