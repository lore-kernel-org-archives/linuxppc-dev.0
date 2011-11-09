Return-Path: <afleming@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
 [209.85.161.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 21BB3B6F7B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 07:10:52 +1100 (EST)
Received: by ggnf2 with SMTP id f2so1491468ggn.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Nov 2011 12:10:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <59b050a97a9b5382918b66f2850a80c86e52f409.1320736936.git.baruch@tkos.co.il>
References: <59b050a97a9b5382918b66f2850a80c86e52f409.1320736936.git.baruch@tkos.co.il>
Date: Wed, 9 Nov 2011 14:10:49 -0600
Message-ID: <CAKWjMd5WCx8pSJiL5U_WkD6XA5dSZLgLZkvMA6sjAKNuAz7PKg@mail.gmail.com>
Subject: Re: [PATCH] net: fsl_pq_mdio: fix oops when using uninitialized mutex
From: Andy Fleming <afleming@gmail.com>
To: Baruch Siach <baruch@tkos.co.il>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Andy Fleming <afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Fix this by moving the of_mdiobus_register() call earlier.
>
> Cc: Andy Fleming <afleming@freescale.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> =A0drivers/net/ethernet/freescale/fsl_pq_mdio.c | =A0 14 +++++++-------
> =A01 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/e=
thernet/freescale/fsl_pq_mdio.c
> index 52f4e8a..e17fd2f 100644
> --- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
> +++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
> @@ -385,6 +385,13 @@ static int fsl_pq_mdio_probe(struct platform_device =
*ofdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tbiaddr =3D *prop;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 err =3D of_mdiobus_register(new_bus, np);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk (KERN_ERR "%s: Cannot register as MD=
IO bus\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_bus->na=
me);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irqs;
> + =A0 =A0 =A0 }
> +


This fix totally breaks the point of setting tbipa beforehand.
mdiobus_register will cause the bus to be scanned, and if any of the
PHYs are at the default address for tbipa, they won't be found. I have
a different fix which I will (re)submit today.


> =A0 =A0 =A0 =A0if (tbiaddr =3D=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32(tbipa, 0);


Andy
