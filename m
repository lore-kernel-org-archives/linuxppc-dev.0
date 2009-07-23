Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 54786B7BBE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 16:46:33 +1000 (EST)
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 45D48DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2009 16:46:33 +1000 (EST)
Date: Thu, 23 Jul 2009 16:46:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 12/20] powerpc/mm: Add hook to flush pgtables when a PTE
	page is freed
Message-Id: <20090723164630.c61c5d54.sfr@canb.auug.org.au>
In-Reply-To: <20090723055957.9D90EDDD1B@ozlabs.org>
References: <20090723055957.9D90EDDD1B@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__23_Jul_2009_16_46_30_+1000_lb3paItgeI_C5LKW"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__23_Jul_2009_16_46_30_+1000_lb3paItgeI_C5LKW
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Thu, 23 Jul 2009 15:59:46 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> +#ifdef CONFIG_PPC_BOOK3E
> +extern void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long addr=
ess);
> +#else
> +#define tlb_flush_pgtable(tlb, address)	do { } while(0)

static inline void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long =
address) {}

>  #else
> -#define __pte_free_tlb(tlb, pte, address)	pte_free((tlb)->mm, (pte))
> +#define __pte_free_tlb(tlb,pte,address)			\
> +do { 							\
> +	tlb_flush_pgtable(tlb, address);		\
> +	pte_free((tlb)->mm, (pte));  			\
> +} while (0)

This could (should?) be a static inline as well.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__23_Jul_2009_16_46_30_+1000_lb3paItgeI_C5LKW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpoB0YACgkQjjKRsyhoI8wsyACdHwOEZS3VmSkHcgiOwdDAUo5C
S6gAoIEogCiDHq4xwNV9m+kXFuskwqjh
=oPuB
-----END PGP SIGNATURE-----

--Signature=_Thu__23_Jul_2009_16_46_30_+1000_lb3paItgeI_C5LKW--
