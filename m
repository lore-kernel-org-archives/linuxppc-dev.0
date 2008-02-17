Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/3] Fix Unlikely(x) == y
From: Michael Ellerman <michael@ellerman.id.au>
To: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20080216103927.2a02352b@laptopd505.fenrus.org>
References: <47B70A61.9030306@tiscali.nl>
	<20080216092552.325e5726@laptopd505.fenrus.org>
	<20080216173315.GU8953@1wt.eu>
	<20080216094226.1e8eede1@laptopd505.fenrus.org>
	<47B72BFE.9060302@am.sony.com>
	<20080216103927.2a02352b@laptopd505.fenrus.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Bw+OjBsWfZC8CV3ijKEj"
Date: Sun, 17 Feb 2008 22:50:03 +1100
Message-Id: <1203249003.6718.24.camel@concordia>
Mime-Version: 1.0
Cc: Roel Kluin <12o3l@tiscali.nl>, lkml <linux-kernel@vger.kernel.org>,
	Willy Tarreau <w@1wt.eu>, linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Bw+OjBsWfZC8CV3ijKEj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2008-02-16 at 10:39 -0800, Arjan van de Ven wrote:
> > >> > you found a great set of bugs..
> > >> > but to be honest... I suspect it's just best to remove unlikely
> > >> > altogether for these cases; unlikely() is almost a
> > >> > go-faster-stripes thing, and if you don't know how to use it you
> > >> > shouldn't be using it... so just removing it for all wrong cases
> > >> > is actually the best thing to do imo.

Hi Arjan,

In general I agree with you that unlikely() is overused, and often in
inappropriate places.

> for mordern (last 10 years) x86 cpus... the cpu branchpredictor is better
> than the coder in general. Same for most other architectures.
>=20
> unlikely() creates bigger code as well.
>=20
> Now... we're talking about your super duper hotpath function here right?
> One where you care about 0.5 cycle speed improvement? (less on modern
> systems ;)

The first patch was to platforms/ps3 code, which runs on the Cell, in
particular the PPE ... which is not an x86 :)

eg:

[michael@schoenaich ~]$ cat branch.c
#include <stdio.h>
int main(void)
{
        int i, j;

        for (i =3D 0, j =3D 0; i < 1000000000; i++)
                if (i % 4 =3D=3D 0)
                        j++;

        printf("j =3D %d\n", j);
        return 0;
}
[michael@schoenaich ~]$ ppu-gcc -Wall -O3 -o branch branch.c
[michael@schoenaich ~]$ time ./branch
real    0m5.172s

[michael@schoenaich ~]$ cat branch.c
..
        for (i =3D 0, j =3D 0; i < 1000000000; i++)
                if (__builtin_expect(i % 4 =3D=3D 0, 0))
                        j++;
..
[michael@schoenaich ~]$ ppu-gcc -Wall -O3 -o branch branch.c
[michael@schoenaich ~]$ time ./branch
real    0m3.762s


Which looks as though unlikely() is helping. Admittedly we don't have a
lot of kernel code that looks like that, but at least unlikely is doing
what we want it to.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Bw+OjBsWfZC8CV3ijKEj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHuB9rdSjSd0sB4dIRAlc3AKCSqznNR2VGMc0CJgu09lg5TF8oPQCgvPJ9
Y9eLdFTtOKF/JB5EtEzwSGI=
=9rV7
-----END PGP SIGNATURE-----

--=-Bw+OjBsWfZC8CV3ijKEj--
