Return-Path: <laforge@gnumonks.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ganesha.gnumonks.org", Issuer "Harald Welte" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BBE792BDB0
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Oct 2004 05:50:44 +1000 (EST)
Date: Fri, 1 Oct 2004 21:31:53 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Message-ID: <20041001193153.GN27499@sunbeam.de.gnumonks.org>
References: <415D8768.8080808@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1y1tiN5hVw5cPBDe"
In-Reply-To: <415D8768.8080808@nortelnetworks.com>
Cc: netdev@oss.sgi.com, linuxppc-dev@ozlabs.org
Subject: Re: kernel crash with G5 Xserve and sungem driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--1y1tiN5hVw5cPBDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 01, 2004 at 10:35:52AM -0600, Chris Friesen wrote:
>=20
> I have patched 2.6.9-rc2 to run in 32-bit mode on the G5 Xserve.
>=20
> When I compile a kernel with the tigon driver and the sungem driver both=
=20
> built-in, the kernel crashes.  Removing the sungem driver fixes the probl=
em.

Yes, I had that too.  The Problem is that the XServe G5 actually has two
sungem MAC's in the chipset but doesn't use them (and apparently their
interrupt lines are not connected either).  Apple just doesn't put them
in their OF tree, but on the PCI they are visible.

The ethernet chips actually used and connected to the ethernet sockets
on the back side are th3.

Just don't compile (or load) the sungem driver on those boxes.

> Is there a known incompatibility between the sungem driver and the Xserve?

yes.


--=20
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Programming is like sex: One mistake and you have to support it your lifeti=
me

--1y1tiN5hVw5cPBDe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBXbCpXaXGVTD0i/8RApp7AJwKFtyJL91PowHWs4uTO6DnaNrthwCgtU9t
sJl0u37ydJljoTsEsvOrDlU=
=+Ev2
-----END PGP SIGNATURE-----

--1y1tiN5hVw5cPBDe--
