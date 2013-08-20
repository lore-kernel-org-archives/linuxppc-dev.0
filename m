Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 06F932C00D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 10:19:08 +1000 (EST)
Date: Tue, 20 Aug 2013 01:18:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <20130820001858.GF30073@sirena.org.uk>
References: <cover.1376912873.git.b42378@freescale.com>
 <ca3061d70ab8bf59afc59031fa7befcfaed26d51.1376912873.git.b42378@freescale.com>
 <5212908E.6050104@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Y18yPE/eBgOv3N1p"
In-Reply-To: <5212908E.6050104@wwwdotorg.org>
Subject: Re: [PATCH v8 2/2] ASoC: fsl: Add S/PDIF machine driver
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, festevam@gmail.com,
 s.hauer@pengutronix.de, Nicolin Chen <b42378@freescale.com>, timur@tabi.org,
 rob.herring@calxeda.com, tomasz.figa@gmail.com, p.zabel@pengutronix.de,
 R65777@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Y18yPE/eBgOv3N1p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2013 at 03:39:26PM -0600, Stephen Warren wrote:
> On 08/19/2013 06:08 AM, Nicolin Chen wrote:
> > This patch implements a device-tree-only machine driver for Freescale
> > i.MX series Soc. It works with spdif_transmitter/spdif_receiver and
> > fsl_spdif.c drivers.
>=20
> > diff --git a/Documentation/devicetree/bindings/sound/imx-audio-spdif.tx=
t b/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt

> > +Optional properties:

> > +  - spdif-transmitter : The phandle of the spdif-transmitter dummy cod=
ec
> > +  - spdif-receiver : The phandle of the spdif-receiver dummy codec

> > +* Note: At least one of these two properties should be set in the DT b=
inding.

> Those object truly don't exist in HW and only exist due to internal
> details of Linux's ASoC subsystem.

They will physically exist if they're usefully present on the board (in
the sense that they're there and can be pointed at) - there will be
either a TOSLINK optical connector or (less commonly) an electrical
connector breaking the signal out to go elsewhere though they don't have
any interaction with software usually which is more what you mean here.

> Or, to map the properties more directly to HW, perhaps name the property
> "spdif-tx-jack-exists", or even "spdif-tx-jack" and make it a phandle to
> a node that represents the actual S/PDIF connector?

S/PDIF is also sometimes used as an interconnect between devices - some
CODECs have S/PDIF I/O (more normally used as an external connector on
the box).  This is most frequently seen as a way to plumb HDMI in since
some HDMI devices seem to provide this as a legacy interconnect, though
it can get used just for regular CODECs as well.  Using this machine
driver would probably be a bit of an abuse for some applications, though
with things like the HDMI one the goal of the hardware is to be dropped
into a driver like this so perhaps it makes sense and is useful anyway.

Equally well it'd be good to get this stuff actually merged, it seems to
have been surprisingly time consuming thus far...

--Y18yPE/eBgOv3N1p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSErXvAAoJELSic+t+oim9X88P/RgAJSPGWxf7dWpbYk7mwgUT
LydNPeWrqoFFSCRuF+D1XbgXz2ProAhWg0gARpUqIgoI1HNvQ6Yb5DoLOMt4QEfg
hU0EtJHyqlBzxTe4bYKhjgFwr/AUfemZ0Kd0q0athpNd5erp+wnOfkScOHE6X4dY
bYUFT+PjIeT6voFVnp79fdTRWtniVSa2SzgvMVVu+nKpVDys+lCLnxK2Ezpy3Imv
8pcIPReFILRCpbauFDpkBKQbl3MROTUA3pji1GO39htcGrkjwGHAujZnqKGLJrRD
iNhb25caSZF+H06T+cXn/zhR+0X9mrvdR87u4z925nlsI1akm/b2cdPcyz1bvI6T
3Fgb57LFwLpOqHvy3bU5T7zqLsRxSTfSy9nYOVIIvmJvrtYfLu+XaWsSY6GQZWkw
DJwHtzGHZgRmX/bbhLAO4wNQy7ChIUKM1m7gO5XSvTfi/t2vYTnHZWiN/of+NfTc
pxgoWJkGg7oikqhgvWsGOT3YqX/DYAyh8IHuueNHwB/UmWXdhUbHDfpGo7WLu6BG
WihCCQ4kNcT70Lzrc/9Hq6rv4i+FwpYuhRte2DnXMpbEBFYnBMVrnEFxLWhuahOe
isD5weo3UJVjc24k8OU6e56d4XXmOFdnhaJwBeDVj4Kl4clLZw9ZXg/asSNtIG+6
vjTiVBWsBA8pFOC7pOZC
=FIw1
-----END PGP SIGNATURE-----

--Y18yPE/eBgOv3N1p--
