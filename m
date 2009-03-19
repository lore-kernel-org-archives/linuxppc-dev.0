Return-Path: <sunder.svit@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 20272DDE98
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 16:37:28 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so254378yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 22:37:27 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 19 Mar 2009 11:07:26 +0530
Message-ID: <d90126080903182237i6057e9afi9051723685bcb2d2@mail.gmail.com>
Subject: Re: [PATCH 1/9] of: add of_parse_phandle() helper for parsing
From: sunder ramani <sunder.svit@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant,

I have here one query though. I found out that there are various
configurations of the PHY device that my be connected to the eTSEC on
the 8548. I am talking only about this because I faced some issues.

My HW had RGMII, SGMII configurations for the different ports to the
PHYs. And the kernel doesnt know about how the interface from the
eTSEC to the physical PHY is. I do acknowledge the ignorance of the
MII layer, but I had to fix up some dirty patches in the phy code to
let me kernel do auto-neg, phy_init for a RGMII, SGMII, interface
differentaiting on the basis of the Phy-IDs. As a result, the PHY
layer would generalize the auto-neg and init functions for the copper
interface.

To Summarize, should not we have a phy_type flag in the OF tree which
will let the PHY layer do the various PHY tasks based on if it is a
copper/fiber interface. I really dont like my fix in my kernel and am
new to open source. Do you think it is a valid argument? If it so, I
would like to plan to introduce those changes and post to the
community.

Please let me know your comments!

Thanx!
Sundar

On Thu, Mar 19, 2009 at 10:35 AM,  <linuxppc-dev-request@ozlabs.org> wrote:
> Send Linuxppc-dev mailing list submissions to
> =A0 =A0 =A0 =A0linuxppc-dev@ozlabs.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
> =A0 =A0 =A0 =A0https://ozlabs.org/mailman/listinfo/linuxppc-dev
> or, via email, send a message with subject or body 'help' to
> =A0 =A0 =A0 =A0linuxppc-dev-request@ozlabs.org
>
> You can reach the person managing the list at
> =A0 =A0 =A0 =A0linuxppc-dev-owner@ozlabs.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linuxppc-dev digest..."
>
>
> Today's Topics:
>
> =A0 1. [PATCH 6/9] net/gianfar: Rework gianfar driver to use OF
> =A0 =A0 =A0PHY/MDIO =A0helper functions (Grant Likely)
> =A0 2. [PATCH 7/9] net/ucc_geth: Rework ucc_geth driver to use OF
> =A0 =A0 =A0PHY/MDIO =A0helper functions (Grant Likely)
> =A0 3. [PATCH 8/9] net/pasemi_mac: Rework pasemi_mac driver to use
> =A0 =A0 =A0of_mdio =A0 infrastructure (Grant Likely)
> =A0 4. [PATCH 9/9] net/fs_enet: Rework fs_enet driver to use of_mdio
> =A0 =A0 =A0infrastructure (Grant Likely)
> =A0 5. Re: [PATCH 1/9] of: add of_parse_phandle() helper for parsing
> =A0 =A0 =A0phandle =A0 properties (Grant Likely)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Wed, 18 Mar 2009 23:00:44 -0600
> From: Grant Likely <grant.likely@secretlab.ca>
> Subject: [PATCH 6/9] net/gianfar: Rework gianfar driver to use OF
> =A0 =A0 =A0 =A0PHY/MDIO =A0 =A0 =A0 =A0helper functions
> To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
> =A0 =A0 =A0 =A0afleming@freescale.com, avorontsov@ru.mvista.com, davem@da=
vemloft.net,
> =A0 =A0 =A0 =A0galak@kernel.crashing.org
> Message-ID: <20090319050043.11320.96160.stgit@localhost.localdomain>
> Content-Type: text/plain; charset=3D"utf-8"
>
> From: Grant Likely <grant.likely@secretlab.ca>
>
> This patch simplifies the driver by making use of more common code.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> =A0drivers/net/gianfar.c =A0 =A0 | =A0 94 ++++++++++++++-----------------=
--------------
> =A0drivers/net/gianfar.h =A0 =A0 | =A0 =A03 +
> =A0drivers/net/gianfar_mii.c | =A0 52 +------------------------
> =A03 files changed, 34 insertions(+), 115 deletions(-)
>
>
> diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
> index 9831b3f..0521267 100644
> --- a/drivers/net/gianfar.c
> +++ b/drivers/net/gianfar.c
> @@ -75,6 +75,7 @@
> =A0#include <linux/if_vlan.h>
> =A0#include <linux/spinlock.h>
> =A0#include <linux/mm.h>
> +#include <linux/of_mdio.h>
> =A0#include <linux/of_platform.h>
> =A0#include <linux/ip.h>
> =A0#include <linux/tcp.h>
> @@ -155,17 +156,13 @@ static inline int gfar_uses_fcb(struct gfar_private=
 *priv)
