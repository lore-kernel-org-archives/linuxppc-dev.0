Return-Path: <sfr@canb.auug.org.au>
Date: Thu, 3 May 2007 11:47:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Dale Farnsworth" <dale@farnsworth.org>
Subject: Re: [PATCH 6/13] powerpc: Add arch/powerpc interrupt handler for
	mv64x60
Message-Id: <20070503114705.a8f305ec.sfr@canb.auug.org.au>
In-Reply-To: <20070502213830.GA27253@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070425235858.GH4046@mag.az.mvista.com>
	<20070502213830.GA27253@xyzzy.farnsworth.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__3_May_2007_11_47_05_+1000_RqHCTvFhy77Rb9lN"
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__3_May_2007_11_47_05_+1000_RqHCTvFhy77Rb9lN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 2 May 2007 14:38:30 -0700 "Dale Farnsworth" <dale@farnsworth.org> wrote:
>
> +DEFINE_SPINLOCK(mv64x60_lock);

Does this need to be global (it is not declared in the header file)?

> +static u32 mv64x60_cached_low_mask  = 0;
> +static u32 mv64x60_cached_high_mask = MV64X60_HIGH_GPP_GROUPS;
> +static u32 mv64x60_cached_gpp_mask  = 0;

Don't initialise things to zero, please.  If you feel it is necessary,
put the "= 0" in a comment.  But generally we know that globals are
initially zero.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__3_May_2007_11_47_05_+1000_RqHCTvFhy77Rb9lN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGOT8eFdBgD/zoJvwRAjn9AJ42713LhtEO/bF/xTRwzu9GdqER4ACfXz6y
8pzbgqcr4tU57FFVlaIk32o=
=52KE
-----END PGP SIGNATURE-----

--Signature=_Thu__3_May_2007_11_47_05_+1000_RqHCTvFhy77Rb9lN--
