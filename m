Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BF15FDDDE6
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 14:42:51 +1100 (EST)
Date: Wed, 21 Nov 2007 14:42:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] sys_indirect kernel implementation for PowerPC
Message-Id: <20071121144245.e8abf9e8.sfr@canb.auug.org.au>
In-Reply-To: <18243.41278.72798.100000@cargo.ozlabs.ibm.com>
References: <18243.41278.72798.100000@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__21_Nov_2007_14_42_45_+1100_=PMuU9ZRSOLkPlA4"
Cc: linuxppc-dev@ozlabs.org, Ulrich Drepper <drepper@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__21_Nov_2007_14_42_45_+1100_=PMuU9ZRSOLkPlA4
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Nov 2007 14:08:46 +1100 Paul Mackerras <paulus@samba.org> wrote:
>
> +#ifdef CONFIG_PPC64

Use CONFIG_COMPAT?

> +struct indirect_registers32 {
> +	unsigned int syscall_nr;
> +	unsigned int args[6];

These could (should?) be compat_ulong_t

> +++ b/include/asm-powerpc/systbl.h
> @@ -313,3 +313,4 @@ COMPAT_SYS_SPU(timerfd)
>  SYSCALL_SPU(eventfd)
>  COMPAT_SYS_SPU(sync_file_range2)
>  COMPAT_SYS(fallocate)
> +COMPAT_SYS(indirect)

Do the SPUs want this?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__21_Nov_2007_14_42_45_+1100_=PMuU9ZRSOLkPlA4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHQ6k6TgG2atn1QN8RAk1MAJ0S1omFAqujP6JTJ77NEcmu/1asggCeNqQI
hGRM/o7QLhFM/i89hXMXGxc=
=hhnL
-----END PGP SIGNATURE-----

--Signature=_Wed__21_Nov_2007_14_42_45_+1100_=PMuU9ZRSOLkPlA4--
