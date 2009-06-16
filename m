Return-Path: <wsa@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 96280B714E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 19:04:57 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 141B8DDDA1
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 19:04:57 +1000 (EST)
Date: Tue, 16 Jun 2009 11:04:35 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] uio: add an of_genirq driver
Message-ID: <20090616090435.GA21321@pengutronix.de>
References: <1244765062-14144-1-git-send-email-w.sang@pengutronix.de>
	<1244765062-14144-3-git-send-email-w.sang@pengutronix.de>
	<fa686aa40906140740m43e9dd8am4d242310f681c95c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
In-Reply-To: <fa686aa40906140740m43e9dd8am4d242310f681c95c@mail.gmail.com>
Cc: devicetree-discuss@ozlabs.org, "Hans J. Koch" <hjk@linutronix.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Greg KH <gregkh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > diff --git a/Documentation/powerpc/dts-bindings/uio-generic.txt b/Docum=
entation/powerpc/dts-bindings/uio-generic.txt
> > new file mode 100644
> > index 0000000..8ad9861
> > --- /dev/null
> > +++ b/Documentation/powerpc/dts-bindings/uio-generic.txt
> > @@ -0,0 +1,16 @@
> > +UIO for custom devices
> > +
> > +A device which will be mapped using the UIO subsystem.
> > +
> > +Properties:
> > + - compatible : should contain the specific model used, followed by
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"generic-uio".
> > + - reg : address range(s) of the device (up to MAX_UIO_MAPS)
> > + - interrupts : interrupt of the device
> > +
> > +Example:
> > + =A0 =A0 =A0 =A0c64fpga@0 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "ptx,c64fpga001", "gene=
ric-uio";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x0 0x10000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <0 0 3>;
> > + =A0 =A0 =A0 =A0};
>=20
> Hmmm, I'm not happy about this.  The device tree describes the
> hardware, not the way Linux uses the hardware.  UIO definitely falls
> into the category of Linux implementation detail.

Yes, I am aware of that. I just started with the mechanisms which are avail=
able
today and hoped we could find some compatible-value which will suit all nee=
ds.

> This should be approached from the other way around.  Either the
> generic-uio of_platform driver should contain an explicit list of
> devices to be handled by UIO,

Well, that could lead to a quite huge match_table over time.

> or the OF infrastructure should be modified to allow things like force
> binding of_devices to of_drivers at runtime.

That is an interesting idea. I could imagine something like a 'new_compatib=
le"
entry in the sysfs-section of the driver similar to 'new_id' for PCI. After
writing a new compatible-string into it, matching will triggered again with=
 the
new entry added. That could (should?) also be placed at the of-core-level. =
Or
did you have something else in mind?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko3YCMACgkQD27XaX1/VRswtwCcDtPiiseb3Z92cZ6a+o9qGHNi
k+wAnAubWxlG7Oi6ZRW2G0NMueA8Gwsh
=0vEj
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
