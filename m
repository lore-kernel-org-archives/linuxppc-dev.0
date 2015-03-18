Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D5EC1A0010
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 16:39:53 +1100 (AEDT)
Date: Wed, 18 Mar 2015 16:39:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCHv3] powerpc: convert relocs_check to a shell script using
 grep
Message-ID: <20150318163948.66dd48d0@canb.auug.org.au>
In-Reply-To: <20150318051940.238AC14011D@ozlabs.org>
References: <20150315220847.1ecfe174@canb.auug.org.au>
 <20150318051940.238AC14011D@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zglHxZqWO_sTp+M4sd=00j="; protocol="application/pgp-signature"
Cc: Paul Mackerras <paulus@samba.org>, David Laight <David.Laight@ACULAB.COM>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/zglHxZqWO_sTp+M4sd=00j=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, 18 Mar 2015 16:19:40 +1100 (AEDT) Michael Ellerman <mpe@ellerman.id=
.au> wrote:
>
> On Sun, 2015-15-03 at 11:08:47 UTC, Stephen Rothwell wrote:
> > This runs a bit faster and removes another use of perl from
> > the kernel build.
>=20
> It tells me:
>=20
> $ make ARCH=3Dpowerpc CROSS_COMPILE=3D -s ppc64_defconfig
> #
> # configuration written to .config
> #
> $ make ARCH=3Dpowerpc CROSS_COMPILE=3D -s -j240=20
> ...
> arch/powerpc/relocs_check.sh: objdump (objdump) is not executable
> make: *** [relocs_check] Error 1
>=20
> I suspect because:
>=20
> +if [ ! -x "$objdump" ]; then
>=20
> Doesn't search the PATH.

Rats!  Trying to be too helpful :-(

I will do another version that just drops the test.  If $objdump is not
executable, it will become obvious fairly soon.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/zglHxZqWO_sTp+M4sd=00j=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVCQ+oAAoJEMDTa8Ir7ZwVdNYP/iyWpk7ffwYZpue3QL4o9cfz
ljglMTtAew+W6FlNtuMAeNUH3Z0kolHpOLWiw2qty1/Ah3jsOTriLYyvoaXlZB26
uvAuWJVunqaZ/bfqOT41Hr7HLXx5wc0bH/tiBPP1e+JL33sPRmB+biUnt5caaGLP
VNZunri1pftdhIiA2tvvS9haT54PkolDjpmVReVE11P/bZdNMPiewnv6sVD0nlAO
fMWemiguYb3FL+TyxPc/E3zuotDXjwGDEhKMlNKBZ59rRtMGl3HlV+q/P/jNy5gK
4LToN0xBIdGz962LmEiRkRsGkX4qi7PREBRtkJfoa6Ym++O3eOYzaa2WOnjphyLy
g/lZdwRZEb1i0q7dsKL3nVLgimGHviaef5jX/2SOai8N4ztBEyVUmfRu+URiO0Pw
mExNGI89Dxp0DRAuoDTiBGDpKmr1s0v3C3cjC97DIWrcBqRctBo0gM+ZOXLhTDev
wSYFqyptMbnjfm+tFywTsXvG0iHQyKEyuBxuW90OP5n+Y6NFh2SbT0mLXBftQvj5
5r6imFX9bBucsx03/m0mzSshoPoCmjWVcgLqd+8rI1ct4+ogNo1n36sAutOg2e06
cbPNTKtjiAYj2DiIXBYenu1zrYedlqPu7CnQMHhxf+40CTH/NY6Eu0NpF7q3hmEf
C6M8lnFLVLAzJdQUb0be
=iT7j
-----END PGP SIGNATURE-----

--Sig_/zglHxZqWO_sTp+M4sd=00j=--
