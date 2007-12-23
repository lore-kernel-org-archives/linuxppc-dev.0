Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 02CBDDDE06
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 13:33:40 +1100 (EST)
Date: Sun, 23 Dec 2007 13:33:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/3] [POWERPC][NAND] FSL UPM NAND driver
Message-Id: <20071223133329.9d2c44e4.sfr@canb.auug.org.au>
In-Reply-To: <20071221204130.GB4829@localhost.localdomain>
References: <20071221203552.GA4738@localhost.localdomain>
	<20071221204130.GB4829@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__23_Dec_2007_13_33_29_+1100_HKx1yToy+JcTKbqi"
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__23_Dec_2007_13_33_29_+1100_HKx1yToy+JcTKbqi
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Dec 2007 23:41:30 +0300 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> +static int __devinit upm_chip_probe(struct of_device *ofdev,
> +				    const struct of_device_id *ofid)
> +{
> +	struct upm_data *ud;
> +	struct resource io_res;
> +	const u32 *prop;
> +	int ret;
> +	int size;
> +
> +	ud =3D kzalloc(sizeof(*ud), GFP_KERNEL);
> +	if (!ud)
> +		return -ENOMEM;
> +
> +	ret =3D of_address_to_resource(ofdev->node, 0, &io_res);
> +	if (ret) {
> +		dev_err(&ofdev->dev, "can't get IO base\n");
> +		goto err;
> +	}
> +
> +	prop =3D of_get_property(ofdev->node, "width", &size);
> +	if (!prop || size !=3D sizeof(u32)) {
> +		dev_err(&ofdev->dev, "can't get chip width\n");
> +		goto err;

Here ret is 0, is that the correct return code?

> +	ud->rnb_gpio =3D of_get_gpio(ofdev->node, 0);
> +	if (ud->rnb_gpio >=3D 0) {
> +		ret =3D gpio_request(ud->rnb_gpio, ofdev->dev.bus_id);
> +		if (ret) {
> +			dev_err(&ofdev->dev, "can't request RNB gpio\n");
> +			goto err;
> +		}
> +		gpio_direction_input(ud->rnb_gpio);
> +	} else if (ud->rnb_gpio =3D=3D -EINVAL) {
> +		dev_err(&ofdev->dev, "specified RNB gpio is invalid\n");
> +		goto err;

Again ret is 0 here.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__23_Dec_2007_13_33_29_+1100_HKx1yToy+JcTKbqi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHbckCTgG2atn1QN8RAoJ+AJ4t6m9jO1iXvFvQdEawum24hbp0WwCfRmAH
3oo/ABZ4llN8dy3MUFzU1no=
=Vf6x
-----END PGP SIGNATURE-----

--Signature=_Sun__23_Dec_2007_13_33_29_+1100_HKx1yToy+JcTKbqi--
