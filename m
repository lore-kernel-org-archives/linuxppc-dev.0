Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 23AA3DDF02
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 13:10:12 +1000 (EST)
Date: Tue, 15 Jul 2008 13:10:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] leds: implement OpenFirmare GPIO LED driver
Message-Id: <20080715131004.32646dae.sfr@canb.auug.org.au>
In-Reply-To: <20080714164114.GA18784@polina.dev.rtsoft.ru>
References: <20080714164114.GA18784@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__15_Jul_2008_13_10_04_+1000_JPX3fhZjiHZlAYkg"
Cc: linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__15_Jul_2008_13_10_04_+1000_JPX3fhZjiHZlAYkg
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Mon, 14 Jul 2008 20:41:14 +0400 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> +static int __devinit of_gpio_leds_probe(struct of_device *ofdev,
> +					const struct of_device_id *match)
> +{
> +	int ret;
> +	struct of_gpio_led *led;
> +	struct device_node *np =3D ofdev->node;
> +
> +	led =3D kzalloc(sizeof(*led), GFP_KERNEL);
> +	if (!led)
> +		return -ENOMEM;
> +
> +	led->np =3D np;

You need to take a reference if you are keeping a pointer to a
device_node, so:
	led->np =3D of_node_get(np);

> +	led->cdev.name =3D of_get_property(np, "label", NULL);
> +	if (!led->cdev.name)
> +		led->cdev.name =3D ofdev->dev.bus_id;

Please use dev_name() in new code:
		led->cdev.name =3D dev_name(&ofdev->dev);

> +	led->cdev.brightness_set =3D gpio_led_set;
> +
> +	ret =3D gpio_request(led->gpio, ofdev->dev.bus_id);

dev_name() again.

> +err_get_gpio:

	of_node_put(led->np);

> +	kfree(led);
> +	return ret;
> +}
> +
> +static int __devexit of_gpio_leds_remove(struct of_device *ofdev)
> +{
> +	struct of_gpio_led *led =3D dev_get_drvdata(&ofdev->dev);
> +
> +	led_classdev_unregister(&led->cdev);
> +	cancel_work_sync(&led->work);
> +	gpio_free(led->gpio);
> +	of_node_put(led->np);

This was going to be unbalanced, but is now correct.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__15_Jul_2008_13_10_04_+1000_JPX3fhZjiHZlAYkg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh8FQ0ACgkQjjKRsyhoI8zeoQCfUMM1DNIvqwa8d/uiM3FTjuIH
EZUAoKeYYZNL2PMSiKDgHxZz877bYRTt
=HVeE
-----END PGP SIGNATURE-----

--Signature=_Tue__15_Jul_2008_13_10_04_+1000_JPX3fhZjiHZlAYkg--
