Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id AB643DDE06
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 15:30:00 +1100 (EST)
Date: Tue, 6 Nov 2007 15:29:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [RFC/PATCH] reduce load time for modules with lots of relocs
Message-Id: <20071106152957.63fcbf9f.sfr@canb.auug.org.au>
In-Reply-To: <20071106023355.GJ9695@localdomain>
References: <598D5675D34BE349929AF5EDE9B03E270174CC98@az33exm24.fsl.freescale.net>
	<20071101235728.GE9695@localdomain>
	<20071106023355.GJ9695@localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__6_Nov_2007_15_29_57_+1100_t.pSumkLq+kNv+fx"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__6_Nov_2007_15_29_57_+1100_t.pSumkLq+kNv+fx
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Nov 2007 20:33:55 -0600 Nathan Lynch <ntl@pobox.com> wrote:
>
>  static unsigned int count_relocs(const Elf32_Rela *rela, unsigned int nu=
m)
>  {
> -	unsigned int i, j, ret =3D 0;
> +	unsigned int i, sorted_count =3D 0;
> +	Elf32_Word last_info;
> +	Elf32_Sword last_addend;
> +	Elf32_Rela **sortbuf =3D NULL;

You don't need to initialise sortbuf and f you make it a "const
Elf32_Rela **" ...

> +	sortbuf =3D vmalloc(num * sizeof(*sortbuf));
> +	if (!sortbuf)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < num; i++)
> +		sortbuf[i] =3D (Elf32_Rela *)&rela[i];

You shouldn't need that cast.

> -static unsigned int count_relocs(const Elf64_Rela *rela, unsigned int nu=
m)
> +static int count_relocs(const Elf64_Rela *rela, unsigned int num)
>  {
>  	unsigned int i, j, ret =3D 0;
> +	Elf64_Xword last_info;
> +	Elf64_Sxword last_addend;
> +	Elf64_Rela **sortbuf =3D NULL;

Same here.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__6_Nov_2007_15_29_57_+1100_t.pSumkLq+kNv+fx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHL+3LTgG2atn1QN8RAu+gAJwNHYatzuWPphCI6Sb/Ht8U8NfmYQCbBuMz
fUM6RCnAH4uiomhY26abawA=
=xhT7
-----END PGP SIGNATURE-----

--Signature=_Tue__6_Nov_2007_15_29_57_+1100_t.pSumkLq+kNv+fx--
