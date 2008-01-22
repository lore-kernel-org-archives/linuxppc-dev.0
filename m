Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E9A7ADDE1A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 10:11:34 +1100 (EST)
Date: Wed, 23 Jan 2008 10:11:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: [PATCH] [POWERPC]: constify function pointer tables
Message-Id: <20080123101118.fcb2136b.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0801222042360.5722@fbirervta.pbzchgretzou.qr>
References: <54038cd4f87a03884e4f59f8f3697889dfb63c54.1201030614.git.jengelh@computergmbh.de>
	<Pine.LNX.4.64.0801222042360.5722@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__23_Jan_2008_10_11_18_+1100_1vURmLZq4+bae4TD"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__23_Jan_2008_10_11_18_+1100_1vURmLZq4+bae4TD
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Good idea ... but ...

On Tue, 22 Jan 2008 20:43:09 +0100 (CET) Jan Engelhardt <jengelh@computergm=
bh.de> wrote:
>
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/set=
up-common.c
> index 2de00f8..57d4f28 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -296,7 +296,7 @@ static void c_stop(struct seq_file *m, void *v)
>  {
>  }
> =20
> -struct seq_operations cpuinfo_op =3D {
> +const struct seq_operations cpuinfo_op =3D {

This is declared non const in fs/proc/proc_misc.c (one of the reasons why
it should be decalred in a header file ...)

The others look good, though.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__23_Jan_2008_10_11_18_+1100_1vURmLZq4+bae4TD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHlngjTgG2atn1QN8RApPEAJ4wxQD+BeKGt/R1vMRvzajrwCguJQCeIn3X
9JxPM+zUmOmdBl4jI3xBcXs=
=st+D
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Jan_2008_10_11_18_+1100_1vURmLZq4+bae4TD--
