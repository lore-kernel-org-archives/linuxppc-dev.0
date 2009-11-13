Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 57BC0B6F29
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Nov 2009 04:47:25 +1100 (EST)
Received: by yxe8 with SMTP id 8so3456973yxe.17
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 09:47:23 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258128892-28800-1-git-send-email-w.sang@pengutronix.de>
References: <1258128892-28800-1-git-send-email-w.sang@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 13 Nov 2009 10:39:56 -0700
Message-ID: <fa686aa40911130939x54ac53f9x173a875a5a4435d3@mail.gmail.com>
Subject: Re: [PATCH] net/can: add driver for mscan family & mpc52xx_mscan
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 13, 2009 at 9:14 AM, Wolfram Sang <w.sang@pengutronix.de> wrote=
:
> Taken from socketcan-svn, fixed remaining todos, cleaned up, tested with =
a
> phyCORE-MPC5200B-IO and a custom board.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: David Miller <davem@davemloft.net>

I don't see any locking in this driver.  What keeps the mscan_isr or
other routines from conflicting with each other?  What is the
concurrency model for CAN devices?

More comments below.  I don't have the background to delve into the
CAN details, but I can make some comments on the general structure of
the driver.

g.

> ---
>
> +static struct of_device_id mpc52xx_cdm_ids[] __devinitdata =3D {
> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc5200-cdm", },
> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc5200b-cdm", },
> + =A0 =A0 =A0 {}
> +};

You can drop the 'b' line. The 'b' version is compatible with the
original, and all in-tree 5200b files claim compatibility with the
non-'b' version.

