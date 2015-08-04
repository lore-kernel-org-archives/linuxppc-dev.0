Return-Path: <balbi@ti.com>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 766961A076F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 02:10:26 +1000 (AEST)
Date: Tue, 4 Aug 2015 11:09:48 -0500
From: Felipe Balbi <balbi@ti.com>
To: Robert Baldyga <r.baldyga@samsung.com>
CC: <balbi@ti.com>, <gregkh@linuxfoundation.org>, <Peter.Chen@freescale.com>,
 <johnyoun@synopsys.com>, <dahlmann.thomas@arcor.de>,
 <nicolas.ferre@atmel.com>, <cernekee@gmail.com>, <leoli@freescale.com>,
 <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
 <robert.jarzmik@free.fr>, <michal.simek@xilinx.com>,
 <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
 <linux-usb@vger.kernel.org>, <linux-omap@vger.kernel.org>,
 <linux-geode@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
 <linuxppc-dev@lists.ozlabs.org>, <andrzej.p@samsung.com>,
 <m.szyprowski@samsung.com>, <stern@rowland.harvard.edu>, <petr.cvek@tul.cz>
Subject: Re: [PATCH v5 07/46] usb: dwc3: gadget: add ep capabilities support
Message-ID: <20150804160948.GJ23659@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
 <1438351258-31578-8-git-send-email-r.baldyga@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="YZVh52eu0Ophig4D"
In-Reply-To: <1438351258-31578-8-git-send-email-r.baldyga@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--YZVh52eu0Ophig4D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2015 at 04:00:19PM +0200, Robert Baldyga wrote:
> Convert endpoint configuration to new capabilities model.
>=20
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>  drivers/usb/dwc3/gadget.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 2feed9e..bd4c3db 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1715,6 +1715,19 @@ static int dwc3_gadget_init_hw_endpoints(struct dw=
c3 *dwc,
>  				return ret;
>  		}
> =20
> +		if (epnum =3D=3D 0 || epnum =3D=3D 1) {
> +			dep->endpoint.caps.type_control =3D true;
> +		} else {
> +			dep->endpoint.caps.type_iso =3D true;
> +			dep->endpoint.caps.type_bulk =3D true;
> +			dep->endpoint.caps.type_int =3D true;
> +		}
> +
> +		if (direction)
> +			dep->endpoint.caps.dir_in =3D true;
> +		else
> +			dep->endpoint.caps.dir_out =3D true;

you can avoid the branch for the direction:

		dep->endpoint.caps.dir_in =3D !!direction;
		dep->endpoint.caps.dir_out =3D !direction;

--=20
balbi

--YZVh52eu0Ophig4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVwOPLAAoJEIaOsuA1yqREeMsQAIPG7g/oNsMI+/wgc4MgLGj4
PRHvg9RnBfZaeh0OoXPyA+YPZPVzl9NMNhv2+Y1fs57Kxs/vGRtDZHzBWLd+8ttd
sOm5xEFxy/Y386OSe1R9B0lSv2bdQhQylXML4kLH5T9qkxMobNVKZa1Ao1OYHCBe
DHCeAa8qZqTyP3cW8sFScXKiIonDJQ0NMnYHC2Pu8YHTCWjltPEpj12Y2kA3uiKZ
dUNMyvYMqhqzmTui3s3Wvyv/2YnA3/KVz8obu2b+tfGUTXMsZ3qtGAcboq9gknd8
GwcRQ+RpVYfu5nuLhsbkD8Osw6qiWguETcsavxLxrrCh+DRfJUkVIQ/rhOdO/+hq
WMLVgRjBxp0NHbq/ftXMAdrQuNTF8b3oEyH6MXIXwVhNc3R453HqbuswaWNl1bzg
cElNL7IytQVF0ksLF2R6nBQrnHnMmdK+j1QpJZiL98ea6Z942a5ykawHhsJ2XL0M
Q5VpSfL98+4Awg9YX0fdao6R7HbyDklMEmkEb2q99wXlf8vOGQQIWN5WTPLFtmfp
+h2+Pw2Q7R+pPn0sg284eqctA0LTiOYPakzKcXMVMRhx3NuRhzzDDVydhROsg40F
kcuKLSFR/ZHGh798vqpU/22cENVimjYHIlHPvJuM53uOP8rslntxg1octhrYRToF
Eyx4MQPzIbkUZ6OlAWgL
=Zeuq
-----END PGP SIGNATURE-----

--YZVh52eu0Ophig4D--
