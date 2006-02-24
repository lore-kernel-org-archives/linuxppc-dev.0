Return-Path: <sfr@canb.auug.org.au>
Date: Fri, 24 Feb 2006 11:12:42 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] change compat shmget size arg to signed
Message-Id: <20060224111242.08f14bd9.sfr@canb.auug.org.au>
In-Reply-To: <20060223232717.GB29454@suse.de>
References: <20060224101644.548b0c24.sfr@canb.auug.org.au>
	<20060223232717.GB29454@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__24_Feb_2006_11_12_42_+1100_Rd8vr1rFTIqIEnkq"
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__24_Feb_2006_11_12_42_+1100_Rd8vr1rFTIqIEnkq
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Feb 2006 00:27:17 +0100 Olaf Hering <olh@suse.de> wrote:
>
>  On Fri, Feb 24, Stephen Rothwell wrote:
>=20
> > Does the ltp test fail on a standard kernel(where SHMMAX is 0x2000000),=
 or
> > only on a SLES kernel (where SHMMAX is ULONG_MAX)?
>=20
> It fails with SLES9 and SLES10. SLES9 has 0x2000000 as default.

So what was shm_ctlmax set to when the test was run.

I am trying to figure out why this test:

if (size < SHMMIN || size > shm_ctlmax)
                return -EINVAL;

Doesn't return -EINVAL for size =3D=3D 0xffffffff if shm_ctlmax is 0x200000=
0?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__24_Feb_2006_11_12_42_+1100_Rd8vr1rFTIqIEnkq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD/k+HFdBgD/zoJvwRAjaaAJwNOKfbhsFCVFBiLCS00TvspMPDyACfafUC
lyIWGX64U0bY0XJnx04Ntr4=
=O2Sr
-----END PGP SIGNATURE-----

--Signature=_Fri__24_Feb_2006_11_12_42_+1100_Rd8vr1rFTIqIEnkq--
