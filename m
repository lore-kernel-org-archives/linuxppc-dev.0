Return-Path: <boris.brezillon@free-electrons.com>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qlMfw4TdXzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 21:54:47 +1000 (AEST)
Date: Wed, 13 Apr 2016 13:54:44 +0200
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, Egor
 Martovetsky <egor@pasemi.com>, Olof Johansson <olof@lixom.net>, Joe Perches
 <joe@perches.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris
 <computersforpeace@gmail.com>, linuxppc-dev@lists.ozlabs.org (open
 list:LINUX FOR POWERPC PA SEMI PWRFICIENT), linux-kernel@vger.kernel.org
 (open list)
Subject: Re: [PATCH V3] mtd: nand: pasemi: switch to dev_* printing functions
Message-ID: <20160413135444.4ab83cde@bbrezillon>
In-Reply-To: <1460540885-4506-1-git-send-email-zajec5@gmail.com>
References: <1460114003-19926-1-git-send-email-zajec5@gmail.com>
 <1460540885-4506-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 13 Apr 2016 11:48:05 +0200
Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> wrote:

> It also contains some minor related changes:
> 1) Don't warn if kzalloc fails as it dumps stack on its own
> 2) Use %pR format for displaying whole resource to avoid:
> warning: format =E2=80=98%08llx=E2=80=99 expects type =E2=80=98long long =
unsigned int=E2=80=99, but argument 2 has type =E2=80=98resource_size_t=E2=
=80=99
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>

Applied with a slightly different commit message to avoid "Possible
unwrapped commit description" checkpatch warning.

Thanks,

Boris

> ---
> V3: Switch to dev_* instead of pr_*
> ---
>  drivers/mtd/nand/pasemi_nand.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/pasemi_nand.c b/drivers/mtd/nand/pasemi_nan=
d.c
> index 63fcb8c..5de7591 100644
> --- a/drivers/mtd/nand/pasemi_nand.c
> +++ b/drivers/mtd/nand/pasemi_nand.c
> @@ -92,8 +92,9 @@ int pasemi_device_ready(struct mtd_info *mtd)
> =20
>  static int pasemi_nand_probe(struct platform_device *ofdev)
>  {
> +	struct device *dev =3D &ofdev->dev;
>  	struct pci_dev *pdev;
> -	struct device_node *np =3D ofdev->dev.of_node;
> +	struct device_node *np =3D dev->of_node;
>  	struct resource res;
>  	struct nand_chip *chip;
>  	int err =3D 0;
> @@ -107,13 +108,11 @@ static int pasemi_nand_probe(struct platform_device=
 *ofdev)
>  	if (pasemi_nand_mtd)
>  		return -ENODEV;
> =20
> -	pr_debug("pasemi_nand at %pR\n", &res);
> +	dev_dbg(dev, "pasemi_nand at %pR\n", &res);
> =20
>  	/* Allocate memory for MTD device structure and private data */
>  	chip =3D kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
>  	if (!chip) {
> -		printk(KERN_WARNING
> -		       "Unable to allocate PASEMI NAND MTD device structure\n");
>  		err =3D -ENOMEM;
>  		goto out;
>  	}
> @@ -121,7 +120,7 @@ static int pasemi_nand_probe(struct platform_device *=
ofdev)
>  	pasemi_nand_mtd =3D nand_to_mtd(chip);
> =20
>  	/* Link the private data with the MTD structure */
> -	pasemi_nand_mtd->dev.parent =3D &ofdev->dev;
> +	pasemi_nand_mtd->dev.parent =3D dev;
> =20
>  	chip->IO_ADDR_R =3D of_iomap(np, 0);
>  	chip->IO_ADDR_W =3D chip->IO_ADDR_R;
> @@ -163,13 +162,13 @@ static int pasemi_nand_probe(struct platform_device=
 *ofdev)
>  	}
> =20
>  	if (mtd_device_register(pasemi_nand_mtd, NULL, 0)) {
> -		printk(KERN_ERR "pasemi_nand: Unable to register MTD device\n");
> +		dev_err(dev, "Unable to register MTD device\n");
>  		err =3D -ENODEV;
>  		goto out_lpc;
>  	}
> =20
> -	printk(KERN_INFO "PA Semi NAND flash at %08llx, control at I/O %x\n",
> -	       res.start, lpcctl);
> +	dev_info(dev, "PA Semi NAND flash at %pR, control at I/O %x\n", &res,
> +		 lpcctl);
> =20
>  	return 0;
> =20



--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
