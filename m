Return-Path: <sfr@canb.auug.org.au>
Date: Thu, 3 May 2007 12:13:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Dale Farnsworth" <dale@farnsworth.org>
Subject: Re: [PATCH 10/13] powerpc: Add arch/powerpc mv64x60 PCI setup
Message-Id: <20070503121358.aabc2755.sfr@canb.auug.org.au>
In-Reply-To: <20070502214609.GE27253@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426000107.GL4046@mag.az.mvista.com>
	<20070502214609.GE27253@xyzzy.farnsworth.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__3_May_2007_12_13_58_+1000_ZIlQLLI9sVIBQlT7"
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__3_May_2007_12_13_58_+1000_ZIlQLLI9sVIBQlT7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 2 May 2007 14:46:09 -0700 "Dale Farnsworth" <dale@farnsworth.org> wrote:
>
> +DECLARE_MUTEX(mv64x60_hs_lock);

Does this need to be global (it is not declared in a header file)?

> +	np = of_find_compatible_node(NULL, NULL, "mv64x60");
> +	if (!np)
> +		return 0;
> +
> +	pdev = platform_device_register_simple("mv64x60", 0, NULL, 0);
> +	if (IS_ERR(pdev))
> +		return PTR_ERR(pdev);

This error leaks a reference count on np.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__3_May_2007_12_13_58_+1000_ZIlQLLI9sVIBQlT7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGOUVrFdBgD/zoJvwRAiwUAJ408vwq7m2Jrh6FqV2lIe7wFrQKnwCcCcjg
NKBw7Q16tsKnbc5ipQ5k1RI=
=/mv8
-----END PGP SIGNATURE-----

--Signature=_Thu__3_May_2007_12_13_58_+1000_ZIlQLLI9sVIBQlT7--
