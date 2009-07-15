Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DE3E6B7B3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jul 2009 03:19:22 +1000 (EST)
Received: from mail-yx0-f199.google.com (mail-yx0-f199.google.com
	[209.85.210.199]) by ozlabs.org (Postfix) with ESMTP id F1DA7DDDA2
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 03:19:21 +1000 (EST)
Received: by yxe37 with SMTP id 37so6271424yxe.17
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jul 2009 10:19:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1247671133-12148-2-git-send-email-wd@denx.de>
References: <1247578966-9847-1-git-send-email-wd@denx.de>
	<1247671133-12148-2-git-send-email-wd@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 15 Jul 2009 11:18:59 -0600
Message-ID: <fa686aa40907151018n194a154cmb8549c98c673d2bb@mail.gmail.com>
Subject: Re: [PATCH 2/2] MPC52xx FEC: be more conservative when setting
	MII_SPEED register
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 15, 2009 at 9:18 AM, Wolfgang Denk<wd@denx.de> wrote:
> This patch adds error checking and prevents clobbering unrelated bits
> (reserved bits or the DIS_PREAMBLE bit) when writing the MII_SPEED
> register on MPC52xx systems.
>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: <netdev@vger.kernel.org>

As I mentioned in the other patch, I don't want the 5121 and 5200 FEC
devices using common code for this.  It is a tiny block of code and
they are different devices.  Just open code the needed calculation
into this driver.

g.

> ---
> =A0drivers/net/fec_mpc52xx.c =A0 =A0 | =A0 =A02 +-
> =A0drivers/net/fec_mpc52xx_phy.c | =A0 =A06 ++++--
> =A02 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
> index cc78633..b69d440 100644
> --- a/drivers/net/fec_mpc52xx.c
> +++ b/drivers/net/fec_mpc52xx.c
> @@ -639,7 +639,7 @@ static void mpc52xx_fec_hw_init(struct net_device *de=
v)
> =A0 =A0 =A0 =A0/* set phy speed.
> =A0 =A0 =A0 =A0 * this can't be done in phy driver, since it needs to be =
called
> =A0 =A0 =A0 =A0 * before fec stuff (even on resume) */
> - =A0 =A0 =A0 out_be32(&fec->mii_speed, priv->mdio_speed);
> + =A0 =A0 =A0 clrsetbits_be32(&fec->mii_speed, 0x7E, priv->mdio_speed);
> =A0}
>
> =A0/**
> diff --git a/drivers/net/fec_mpc52xx_phy.c b/drivers/net/fec_mpc52xx_phy.=
c
> index 31e6d62..f733d43 100644
> --- a/drivers/net/fec_mpc52xx_phy.c
> +++ b/drivers/net/fec_mpc52xx_phy.c
> @@ -105,8 +105,10 @@ static int mpc52xx_fec_mdio_probe(struct of_device *=
of,
> =A0 =A0 =A0 =A0dev_set_drvdata(dev, bus);
>
> =A0 =A0 =A0 =A0/* set MII speed */
> - =A0 =A0 =A0 out_be32(&priv->regs->mii_speed,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((mpc5xxx_get_bus_frequency(of->node) >> 20=
) / 5) << 1);
> + =A0 =A0 =A0 i =3D mpc5xxx_get_mii_speed(of);
> + =A0 =A0 =A0 if (i<0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_unmap;
> + =A0 =A0 =A0 clrsetbits_be32(&priv->regs->mii_speed, 0x7E, i);
>
> =A0 =A0 =A0 =A0err =3D of_mdiobus_register(bus, np);
> =A0 =A0 =A0 =A0if (err)
> --
> 1.6.0.6
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