>
> =A0static int gfar_of_init(struct net_device *dev)
> =A0{
> - =A0 =A0 =A0 struct device_node *phy, *mdio;
> - =A0 =A0 =A0 const unsigned int *id;
> =A0 =A0 =A0 =A0const char *model;
> =A0 =A0 =A0 =A0const char *ctype;
> =A0 =A0 =A0 =A0const void *mac_addr;
> - =A0 =A0 =A0 const phandle *ph;
> =A0 =A0 =A0 =A0u64 addr, size;
> =A0 =A0 =A0 =A0int err =3D 0;
> =A0 =A0 =A0 =A0struct gfar_private *priv =3D netdev_priv(dev);
> =A0 =A0 =A0 =A0struct device_node *np =3D priv->node;
> - =A0 =A0 =A0 char bus_name[MII_BUS_ID_SIZE];
>
> =A0 =A0 =A0 =A0if (!np || !of_device_is_available(np))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> @@ -228,8 +225,8 @@ static int gfar_of_init(struct net_device *dev)
> =A0 =A0 =A0 =A0if (of_get_property(np, "fsl,magic-packet", NULL))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->device_flags |=3D FSL_GIANFAR_DEV_HA=
S_MAGIC_PACKET;
>
> - =A0 =A0 =A0 ph =3D of_get_property(np, "phy-handle", NULL);
> - =A0 =A0 =A0 if (ph =3D=3D NULL) {
> + =A0 =A0 =A0 priv->phy_node =3D of_parse_phandle(np, "phy-device", 0);
> + =A0 =A0 =A0 if (!priv->phy_node) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 *fixed_link;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fixed_link =3D (u32 *)of_get_property(np, =
"fixed-link", NULL);
> @@ -237,57 +234,10 @@ static int gfar_of_init(struct net_device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -ENODEV;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_out;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(priv->phy_bus_id, sizeof(priv->phy=
_bus_id),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PHY_ID_FMT,=
 "0", fixed_link[0]);
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy =3D of_find_node_by_phandle(*ph);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (phy =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENODEV;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdio =3D of_get_parent(phy);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 id =3D of_get_property(phy, "reg", NULL);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(phy);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(mdio);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gfar_mdio_bus_name(bus_name, mdio);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(priv->phy_bus_id, sizeof(priv->phy=
_bus_id), "%s:%02x",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_name, *=
id);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Find the TBI PHY. =A0If it's not there, we don't suppor=
t SGMII */
> - =A0 =A0 =A0 ph =3D of_get_property(np, "tbi-handle", NULL);
> - =A0 =A0 =A0 if (ph) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_node *tbi =3D of_find_node_by=
_phandle(*ph);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct of_device *ofdev;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mii_bus *bus;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!tbi)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdio =3D of_get_parent(tbi);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!mdio)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ofdev =3D of_find_device_by_node(mdio);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(mdio);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 id =3D of_get_property(tbi, "reg", NULL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!id)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(tbi);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D dev_get_drvdata(&ofdev->dev);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->tbiphy =3D bus->phy_map[*id];
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 priv->tbi_node =3D of_parse_phandle(np, "tbi-handle", 0);
>
> =A0 =A0 =A0 =A0return 0;
>
> @@ -661,7 +611,6 @@ static int init_phy(struct net_device *dev)
> =A0 =A0 =A0 =A0uint gigabit_support =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->device_flags & FSL_GIANFAR_DEV_HAS_G=
IGABIT ?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SUPPORTED_1000baseT_Full : 0;
> - =A0 =A0 =A0 struct phy_device *phydev;
> =A0 =A0 =A0 =A0phy_interface_t interface;
>
> =A0 =A0 =A0 =A0priv->oldlink =3D 0;
> @@ -670,23 +619,38 @@ static int init_phy(struct net_device *dev)
>
> =A0 =A0 =A0 =A0interface =3D gfar_get_interface(dev);
>
> - =A0 =A0 =A0 phydev =3D phy_connect(dev, priv->phy_bus_id, &adjust_link,=
 0, interface);
> + =A0 =A0 =A0 if (priv->phy_node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->phydev =3D of_phy_connect(dev, priv->=
phy_node, &adjust_link,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 0, interface);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!priv->phydev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "error: =
Could not attach to PHY\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (priv->tbi_node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->tbiphy =3D of_phy_connect(dev, priv->=
tbi_node, &adjust_link,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 0, interface);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!priv->tbiphy) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "error: =
Could not attach to TBI\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_tbiphy;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (interface =3D=3D PHY_INTERFACE_MODE_SGMII)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gfar_configure_serdes(dev);
>
> - =A0 =A0 =A0 if (IS_ERR(phydev)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: Could not attach to PH=
Y\n", dev->name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(phydev);
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0/* Remove any features not supported by the controller */
> - =A0 =A0 =A0 phydev->supported &=3D (GFAR_SUPPORTED | gigabit_support);
> - =A0 =A0 =A0 phydev->advertising =3D phydev->supported;
> -
> - =A0 =A0 =A0 priv->phydev =3D phydev;
> + =A0 =A0 =A0 priv->phydev->supported &=3D (GFAR_SUPPORTED | gigabit_supp=
ort);
> + =A0 =A0 =A0 priv->phydev->advertising =3D priv->phydev->supported;
>
> =A0 =A0 =A0 =A0return 0;
> +
> + err_tbiphy:
> + =A0 =A0 =A0 if (priv->phy_node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_disconnect(priv->phydev);
> + =A0 =A0 =A0 priv->phydev =3D NULL;
> + =A0 =A0 =A0 return -ENODEV;
> =A0}
>
> =A0/*
> diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h
> index eaa8689..d3d56a9 100644
> --- a/drivers/net/gianfar.h
> +++ b/drivers/net/gianfar.h
> @@ -775,7 +775,8 @@ struct gfar_private {
> =A0 =A0 =A0 =A0spinlock_t bflock;
>
> =A0 =A0 =A0 =A0phy_interface_t interface;
> - =A0 =A0 =A0 char =A0 =A0phy_bus_id[BUS_ID_SIZE];
> + =A0 =A0 =A0 struct device_node *phy_node;
> + =A0 =A0 =A0 struct device_node *tbi_node;
> =A0 =A0 =A0 =A0u32 device_flags;
> =A0 =A0 =A0 =A0unsigned char rx_csum_enable:1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0extended_hash:1,
> diff --git a/drivers/net/gianfar_mii.c b/drivers/net/gianfar_mii.c
> index f49a426..c6d77bd 100644
> --- a/drivers/net/gianfar_mii.c
> +++ b/drivers/net/gianfar_mii.c
> @@ -35,6 +35,7 @@
> =A0#include <linux/mii.h>
> =A0#include <linux/phy.h>
> =A0#include <linux/of.h>
> +#include <linux/of_mdio.h>
> =A0#include <linux/of_platform.h>
>
> =A0#include <asm/io.h>
> @@ -152,45 +153,6 @@ static int gfar_mdio_reset(struct mii_bus *bus)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -/* Allocate an array which provides irq #s for each PHY on the given bus=
 */
> -static int *create_irq_map(struct device_node *np)
> -{
> - =A0 =A0 =A0 int *irqs;
> - =A0 =A0 =A0 int i;
> - =A0 =A0 =A0 struct device_node *child =3D NULL;
> -
> - =A0 =A0 =A0 irqs =3D kcalloc(PHY_MAX_ADDR, sizeof(int), GFP_KERNEL);
> -
> - =A0 =A0 =A0 if (!irqs)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> -
> - =A0 =A0 =A0 for (i =3D 0; i < PHY_MAX_ADDR; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 irqs[i] =3D PHY_POLL;
> -
> - =A0 =A0 =A0 while ((child =3D of_get_next_child(np, child)) !=3D NULL) =
{
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int irq =3D irq_of_parse_and_map(child, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u32 *id;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irq =3D=3D NO_IRQ)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 id =3D of_get_property(child, "reg", NULL);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!id)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*id < PHY_MAX_ADDR && *id >=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irqs[*id] =3D irq;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "%d is not a valid PHY address\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 np->full_name, *id);
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 return irqs;
> -}
> -
> -
> =A0void gfar_mdio_bus_name(char *name, struct device_node *np)
> =A0{
> =A0 =A0 =A0 =A0const u32 *reg;
> @@ -253,7 +215,7 @@ static int gfar_mdio_probe(struct of_device *ofdev,
>
> =A0 =A0 =A0 =A0new_bus->priv =3D (void __force *)regs;
>
> - =A0 =A0 =A0 new_bus->irq =3D create_irq_map(np);
> + =A0 =A0 =A0 new_bus->irq =3D kcalloc(PHY_MAX_ADDR, sizeof(int), GFP_KER=
NEL);
>
> =A0 =A0 =A0 =A0if (new_bus->irq =3D=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -ENOMEM;
> @@ -301,15 +263,7 @@ static int gfar_mdio_probe(struct of_device *ofdev,
>
> =A0 =A0 =A0 =A0gfar_write(&enet_regs->tbipa, tbiaddr);
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* The TBIPHY-only buses will find PHYs at every address,
> - =A0 =A0 =A0 =A0* so we mask them all but the TBI
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (!of_device_is_compatible(np, "fsl,gianfar-mdio"))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_bus->phy_mask =3D ~(1 << tbiaddr);
> -
> - =A0 =A0 =A0 err =3D mdiobus_register(new_bus);
> -
> + =A0 =A0 =A0 err =3D of_mdiobus_register(new_bus, np);
> =A0 =A0 =A0 =A0if (err !=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk (KERN_ERR "%s: Cannot register as M=
DIO bus\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_bus->n=
ame);
>
>
>
> ------------------------------
>
> Message: 2
> Date: Wed, 18 Mar 2009 23:00:50 -0600
> From: Grant Likely <grant.likely@secretlab.ca>
> Subject: [PATCH 7/9] net/ucc_geth: Rework ucc_geth driver to use OF
> =A0 =A0 =A0 =A0PHY/MDIO =A0 =A0 =A0 =A0helper functions
> To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
> =A0 =A0 =A0 =A0afleming@freescale.com, avorontsov@ru.mvista.com, davem@da=
vemloft.net,
> =A0 =A0 =A0 =A0galak@kernel.crashing.org
> Message-ID: <20090319050049.11320.98769.stgit@localhost.localdomain>
> Content-Type: text/plain; charset=3D"utf-8"
>
> From: Grant Likely <grant.likely@secretlab.ca>
>
> This patch simplifies the driver by making use of more common code.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> =A0drivers/net/ucc_geth.c =A0 =A0 | =A0 27 ++++++---------------------
> =A0drivers/net/ucc_geth_mii.c | =A0 17 +++--------------
> =A02 files changed, 9 insertions(+), 35 deletions(-)
>
>
> diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
> index e879868..45bb627 100644
> --- a/drivers/net/ucc_geth.c
> +++ b/drivers/net/ucc_geth.c
> @@ -28,6 +28,7 @@
> =A0#include <linux/mii.h>
> =A0#include <linux/phy.h>
> =A0#include <linux/workqueue.h>
> +#include <linux/of_mdio.h>
> =A0#include <linux/of_platform.h>
>
> =A0#include <asm/uaccess.h>
> @@ -1537,35 +1538,19 @@ static int init_phy(struct net_device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct ucc_geth_private *priv =3D netdev_priv(dev);
> =A0 =A0 =A0 =A0struct device_node *np =3D priv->node;
> - =A0 =A0 =A0 struct device_node *phy, *mdio;
> - =A0 =A0 =A0 const phandle *ph;
> - =A0 =A0 =A0 char bus_name[MII_BUS_ID_SIZE];
> - =A0 =A0 =A0 const unsigned int *id;
> + =A0 =A0 =A0 struct device_node *phy;
> =A0 =A0 =A0 =A0struct phy_device *phydev;
> - =A0 =A0 =A0 char phy_id[BUS_ID_SIZE];
>
> =A0 =A0 =A0 =A0priv->oldlink =3D 0;
> =A0 =A0 =A0 =A0priv->oldspeed =3D 0;
> =A0 =A0 =A0 =A0priv->oldduplex =3D -1;
>
> - =A0 =A0 =A0 ph =3D of_get_property(np, "phy-handle", NULL);
> - =A0 =A0 =A0 phy =3D of_find_node_by_phandle(*ph);
> - =A0 =A0 =A0 mdio =3D of_get_parent(phy);
> -
> - =A0 =A0 =A0 id =3D of_get_property(phy, "reg", NULL);
> -
> + =A0 =A0 =A0 phy =3D of_parse_phandle(np, "phy-handle", 0);
> + =A0 =A0 =A0 phydev =3D of_phy_connect(dev, phy, &adjust_link, 0, priv->=
phy_interface);
> =A0 =A0 =A0 =A0of_node_put(phy);
> - =A0 =A0 =A0 of_node_put(mdio);
> -
> - =A0 =A0 =A0 uec_mdio_bus_name(bus_name, mdio);
> - =A0 =A0 =A0 snprintf(phy_id, sizeof(phy_id), "%s:%02x",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bus_name=
, *id);
> -
> - =A0 =A0 =A0 phydev =3D phy_connect(dev, phy_id, &adjust_link, 0, priv->=
phy_interface);
> -
> - =A0 =A0 =A0 if (IS_ERR(phydev)) {
> + =A0 =A0 =A0 if (!phydev) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk("%s: Could not attach to PHY\n", de=
v->name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(phydev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0phydev->supported &=3D (ADVERTISED_10baseT_Half |
> diff --git a/drivers/net/ucc_geth_mii.c b/drivers/net/ucc_geth_mii.c
> index 0ada4ed..9f2492f 100644
> --- a/drivers/net/ucc_geth_mii.c
> +++ b/drivers/net/ucc_geth_mii.c
> @@ -36,6 +36,7 @@
> =A0#include <linux/mii.h>
> =A0#include <linux/phy.h>
> =A0#include <linux/fsl_devices.h>
> +#include <linux/of_mdio.h>
> =A0#include <linux/of_platform.h>
>
> =A0#include <asm/io.h>
> @@ -135,11 +136,10 @@ static int uec_mdio_probe(struct of_device *ofdev, =
const struct of_device_id *ma
> =A0{
> =A0 =A0 =A0 =A0struct device *device =3D &ofdev->dev;
> =A0 =A0 =A0 =A0struct device_node *np =3D ofdev->node, *tempnp =3D NULL;
> - =A0 =A0 =A0 struct device_node *child =3D NULL;
> =A0 =A0 =A0 =A0struct ucc_mii_mng __iomem *regs;
> =A0 =A0 =A0 =A0struct mii_bus *new_bus;
> =A0 =A0 =A0 =A0struct resource res;
> - =A0 =A0 =A0 int k, err =3D 0;
> + =A0 =A0 =A0 int err =3D 0;
>
> =A0 =A0 =A0 =A0new_bus =3D mdiobus_alloc();
> =A0 =A0 =A0 =A0if (NULL =3D=3D new_bus)
> @@ -165,17 +165,6 @@ static int uec_mdio_probe(struct of_device *ofdev, c=
onst struct of_device_id *ma
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto reg_map_fail;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 for (k =3D 0; k < 32; k++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_bus->irq[k] =3D PHY_POLL;
> -
> - =A0 =A0 =A0 while ((child =3D of_get_next_child(np, child)) !=3D NULL) =
{
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int irq =3D irq_of_parse_and_map(child, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irq !=3D NO_IRQ) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u32 *id =3D of_get_pr=
operty(child, "reg", NULL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_bus->irq[*id] =3D irq;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0/* Set the base address */
> =A0 =A0 =A0 =A0regs =3D ioremap(res.start, sizeof(struct ucc_mii_mng));
>
> @@ -220,7 +209,7 @@ static int uec_mdio_probe(struct of_device *ofdev, co=
nst struct of_device_id *ma
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 err =3D mdiobus_register(new_bus);
> + =A0 =A0 =A0 err =3D of_mdiobus_register(new_bus, np);
> =A0 =A0 =A0 =A0if (0 !=3D err) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "%s: Cannot register as MD=
IO bus\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_bus->name);
>
>
>
> ------------------------------
>
> Message: 3
> Date: Wed, 18 Mar 2009 23:00:55 -0600
> From: Grant Likely <grant.likely@secretlab.ca>
> Subject: [PATCH 8/9] net/pasemi_mac: Rework pasemi_mac driver to use
> =A0 =A0 =A0 =A0of_mdio infrastructure
> To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
> =A0 =A0 =A0 =A0afleming@freescale.com, avorontsov@ru.mvista.com, davem@da=
vemloft.net,
> =A0 =A0 =A0 =A0galak@kernel.crashing.org
> Message-ID: <20090319050055.11320.62033.stgit@localhost.localdomain>
> Content-Type: text/plain; charset=3D"utf-8"
>
> From: Grant Likely <grant.likely@secretlab.ca>
>
> This patch simplifies the driver by making use of more common code.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> =A0drivers/net/pasemi_mac.c | =A0 19 +++----------------
> =A0drivers/net/pasemi_mac.h | =A0 =A01 -
> =A02 files changed, 3 insertions(+), 17 deletions(-)
>
>
> diff --git a/drivers/net/pasemi_mac.c b/drivers/net/pasemi_mac.c
> index d0349e7..8c92d1f 100644
> --- a/drivers/net/pasemi_mac.c
> +++ b/drivers/net/pasemi_mac.c
> @@ -1086,34 +1086,21 @@ static int pasemi_mac_phy_init(struct net_device =
*dev)
> =A0 =A0 =A0 =A0struct pasemi_mac *mac =3D netdev_priv(dev);
> =A0 =A0 =A0 =A0struct device_node *dn, *phy_dn;
> =A0 =A0 =A0 =A0struct phy_device *phydev;
> - =A0 =A0 =A0 unsigned int phy_id;
> =A0 =A0 =A0 =A0const phandle *ph;
> =A0 =A0 =A0 =A0const unsigned int *prop;
> =A0 =A0 =A0 =A0struct resource r;
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0dn =3D pci_device_to_OF_node(mac->pdev);
> - =A0 =A0 =A0 ph =3D of_get_property(dn, "phy-handle", NULL);
> - =A0 =A0 =A0 if (!ph)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> - =A0 =A0 =A0 phy_dn =3D of_find_node_by_phandle(*ph);
> -
> - =A0 =A0 =A0 prop =3D of_get_property(phy_dn, "reg", NULL);
> - =A0 =A0 =A0 ret =3D of_address_to_resource(phy_dn->parent, 0, &r);
> - =A0 =A0 =A0 if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> -
> - =A0 =A0 =A0 phy_id =3D *prop;
> - =A0 =A0 =A0 snprintf(mac->phy_id, sizeof(mac->phy_id), "%x:%02x",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(int)r.start, phy_id);
> -
> + =A0 =A0 =A0 phy_dn =3D of_parse_phandle(dn, "phy-handle", 0);
> =A0 =A0 =A0 =A0of_node_put(phy_dn);
>
> =A0 =A0 =A0 =A0mac->link =3D 0;
> =A0 =A0 =A0 =A0mac->speed =3D 0;
> =A0 =A0 =A0 =A0mac->duplex =3D -1;
>
> - =A0 =A0 =A0 phydev =3D phy_connect(dev, mac->phy_id, &pasemi_adjust_lin=
k, 0, PHY_INTERFACE_MODE_SGMII);
> + =A0 =A0 =A0 phydev =3D of_phy_connect(dev, phy_dn, &pasemi_adjust_link,=
 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PHY_INTERFA=
CE_MODE_SGMII);
>
> =A0 =A0 =A0 =A0if (IS_ERR(phydev)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "%s: Could not attach to p=
hy\n", dev->name);
> diff --git a/drivers/net/pasemi_mac.h b/drivers/net/pasemi_mac.h
> index 1a115ec..e2f4efa 100644
> --- a/drivers/net/pasemi_mac.h
> +++ b/drivers/net/pasemi_mac.h
> @@ -100,7 +100,6 @@ struct pasemi_mac {
> =A0 =A0 =A0 =A0int =A0 =A0 duplex;
>
> =A0 =A0 =A0 =A0unsigned int =A0 =A0msg_enable;
> - =A0 =A0 =A0 char =A0 =A0phy_id[BUS_ID_SIZE];
> =A0};
>
> =A0/* Software status descriptor (ring_info) */
>
>
>
> ------------------------------
>
> Message: 4
> Date: Wed, 18 Mar 2009 23:01:01 -0600
> From: Grant Likely <grant.likely@secretlab.ca>
> Subject: [PATCH 9/9] net/fs_enet: Rework fs_enet driver to use of_mdio
> =A0 =A0 =A0 =A0infrastructure
> To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
> =A0 =A0 =A0 =A0afleming@freescale.com, avorontsov@ru.mvista.com, davem@da=
vemloft.net,
> =A0 =A0 =A0 =A0galak@kernel.crashing.org
> Message-ID: <20090319050100.11320.64495.stgit@localhost.localdomain>
> Content-Type: text/plain; charset=3D"utf-8"
>
> From: Grant Likely <grant.likely@secretlab.ca>
>
> This patch simplifies the driver by making use of more common code.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> =A0drivers/net/fs_enet/fs_enet-main.c | =A0 66 +++++---------------------=
----------
> =A0drivers/net/fs_enet/mii-bitbang.c =A0| =A0 29 +---------------
> =A0drivers/net/fs_enet/mii-fec.c =A0 =A0 =A0| =A0 26 +-------------
> =A0include/linux/fs_enet_pd.h =A0 =A0 =A0 =A0 | =A0 =A06 +--
> =A04 files changed, 14 insertions(+), 113 deletions(-)
>
>
> diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_=
enet-main.c
> index ce900e5..e039d6a 100644
> --- a/drivers/net/fs_enet/fs_enet-main.c
> +++ b/drivers/net/fs_enet/fs_enet-main.c
> @@ -36,6 +36,8 @@
> =A0#include <linux/fs.h>
> =A0#include <linux/platform_device.h>
> =A0#include <linux/phy.h>
> +#include <linux/of.h>
> +#include <linux/of_mdio.h>
> =A0#include <linux/of_platform.h>
> =A0#include <linux/of_gpio.h>
>
> @@ -752,9 +754,10 @@ static int fs_init_phy(struct net_device *dev)
> =A0 =A0 =A0 =A0fep->oldlink =3D 0;
> =A0 =A0 =A0 =A0fep->oldspeed =3D 0;
> =A0 =A0 =A0 =A0fep->oldduplex =3D -1;
> - =A0 =A0 =A0 if(fep->fpi->bus_id)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 phydev =3D phy_connect(dev, fep->fpi->bus_i=
d, &fs_adjust_link, 0,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PHY_INTERFA=
CE_MODE_MII);
> + =A0 =A0 =A0 if(fep->fpi->phy_node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phydev =3D of_phy_connect(dev, fep->fpi->ph=
y_node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 &fs_adjust_link, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 PHY_INTERFACE_MODE_MII);
> =A0 =A0 =A0 =A0else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk("No phy bus ID specified in BSP cod=
e\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> @@ -962,57 +965,6 @@ static void cleanup_immap(void)
>
> =A0/*********************************************************************=
*****************/
>
> -static int __devinit find_phy(struct device_node *np,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct fs_pl=
atform_info *fpi)
> -{
> - =A0 =A0 =A0 struct device_node *phynode, *mdionode;
> - =A0 =A0 =A0 int ret =3D 0, len, bus_id;
> - =A0 =A0 =A0 const u32 *data;
> -
> - =A0 =A0 =A0 data =A0=3D of_get_property(np, "fixed-link", NULL);
> - =A0 =A0 =A0 if (data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(fpi->bus_id, 16, "%x:%02x", 0, *da=
ta);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 data =3D of_get_property(np, "phy-handle", &len);
> - =A0 =A0 =A0 if (!data || len !=3D 4)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> -
> - =A0 =A0 =A0 phynode =3D of_find_node_by_phandle(*data);
> - =A0 =A0 =A0 if (!phynode)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> -
> - =A0 =A0 =A0 data =3D of_get_property(phynode, "reg", &len);
> - =A0 =A0 =A0 if (!data || len !=3D 4) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_put_phy;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 mdionode =3D of_get_parent(phynode);
> - =A0 =A0 =A0 if (!mdionode) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_put_phy;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 bus_id =3D of_get_gpio(mdionode, 0);
> - =A0 =A0 =A0 if (bus_id < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct resource res;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D of_address_to_resource(mdionode, 0,=
 &res);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_put_mdio;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_id =3D res.start;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 snprintf(fpi->bus_id, 16, "%x:%02x", bus_id, *data);
> -
> -out_put_mdio:
> - =A0 =A0 =A0 of_node_put(mdionode);
> -out_put_phy:
> - =A0 =A0 =A0 of_node_put(phynode);
> - =A0 =A0 =A0 return ret;
> -}
> -
> =A0#ifdef CONFIG_FS_ENET_HAS_FEC
> =A0#define IS_FEC(match) ((match)->data =3D=3D &fs_fec_ops)
> =A0#else
> @@ -1046,9 +998,9 @@ static int __devinit fs_enet_probe(struct of_device =
*ofdev,
> =A0 =A0 =A0 =A0fpi->rx_copybreak =3D 240;
> =A0 =A0 =A0 =A0fpi->use_napi =3D 1;
> =A0 =A0 =A0 =A0fpi->napi_weight =3D 17;
> -
> - =A0 =A0 =A0 ret =3D find_phy(ofdev->node, fpi);
> - =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 fpi->phy_node =3D of_parse_phandle(ofdev->node, "phy-handle=
", 0);
> + =A0 =A0 =A0 if ((!fpi->phy_node) && (!of_get_property(ofdev->node, "fix=
ed-link",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 NULL)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_free_fpi;
>
> =A0 =A0 =A0 =A0privsize =3D sizeof(*fep) +
> diff --git a/drivers/net/fs_enet/mii-bitbang.c b/drivers/net/fs_enet/mii-=
bitbang.c
> index 49b6645..93b481b 100644
> --- a/drivers/net/fs_enet/mii-bitbang.c
> +++ b/drivers/net/fs_enet/mii-bitbang.c
> @@ -22,6 +22,7 @@
> =A0#include <linux/mii.h>
> =A0#include <linux/platform_device.h>
> =A0#include <linux/mdio-bitbang.h>
> +#include <linux/of_mdio.h>
> =A0#include <linux/of_platform.h>
>
> =A0#include "fs_enet.h"
> @@ -149,31 +150,12 @@ static int __devinit fs_mii_bitbang_init(struct mii=
_bus *bus,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static void __devinit add_phy(struct mii_bus *bus, struct device_node *n=
p)
> -{
> - =A0 =A0 =A0 const u32 *data;
> - =A0 =A0 =A0 int len, id, irq;
> -
> - =A0 =A0 =A0 data =3D of_get_property(np, "reg", &len);
> - =A0 =A0 =A0 if (!data || len !=3D 4)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> -
> - =A0 =A0 =A0 id =3D *data;
> - =A0 =A0 =A0 bus->phy_mask &=3D ~(1 << id);
> -
> - =A0 =A0 =A0 irq =3D of_irq_to_resource(np, 0, NULL);
> - =A0 =A0 =A0 if (irq !=3D NO_IRQ)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->irq[id] =3D irq;
> -}
> -
> =A0static int __devinit fs_enet_mdio_probe(struct of_device *ofdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 const struct of_device_id *match)
> =A0{
> - =A0 =A0 =A0 struct device_node *np =3D NULL;
> =A0 =A0 =A0 =A0struct mii_bus *new_bus;
> =A0 =A0 =A0 =A0struct bb_info *bitbang;
> =A0 =A0 =A0 =A0int ret =3D -ENOMEM;
> - =A0 =A0 =A0 int i;
>
> =A0 =A0 =A0 =A0bitbang =3D kzalloc(sizeof(struct bb_info), GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!bitbang)
> @@ -196,17 +178,10 @@ static int __devinit fs_enet_mdio_probe(struct of_d=
evice *ofdev,
> =A0 =A0 =A0 =A0if (!new_bus->irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_unmap_regs;
>
> - =A0 =A0 =A0 for (i =3D 0; i < PHY_MAX_ADDR; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_bus->irq[i] =3D -1;
> -
> - =A0 =A0 =A0 while ((np =3D of_get_next_child(ofdev->node, np)))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(np->type, "ethernet-phy"))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_phy(new_bus, np);
> -
> =A0 =A0 =A0 =A0new_bus->parent =3D &ofdev->dev;
> =A0 =A0 =A0 =A0dev_set_drvdata(&ofdev->dev, new_bus);
>
> - =A0 =A0 =A0 ret =3D mdiobus_register(new_bus);
> + =A0 =A0 =A0 ret =3D of_mdiobus_register(new_bus, ofdev->node);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_free_irqs;
>
> diff --git a/drivers/net/fs_enet/mii-fec.c b/drivers/net/fs_enet/mii-fec.=
c
> index 28077cc..bdc3160 100644
> --- a/drivers/net/fs_enet/mii-fec.c
> +++ b/drivers/net/fs_enet/mii-fec.c
> @@ -102,23 +102,6 @@ static int fs_enet_fec_mii_reset(struct mii_bus *bus=
)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static void __devinit add_phy(struct mii_bus *bus, struct device_node *n=
p)
> -{
> - =A0 =A0 =A0 const u32 *data;
> - =A0 =A0 =A0 int len, id, irq;
> -
> - =A0 =A0 =A0 data =3D of_get_property(np, "reg", &len);
> - =A0 =A0 =A0 if (!data || len !=3D 4)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> -
> - =A0 =A0 =A0 id =3D *data;
> - =A0 =A0 =A0 bus->phy_mask &=3D ~(1 << id);
> -
> - =A0 =A0 =A0 irq =3D of_irq_to_resource(np, 0, NULL);
> - =A0 =A0 =A0 if (irq !=3D NO_IRQ)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->irq[id] =3D irq;
> -}
> -
> =A0static int __devinit fs_enet_mdio_probe(struct of_device *ofdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 const struct of_device_id *match)
> =A0{
> @@ -165,17 +148,10 @@ static int __devinit fs_enet_mdio_probe(struct of_d=
evice *ofdev,
> =A0 =A0 =A0 =A0if (!new_bus->irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_unmap_regs;
>
> - =A0 =A0 =A0 for (i =3D 0; i < PHY_MAX_ADDR; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_bus->irq[i] =3D -1;
> -
> - =A0 =A0 =A0 while ((np =3D of_get_next_child(ofdev->node, np)))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(np->type, "ethernet-phy"))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_phy(new_bus, np);
> -
> =A0 =A0 =A0 =A0new_bus->parent =3D &ofdev->dev;
> =A0 =A0 =A0 =A0dev_set_drvdata(&ofdev->dev, new_bus);
>
> - =A0 =A0 =A0 ret =3D mdiobus_register(new_bus);
> + =A0 =A0 =A0 ret =3D of_mdiobus_register(new_bus, ofdev->node);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_free_irqs;
>
> diff --git a/include/linux/fs_enet_pd.h b/include/linux/fs_enet_pd.h
> index 8300cab..51b7934 100644
> --- a/include/linux/fs_enet_pd.h
> +++ b/include/linux/fs_enet_pd.h
> @@ -17,6 +17,7 @@
> =A0#define FS_ENET_PD_H
>
> =A0#include <linux/string.h>
> +#include <linux/of_mdio.h>
> =A0#include <asm/types.h>
>
> =A0#define FS_ENET_NAME =A0 "fs_enet"
> @@ -130,10 +131,7 @@ struct fs_platform_info {
>
> =A0 =A0 =A0 =A0u32 device_flags;
>
> - =A0 =A0 =A0 int phy_addr; =A0 =A0 =A0 =A0 =A0 /* the phy address (-1 no=
 phy) */
> - =A0 =A0 =A0 char bus_id[16];
> - =A0 =A0 =A0 int phy_irq; =A0 =A0 =A0 =A0 =A0 =A0/* the phy irq (if it e=
xists) =A0*/
> -
> + =A0 =A0 =A0 struct device_node *phy_node;
> =A0 =A0 =A0 =A0const struct fs_mii_bus_info *bus_info;
>
> =A0 =A0 =A0 =A0int rx_ring, tx_ring; =A0 /* number of buffers on rx =A0 =
=A0 */
>
>
>
> ------------------------------
>
> Message: 5
> Date: Wed, 18 Mar 2009 23:05:21 -0600
> From: Grant Likely <grant.likely@secretlab.ca>
> Subject: Re: [PATCH 1/9] of: add of_parse_phandle() helper for parsing
> =A0 =A0 =A0 =A0phandle properties
> To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
> =A0 =A0 =A0 =A0afleming@freescale.com, =A0 =A0 =A0 =A0 avorontsov@ru.mvis=
ta.com,
> =A0 =A0 =A0 =A0davem@davemloft.net, galak@kernel.crashing.org
> Message-ID:
> =A0 =A0 =A0 =A0<fa686aa40903182205w231e17e9wbd0dcc05d994d46e@mail.gmail.c=
om>
> Content-Type: text/plain; charset=3DISO-8859-1
>
> Bah! =A0Messed up the 'stg mail' command when sending this series and
> the 'RFC' tag didn't get added.
>
> This is firmly in the RFC category. =A0Please don't apply. =A0It doesn't
> have the level of polish that I'm happy with.
>
> This series is intended to make phy_device connecting simpler and more
> robust by using the PHY's device_node as the search key when
> connecting to PHY. =A0Changes are made to both the MDIO busses to
> extract the PHY data out of the device tree, and to the drivers to use
> a common helper function for finding the PHY it is interested in.
>
> Comments please.
> g.
>
> On Wed, Mar 18, 2009 at 11:00 PM, Grant Likely
> <grant.likely@secretlab.ca> wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> of_parse_phandle() is a helper function to read and parse a phandle
>> property and return a pointer to the resulting device_node.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>>
>> ?drivers/of/base.c ?| ? 23 +++++++++++++++++++++++
>> ?include/linux/of.h | ? ?3 +++
>> ?2 files changed, 26 insertions(+), 0 deletions(-)
>>
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index cd17092..1eaada4 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -494,6 +494,29 @@ int of_modalias_node(struct device_node *node, char=
 *modalias, int len)
>> ?EXPORT_SYMBOL_GPL(of_modalias_node);
>>
>> ?/**
>> + * of_parse_phandle - Resolve a phandle property to a device_node point=
er
>> + * @np: Pointer to device node holding phandle property
>> + * @phandle_name: Name of property holding a phandle value
>> + * @index: For properties holding a table of phandles, this is the inde=
x into
>> + * ? ? ? ? the table
>> + *
>> + * Returns the device_node pointer pointed to by the phandle, or NULL
>> + */
>> +struct device_node *
>> +of_parse_phandle(struct device_node *np, const char *phandle_name, int =
index)
>> +{
>> + ? ? ? const phandle *phandle;
>> + ? ? ? int size;
>> +
>> + ? ? ? phandle =3D of_get_property(np, phandle_name, &size);
>> + ? ? ? if ((!phandle) || (size < sizeof(*phandle) * (index + 1)))
>> + ? ? ? ? ? ? ? return NULL;
>> +
>> + ? ? ? return of_find_node_by_phandle(phandle[index]);
>> +}
>> +EXPORT_SYMBOL(of_parse_phandle);
>> +
>> +/**
>> ?* of_parse_phandles_with_args - Find a node pointed by phandle in a lis=
t
>> ?* @np: ? ? ? ? ? ? ? ?pointer to a device tree node containing a list
>> ?* @list_name: property name that contains a list
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index 6a7efa2..7be2d10 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -77,6 +77,9 @@ extern int of_n_size_cells(struct device_node *np);
>> ?extern const struct of_device_id *of_match_node(
>> ? ? ? ?const struct of_device_id *matches, const struct device_node *nod=
e);
>> ?extern int of_modalias_node(struct device_node *node, char *modalias, i=
nt len);
>> +extern struct device_node *of_parse_phandle(struct device_node *np,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? const char *phandle_name,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? int index);
>> ?extern int of_parse_phandles_with_args(struct device_node *np,
>> ? ? ? ?const char *list_name, const char *cells_name, int index,
>> ? ? ? ?struct device_node **out_node, const void **out_args);
>>
>>
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>
>
> ------------------------------
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
> End of Linuxppc-dev Digest, Vol 55, Issue 122
> *********************************************
>
