Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6FB89DDE05
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 09:40:23 +1100 (EST)
Date: Thu, 24 Jan 2008 09:40:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Move RapidIO support code from arch/ppc
Message-Id: <20080124094017.8afc5077.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0801230637510.4478@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0801230637510.4478@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__24_Jan_2008_09_40_17_+1100_2rKKRWOWM_LFssAZ"
Cc: linuxppc-dev@ozlabs.org, Wei.Zhang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__24_Jan_2008_09_40_17_+1100_2rKKRWOWM_LFssAZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Wed, 23 Jan 2008 06:38:29 -0600 (CST) Kumar Gala <galak@kernel.crashing.=
org> wrote:
>
> +++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
> @@ -190,6 +188,7 @@ mpc85xx_exclude_device(u_char bus, u_char devfn)
>  #endif /* CONFIG_PCI */
>=20
>  #ifdef CONFIG_RAPIDIO
> +extern void mpc85xx_rio_setup(int law_start, int law_size);

Ooops! This should be in a header file, of course.

> +++ b/arch/ppc/platforms/85xx/stx_gp3.c
> @@ -270,6 +269,7 @@ int mpc85xx_exclude_device(u_char bus, u_char devfn)
>  #endif /* CONFIG_PCI */
>=20
>  #ifdef CONFIG_RAPIDIO
> +extern void mpc85xx_rio_setup(int law_start, int law_size);

And again.

I guess this is just temporary in which case we can probably live with
it.  But do not forget to fix it up.

> +++ b/arch/ppc/platforms/85xx/tqm85xx.c
> @@ -309,6 +308,7 @@ int mpc85xx_exclude_device(u_char bus, u_char devfn)
>  #endif /* CONFIG_PCI */
>=20
>  #ifdef CONFIG_RAPIDIO
> +extern void mpc85xx_rio_setup(int law_start, int law_size);

Third time lucky?   :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__24_Jan_2008_09_40_17_+1100_2rKKRWOWM_LFssAZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHl8JVTgG2atn1QN8RApOcAJ0W6DZSKDQGaWatosyVCEmOIIT2MwCcDwYT
O/pAsESD63cieSG/5TGjOxc=
=cSO5
-----END PGP SIGNATURE-----

--Signature=_Thu__24_Jan_2008_09_40_17_+1100_2rKKRWOWM_LFssAZ--
