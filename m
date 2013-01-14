Return-Path: <balbi@ti.com>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 705E62C0087
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 21:16:55 +1100 (EST)
Date: Mon, 14 Jan 2013 12:16:42 +0200
From: Felipe Balbi <balbi@ti.com>
To: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH v3 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
Message-ID: <20130114101642.GB10874@arwen.pp.htv.fi>
References: <1358158361-25550-1-git-send-email-peter.chen@freescale.com>
 <1358158361-25550-2-git-send-email-peter.chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
In-Reply-To: <1358158361-25550-2-git-send-email-peter.chen@freescale.com>
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 balbi@ti.com, kernel@pengutronix.de, shawn.guo@linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 14, 2013 at 06:12:39PM +0800, Peter Chen wrote:
> @@ -2756,22 +2753,41 @@ static int fsl_udc_otg_resume(struct device *dev)
> =20
>  	return fsl_udc_resume(NULL);
>  }
> -
>  /*----------------------------------------------------------------------=
---
>  	Register entry point for the peripheral controller driver
>  ------------------------------------------------------------------------=
--*/
> -
> +static const struct platform_device_id fsl_udc_devtype[] =3D {
> +	{
> +		.name =3D "imx-udc-mx25",
> +		.driver_data =3D IMX25_UDC,
> +	}, {
> +		.name =3D "imx-udc-mx27",
> +		.driver_data =3D IMX27_UDC,
> +	}, {
> +		.name =3D "imx-udc-mx31",
> +		.driver_data =3D IMX31_UDC,
> +	}, {
> +		.name =3D "imx-udc-mx35",
> +		.driver_data =3D IMX35_UDC,
> +	}, {
> +		.name =3D "imx-udc-mx51",
> +		.driver_data =3D IMX51_UDC,
> +	}
> +};

I wonder if your driver-data is actually needed since you can use string
comparisson to achieve the exact same outcome.

--=20
balbi

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ89sKAAoJEIaOsuA1yqRE7eEP/29W6BuqsKyQFcg4S/9d9uTe
AE9g/9/3wMusOj/N8lSTswmboMkcUCZhPDS9X7LEQmveqQ0lhvX2JsoCEZo72oQV
21B2wB4aU2kD56hj0lY4I4a3RJ8jjVl5fawJveU+MBceMlBIVfLRgPNCPatUmqi3
oXehhOJbwUkZwN/59sLwn00Iz81IIo8DVgkwxKAQYL+fEV8+Rdywm+PtIQ7rR9Ou
vPFfavMZCcMmVfINi9hkTBE8zhq0rXscKq5qj0NNGEnsgEzFVrjgOBWnlIsAOLR5
fxPkgC82ZBm9Xy/M7ABua8sLLRPXKAvXXrNZ+hEgYWZbToUv2qxN/WFO8CxMGfDv
SrJMEjvjpMxsdUAm9aUwZ0XHz8GzPWC5WMpIf2ZRtqQtXYDdjE+Jsq5i4sVICITz
0CebfuuuSvH+pWKVDhPZnZmLZ3QldWbRNMjFVjl5rv19eFn+3GYpvA6XeIVXNkmV
shrCapou9d6d+ptfBKXLcWQLUdaQ4v/JNMhJLvoRz7s+nP70LFvQER2tIBPsBBrI
S/BQHC+MyTfBlMWi+hAySmQ8l81Kb6dhJEsA5yFevDWj9gblk92gNlx7l98ZDyXr
+6ovMIKN9yQ8J/u1nHzryVcNgEf6Pfzjw7r9iV7jy6sOPjScQSf1a3g3Zxs36Orq
KOLqAzDNY89sP16cc/Kq
=kg01
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
