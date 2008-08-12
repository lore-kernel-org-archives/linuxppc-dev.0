Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 86C97DDE20
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 16:44:02 +1000 (EST)
Date: Tue, 12 Aug 2008 16:43:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 1/3] add support for exporting symbols from .S files
Message-Id: <20080812164352.ddcf1ef5.sfr@canb.auug.org.au>
In-Reply-To: <200808111618.08206.arnd@arndb.de>
References: <200808111606.44103.arnd@arndb.de>
	<200808111618.08206.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__12_Aug_2008_16_43_52_+1000_D8CMr=yIctHD7/_o"
Cc: linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Russell <rusty@rustcorp.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>, David,
	linuxppc-dev@ozlabs.org, Rusty, Al Viro <viro@zeniv.linux.org.uk>,
	Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__12_Aug_2008_16_43_52_+1000_D8CMr=yIctHD7/_o
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Mon, 11 Aug 2008 16:18:07 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> +#ifdef CONFIG_MODULES
> +.macro __EXPORT_SYMBOL sym section symtab strtab
> +	.section \section,"a",@progbits
> +	.type \symtab, @object
> +	.ifeq BITS_PER_LONG-32
> +	.align 3
> +\symtab:
> +	.long \sym
> +	.long \strtab
> +	.else
> +	.align 4

This won't be portable across architectures as .align is sometimes in
bytes and sometimes a power of two.  You can use .balign or .p2align
portably on gas, though.=20

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__12_Aug_2008_16_43_52_+1000_D8CMr=yIctHD7/_o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkihMSgACgkQjjKRsyhoI8z1NgCdE+5N8sLRvEyit8oSyDlvgFDC
A1QAoLW3fr0aR/zWgq/v5nbXOSHaCWv4
=jmEu
-----END PGP SIGNATURE-----

--Signature=_Tue__12_Aug_2008_16_43_52_+1000_D8CMr=yIctHD7/_o--
