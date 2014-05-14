Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 14 May 2014 13:34:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: powerpc/ppc64: Allow allmodconfig to build (finally !)
Message-ID: <20140514133434.13b66009@canb.auug.org.au>
In-Reply-To: <20140513171749.GA9440@roeck-us.net>
References: <1399874254.17624.85.camel@pasglop>
 <20140513002846.GA29753@roeck-us.net>
 <1399972601.17624.169.camel@pasglop>
 <20140513171749.GA9440@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XaWgqHPQaBXu_Gr34HarfeB"; protocol="application/pgp-signature"
Cc: linuxppc-dev@lists.ozlabs.org, Alan Modra <amodra@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/XaWgqHPQaBXu_Gr34HarfeB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Tue, 13 May 2014 10:17:49 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, May 13, 2014 at 07:16:41PM +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2014-05-12 at 17:28 -0700, Guenter Roeck wrote:
> >=20
> > > After applying this patch, I get
> > >=20
> > > arch/powerpc/kernel/exceptions-64s.S:269: Error: operand out of range
> > > (0x000000000000814c is not between 0xffffffffffff8000 and 0x000000000=
0007ffc)
> > > arch/powerpc/kernel/exceptions-64s.S:729: Error: operand out of range
> > > (0x000000000000814c is not between 0xffffffffffff8000 and 0x000000000=
0007ffc)
> > >=20
> > > with powerpc:defconfig, powerpc:allmodconfig, powerpc:cell_defconfig,=
 and
> > > powerpc:maple_defconfig.
> > >=20
> > > This is on top of v3.15-rc5. Any idea what is going on ?
> > >=20
> > > Compiler is powerpc64-poky-linux-gcc (GCC) 4.7.2 (from poky 1.4.0-1).
> >=20
> > Interesting... works with all my test configs using 4.7.3...
> >=20
> > I don't have my tree at hand right now, I'll check what that means
> > tomorrow see if I can find a workaround.
> >=20
> It works for me with gcc 4.8.2 (build from yocto 1.6.0).
>=20
> Is asking people to use gcc 4.7.3 or later acceptable ?

OK, this appears to be an assembler bug.

$ cat test.s
	.text
x:
	.pushsection	b, "a"
	beq y
	.popsection
	.=3D0x80000
y:
$ /opt/cross/gcc-4.6.3-nolibc/powerpc64-linux/bin/powerpc64-linux-as --vers=
ion
GNU assembler (GNU Binutils) 2.22
This assembler was configured for a target of `powerpc64-linux'.
$ /opt/cross/gcc-4.6.3-nolibc/powerpc64-linux/bin/powerpc64-linux-as -o tes=
t.o test.s=20
test.s: Assembler messages:
test.s:4: Error: operand out of range (0x0000000000080000 is not between 0x=
ffffffffffff8000 and 0x0000000000007ffc)
$ /opt/cross/gcc-4.8.1-nolibc/powerpc64-linux/bin/powerpc64-linux-as --vers=
ion
GNU assembler (GNU Binutils) 2.23.52.20130512
This assembler was configured for a target of `powerpc64-linux'.
$ /opt/cross/gcc-4.8.1-nolibc/powerpc64-linux/bin/powerpc64-linux-as -o tes=
t.o test.s=20
(no error)

Alan, can you shed light on when it was fixed?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/XaWgqHPQaBXu_Gr34HarfeB
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTcuRRAAoJEMDTa8Ir7ZwVH/gP/A4zQTexuIE4ctK+NCuZdj4G
Ykn97oFP7VVUftexM+YbvQr23hAOkwLT5wkHAVKqifvcT7KBoxIlBZleCDkYx6vp
vdPcp/lHlCHg34sZwOKsel+4CSqs0BrTosvRCdMNhSh/lo9roudLhXyTKmhJEloS
Ey5AD+VrckiR2YXxxpqBZtOkq4dQM2f+2xnKZXGsDyj6F/WewhSdEn51VrVieoOA
4x1OBRU0+pW42YUejt0NfNHxIIU4+W1eajBp+3ScJ5m7FQcgw7zpNqg+1aBnY/PW
iWnzmvW8jFcgVQs9aBuqJJ/rDUffwo5OYOkDZx/w8/xAw6YqswOaNbDrCINnXG+X
ww/3Vy7WK7yo1Jg5hvct68QGeotkygQgah1Rsi33RiujPOVFfXrO1zoVnGeypxOV
NXX8EGaWKJQaSx6PLR5YR3YSN4BPZqssOeU008/WgkesQHfofNNYtV4cArZ8GHTL
cbpd2glsLc84vwWyMj89oiLSlm+bR4ezScFjzt/yq/BfULOsJsl96OeVnr5BnivM
YM7T4hF3FiWvYNiD6vgCROYeU6uqiSnb35+Lm/8HxdYIi9yAa7EZfbsYqNpJf3Z/
zCfYmpLL/74miOaQJo7KUlWKNh3WB/XKHledGoGsncXMRJPiFttujiSfCOgzvZRx
efgFsfb9WN8wdQhEJj6W
=udnz
-----END PGP SIGNATURE-----

--Sig_/XaWgqHPQaBXu_Gr34HarfeB--
