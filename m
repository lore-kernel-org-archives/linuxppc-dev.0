Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 00B95DDE2A
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 13:10:34 +1100 (EST)
Date: Thu, 22 Mar 2007 13:10:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: olof@lixom.net (Olof Johansson)
Subject: Re: [PATCH] Use mtocrf in asm when CONFIG_POWER4_ONLY=y
Message-Id: <20070322131041.5656df1a.sfr@canb.auug.org.au>
In-Reply-To: <20070322020925.GA13114@lixom.net>
References: <20070322020925.GA13114@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__22_Mar_2007_13_10_41_+1100_el7B+GGM4.uwhmAl"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__22_Mar_2007_13_10_41_+1100_el7B+GGM4.uwhmAl
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 21 Mar 2007 21:09:26 -0500 olof@lixom.net (Olof Johansson) wrote:
>
> +/* Move to CR, single-entry optimized version. Only available
> + * on POWER4 and later.
> + */
> +#ifdef CONFIG_POWER4_ONLY
> +#define PPC_MTOCRF      stringify_in_c(mtocrf)
                     ^^^^^^
Please use a TAB character here.

> +#else
> +#define PPC_MTOCRF      stringify_in_c(mtcrf)
                     ^^^^^^
and here.

> +#endif
> +
>  #else /* 32-bit */
>
>  /* operations for longs and pointers */
> @@ -89,6 +100,7 @@
>  #define PPC_LLARX	stringify_in_c(lwarx)
>  #define PPC_STLCX	stringify_in_c(stwcx.)
>  #define PPC_CNTLZL	stringify_in_c(cntlzw)
> +#define PPC_MTOCRF      stringify_in_c(mtcrf)
                     ^^^^^^
and here :-)

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__22_Mar_2007_13_10_41_+1100_el7B+GGM4.uwhmAl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGAeWmFdBgD/zoJvwRAuBDAJ9iy5D1164RhclqZcgaKND52i576gCgmy49
mzi+kGksnRJLSo6xzkAhtF0=
=yycY
-----END PGP SIGNATURE-----

--Signature=_Thu__22_Mar_2007_13_10_41_+1100_el7B+GGM4.uwhmAl--
