Return-Path: <tony@bakeyournoodle.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C7981A078F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 13:33:23 +1100 (AEDT)
Date: Thu, 20 Nov 2014 13:33:19 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc: Remove more traces of bootmem
Message-ID: <20141120023319.GA71013@thor.bakeyournoodle.com>
References: <1416442058-19544-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
In-Reply-To: <1416442058-19544-1-git-send-email-mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, David.Laight@ACULAB.COM
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2014 at 11:07:38AM +1100, Michael Ellerman wrote:
> Although we are now selecting NO_BOOTMEM, we still have some traces of
> bootmem lying around. That is because even with NO_BOOTMEM there is
> still a shim that converts bootmem calls into memblock calls, but
> ultimately we want to remove all traces of bootmem.
>=20
> Most of the patch is conversions from alloc_bootmem() to
> memblock_virt_alloc(). In general a call such as:
>=20
>   p =3D (struct foo *)alloc_bootmem(x);
>=20
> Becomes:
>=20
>   p =3D memblock_virt_alloc(x, 0);
>=20
> We don't need the cast because memblock_virt_alloc() returns a void *.
> The alignment value of zero tells memblock to use the default alignment,
> which is SMP_CACHE_BYTES, the same value alloc_bootmem() uses.
>=20
> We remove a number of NULL checks on the result of
> memblock_virt_alloc(). That is because memblock_virt_alloc() will panic
> if it can't allocate, in exactly the same way as alloc_bootmem(), so the
> NULL checks are and always have been redundant.
>=20
> The memory returned by memblock_virt_alloc() is already zeroed, so we
> remove several memsets of the result of memblock_virt_alloc().
>=20
> Finally we convert a few uses of __alloc_bootmem(x, y, MAX_DMA_ADDRESS)
> to just plain memblock_virt_alloc(). We don't use memblock_alloc_base()
> because MAX_DMA_ADDRESS is ~0ul on powerpc, so limiting the allocation
> to that is pointless, 16XB ought to be enough for anyone.
>=20
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---

<snip>

> --- a/arch/powerpc/lib/alloc.c
> +++ b/arch/powerpc/lib/alloc.c
> @@ -13,9 +13,7 @@ void * __init_refok zalloc_maybe_bootmem(size_t size, g=
fp_t mask)
>  	if (mem_init_done)
>  		p =3D kzalloc(size, mask);
>  	else {
> -		p =3D alloc_bootmem(size);
> -		if (p)
> -			memset(p, 0, size);
> +		p =3D memblock_virt_alloc(size, 0);
>  	}

You knew someone would ask but ...
Do you want to remove the {} form the else clause so that the style matches=
 the  if()

Yours Tony.

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUbVLuAAoJEPvNNsFAAoTB4XsQAOpkcqMTG+Y3bolstLyJDAiY
vO4LjUiBRjyKwClL5qVuxLvj128sLZk5+Z4ID3ilsu4n1NESvqAuYTvdXpTLJwn9
Ch2YanRVOsz7ZTDHjBxprOHWf9ptso0HOgeM345vWwx+HHiFLvErrdg+WYUYxZwP
2udpnZbkywXV1ph7YZfXgWV8/2A3PGL31/ZW1qxi0Y6/Dm7hn2ZWH5NUuexm7fG6
6Zl+gd7eMFgZSDVpoQ+tb+SKE9oJsadITU9kl0bAedfoRNnCTfpXGNxAs3JeAcpx
8Rg9++4rSZvfDek7qrGLY++0kiv41IFO4ZYHEZmlvT047yTWFwCfECbdYDOQs8Fe
ztkwiJ9Vp02SFzkkvxiF309djBvKHF9PCRdk0FY3QTvGMhiXFUH46tDgfsEVBter
HrYfAjW6cInGZyez6EhFcl959OtTIn3wPu/f56Ec5Az+lmkntoaHvOH8bGCAGgyj
I5wJsI6kOphByEfq+j9FDXSEZMKSeFxrX57wNwg4gCx3fITYkIg3M1qx6OvRGJf9
645C7N4ds+ziG4GCe4ZRK6caNc552ZPP1RnTvNzkT6LPD+LfQoEMNxb8veGSh9Gl
7iiCQcxYQ2xB5TyfokYlKGDhsZI9/mYJZYop40M+8HaIBcqIxNGl3KIgbeBqyTi1
BxzHItjcCuDpjYUq66qF
=z7I5
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
