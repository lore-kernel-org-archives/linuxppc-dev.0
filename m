Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D3901A08E9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2015 08:49:20 +1100 (AEDT)
Date: Sat, 14 Mar 2015 08:49:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCHv2] powerpc: comvert relocs_check to a shell script using
 grep
Message-ID: <20150314084913.3af53318@canb.auug.org.au>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CAFEAE2@AcuExch.aculab.com>
References: <20150313131949.3e9d2b11@canb.auug.org.au>
 <063D6719AE5E284EB5DD2968C1650D6D1CAFEAE2@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UrutLlEfjZ_E=HI6348DSrM"; protocol="application/pgp-signature"
Cc: Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/UrutLlEfjZ_E=HI6348DSrM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Fri, 13 Mar 2015 14:18:10 +0000 David Laight <David.Laight@ACULAB.COM> w=
rote:
>
> From: Stephen Rothwell
> > This runs a bit faster and removes another use of perl from
> > the kernel build.
> ...
> > diff --git a/arch/powerpc/relocs_check.sh b/arch/powerpc/relocs_check.sh
> > new file mode 100755
> > index 000000000000..182eae9cc40d
> > --- /dev/null
> > +++ b/arch/powerpc/relocs_check.sh
> > @@ -0,0 +1,59 @@
> > +#!/bin/sh
> ...
> > +if [ ${#*} -lt 2 ]; then
> > +	echo "$0 [path to objdump] [path to vmlinux]" 1>&2
> > +	exit 1
> > +fi
> > +
> > +# Have Kbuild supply the path to objdump so we handle cross compilatio=
n.
> > +objdump=3D"$1"
> > +vmlinux=3D"$2"
>=20
> I'm not 100% sure of the requirements on /bin/sh for kernel builds.
> But ${#*} is probably not completely portable (and may not be safe
> if there are embedded spaces in the arguments).

Oops, that is just wrong :-( ${#*} is undefined in Posix but is the
same as $# in bash.  It needs to be just $#.

> Might be better to check:
> 	if [ -z "$objdump" -o -z "$vmlinux" ]
> instead.
>=20
> Or even:
> 	if [ ! -x "$objdump" -o ! -r "$vmlinux" ]

That last is a good idea as well.

I will do another version.

Thanks for catching that.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/UrutLlEfjZ_E=HI6348DSrM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVA1teAAoJEMDTa8Ir7ZwVnKsP/1/K22lJHVsZl7Xz2NB6rkCP
ISB8JFXijd1y4uvyPu9kmN7Zivv4jRV6P2yhUkNqog/fCMUOv3w5A3sIRgMnn42I
ppAeFHc/kui+OTY2Drl/IlHra4BTzvyrBNjr+C4xbjXEsbG/uVQvn9T7RjJH8DBd
hqurCRGRuzC2eb6IXyxK9vu7C+yHQMhBvhbFH19zFWieSZzDPSLYp3GYSJN4Qrly
v0GofXlG04ERlyK6Hz3PZ/uuKSS7iONwJC/OjfOWbXepEFPWsQFJOyQnwicdeZcu
kNTsBVAy4UwFk+wQ0WSHhCA62AKSyLI7+PeFq+DuiEPWlJR+a8C+ptvVWYTs1rTY
jF55rEWbqpZvA19s2LKfTGnSQJCsDoKBrygLYbwlRhpejg4Wd+k3E6JkRm6oTNvR
pfN/181chyaFIzXhuMvvH/07msvyI+3iwr1IMB3XZ3NNt5LIYXTxOvFmvLp7Z+Gk
CulB68I3XYCKu55JZO+ausFits4QGSV7rPnFahb0TQF/IOJSjPbNFAri4Mx6lF4Z
z/88WfcWudu9/OJ4++rby5w7lZdTpKafcsKQ4tXYWQZf243qhKqpuT6n5w1Mfg0Y
tOtea5AAb4RN7i63Cqx1rNOV3dXQXPQHxxuTU3h8xoZoSmTS9le/wTrqD5wRD1dH
W5NvQzdujNsjRGdCcHl1
=gIEt
-----END PGP SIGNATURE-----

--Sig_/UrutLlEfjZ_E=HI6348DSrM--
