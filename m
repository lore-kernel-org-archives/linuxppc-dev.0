Return-Path: <balbi@ti.com>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F41A51A0C10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 00:09:08 +1000 (AEST)
Date: Thu, 30 Jul 2015 09:08:29 -0500
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
Subject: Re: [PATCH v4 04/46] staging: emxx_udc: add ep capabilities support
Message-ID: <20150730140829.GA18246@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
References: <1437988616-6962-1-git-send-email-r.baldyga@samsung.com>
 <1437988616-6962-5-git-send-email-r.baldyga@samsung.com>
 <20150729152029.GB32418@saruman.tx.rr.com>
 <55B9CF1A.1070107@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
In-Reply-To: <55B9CF1A.1070107@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 30, 2015 at 09:15:38AM +0200, Robert Baldyga wrote:
> On 07/29/2015 05:20 PM, Felipe Balbi wrote:
> > On Mon, Jul 27, 2015 at 11:16:14AM +0200, Robert Baldyga wrote:
> >> Convert endpoint configuration to new capabilities model.
> >>
> >> Fixed typo in "epc-nulk" to "epc-bulk".
> >>
> >> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> >> ---
> >>  drivers/staging/emxx_udc/emxx_udc.c | 60 ++++++++++++++++++----------=
---------
> >>  1 file changed, 29 insertions(+), 31 deletions(-)
> >>
> >> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emx=
x_udc/emxx_udc.c
> >> index 3b7aa36..0d64bee 100644
> >> --- a/drivers/staging/emxx_udc/emxx_udc.c
> >> +++ b/drivers/staging/emxx_udc/emxx_udc.c
> >> @@ -3153,36 +3153,33 @@ static const struct usb_gadget_ops nbu2ss_gadg=
et_ops =3D {
> >>  	.ioctl			=3D nbu2ss_gad_ioctl,
> >>  };
> >> =20
> >> -static const char g_ep0_name[] =3D "ep0";
> >> -static const char g_ep1_name[] =3D "ep1-bulk";
> >> -static const char g_ep2_name[] =3D "ep2-bulk";
> >> -static const char g_ep3_name[] =3D "ep3in-int";
> >> -static const char g_ep4_name[] =3D "ep4-iso";
> >> -static const char g_ep5_name[] =3D "ep5-iso";
> >> -static const char g_ep6_name[] =3D "ep6-bulk";
> >> -static const char g_ep7_name[] =3D "ep7-bulk";
> >> -static const char g_ep8_name[] =3D "ep8in-int";
> >> -static const char g_ep9_name[] =3D "ep9-iso";
> >> -static const char g_epa_name[] =3D "epa-iso";
> >> -static const char g_epb_name[] =3D "epb-bulk";
> >> -static const char g_epc_name[] =3D "epc-nulk";
> >> -static const char g_epd_name[] =3D "epdin-int";
> >> -
> >> -static const char *gp_ep_name[NUM_ENDPOINTS] =3D {
> >> -	g_ep0_name,
> >> -	g_ep1_name,
> >> -	g_ep2_name,
> >> -	g_ep3_name,
> >> -	g_ep4_name,
> >> -	g_ep5_name,
> >> -	g_ep6_name,
> >> -	g_ep7_name,
> >> -	g_ep8_name,
> >> -	g_ep9_name,
> >> -	g_epa_name,
> >> -	g_epb_name,
> >> -	g_epc_name,
> >> -	g_epd_name,
> >> +static const struct {
> >> +	const char *name;
> >> +	const struct usb_ep_caps caps;
> >> +} ep_info[NUM_ENDPOINTS] =3D {
> >> +#define EP_INFO(_name, _type, _dir) \
> >> +	{ \
> >> +		.name =3D _name, \
> >> +		.caps =3D USB_EP_CAPS(USB_EP_CAPS_TYPE_ ## _type, \
> >> +				USB_EP_CAPS_DIR_ ## _dir), \
> >> +	}
> >> +
> >> +	EP_INFO("ep0",		CONTROL, ALL),
> >> +	EP_INFO("ep1-bulk",	BULK,	ALL),
> >> +	EP_INFO("ep2-bulk",	BULK,	ALL),
> >> +	EP_INFO("ep3in-int",	INT,	IN),
> >> +	EP_INFO("ep4-iso",	INT,	ALL),
> >> +	EP_INFO("ep5-iso",	ISO,	ALL),
> >> +	EP_INFO("ep6-bulk",	ISO,	ALL),
> >> +	EP_INFO("ep7-bulk",	BULK,	ALL),
> >> +	EP_INFO("ep8in-int",	INT,	IN),
> >> +	EP_INFO("ep9-iso",	ISO,	ALL),
> >> +	EP_INFO("epa-iso",	ISO,	ALL),
> >> +	EP_INFO("epb-bulk",	BULK,	ALL),
> >> +	EP_INFO("epc-bulk",	BULK,	ALL),
> >> +	EP_INFO("epdin-int",	INT,	IN),
> >=20
> > IMO, this is pointless obfuscation. It just makes it a pain to grep
> > source around. Why don't you have UDC drivers initialize the 1-bit flags
> > directly ?
> >=20
>=20
> Do you mean something like this? It just makes it a pain to scroll this
> source ;)

but it's at least easy to grep. Another option would be the following:

EP_INFO("ep0", USB_EP_CAPS(USB_EP_CAPS_TYPE_CONTROL,
			USB_EP_CAPS_DIR_ALL)),

that also helps grepping.

--=20
balbi

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVui/dAAoJEIaOsuA1yqRERbkP/RBftgX7pLkjFndHv+CP6y0W
AHsiYG674qvKKN1eQElrsZiJb/JOsGJDby95tEy737xO2GqM+2fX5B99dgWeuuvv
16HStn8nFIfEDDZGmTUJga8EtKHS2CRK6Ex5BAFa6csELbtnhhWgRYO+JnagLAZh
GOSm1FIYaA2hCL6Y+625/vqm0J7paBm9cm1/c6pQ3DRXk9q2mYkjoywWEqKAgkhX
jLxj5qRAVURlY9kE5u+HGj6uwgOtbEWt5+7Lcb7sqCIwnptPV2edxO/siuuvNW+2
gDMgRWdEPevDmj6vKddk8TAhr9QUw1LvK/NADrQQbPfdk8ADVqDfxum/VgSVJxWW
7k1CRUWqFlG9JraqUzWsZtHonANyUCOuFVpSquknbRDPyGLvfK3hgjI5jrHK3mDi
d8LeH/UBaAWjmUMIKAtVnnN1lPiz/dHDRvMlqy2Qo0F7rfnjg++E5VQnkO9oJIqO
e5CwBogipzDJjZHxODhrALerwSTK5HWaZ81xmZZRYTdTuIElsnyqZzQXSHoeGC2S
YkbEdcrkwchiIYKJmURK9Ja/52KuMv9F3KUQCFwMXnYhCYQIfrhhbprcZhiULHcs
ymXV4S/rqWYaxUcQ2aDQVfn8VM3vgM/T+tjf7418qfB20qAwuJlWVvOsBdNhFIe+
ImriM6edRakkm/UPU04x
=zkAA
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
