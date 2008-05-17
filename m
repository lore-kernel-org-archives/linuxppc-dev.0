Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0F907DDED4
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 12:55:27 +1000 (EST)
Date: Sat, 17 May 2008 12:55:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 3/3] [POWERPC] 40x/Book-E: Save/restore volatile
	exception registers
Message-Id: <20080517125517.46cd43a7.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0805161407440.6286@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0805161404410.6286@blarg.am.freescale.net>
	<Pine.LNX.4.64.0805161406100.6286@blarg.am.freescale.net>
	<Pine.LNX.4.64.0805161407440.6286@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__17_May_2008_12_55_17_+1000_/ue0NfBI_UTF9=sw"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__17_May_2008_12_55_17_+1000_/ue0NfBI_UTF9=sw
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Fri, 16 May 2008 14:08:00 -0500 (CDT) Kumar Gala <galak@kernel.crashing.=
org> wrote:
>
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -52,6 +52,15 @@
>  #include <asm/iseries/alpaca.h>
>  #endif
>=20
> +#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
> +#include "head_booke.h"
> +#endif
> +
> +#define DEFINE(sym, val) \
> +	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
> +
> +#define BLANK() asm volatile("\n->" : : )
> +

Why are these defines here? We already pick them up from kbuild.h ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__17_May_2008_12_55_17_+1000_/ue0NfBI_UTF9=sw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFILkkbTgG2atn1QN8RAigiAJ4gUjUywckiMWxXuyOmq4ZKnngFFwCfUGDA
7sZeffXYWRMoGtbDd3Itbbw=
=LSZe
-----END PGP SIGNATURE-----

--Signature=_Sat__17_May_2008_12_55_17_+1000_/ue0NfBI_UTF9=sw--
