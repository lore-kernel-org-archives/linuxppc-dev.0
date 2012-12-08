Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 784E22C0193
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Dec 2012 04:23:10 +1100 (EST)
Message-ID: <1354987359.20838.67.camel@deadeye.wl.decadent.org.uk>
Subject: Re: [PATCH] powerpc: fix wii_memory_fixups() compile error on 3.0.y
 tree
From: Ben Hutchings <ben@decadent.org.uk>
To: shuah.khan@hp.com
Date: Sat, 08 Dec 2012 17:22:39 +0000
In-Reply-To: <1354932445.7407.15.camel@lorien2>
References: <1354932445.7407.15.camel@lorien2>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-DBRuhmgtNxp0Slc7LYgb"
Mime-Version: 1.0
Cc: stable <stable@vger.kernel.org>, paulus@samba.org, shuahkhan@gmail.com,
 Greg KH <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-DBRuhmgtNxp0Slc7LYgb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-12-07 at 19:07 -0700, Shuah Khan wrote:
> Fix wii_memory_fixups() the following compile error on 3.0.y tree with=
=20
> wii_defconfig on 3.0.y tree.
>=20
>   CC      arch/powerpc/platforms/embedded6xx/wii.o
> arch/powerpc/platforms/embedded6xx/wii.c: In function =E2=80=98wii_memory=
_fixups=E2=80=99:
> arch/powerpc/platforms/embedded6xx/wii.c:88:2: error: format =E2=80=98%ll=
x=E2=80=99 expects argument of type =E2=80=98long long unsigned int=E2=80=
=99, but argument 2 has type =E2=80=98phys_addr_t=E2=80=99 [-Werror=3Dforma=
t]
> arch/powerpc/platforms/embedded6xx/wii.c:88:2: error: format =E2=80=98%ll=
x=E2=80=99 expects argument of type =E2=80=98long long unsigned int=E2=80=
=99, but argument 3 has type =E2=80=98phys_addr_t=E2=80=99 [-Werror=3Dforma=
t]
> arch/powerpc/platforms/embedded6xx/wii.c:90:2: error: format =E2=80=98%ll=
x=E2=80=99 expects argument of type =E2=80=98long long unsigned int=E2=80=
=99, but argument 2 has type =E2=80=98phys_addr_t=E2=80=99 [-Werror=3Dforma=
t]
> arch/powerpc/platforms/embedded6xx/wii.c:90:2: error: format =E2=80=98%ll=
x=E2=80=99 expects argument of type =E2=80=98long long unsigned int=E2=80=
=99, but argument 3 has type =E2=80=98phys_addr_t=E2=80=99 [-Werror=3Dforma=
t]
> cc1: all warnings being treated as errors
> make[2]: *** [arch/powerpc/platforms/embedded6xx/wii.o] Error 1
> make[1]: *** [arch/powerpc/platforms/embedded6xx] Error 2
> make: *** [arch/powerpc/platforms] Error 2
>=20
> Signed-off-by: Shuah Khan <shuah.khan@hp.com>
> CC: stable@vger.kernel.org 3.0.y
> ---
>  arch/powerpc/platforms/embedded6xx/wii.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/plat=
forms/embedded6xx/wii.c
> index 1b5dc1a..13d58dd 100644
> --- a/arch/powerpc/platforms/embedded6xx/wii.c
> +++ b/arch/powerpc/platforms/embedded6xx/wii.c
> @@ -85,9 +85,9 @@ void __init wii_memory_fixups(void)
>  	wii_hole_start =3D p[0].base + p[0].size;
>  	wii_hole_size =3D p[1].base - wii_hole_start;
> =20
> -	pr_info("MEM1: <%08llx %08llx>\n", p[0].base, p[0].size);
> +	pr_info("MEM1: <%08ulx %08ulx>\n", p[0].base, p[0].size);

"%08ulx" is the conversion specification "%08u" followed by literal
"lx".  If phys_addr_t is always defined as unsigned long or always
unsigned int for this platform then you could use "%08lx" or "%08x"
respectively.  But usually the right thing to do is to cast the
arguments of type phys_addr_t to unsigned long long (or, equivalently,
u64).

Ben.

>  	pr_info("HOLE: <%08lx %08lx>\n", wii_hole_start, wii_hole_size);
> -	pr_info("MEM2: <%08llx %08llx>\n", p[1].base, p[1].size);
> +	pr_info("MEM2: <%08ulx %08ulx>\n", p[1].base, p[1].size);
> =20
>  	p[0].size +=3D wii_hole_size + p[1].size;
> =20

--=20
Ben Hutchings
Beware of programmers who carry screwdrivers. - Leonard Brandwein

--=-DBRuhmgtNxp0Slc7LYgb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUMN3X+e/yOyVhhEJAQo3lA/+Kti27IqY4fqMGYeMNnz7Eapv1tCV5+b9
pll4F2F3TVeYqFGNU9Nlu5+6a7+xLXxHaqeae+BLlg6I00W6XRhwOchKNDLUiI/U
qTts3Ehx+i7w98CcH5fcwk7VZ8qkx3Z1/v3wwk/OgUcZwYH7QtSC5FwRWWTICyME
IvCdojgu7JHi8rU0hpiWi26dPf84eWJRoGhxlVa9Rpz7kFgwF6JdJw4j9d79WLLR
1OhngXdzs5EXDjUHCzE57qTYoPi4xp8DzDbADL7N+Oj8/V2qpjQIIy2ZF9bwnwTs
mWTfTYjKcZcfUjs6ajz2yxmNGmyvS00LSey2MRekO6eXBVovvte+UmeKGnvWz00U
jrUVR2r9LUQXh/Ks5RHVsVEisitRFY88CldT0braHCUf5qvTtjzwZPChO7b5OC4L
NKJ3UjPaEZmAaINgbuGJnAS4g/wFJWLx9rwwMRGV1FS1zNQybc/Otp1S/1AdZbll
fxXPe18EkOXpDqqPtOpRJYBFfMuHadl9CnLmKglhOEJeFUtq/qiwBUFJOZE4e9lz
D9Wtf4UHt99lxoh1EeM31pVV6xS4oVnws+GeccUTT9WTIihSgBPrvS6/8CSn6XnK
Lb4FMS20U9kjvPKjPiQOgHsnDyELcXz9sVSkuC+iXu/HXyH0mBPoWv3eq0D5Suk4
9CKyuWufvls=
=R8u4
-----END PGP SIGNATURE-----

--=-DBRuhmgtNxp0Slc7LYgb--
