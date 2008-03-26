Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 67193DE041
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 11:41:49 +1100 (EST)
Date: Wed, 26 Mar 2008 11:41:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCHv4 2.6.25] i2c: adds support for i2c bus on Freescale
	CPM1/CPM2 controllers
Message-Id: <20080326114134.495f5fe5.sfr@canb.auug.org.au>
In-Reply-To: <47E94891.6020000@scram.de>
References: <47A1C4E9.4000003@scram.de>
	<20080221130520.12b01553@hyperion.delvare>
	<47BEAF00.50106@scram.de>
	<20080223134335.0f5c7d79@hyperion.delvare>
	<47E94891.6020000@scram.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__26_Mar_2008_11_41_34_+1100_UJKxs76A9rxk8EiT"
Cc: Jean Delvare <khali@linux-fr.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
	Scott Wood <scottwood@freescale.com>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__26_Mar_2008_11_41_34_+1100_UJKxs76A9rxk8EiT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jochen,

Firstly, you should probably cc Dave Miller <davem@davemloft.net> on
anything in drivers/of as Sparc is the other user of this stuff (just in
case they are interested).

On Tue, 25 Mar 2008 19:46:41 +0100 Jochen Friedrich <jochen@scram.de> wrote:
>
> +++ b/drivers/of/i2c.c
> @@ -0,0 +1,113 @@
> +/*
> + * OF helpers for the I2C API
> + *
> + * Copyright (c) 2008 Jochen Friedrich <jochen@scram.de>
> + *
> + * Based on a previous patch from Jon Smirl <jonsmirl@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/i2c.h>
> +#include <asm/prom.h>

You should really include <linux/of.h> instead.

> +struct i2c_driver_device {
> +	char    *of_device;
> +	char    *i2c_type;
> +};
> +
> +static struct i2c_driver_device i2c_devices[] =3D {
> +	{"dallas,ds1374", "rtc-ds1374",},
                                      ^
You don't need the comma before the brace (unless you are anticipating
that struct i2c_driver_device will change.  Even then, its not a big
thing.

> +void of_register_i2c_devices(struct i2c_adapter *adap,
> +			     struct device_node *adap_node)
> +{
> +	void *result;
> +	struct device_node *node =3D NULL;
> +
> +	while ((node =3D of_get_next_child(adap_node, node))) {

	for_each_child_of_node(adap_node, node) {
And then you don't need to initialise "node" above.

> +		info.irq =3D irq_of_parse_and_map(node, 0);
> +		if (info.irq =3D=3D NO_IRQ)
> +			info.irq =3D -1;
> +
> +		if (of_find_i2c_driver(node, &info) < 0)
> +			continue;

Do you need to clean up after the irq_of_parse_and_map() above?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__26_Mar_2008_11_41_34_+1100_UJKxs76A9rxk8EiT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH6ZvITgG2atn1QN8RAoXFAJsEqqH7iZhpHvA1uXpHA/wkhKZH9ACaA7+9
W3o27184QInyS5UMNNMbrdg=
=PjN3
-----END PGP SIGNATURE-----

--Signature=_Wed__26_Mar_2008_11_41_34_+1100_UJKxs76A9rxk8EiT--
