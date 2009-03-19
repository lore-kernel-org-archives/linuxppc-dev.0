Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 0BDABDFDE8
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 16:06:49 +1100 (EST)
Received: by mail-gx0-f157.google.com with SMTP id 1so2588448gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 22:06:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090319050038.11320.71538.stgit@localhost.localdomain>
References: <20090319050015.11320.61641.stgit@localhost.localdomain>
	<20090319050038.11320.71538.stgit@localhost.localdomain>
Date: Wed, 18 Mar 2009 23:06:48 -0600
Message-ID: <fa686aa40903182206s583f0896v32813718da9d82cf@mail.gmail.com>
Subject: Re: [PATCH 5/9] net: make mpc5200 fec driver use of_mdio
	infrastructure
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
> The patch reworks the MPC5200 Fast Ethernet Controller (FEC) driver to
> use the of_mdio infrastructure for registering PHY devices from data out
> openfirmware device tree, and eliminates the assumption that the PHY
> for the FEC is always attached to the FEC's own MDIO bus. =A0With this
> patch, the FEC can use a PHY attached to any MDIO bus if it is described
> in the device tree.
> ---
>
> =A0drivers/net/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 =A02
> =A0drivers/net/fec_mpc52xx.c =A0 =A0 | =A0175 +++++++++++----------------=
--------------
> =A0drivers/net/fec_mpc52xx_phy.c | =A0 26 +-----
> =A03 files changed, 53 insertions(+), 150 deletions(-)
>
>
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index a2f185f..3aa24f6 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -1854,7 +1854,7 @@ config FEC_MPC52xx
>
> =A0config FEC_MPC52xx_MDIO
> =A0 =A0 =A0 =A0bool "MPC52xx FEC MDIO bus driver"
> - =A0 =A0 =A0 depends on FEC_MPC52xx
> + =A0 =A0 =A0 depends on FEC_MPC52xx && OF_MDIO
> =A0 =A0 =A0 =A0default y
> =A0 =A0 =A0 =A0---help---
> =A0 =A0 =A0 =A0 =A0The MPC5200's FEC can connect to the Ethernet either w=
ith
> diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
> index 3d55f9a..12ab8ae 100644
> --- a/drivers/net/fec_mpc52xx.c
> +++ b/drivers/net/fec_mpc52xx.c
> @@ -25,6 +25,7 @@
> =A0#include <linux/hardirq.h>
> =A0#include <linux/delay.h>
> =A0#include <linux/of_device.h>
> +#include <linux/of_mdio.h>
> =A0#include <linux/of_platform.h>
>
> =A0#include <linux/netdevice.h>
> @@ -43,11 +44,9 @@
>
> =A0#define DRIVER_NAME "mpc52xx-fec"
>
> -#define FEC5200_PHYADDR_NONE =A0 (-1)
> -#define FEC5200_PHYADDR_7WIRE =A0(-2)
> -
> =A0/* Private driver data structure */
> =A0struct mpc52xx_fec_priv {
> + =A0 =A0 =A0 struct net_device *ndev;
> =A0 =A0 =A0 =A0int duplex;
> =A0 =A0 =A0 =A0int speed;
> =A0 =A0 =A0 =A0int r_irq;
> @@ -59,10 +58,11 @@ struct mpc52xx_fec_priv {
> =A0 =A0 =A0 =A0int msg_enable;
>
> =A0 =A0 =A0 =A0/* MDIO link details */
> - =A0 =A0 =A0 int phy_addr;
> - =A0 =A0 =A0 unsigned int phy_speed;
> + =A0 =A0 =A0 unsigned int mdio_speed;
> + =A0 =A0 =A0 struct device_node *phy_node;
> =A0 =A0 =A0 =A0struct phy_device *phydev;
> =A0 =A0 =A0 =A0enum phy_state link;
> + =A0 =A0 =A0 int seven_wire_mode;
> =A0};
>
>
> @@ -210,66 +210,6 @@ static void mpc52xx_fec_adjust_link(struct net_devic=
e *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0phy_print_status(phydev);
> =A0}
>
> -static int mpc52xx_fec_init_phy(struct net_device *dev)
> -{
> - =A0 =A0 =A0 struct mpc52xx_fec_priv *priv =3D netdev_priv(dev);
> - =A0 =A0 =A0 struct phy_device *phydev;
> - =A0 =A0 =A0 char phy_id[BUS_ID_SIZE];
> -
> - =A0 =A0 =A0 snprintf(phy_id, sizeof(phy_id), "%x:%02x",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned int)dev->base_add=
r, priv->phy_addr);
> -
> - =A0 =A0 =A0 priv->link =3D PHY_DOWN;
> - =A0 =A0 =A0 priv->speed =3D 0;
> - =A0 =A0 =A0 priv->duplex =3D -1;
> -
> - =A0 =A0 =A0 phydev =3D phy_connect(dev, phy_id, &mpc52xx_fec_adjust_lin=
k, 0, PHY_INTERFACE_MODE_MII);
> - =A0 =A0 =A0 if (IS_ERR(phydev)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "phy_connect failed\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(phydev);
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 dev_info(&dev->dev, "attached phy %i to driver %s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phydev->addr, phydev->drv->=
name);
> -
> - =A0 =A0 =A0 priv->phydev =3D phydev;
> -
> - =A0 =A0 =A0 return 0;
> -}
> -
> -static int mpc52xx_fec_phy_start(struct net_device *dev)
> -{
> - =A0 =A0 =A0 struct mpc52xx_fec_priv *priv =3D netdev_priv(dev);
> - =A0 =A0 =A0 int err;
> -
> - =A0 =A0 =A0 if (priv->phy_addr < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 err =3D mpc52xx_fec_init_phy(dev);
> - =A0 =A0 =A0 if (err) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "mpc52xx_fec_init_phy fa=
iled\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 /* reset phy - this also wakes it from PDOWN */
> - =A0 =A0 =A0 phy_write(priv->phydev, MII_BMCR, BMCR_RESET);
> - =A0 =A0 =A0 phy_start(priv->phydev);
> -
> - =A0 =A0 =A0 return 0;
> -}
> -
> -static void mpc52xx_fec_phy_stop(struct net_device *dev)
> -{
> - =A0 =A0 =A0 struct mpc52xx_fec_priv *priv =3D netdev_priv(dev);
> -
> - =A0 =A0 =A0 if (!priv->phydev)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> -
> - =A0 =A0 =A0 phy_disconnect(priv->phydev);
> - =A0 =A0 =A0 /* power down phy */
> - =A0 =A0 =A0 phy_stop(priv->phydev);
> - =A0 =A0 =A0 phy_write(priv->phydev, MII_BMCR, BMCR_PDOWN);
> -}
> -
> =A0static int mpc52xx_fec_phy_mii_ioctl(struct mpc52xx_fec_priv *priv,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mii_ioctl_data *mii_data, int cmd)
> =A0{
> @@ -279,25 +219,25 @@ static int mpc52xx_fec_phy_mii_ioctl(struct mpc52xx=
_fec_priv *priv,
> =A0 =A0 =A0 =A0return phy_mii_ioctl(priv->phydev, mii_data, cmd);
> =A0}
>
> -static void mpc52xx_fec_phy_hw_init(struct mpc52xx_fec_priv *priv)
> -{
> - =A0 =A0 =A0 struct mpc52xx_fec __iomem *fec =3D priv->fec;
> -
> - =A0 =A0 =A0 if (priv->phydev)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> -
> - =A0 =A0 =A0 out_be32(&fec->mii_speed, priv->phy_speed);
> -}
> -
> =A0static int mpc52xx_fec_open(struct net_device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct mpc52xx_fec_priv *priv =3D netdev_priv(dev);
> =A0 =A0 =A0 =A0int err =3D -EBUSY;
>
> + =A0 =A0 =A0 if (priv->phy_node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->phydev =3D of_phy_connect(priv->ndev,=
 priv->phy_node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 mpc52xx_fec_adjust_link, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!priv->phydev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "of_phy_=
connect failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_start(priv->phydev);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (request_irq(dev->irq, &mpc52xx_fec_interrupt, IRQF_SHA=
RED,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DRIVER_NAME "_ctrl", dev))=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&dev->dev, "ctrl interrupt request=
 failed\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_phy;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (request_irq(priv->r_irq, &mpc52xx_fec_rx_interrupt, 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DRIVER_NAME "_rx", dev)) {
> @@ -319,10 +259,6 @@ static int mpc52xx_fec_open(struct net_device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_irqs;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 err =3D mpc52xx_fec_phy_start(dev);
> - =A0 =A0 =A0 if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_skbs;
> -
> =A0 =A0 =A0 =A0bcom_enable(priv->rx_dmatsk);
> =A0 =A0 =A0 =A0bcom_enable(priv->tx_dmatsk);
>
> @@ -332,16 +268,18 @@ static int mpc52xx_fec_open(struct net_device *dev)
>
> =A0 =A0 =A0 =A0return 0;
>
> - free_skbs:
> - =A0 =A0 =A0 mpc52xx_fec_free_rx_buffers(dev, priv->rx_dmatsk);
> -
> =A0free_irqs:
> =A0 =A0 =A0 =A0free_irq(priv->t_irq, dev);
> =A0free_2irqs:
> =A0 =A0 =A0 =A0free_irq(priv->r_irq, dev);
> =A0free_ctrl_irq:
> =A0 =A0 =A0 =A0free_irq(dev->irq, dev);
> - out:
> + free_phy:
> + =A0 =A0 =A0 if (priv->phydev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_stop(priv->phydev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_disconnect(priv->phydev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->phydev =3D NULL;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0return err;
> =A0}
> @@ -360,7 +298,12 @@ static int mpc52xx_fec_close(struct net_device *dev)
> =A0 =A0 =A0 =A0free_irq(priv->r_irq, dev);
> =A0 =A0 =A0 =A0free_irq(priv->t_irq, dev);
>
> - =A0 =A0 =A0 mpc52xx_fec_phy_stop(dev);
> + =A0 =A0 =A0 if (priv->phydev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* power down phy */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_stop(priv->phydev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_disconnect(priv->phydev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->phydev =3D NULL;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -700,7 +643,7 @@ static void mpc52xx_fec_hw_init(struct net_device *de=
v)
> =A0 =A0 =A0 =A0/* set phy speed.
> =A0 =A0 =A0 =A0 * this can't be done in phy driver, since it needs to be =
called
> =A0 =A0 =A0 =A0 * before fec stuff (even on resume) */
> - =A0 =A0 =A0 mpc52xx_fec_phy_hw_init(priv);
> + =A0 =A0 =A0 out_be32(&fec->mii_speed, priv->mdio_speed);
> =A0}
>
> =A0/**
> @@ -736,7 +679,7 @@ static void mpc52xx_fec_start(struct net_device *dev)
> =A0 =A0 =A0 =A0rcntrl =3D FEC_RX_BUFFER_SIZE << 16; =A0 =A0 =A0/* max fra=
me length */
> =A0 =A0 =A0 =A0rcntrl |=3D FEC_RCNTRL_FCE;
>
> - =A0 =A0 =A0 if (priv->phy_addr !=3D FEC5200_PHYADDR_7WIRE)
> + =A0 =A0 =A0 if (!priv->seven_wire_mode)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rcntrl |=3D FEC_RCNTRL_MII_MODE;
>
> =A0 =A0 =A0 =A0if (priv->duplex =3D=3D DUPLEX_FULL)
> @@ -802,8 +745,6 @@ static void mpc52xx_fec_stop(struct net_device *dev)
>
> =A0 =A0 =A0 =A0/* Stop FEC */
> =A0 =A0 =A0 =A0out_be32(&fec->ecntrl, in_be32(&fec->ecntrl) & ~FEC_ECNTRL=
_ETHER_EN);
> -
> - =A0 =A0 =A0 return;
> =A0}
>
> =A0/* reset fec and bestcomm tasks */
> @@ -821,9 +762,11 @@ static void mpc52xx_fec_reset(struct net_device *dev=
)
>
> =A0 =A0 =A0 =A0mpc52xx_fec_hw_init(dev);
>
> - =A0 =A0 =A0 phy_stop(priv->phydev);
> - =A0 =A0 =A0 phy_write(priv->phydev, MII_BMCR, BMCR_RESET);
> - =A0 =A0 =A0 phy_start(priv->phydev);
> + =A0 =A0 =A0 if (priv->phydev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_stop(priv->phydev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_write(priv->phydev, MII_BMCR, BMCR_RESE=
T);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_start(priv->phydev);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0bcom_fec_rx_reset(priv->rx_dmatsk);
> =A0 =A0 =A0 =A0bcom_fec_tx_reset(priv->tx_dmatsk);
> @@ -923,7 +866,6 @@ static const struct net_device_ops mpc52xx_fec_netdev=
_ops =3D {
> =A0#endif
> =A0};
>
> -
> =A0static int __devinit
> =A0mpc52xx_fec_probe(struct of_device *op, const struct of_device_id *mat=
ch)
> =A0{
> @@ -931,8 +873,6 @@ mpc52xx_fec_probe(struct of_device *op, const struct =
of_device_id *match)
> =A0 =A0 =A0 =A0struct net_device *ndev;
> =A0 =A0 =A0 =A0struct mpc52xx_fec_priv *priv =3D NULL;
> =A0 =A0 =A0 =A0struct resource mem;
> - =A0 =A0 =A0 struct device_node *phy_node;
> - =A0 =A0 =A0 const phandle *phy_handle;
> =A0 =A0 =A0 =A0const u32 *prop;
> =A0 =A0 =A0 =A0int prop_size;
>
> @@ -945,6 +885,7 @@ mpc52xx_fec_probe(struct of_device *op, const struct =
of_device_id *match)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> =A0 =A0 =A0 =A0priv =3D netdev_priv(ndev);
> + =A0 =A0 =A0 priv->ndev =3D ndev;
>
> =A0 =A0 =A0 =A0/* Reserve FEC control zone */
> =A0 =A0 =A0 =A0rv =3D of_address_to_resource(op->node, 0, &mem);
> @@ -968,6 +909,7 @@ mpc52xx_fec_probe(struct of_device *op, const struct =
of_device_id *match)
> =A0 =A0 =A0 =A0ndev->watchdog_timeo =A0 =A0=3D FEC_WATCHDOG_TIMEOUT;
> =A0 =A0 =A0 =A0ndev->base_addr =A0 =A0 =A0 =A0 =3D mem.start;
> =A0 =A0 =A0 =A0ndev->netdev_ops =3D &mpc52xx_fec_netdev_ops;
> + =A0 =A0 =A0 SET_NETDEV_DEV(ndev, &op->dev);
>
> =A0 =A0 =A0 =A0priv->t_irq =3D priv->r_irq =3D ndev->irq =3D NO_IRQ; /* I=
RQ are free for now */
>
> @@ -1017,14 +959,9 @@ mpc52xx_fec_probe(struct of_device *op, const struc=
t of_device_id *match)
> =A0 =A0 =A0 =A0 */
>
> =A0 =A0 =A0 =A0/* Start with safe defaults for link connection */
> - =A0 =A0 =A0 priv->phy_addr =3D FEC5200_PHYADDR_NONE;
> - =A0 =A0 =A0 priv->speed =3D 100;
> + =A0 =A0 =A0 priv->speed =3D 10;
> =A0 =A0 =A0 =A0priv->duplex =3D DUPLEX_HALF;
> - =A0 =A0 =A0 priv->phy_speed =3D ((mpc52xx_find_ipb_freq(op->node) >> 20=
) / 5) << 1;
> -
> - =A0 =A0 =A0 /* the 7-wire property means don't use MII mode */
> - =A0 =A0 =A0 if (of_find_property(op->node, "fsl,7-wire-mode", NULL))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->phy_addr =3D FEC5200_PHYADDR_7WIRE;
> + =A0 =A0 =A0 priv->mdio_speed =3D ((mpc52xx_find_ipb_freq(op->node) >> 2=
0) / 5) << 1;
>
> =A0 =A0 =A0 =A0/* The current speed preconfigures the speed of the MII li=
nk */
> =A0 =A0 =A0 =A0prop =3D of_get_property(op->node, "current-speed", &prop_=
size);
> @@ -1033,43 +970,23 @@ mpc52xx_fec_probe(struct of_device *op, const stru=
ct of_device_id *match)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->duplex =3D prop[1] ? DUPLEX_FULL : D=
UPLEX_HALF;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* If there is a phy handle, setup link to that phy */
> - =A0 =A0 =A0 phy_handle =3D of_get_property(op->node, "phy-handle", &pro=
p_size);
> - =A0 =A0 =A0 if (phy_handle && (prop_size >=3D sizeof(phandle))) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_node =3D of_find_node_by_phandle(*phy_h=
andle);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 prop =3D of_get_property(phy_node, "reg", &=
prop_size);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prop && (prop_size >=3D sizeof(u32)))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((*prop >=3D 0) && (*pro=
p < PHY_MAX_ADDR))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->phy_a=
ddr =3D *prop;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(phy_node);
> + =A0 =A0 =A0 /* If there is a phy handle, then get the PHY node */
> + =A0 =A0 =A0 priv->phy_node =3D of_parse_phandle(op->node, "phy-handle",=
 0);
> +
> + =A0 =A0 =A0 /* the 7-wire property means don't use MII mode */
> + =A0 =A0 =A0 if (of_find_property(op->node, "fsl,7-wire-mode", NULL)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->seven_wire_mode =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&ndev->dev, "using 7-wire PHY mode=
\n");
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Hardware init */
> =A0 =A0 =A0 =A0mpc52xx_fec_hw_init(ndev);
> -
> =A0 =A0 =A0 =A0mpc52xx_fec_reset_stats(ndev);
>
> - =A0 =A0 =A0 SET_NETDEV_DEV(ndev, &op->dev);
> -
> - =A0 =A0 =A0 /* Register the new network device */
> =A0 =A0 =A0 =A0rv =3D register_netdev(ndev);
> =A0 =A0 =A0 =A0if (rv < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto probe_error;
>
> - =A0 =A0 =A0 /* Now report the link setup */
> - =A0 =A0 =A0 switch (priv->phy_addr) {
> - =A0 =A0 =A0 =A0case FEC5200_PHYADDR_NONE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&ndev->dev, "Fixed speed MII link:=
 %i%cD\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->speed, priv->duple=
x ? 'F' : 'H');
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0case FEC5200_PHYADDR_7WIRE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&ndev->dev, "using 7-wire PHY mode=
\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0default:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&ndev->dev, "Using PHY at MDIO add=
ress %i\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->phy_addr);
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0/* We're done ! */
> =A0 =A0 =A0 =A0dev_set_drvdata(&op->dev, ndev);
>
> diff --git a/drivers/net/fec_mpc52xx_phy.c b/drivers/net/fec_mpc52xx_phy.=
c
> index dd9bfa4..fec9f24 100644
> --- a/drivers/net/fec_mpc52xx_phy.c
> +++ b/drivers/net/fec_mpc52xx_phy.c
> @@ -14,12 +14,14 @@
> =A0#include <linux/netdevice.h>
> =A0#include <linux/phy.h>
> =A0#include <linux/of_platform.h>
> +#include <linux/of_mdio.h>
> =A0#include <asm/io.h>
> =A0#include <asm/mpc52xx.h>
> =A0#include "fec_mpc52xx.h"
>
> =A0struct mpc52xx_fec_mdio_priv {
> =A0 =A0 =A0 =A0struct mpc52xx_fec __iomem *regs;
> + =A0 =A0 =A0 int mdio_irqs[PHY_MAX_ADDR];
> =A0};
>
> =A0static int mpc52xx_fec_mdio_transfer(struct mii_bus *bus, int phy_id,
> @@ -27,7 +29,7 @@ static int mpc52xx_fec_mdio_transfer(struct mii_bus *bu=
s, int phy_id,
> =A0{
> =A0 =A0 =A0 =A0struct mpc52xx_fec_mdio_priv *priv =3D bus->priv;
> =A0 =A0 =A0 =A0struct mpc52xx_fec __iomem *fec;
> - =A0 =A0 =A0 int tries =3D 100;
> + =A0 =A0 =A0 int tries =3D 3;
>
> =A0 =A0 =A0 =A0value |=3D (phy_id << FEC_MII_DATA_PA_SHIFT) & FEC_MII_DAT=
A_PA_MSK;
> =A0 =A0 =A0 =A0value |=3D (reg << FEC_MII_DATA_RA_SHIFT) & FEC_MII_DATA_R=
A_MSK;
> @@ -38,7 +40,7 @@ static int mpc52xx_fec_mdio_transfer(struct mii_bus *bu=
s, int phy_id,
>
> =A0 =A0 =A0 =A0/* wait for it to finish, this takes about 23 us on lite52=
00b */
> =A0 =A0 =A0 =A0while (!(in_be32(&fec->ievent) & FEC_IEVENT_MII) && --trie=
s)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(5);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(1);
>
> =A0 =A0 =A0 =A0if (!tries)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ETIMEDOUT;
> @@ -64,7 +66,6 @@ static int mpc52xx_fec_mdio_probe(struct of_device *of,
> =A0{
> =A0 =A0 =A0 =A0struct device *dev =3D &of->dev;
> =A0 =A0 =A0 =A0struct device_node *np =3D of->node;
> - =A0 =A0 =A0 struct device_node *child =3D NULL;
> =A0 =A0 =A0 =A0struct mii_bus *bus;
> =A0 =A0 =A0 =A0struct mpc52xx_fec_mdio_priv *priv;
> =A0 =A0 =A0 =A0struct resource res =3D {};
> @@ -85,22 +86,7 @@ static int mpc52xx_fec_mdio_probe(struct of_device *of=
,
> =A0 =A0 =A0 =A0bus->write =3D mpc52xx_fec_mdio_write;
>
> =A0 =A0 =A0 =A0/* setup irqs */
> - =A0 =A0 =A0 bus->irq =3D kmalloc(sizeof(bus->irq[0]) * PHY_MAX_ADDR, GF=
P_KERNEL);
> - =A0 =A0 =A0 if (bus->irq =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_free;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 for (i=3D0; i<PHY_MAX_ADDR; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->irq[i] =3D PHY_POLL;
> -
> - =A0 =A0 =A0 while ((child =3D of_get_next_child(np, child)) !=3D NULL) =
{
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int irq =3D irq_of_parse_and_map(child, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irq !=3D NO_IRQ) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u32 *id =3D of_get_pr=
operty(child, "reg", NULL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (id)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->irq[*i=
d] =3D irq;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 bus->irq =3D priv->mdio_irqs;
>
> =A0 =A0 =A0 =A0/* setup registers */
> =A0 =A0 =A0 =A0err =3D of_address_to_resource(np, 0, &res);
> @@ -122,7 +108,7 @@ static int mpc52xx_fec_mdio_probe(struct of_device *o=
f,
> =A0 =A0 =A0 =A0out_be32(&priv->regs->mii_speed,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((mpc52xx_find_ipb_freq(of->node) >> 20) /=
 5) << 1);
>
> - =A0 =A0 =A0 err =3D mdiobus_register(bus);
> + =A0 =A0 =A0 err =3D of_mdiobus_register(bus, np);
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_unmap;
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
