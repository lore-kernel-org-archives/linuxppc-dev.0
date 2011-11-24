Return-Path: <balbi@ti.com>
Received: from na3sys009aog117.obsmtp.com (na3sys009aog117.obsmtp.com
 [74.125.149.242])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4D9231007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 20:37:52 +1100 (EST)
Received: by mail-yw0-f53.google.com with SMTP id 19so1277766ywm.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 01:37:49 -0800 (PST)
Date: Thu, 24 Nov 2011 11:37:47 +0200
From: Felipe Balbi <balbi@ti.com>
To: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH] USB: fsl_udc_core: Use (&) instead of (==) to compare
 ISO XFER
Message-ID: <20111124093746.GK3352@legolas.emea.dhcp.ti.com>
References: <1321924521-3218-1-git-send-email-peter.chen@freescale.com>
 <op.v5bp28eu3l0zgt@mpn-glaptop> <op.v5bqaaw33l0zgt@mpn-glaptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="g4MvFqI7wmANiPDo"
In-Reply-To: <op.v5bqaaw33l0zgt@mpn-glaptop>
Cc: gregkh@suse.de, linux-usb@vger.kernel.org, balbi@ti.com,
 Peter Chen <peter.chen@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 stable@kernel.org
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--g4MvFqI7wmANiPDo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 22, 2011 at 02:26:24AM +0100, Michal Nazarewicz wrote:
> >On Tue, 22 Nov 2011 02:15:21 +0100, Peter Chen <peter.chen@freescale.com=
> wrote:
> >>@@ -877,7 +877,7 @@ fsl_ep_queue(struct usb_ep *_ep, struct usb_request=
 *_req, gfp_t gfp_flags)
> >> 		VDBG("%s, bad ep", __func__);
> >> 		return -EINVAL;
> >> 	}
> >>-	if (ep->desc->bmAttributes =3D=3D USB_ENDPOINT_XFER_ISOC) {
> >>+	if (ep->desc->bmAttributes & USB_ENDPOINT_XFER_ISOC) {
>=20
> On Tue, 22 Nov 2011 02:22:10 +0100, Michal Nazarewicz <mina86@mina86.com>=
 wrote:
> >What you really meant is:
> >
> >(ep->desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) =3D=3D USB_ENDPOIN=
T_XFER_ISOC
> >
> >It would probably be useful to create a function that performs that chec=
k rather
> >than having to type all of that every time.
>=20
> Ah, there it is:
>=20
> usb_endpoint_xfer_isoc(ep)

yeah, please use the helpers.

--=20
balbi

--g4MvFqI7wmANiPDo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOzhBqAAoJEIaOsuA1yqREdt0P/2xEZ8xi2U1igO6FCGLIdFDB
5ka2IgClBY6JYEYhbsYK4oCDz0lXu+nR8YZgLc0qjtDhoC1X/SL4iZh0IPHjct72
bm+XggdBGX2BnAPAIy3VlAmV+3/NwIiEwU5osBhOMZe+vaSfcE0suo8ZlwMa9t8c
oYKdEw9gWLkaXjNaGsfNtBxumJcIq3nEEDcgMKfI2SRCEYCwYeUua3114HDTXsNg
NKUxzAnL4v8aVodGFOlNhEB23x4iUrPSxaqXzabXsCdY6OpTwlKY+dDIjyVSzNSg
z41fhwzqiXjWNly8JOTyisG8zz/D/QZNXtM74n92DwIRXeJqjY/PdcpyBblsj+1B
DOjUGhDAO85hPlzCRdNyP7IgcI8bgq0EhWOUnEx9K9jyVI2alYop8hDWjhVYSQM7
UR1lWGlK37zGMCWtzB9jbSRa00stVOcEAXjx5akZTGceLDYVswW8ikJDXDu6tDjp
L/l2Q38MJfXUIBQxU6TiLDSLOvpTWE7qSOCNbxhvKNQuFkvt3G+BmsW8+5tPolCC
koiB2ol2wnRMpuUV/W8xQ+VSXiykuv65pi0Wk0xlLvmxOwEPuGT9D3j3NhB+b9G1
nSv7gAbEnc5yrttKxHm4nWJfMtXbyXlb1pmeJ8/cbU4YM6Tj4sK7zCo+OUsAdtw9
6Tfy/pgEa1Kao9x5kAJ5
=m8sY
-----END PGP SIGNATURE-----

--g4MvFqI7wmANiPDo--
