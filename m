Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 9A9D1B6F18
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Apr 2011 16:35:59 +1000 (EST)
Date: Mon, 11 Apr 2011 16:35:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/4] powerpc/pci: Split IO vs MMIO indirect access hooks
Message-Id: <20110411163553.90489a0d.sfr@canb.auug.org.au>
In-Reply-To: <3ed7c174af4ccbab67467aa80fe84bd6c6e218ee.1302501428.git.michael@ellerman.id.au>
References: <3ed7c174af4ccbab67467aa80fe84bd6c6e218ee.1302501428.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__11_Apr_2011_16_35_53_+1000_eO6R=HJLDkp98FWt"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__11_Apr_2011_16_35_53_+1000_eO6R=HJLDkp98FWt
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

Just a small note:

On Mon, 11 Apr 2011 15:54:27 +1000 (EST) Benjamin Herrenschmidt <benh@kerne=
l.crashing.org> wrote:
>
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kcon=
fig
> index 59eeb77..220b137 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -152,13 +152,18 @@ config PPC_P7_NAP
>  	default n
> =20
>  config PPC_INDIRECT_IO
> -	bool
> +	def_bool y
>  	select GENERIC_IOMAP
> -	default n
> +	depends on PPC_INDIRECT_PIO || PPC_INDIRECT_MMIO

config PPC_INDIRECT_IO
	bool
	select GENERIC_IOMAP

> +config PPC_INDIRECT_PIO
> +	def_bool n

config PPC_INDIRECT_PIO
	bool
	select PPC_INDIRECT_IO

> +config PPC_INDIRECT_MEM
> +	def_bool n

config PPC_INDIRECT_MEM
	bool
	select PPC_INDIRECT_IO

>  config GENERIC_IOMAP
> -	bool
> -	default n
> +	def_bool n

Just remove the "defaul n"  (or leave it alobe).

The default for bool is 'n'.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__11_Apr_2011_16_35_53_+1000_eO6R=HJLDkp98FWt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJNoqFJAAoJEDMEi1NhKgbs1vAIAJDKAGzDRRJdpKdW6kvmVJ2/
IN2gZ+YfOqfwatnxT3JSnREtcbB3M+HGsMf7WiZI6T6Fx25buld4TGcHaMFUmMbH
LcYOqlPcrEEpT1rMsKfy2gA4mGs5BaTiF5VuehxJK1uQ8igQxAUZ3t213RPTcKpe
EEQ/MydIULOUkIlnF1S6sfoZ6wYJlAjVHyEbq8SOMWX/JPtvIa3InQiQBQ39OTVs
xYsAMOzTLnC4Bqecs6RtzK7TN+DirmrsO4K/EuwXr1hEKV4XUYseYR8fxfqUDXAQ
kmTurcyqeBxEx8I5bBdqrkaKeZnDv4rEphY9mbKVxp7liR88bykTcXTJSgy/50g=
=B/ML
-----END PGP SIGNATURE-----

--Signature=_Mon__11_Apr_2011_16_35_53_+1000_eO6R=HJLDkp98FWt--
