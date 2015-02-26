Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 55F611A0001
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 10:21:41 +1100 (AEDT)
Date: Fri, 27 Feb 2015 10:21:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
Message-ID: <20150227102136.17ef1fe6@canb.auug.org.au>
In-Reply-To: <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
References: <54EB735F.5030207@upv.es>
 <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
 <20150223205436.15133mg1kpyojyik@webmail.upv.es>
 <20150224073906.GA16422@gmail.com>
 <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vn9S4W+r=ApEhzXbcRjeXe4"; protocol="application/pgp-signature"
Cc: Kees Cook <keescook@chromium.org>, "x86@kernel.org" <x86@kernel.org>,
 Hector Marco Gisbert <hecmargi@upv.es>, LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List
 <linux-mips@linux-mips.org>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, ismael Ripoll <iripoll@upv.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/vn9S4W+r=ApEhzXbcRjeXe4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, 26 Feb 2015 14:38:15 -0800 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> diff -puN fs/binfmt_elf.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mi=
ps-fix fs/binfmt_elf.c
> --- a/fs/binfmt_elf.c~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-f=
ix
> +++ a/fs/binfmt_elf.c
> @@ -22,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/personality.h>
>  #include <linux/elfcore.h>
> +#include <linux/elf-randomization.h>
>  #include <linux/init.h>
>  #include <linux/highuid.h>
>  #include <linux/compiler.h>
> @@ -2300,6 +2301,26 @@ out:
> =20
>  #endif		/* CONFIG_ELF_CORE */
> =20
> +/* Not all architectures implement mmap_rnd() */
> +unsigned long __weak mmap_rnd(void)
> +{
> +}
> +
> +/*
> + * Not all architectures use randomize_et_dyn(), so use __weak to let the
> + * linker omit it from vmlinux
> + */
> +unsigned long __weak randomize_et_dyn(unsigned long base)
> +{
> +	unsigned long ret;
> +
> +	if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +		!(current->flags & PF_RANDOMIZE))
> +		return base;
> +	ret =3D base + mmap_rnd();
> +	return max(ret, base);
> +}
> +

Didn't we have some trouble with some compilers when the weak function
(mmap_rnd) was defined and used in the same file i.e. the wrong one was
used?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/vn9S4W+r=ApEhzXbcRjeXe4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJU76qEAAoJEMDTa8Ir7ZwV3OAP/3cZHBA0MOrqzhcDL520XAn1
MZUWfZnxFBhgGp9fpWP65adi9lgKgWZ6OeyzqTxqMSvkYHNc3uDWkJEaWJKigu8w
nQOe8kHzJ5sGQm6HIhO59xTEzg2phTQj2Pwg2g5WcGnv/IUo57PRNW7z0ctX/j9A
1hx9lD9WPstiJ9h/onkyg1Ic2UXgq8ZkYYWvn02wtpZprv8nmYfJYuHF0mj3ikfZ
5y7HBfFx3nC62R5Ad5uBcgodhGqDJ9HLm2nS1ZDV4S4tFcVX4sUPLj3PFF3tZuwp
n2GXul6wWlJqH7DRfjIoMOJE7DhZIWfAhltF6BQ/48flAeGMz9fu9pAs4OWyry3Q
oWZ95jzg/TKRaKfkUsONH9nGbGoaEA2PaZSOSuVGPRHUHa+srmVz/Sv6N2qeBdEr
dqqKVxc5QyNYpcSq7roA6g9Epzc68V16qn23AGy+Ozd6gmd0fHTryVoHE0Of4aTC
aK66joNBePz4EMlAX+e6/bbnbT+BAV5dqm9tCuwOPo8zTw9gxamfREa/N57+1TgO
6sHPgtqbHgXGlcS8sqb/uJ8xOvhLccMH1WHPVh6odpc0FYNG0PogKPF7vjY1iRnW
5sNQe6NZ+OP+NueTFCYgVE9nmBr70K2uLN1WoLFJnMumIOpfV5GFx5OQ2tTMrI+u
R7WKngqm8Fw0wOcO/myE
=rJqS
-----END PGP SIGNATURE-----

--Sig_/vn9S4W+r=ApEhzXbcRjeXe4--
