Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 82157679F6
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 11:41:03 +1000 (EST)
Date: Sat, 29 Apr 2006 11:40:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [2.6.18] powerpc: kill union tce_entry
Message-Id: <20060429114056.09928ba9.sfr@canb.auug.org.au>
In-Reply-To: <20060428140835.GG5518@pb15.lixom.net>
References: <20060428140835.GG5518@pb15.lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__29_Apr_2006_11_40_56_+1000_aQK0AdtsFCgF8Mcy"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__29_Apr_2006_11_40_56_+1000_aQK0AdtsFCgF8Mcy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Apr 2006 09:08:35 -0500 Olof Johansson <olof@lixom.net> wrote:
>
> -	struct {
> -		unsigned int  tb_cacheBits :6;	/* Cache hash bits - not used */
> -		unsigned int  tb_rsvd      :6;
> -		unsigned long tb_rpn       :40;	/* Real page number */
> -		unsigned int  tb_valid     :1;	/* Tce is valid (vb only) */
> -		unsigned int  tb_allio     :1;	/* Tce is valid for all lps (vb only) */
> -		unsigned int  tb_lpindex   :8;	/* LpIndex for user of TCE (vb only) */
> -		unsigned int  tb_pciwr     :1;	/* Write allowed (pci only) */
> -		unsigned int  tb_rdwr      :1;	/* Read allowed  (pci), Write allowed (=
vb) */
> -	} te_bits;

> +#define TCE_RPN_MASK		0xfffffffffful  /* 40-bit RPN (4K pages) */
> +#define TCE_RPN_SHIFT		12
> +#define TCE_VALID		0x200		/* TCE valid */
> +#define TCE_ALLIO		0x100		/* TCE valid for all lpars */

Shouldn't the above two be 0x800 and 0x400 respectively (or is my bit
counting/ordering mucked up)?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__29_Apr_2006_11_40_56_+1000_aQK0AdtsFCgF8Mcy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEUsQoFdBgD/zoJvwRAibFAJ4zSu6UOhQtvJaeVLdwqgazwWQC9wCfRPe3
3e3dXue+QGFqdvtaQQke8fo=
=2ddf
-----END PGP SIGNATURE-----

--Signature=_Sat__29_Apr_2006_11_40_56_+1000_aQK0AdtsFCgF8Mcy--
