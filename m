Return-Path: <thierry.reding@gmail.com>
Received: from mail-bk0-x232.google.com (mail-bk0-x232.google.com
 [IPv6:2a00:1450:4008:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ABF422C0143
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 05:46:13 +1000 (EST)
Received: by mail-bk0-f50.google.com with SMTP id mz11so1638489bkb.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 12:46:07 -0700 (PDT)
Date: Mon, 19 Aug 2013 21:46:04 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH RESEND] i2c: move of helpers into the core
Message-ID: <20130819194603.GC4961@mithrandir>
References: <1376918361-7014-1-git-send-email-wsa@the-dreams.de>
 <1376935183-11218-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
In-Reply-To: <1376935183-11218-1-git-send-email-wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com,
 linux-samsung-soc@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2013 at 07:59:40PM +0200, Wolfram Sang wrote:
[...]
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
[...]
> +#if IS_ENABLED(CONFIG_OF)
> +static void of_i2c_register_devices(struct i2c_adapter *adap)
> +{
[...]
> +}
[...]
> +#endif /* CONFIG_OF */

Isn't this missing the dummy implementation for !OF.

>  static int i2c_do_add_adapter(struct i2c_driver *driver,
>  			      struct i2c_adapter *adap)
>  {
> @@ -1058,6 +1160,8 @@ static int i2c_register_adapter(struct i2c_adapter =
*adap)
> =20
>  exit_recovery:
>  	/* create pre-declared device nodes */
> +	of_i2c_register_devices(adap);

Alternatively you could remove the of_i2c_register_devices() from the
"#ifdef CONFIG_OF" block so that it will always be compiled. You could
turn the above into

	if (IS_ENABLED(CONFIG_OF))
		of_i2c_register_devices(adap);

and let the compiler throw the static function away if it sees that the
condition is always false.

Thierry

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSEnX7AAoJEN0jrNd/PrOhtxEP/2Ulur33dk711CAHb3j6OaCw
JZ633M09rA84w4ngGfFM/2IfZFUBeqoyQ7wDnrtW7N89A+COpTqCAOpqo1LQ4WdU
aehQXm1JyGXPiKb9hvgNXfL9Xz5U1VALvivFJs4kroXVIUlceGmoBZ/ywXYp8SH3
0C9ClEkxCyvzaIBVmuwDVYZrr42pQduXnbTa/AwwIDlYcUfhELm8a3vfxteP3d9d
pjrqsxmhTgGHoVp2EvGKXacaf2ISiwMe/FUK1dSrbRf69TU9KTVnUh8eIPlBCJ8s
bjolz/LfRakgSmQpnzru+3apNnpkPOqApQhWd15E2o2ZUM0XRQx1ratt+meZEbbZ
GWZj4jPeXWSDWkxtQwFgtPlltyMzJ11AvMxpgs93hjNmdDsjH5uPbrC5Cvz2S2MC
UB5QOBMRb+DcdQhb72cg4GSiSv08loIFwRQb3lPuDQe2CzbcinHvTUANlzQXKmnF
R8ZZ2UL1akR3zULh7CmzvQzNHplLOuS4T/J1gu9V7EhOJs2I7xWcoHqCVsqhfIk7
MGSyYf7te7elOJKNomD/v22ojmbcmPapAf1yn1GBr74mk2t8SdH/QszRMem27oh5
iL1yw/CIktcr6/EhOlQjIePBum4yQNAxnbtfbFc9ZBkLpR9YsDOw/CE7gEDQargW
H56h2el3+6kiSlao+UmT
=ukb7
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
