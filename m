Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 3EEA4DEBB0
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 16:06:19 +1100 (EST)
Received: by gxk1 with SMTP id 1so2588448gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 22:06:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090319050032.11320.37658.stgit@localhost.localdomain>
References: <20090319050015.11320.61641.stgit@localhost.localdomain>
	<20090319050032.11320.37658.stgit@localhost.localdomain>
Date: Wed, 18 Mar 2009 23:06:17 -0600
Message-ID: <fa686aa40903182206j1c0e2621u71370b57bf86fafd@mail.gmail.com>
Subject: Re: [PATCH 4/9] openfirmware: Add OF phylib support code
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, afleming@freescale.com,
	avorontsov@ru.mvista.com, davem@davemloft.net, galak@kernel.crashing.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

RFC, please don't apply yet.

On Wed, Mar 18, 2009 at 11:00 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> Add support for parsing the device tree for PHY devices on an MDIO bus
>
> CC: Andy Fleming <afleming@freescale.com>
> CC: linuxppc-dev@ozlabs.org
> CC: devtree-discuss@ozlabs.org
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> =A0drivers/of/Kconfig =A0 =A0 =A0| =A0 =A06 ++
> =A0drivers/of/Makefile =A0 =A0 | =A0 =A01
> =A0drivers/of/of_mdio.c =A0 =A0| =A0130 +++++++++++++++++++++++++++++++++=
++++++++++++++
> =A0include/linux/of_mdio.h | =A0 21 ++++++++
> =A04 files changed, 158 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/of/of_mdio.c
> =A0create mode 100644 include/linux/of_mdio.h
>
>
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index f821dbc..6fe043b 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -19,3 +19,9 @@ config OF_SPI
> =A0 =A0 =A0 =A0depends on OF && PPC_OF && SPI
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0OpenFirmware SPI accessors
> +
> +config OF_MDIO
> + =A0 =A0 =A0 def_tristate PHYLIB
> + =A0 =A0 =A0 depends on OF && PHYLIB
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 OpenFirmware MDIO bus (Ethernet PHY) accessors
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index 4c3c6f8..bdfb5f5 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -3,3 +3,4 @@ obj-$(CONFIG_OF_DEVICE) +=3D device.o platform.o
> =A0obj-$(CONFIG_OF_GPIO) =A0 +=3D gpio.o
> =A0obj-$(CONFIG_OF_I2C) =A0 +=3D of_i2c.o
> =A0obj-$(CONFIG_OF_SPI) =A0 +=3D of_spi.o
> +obj-$(CONFIG_OF_MDIO) =A0+=3D of_mdio.o
> diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
> new file mode 100644
> index 0000000..6f3038a
> --- /dev/null
> +++ b/drivers/of/of_mdio.c
> @@ -0,0 +1,130 @@
> +/*
> + * OF helpers for the MDIO (Ethernet PHY) API
> + *
> + * Copyright (c) 2009 Secret Lab Technologies, Ltd.
> + *
> + * This file is released under the GPLv2
> + *
> + * This file provides helper functions for extracting PHY device informa=
tion
> + * out of the OpenFirmware device tree and using it to populate an mii_b=
us.
> + */
> +
> +#include <linux/phy.h>
> +#include <linux/of.h>
> +#include <linux/of_mdio.h>
> +#include <linux/module.h>
> +
> +MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
> +MODULE_LICENSE("GPL");
> +
> +/**
> + * of_mdiobus_register - Register mii_bus and create PHYs from the devic=
e tree
> + * @mdio: pointer to mii_bus structure
> + * @np: pointer to device_node of MDIO bus.
> + *
> + * This function registers the mii_bus structure and registers a phy_dev=
ice
> + * for each child node of @np.
> + */
> +int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
> +{
> + =A0 =A0 =A0 struct phy_device *phy;
> + =A0 =A0 =A0 struct device_node *child;
> + =A0 =A0 =A0 int rc, i;
> +
> + =A0 =A0 =A0 /* Mask out all PHYs from auto probing. =A0Instead the PHYs=
 listed in
> + =A0 =A0 =A0 =A0* the device tree are populated after the bus has been r=
egistered */
> + =A0 =A0 =A0 mdio->phy_mask =3D ~0;
> +
> + =A0 =A0 =A0 /* Clear all the IRQ properties */
> + =A0 =A0 =A0 if (mdio->irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i=3D0; i<PHY_MAX_ADDR; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdio->irq[i] =3D PHY_POLL;
> +
> + =A0 =A0 =A0 /* Register the MDIO bus */
> + =A0 =A0 =A0 rc =3D mdiobus_register(mdio);
> + =A0 =A0 =A0 if (rc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
> +
> + =A0 =A0 =A0 /* Loop over the child nodes and register a phy_device for =
each one */
> + =A0 =A0 =A0 for_each_child_of_node(np, child) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u32 *addr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int len;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* A PHY must have a reg property in the ra=
nge [0-31] */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D of_get_property(child, "reg", &len=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!addr || len < sizeof(*addr) || *addr >=
=3D 32 || *addr < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&mdio->dev, "%s has=
 invalid PHY address\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 child->full=
_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mdio->irq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdio->irq[*addr] =3D irq_of=
_parse_and_map(child, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!mdio->irq[*addr])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdio->irq[*=
addr] =3D PHY_POLL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy =3D get_phy_device(mdio, *addr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!phy) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&mdio->dev, "error =
probing PHY at address %i\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *addr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_scan_fixups(phy);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Associate the OF node with the device st=
ructure so it
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* can be looked up later */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_get(child);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_archdata_set_node(&phy->dev.archdata, c=
hild);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* All data is now stored in the phy struct=
; register it */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D phy_device_register(phy);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_device_free(phy);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(child);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&mdio->dev, "registered phy %s at a=
ddress %i\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 child->name, *addr);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL(of_mdiobus_register);
> +
> +/**
> + * of_phy_connect - Connect to the phy described in the device tree
> + * @dev: pointer to net_device claiming the phy
> + * @phy_np: Pointer to device tree node for the PHY
> + * @hndlr: Link state callback for the network device
> + * @iface: PHY data interface type
> + *
> + * Returns a pointer to the phy_device if successfull. =A0NULL otherwise
> + */
> +struct phy_device *of_phy_connect(struct net_device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
device_node *phy_np,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void (*=
hndlr)(struct net_device *), u32 flags,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_int=
erface_t iface)
> +{
> + =A0 =A0 =A0 int match(struct device *dev, void *phy_np)
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return dev_archdata_get_node(&dev->archdata=
) =3D=3D phy_np;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 struct device *d;
> + =A0 =A0 =A0 int rc;
> +
> + =A0 =A0 =A0 if (!phy_np)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 d =3D bus_find_device(&mdio_bus_type, NULL, phy_np, match);
> + =A0 =A0 =A0 if (!d)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 rc =3D phy_connect_direct(dev, to_phy_device(d), hndlr, fla=
gs, iface);
> + =A0 =A0 =A0 if (rc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 return to_phy_device(d);
> +}
> +EXPORT_SYMBOL(of_phy_connect);
> diff --git a/include/linux/of_mdio.h b/include/linux/of_mdio.h
> new file mode 100644
> index 0000000..ec092cc
> --- /dev/null
> +++ b/include/linux/of_mdio.h
> @@ -0,0 +1,21 @@
> +/*
> + * OF helpers for the MDIO (Ethernet PHY) API
> + *
> + * Copyright (c) 2009 Secret Lab Technologies, Ltd.
> + *
> + * This file is released under the GPLv2
> + */
> +
> +#ifndef __LINUX_OF_MDIO_H
> +#define __LINUX_OF_MDIO_H
> +
> +#include <linux/phy.h>
> +#include <linux/of.h>
> +
> +extern int of_mdiobus_register(struct mii_bus *mdio, struct device_node =
*np);
> +extern struct phy_device *of_phy_connect(struct net_device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct device_node *phy_np,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0void (*hndlr)(struct net_device *),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0u32 flags, phy_interface_t iface);
> +
> +#endif /* __LINUX_OF_MDIO_H */
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