> +
> +/*
> + * Get the frequency of the external oscillator clock connected
> + * to the SYS_XTAL_IN pin, or return 0 if it cannot be determined.
> + */
> +static unsigned int =A0__devinit mpc52xx_can_xtal_freq(struct of_device =
*of)
> +{
> + =A0 =A0 =A0 struct mpc52xx_cdm =A0__iomem *cdm;
> + =A0 =A0 =A0 struct device_node *np_cdm;
> + =A0 =A0 =A0 unsigned int freq;
> + =A0 =A0 =A0 u32 val;
> +
> + =A0 =A0 =A0 freq =3D mpc5xxx_get_bus_frequency(of->node);
> + =A0 =A0 =A0 if (!freq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Determine SYS_XTAL_IN frequency from the clock domain =
settings
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 np_cdm =3D of_find_matching_node(NULL, mpc52xx_cdm_ids);
> + =A0 =A0 =A0 if (!np_cdm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&of->dev, "can't get clock node!\n"=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 cdm =3D of_iomap(np_cdm, 0);
> + =A0 =A0 =A0 of_node_put(np_cdm);
> +
> + =A0 =A0 =A0 if (in_8(&cdm->ipb_clk_sel) & 0x1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 freq *=3D 2;
> + =A0 =A0 =A0 val =A0=3D in_be32(&cdm->rstcfg);
> + =A0 =A0 =A0 if (val & (1 << 5))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 freq *=3D 8;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 freq *=3D 4;

freq *=3D (val & (1 << 5)) ? 8 : 4;

> + =A0 =A0 =A0 if (val & (1 << 6))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 freq /=3D 12;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 freq /=3D 16;

Ditto.

> +
> + =A0 =A0 =A0 iounmap(cdm);
> +
> + =A0 =A0 =A0 return freq;
> +}
> +
> +/*
> + * Get frequency of the MSCAN clock source
> + *
> + * Either the oscillator clock (SYS_XTAL_IN) or the IP bus clock (IP_CLK=
)
> + * can be selected. According to the MPC5200 user's manual, the oscillat=
or
> + * clock is the better choice as it has less jitter but due to a hardwar=
e
> + * bug, it can not be selected for the old MPC5200 Rev. A chips.
> + */
> +
> +static unsigned int =A0__devinit mpc52xx_can_clock_freq(struct of_device=
 *of,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int clock_src)
> +{
> + =A0 =A0 =A0 unsigned int pvr;
> +
> + =A0 =A0 =A0 pvr =3D mfspr(SPRN_PVR);
> +
> + =A0 =A0 =A0 if (clock_src =3D=3D MSCAN_CLKSRC_BUS || pvr =3D=3D 0x80822=
011)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mpc5xxx_get_bus_frequency(of->node);
> +
> + =A0 =A0 =A0 return mpc52xx_can_xtal_freq(of);
> +}

mpc52xx_can_xtal_freq() is only used by this function.  Do they need
to be separate?

> +static int __devinit mpc5xxx_can_probe(struct of_device *ofdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0const struct of_device_id *id)
> +{
> + =A0 =A0 =A0 struct device_node *np =3D ofdev->node;
> + =A0 =A0 =A0 struct net_device *dev;
> + =A0 =A0 =A0 struct mscan_priv *priv;
> + =A0 =A0 =A0 void __iomem *base;
> + =A0 =A0 =A0 const char *clk_src;
> + =A0 =A0 =A0 int err, irq, clock_src;
> +
> + =A0 =A0 =A0 base =3D of_iomap(ofdev->node, 0);
> + =A0 =A0 =A0 if (!base) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&ofdev->dev, "couldn't ioremap\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_release_mem;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 irq =3D irq_of_parse_and_map(np, 0);
> + =A0 =A0 =A0 if (!irq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&ofdev->dev, "no irq found\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_unmap_mem;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev =3D alloc_mscandev();
> + =A0 =A0 =A0 if (!dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_dispose_irq;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 priv =3D netdev_priv(dev);
> + =A0 =A0 =A0 priv->reg_base =3D base;
> + =A0 =A0 =A0 dev->irq =3D irq;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Either the oscillator clock (SYS_XTAL_IN) or the IP bu=
s clock
> + =A0 =A0 =A0 =A0* (IP_CLK) can be selected as MSCAN clock source. Accord=
ing to
> + =A0 =A0 =A0 =A0* the MPC5200 user's manual, the oscillator clock is the=
 better
> + =A0 =A0 =A0 =A0* choice as it has less jitter. For this reason, it is s=
elected
> + =A0 =A0 =A0 =A0* by default.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 clk_src =3D of_get_property(np, "fsl,mscan-clk-src", NULL);
> + =A0 =A0 =A0 if (clk_src && strcmp(clk_src, "ip") =3D=3D 0)

Should protect against non-null.  strncmp() maybe?


> +static struct of_device_id __devinitdata mpc5xxx_can_table[] =3D {
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200-mscan"},
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200b-mscan"},
> + =A0 =A0 =A0 {},
> +};

Ditto here; the 'b' version can be dropped.

> +static int mscan_set_mode(struct net_device *dev, u8 mode)
> +{
> + =A0 =A0 =A0 struct mscan_priv *priv =3D netdev_priv(dev);
> + =A0 =A0 =A0 struct mscan_regs *regs =3D (struct mscan_regs *)priv->reg_=
base;
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 u8 canctl1;
> +
> + =A0 =A0 =A0 if (mode !=3D MSCAN_NORMAL_MODE) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (priv->tx_active) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Abort transfers before g=
oing to sleep */#
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->cantarq, priv-=
>tx_active);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Suppress TX done interru=
pts */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->cantier, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 canctl1 =3D in_8(&regs->canctl1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((mode & MSCAN_SLPRQ) && (canctl1 & MSCA=
N_SLPAK) =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->canctl0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_8(&regs->can=
ctl0) | MSCAN_SLPRQ);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < MSCAN_SET=
_MODE_RETRIES; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (in_8(&r=
egs->canctl1) & MSCAN_SLPAK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(100)=
;

Ugh.  Can you sleep instead?  This burns a lot of CPU cycles to no purpose.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The mscan controller w=
ill fail to enter sleep mode,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* while there are irregu=
lar activities on bus, like
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* somebody keeps retrans=
mitting. This behavior is
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* undocumented and seems=
 to differ between mscan built
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* in mpc5200b and mpc520=
0. We proceed in that case,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* since otherwise the sl=
prq will be kept set and the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* controller will get st=
uck. NOTE: INITRQ or CSWAI
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* will abort all active =
transmit actions, if still
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* any, at once.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i >=3D MSCAN_SET_MODE_R=
ETRIES)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev=
->dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "device failed to enter sleep mode. "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "We proceed anyhow.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->can.s=
tate =3D CAN_STATE_SLEEPING;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((mode & MSCAN_INITRQ) && (canctl1 & MSC=
AN_INITAK) =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->canctl0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_8(&regs->can=
ctl0) | MSCAN_INITRQ);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < MSCAN_SET=
_MODE_RETRIES; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (in_8(&r=
egs->canctl1) & MSCAN_INITAK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i >=3D MSCAN_SET_MODE_R=
ETRIES)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EN=
ODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->can.state =3D CAN_STA=
TE_STOPPED;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mode & MSCAN_CSWAI)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->canctl0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_8(&regs->can=
ctl0) | MSCAN_CSWAI);
> +
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 canctl1 =3D in_8(&regs->canctl1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (canctl1 & (MSCAN_SLPAK | MSCAN_INITAK))=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->canctl0, in_8(=
&regs->canctl0) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~(MSCAN_SLPRQ |=
 MSCAN_INITRQ));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < MSCAN_SET=
_MODE_RETRIES; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 canctl1 =3D=
 in_8(&regs->canctl1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(canct=
l1 & (MSCAN_INITAK | MSCAN_SLPAK)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i >=3D MSCAN_SET_MODE_R=
ETRIES)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EN=
ODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->can.s=
tate =3D CAN_STATE_ERROR_ACTIVE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return ret;
> +}

[snip]

> +static int mscan_do_set_mode(struct net_device *dev, enum can_mode mode)
> +{
> +
> + =A0 =A0 =A0 struct mscan_priv *priv =3D netdev_priv(dev);
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!priv->open_time)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 switch (mode) {
> + =A0 =A0 =A0 case CAN_MODE_SLEEP:
> + =A0 =A0 =A0 case CAN_MODE_STOP:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 netif_stop_queue(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mscan_set_mode(dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(mode =3D=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CAN_MODE_ST=
OP) ? MSCAN_INIT_MODE :
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MSCAN_SLEEP_=
MODE);

A little hard on the eyes.  Can you rework to not spill over 4 lines?
(ie. calc mode flag on the line above?)

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case CAN_MODE_START:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (priv->can.state <=3D CAN_STATE_BUS_OFF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mscan_set_mode(dev, MSCAN_I=
NIT_MODE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mscan_start(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (netif_queue_stopped(dev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 netif_wake_queue(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EOPNOTSUPP;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return ret;
> +}

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
