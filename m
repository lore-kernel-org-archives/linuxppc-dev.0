Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id C34B9DDE1E
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 08:47:36 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] fs_enet: Don't call phy_mii_ioctl() in atomic context.
Date: Fri, 15 Feb 2008 15:47:32 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B04006942@ismail.innsys.innovsys.com>
In-Reply-To: <20080215210804.GA14468@loki.buserror.net>
References: <20080215210804.GA14468@loki.buserror.net>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Scott Wood" <scottwood@freescale.com>,
	<jgarzik@pobox.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> The lock acquisition in fs_ioctl() does not appear to actually be
> necessary, and thus is simply removed.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com> ---
> This fixes the following bug:
> http://ozlabs.org/pipermail/linuxppc-dev/2008-February/051564.html
>=20
>  drivers/net/fs_enet/fs_enet-main.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/fs_enet/fs_enet-main.c
> b/drivers/net/fs_enet/fs_enet-main.c
> index 42d94ed..af869cf 100644
> --- a/drivers/net/fs_enet/fs_enet-main.c
> +++ b/drivers/net/fs_enet/fs_enet-main.c
> @@ -946,16 +946,11 @@ static int fs_ioctl(struct net_device
> *dev, struct ifreq *rq, int cmd)
>  {
>  	struct fs_enet_private *fep =3D netdev_priv(dev);
>  	struct mii_ioctl_data *mii =3D (struct mii_ioctl_data
*)&rq->ifr_data;
> -	unsigned long flags;
> -	int rc;
>=20
>  	if (!netif_running(dev))
>  		return -EINVAL;
>=20
> -	spin_lock_irqsave(&fep->lock, flags);
> -	rc =3D phy_mii_ioctl(fep->phydev, mii, cmd);
> -	spin_unlock_irqrestore(&fep->lock, flags);
> -	return rc;
> +	return phy_mii_ioctl(fep->phydev, mii, cmd);
>  }
>=20
>  extern int fs_mii_connect(struct net_device *dev);

Acked-by: Rune Torgersen <runet@innovsys.com>

Tested it and it does indeed take care of the bug.
