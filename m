Return-Path: <ldv@altlinux.org>
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 40M3Nv5D5xzF1SM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 11:34:38 +1000 (AEST)
Date: Thu, 12 Apr 2018 04:34:35 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-sparc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
Message-ID: <20180412013435.GA21219@altlinux.org>
References: <20180409152253.GD10489@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
In-Reply-To: <20180409152253.GD10489@altlinux.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 09, 2018 at 06:22:53PM +0300, Dmitry V. Levin wrote:
> There seems to be a regression in v4.16 on ppc compat very similar
> to sparc compat regression reported earlier at
> https://marc.info/?l=3Dlinux-sparc&m=3D151501500704383 .
>=20
> The symptoms are exactly the same: the same signal_receive test from
> the strace test suite fails with the same diagnostics:
> https://build.opensuse.org/public/build/home:ldv_alt/openSUSE_Factory_Pow=
erPC/ppc/strace/_log

The log is big, just look for "KERNEL BUG".

> Unfortunately, I do not have any means to investigate further,
> so just passing this information on to those who care.

OK, the faulty commit is v4.16-rc1~159^2~39
("signal/powerpc: Document conflicts with SI_USER and SIGFPE and SIGTRAP").

One might think that a commit called "Document conflicts" shouldn't
introduce an ABI regression, but this one definitely does by defining
FPE_FIXME and TRAP_FIXME in arch/powerpc/include/uapi/asm/siginfo.h
that affect siginfo_layout().

A similar commit v4.16-rc1~159^2~37
("signal/arm: Document conflicts with SI_USER and SIGFPE") must have
introduced a similar ABI regression to compat arm.

An earlier commit v4.14-rc1~60^2^2~5
("signal/sparc: Document a conflict with SI_USER with SIGFPE") introduced
a similar ABI regression to compat sparc.

There is a clear pattern of sneaking in ABI changes using innocently
looking commit messages.


--=20
ldv

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJazrerAAoJEAVFT+BVnCUIChMQAJxouuxIeyN9pi7FZQztb3Fr
hU39sGuyIpVMJ50K4dJq/3Yo+t+q+8AUWSg8sHQEqe4JzRR26dhVr8cYr6XsBftY
x6+qiWhvBGoTZbpJbBmZFrkaCWEjgTws8W9YBUzoYxLLNLCWAXrcf6UGL9kQmZqY
I7GdvUlsO6B9xFFaQOkgpqNizI7N5mI0dV+SoMdgMs0psoq0C+1vDmG6lknDzdi1
mqLffdhMisnO+mdL+ixp3keV0daIjN7liDclCX0pxBzedNm4ilc3FwSPvxpjhwsB
di6WJ9CiBjHRpl65jz9E8DVz6+FFdPf1pKCD650vPTmA7XnFOTeALaYTPUUsPovW
vXTY/3SLDgmD++vWd5PwJrkxo1I3rk0CifGcoQn4UTHXOzGHZunkETpS/PSoXFc4
AhSQVEjlMARxedt0wmTE3m13tUwttiRz4kT9vJrnd9nchYg6Bc/SwhrSxjJYyWUJ
DwsBFowrdKR9Bt67QZKaAU17hq9zPBZ3IxpnZ1ZbvTk62T8pmZQheve1YO69w0dg
gB5gLlmwKOMJ/ZS8H/fD4ro257j/gMEhfVRroCwPzKSQ+fm7h+XEHSFK7yl6DQ28
tGIOuyqGADAX7A/CS8BkuAe0WezklG5JphMiEaU4ClLxLb0Nz5avGYvY19UgtE7U
7E7ani2qtbR2nf97TPi3
=Xlro
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
