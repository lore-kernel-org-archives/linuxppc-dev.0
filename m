Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 77EFEDE240
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 16:37:10 +1100 (EST)
Date: Wed, 7 Jan 2009 16:36:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/cell: fix the prototype of create_vma_map
Message-Id: <20090107163657.4feddae0.sfr@canb.auug.org.au>
In-Reply-To: <1231299299.14860.58.camel@pasglop>
References: <20090107105822.221c4395.sfr@canb.auug.org.au>
	<1231299299.14860.58.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__7_Jan_2009_16_36_57_+1100_2bOzgx+uOOUKLk1o"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__7_Jan_2009_16_36_57_+1100_2bOzgx+uOOUKLk1o
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 07 Jan 2009 14:34:59 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> On Wed, 2009-01-07 at 10:58 +1100, Stephen Rothwell wrote:
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  arch/powerpc/oprofile/cell/pr_util.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> Arnd, I'm not too sure about this one, what do you think ? Shouldn't the
> objectid be a u64 and the callers be fixed instead ?

The *one* caller passes an "unsigned long" and in the function, objectid
(which is called __spu_elf_start there) is only cast to a "void __user *".
Don't we assume that all pointers (kernel and user) can fit into an
"unsigned long"?

Also the value originally comes from a notifier callback
(spu_active_notify) which is passed this value as an "unsigned long".

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__7_Jan_2009_16_36_57_+1100_2bOzgx+uOOUKLk1o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklkP3kACgkQjjKRsyhoI8xY2QCfQbqFjvAt/Xw/baQs1EQO7IdN
gowAn1FPztl2qEm0G1lO/TPC0XzjDP1i
=WO3w
-----END PGP SIGNATURE-----

--Signature=_Wed__7_Jan_2009_16_36_57_+1100_2bOzgx+uOOUKLk1o--
