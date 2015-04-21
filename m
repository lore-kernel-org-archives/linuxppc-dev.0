Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 928331A0245
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 08:23:39 +1000 (AEST)
Date: Wed, 22 Apr 2015 08:23:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc: Disable building the 32-bit VDSO on little
 endian
Message-ID: <20150422082322.7779e6b7@canb.auug.org.au>
In-Reply-To: <1429609312-32638-2-git-send-email-mpe@ellerman.id.au>
References: <1429609312-32638-1-git-send-email-mpe@ellerman.id.au>
 <1429609312-32638-2-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8yKqhz236jwW6+J7+lsg8wF"; protocol="application/pgp-signature"
Cc: linuxppc-dev@ozlabs.org, sam.mj@au1.ibm.com,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/8yKqhz236jwW6+J7+lsg8wF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Tue, 21 Apr 2015 19:41:52 +1000 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> The only little endian configuration we support is ppc64le. As such if
> we're building little endian we don't need a 32-bit VDSO, because there
> is no 32-bit userspace.
>=20
> This patch is a fairly ugly mess of #ifdefs, but is the minimal logic
> required to disable the 32-bit VDSO. We can hopefully clean up the
> result in future with some further refactoring.
>=20
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/Makefile           |  3 ++-
>  arch/powerpc/kernel/signal_32.c        | 11 ++++++++--
>  arch/powerpc/kernel/vdso.c             | 38 ++++++++++++++++++++++++++++=
+++++-
>  arch/powerpc/perf/callchain.c          |  5 +++++
>  arch/powerpc/platforms/Kconfig.cputype | 10 +++++++++
>  5 files changed, 63 insertions(+), 4 deletions(-)

I think you could avoid the patches to signal_32.c and callchain.c by
defining vdso32{,_rt}_sigtramp to be 0 in
arch/powerpc/include/asm/vdso.h. There may be other similar fixes.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/8yKqhz236jwW6+J7+lsg8wF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVNs3pAAoJEMDTa8Ir7ZwV1wMP/jeq4Moxd6/VSndtbqtt3Z8j
oxgpMMkGK7f8cyPYiXPBQ/w9F1doIDwMV7iswBMuflrVNh58SvbkUFa8Cs3/Xd1Y
smrBdkvtL00Vwgv7Rn1d/WiOkWDzfZjK63CfAaLHgqFPiWrGePHzqoQYiW51Ukgi
W89f7n+HUhJIB6Xe8mmL3LGDRuYBh9x/LSE4tCfyPT9LC8wDHkoL4GUzLSTYDpXh
kZ0ypQmlrBBm+b5sdvj1Gqv+6zoGRwUABLE9a50Q43IB9gC+xmKcr2yPuKjnSMFq
xPcLa5kTPqmk6wfd+yJnVZW51chapVnaCEu/OdXYAFdMpovgAOP1c2Lf5oBeHRhp
4LDpm6NhJIcG472jRnj8NhMyVJuaH+rirxsrHUKJtJPraFN52CAY2yBKkVeulXu2
rZ2ZHZpzFN5VLj/DSS3fQxKslQNWbI98iMeonKKafffdDDKHSOXL1LkamnwOLcbA
C8nzvD/EgrBokM7uZmXey74elQ+dNEskdKCtgM2uAB3EljLF5jQncwdpaGT3lDAr
CKTgJGnAiHIaftEiXEzspI7a4E1EbHyfRuswpGvzf2+mxMNsWF5ZmAGUvZsWJHVR
56+zsYoj1jfDgjb5knKOxtvGVUBiKfTMzZ+3xBMeiUjbQjQrDmqyB+diNZIj10nt
onv50BB4buVmWEhpWlKt
=kzwU
-----END PGP SIGNATURE-----

--Sig_/8yKqhz236jwW6+J7+lsg8wF--
