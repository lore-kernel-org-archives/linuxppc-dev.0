Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A49B7DDF44
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Jan 2009 23:12:08 +1100 (EST)
Date: Sun, 4 Jan 2009 23:12:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] 2.6.28-git4 - powerpc - drivers build fails with
	!CONFIG_VIOPATH
Message-Id: <20090104231202.239c824a.sfr@canb.auug.org.au>
In-Reply-To: <5414eaef99b7392a95f6e3488b81dbf7@bga.com>
References: <5414eaef99b7392a95f6e3488b81dbf7@bga.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__4_Jan_2009_23_12_02_+1100_sS0_ddx+6veNp2Sv"
Cc: linux-ppc <linuxppc-dev@ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__4_Jan_2009_23_12_02_+1100_sS0_ddx+6veNp2Sv
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Milton,

On Sun, 4 Jan 2009 02:54:15 -0600 Milton Miller <miltonm@bga.com> wrote:
>
> As VIOPATH is iSeries code and is only used by the iSeries code, the=20
> requirment should be
>=20
> depends on PPC_PSERIES || (PPC_ISERIES && VIOPATH)
>=20
> except VIOPATH isn't selectable:
>=20
> arch/powerpc/platforms/iseries/Kconfig:
>=20
>   config VIOPATH
>          bool
>          depends on VIODASD || VIOCD || VIOTAPE || ISERIES_VETH
>          default y
>=20
> so instead we should be adding
>=20
> select VIOPATH if PPC_ISERIES
>=20
> to SCSI_IBMVSCSI and just
>=20
> select VIOPATH
>=20
> to HVC_ISERIES as it depends on PPC_ISERIES
>=20
> otherwise you have to enable one driver to get these other drivers.

You are completely correct.  We didn't have "select" when those drivers
were added (at least I was not aware of it) so they should all be changed
to select VIOPATH and the dependency in VIOPATH should be dropped.  This so=
rt of thing is exactly what select is for.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__4_Jan_2009_23_12_02_+1100_sS0_ddx+6veNp2Sv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklgp5IACgkQjjKRsyhoI8w07QCgvfGCyOEUTdDPbJYB02ZJfKHi
yM8AmwR2ghlGqAbHtPL62M+89F9+DB0R
=kgnN
-----END PGP SIGNATURE-----

--Signature=_Sun__4_Jan_2009_23_12_02_+1100_sS0_ddx+6veNp2Sv--
