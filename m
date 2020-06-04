Return-Path: <SRS0=7wTx=7R=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066BBC433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 07:51:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28470206DC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 07:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TF4Zj3IZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28470206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49cydh6ZBDzDqlh
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 17:51:20 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49cybX113xzDqkp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2020 17:49:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.a=rsa-sha256 header.s=201702 header.b=TF4Zj3IZ; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49cybV3gm4z9sSc;
 Thu,  4 Jun 2020 17:49:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1591256967;
 bh=o+OWDom/fYwGhP1oWFmSJHDLHpi/7YbUUe8i95I5KR0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=TF4Zj3IZINV5x8p+m/3ufAgGFCfpde+kvrjCdi7a9hAReoumikHofSYWtlZvv/CM8
 p6UWPKJ250sAVk1Tj0CM9phkTfWQhL6xSBCOHAXoNqM9jFU5Q+oVsymD47GuHpUFoI
 jjNjk8dYl0vWJJaSV4yGeiBNyT4xvcHTFBZWUcKS0AR4wDAO3mSlqoEsZI8MIKSZ/6
 w0WLpA3ji7n0Wf3OWozpi0wZNzXc4ZjOMFjVsxvF/M987a6Za8Xm8txrJN2CHM7HUq
 sZto9Nk5rqfI37+iZdiqnhEMPvmOS3qq/nio7xHgR/OHsqgX6DWNbUoDdaOCphuJoH
 lPt5/v+2aJuyg==
Date: Thu, 4 Jun 2020 17:49:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: Re: linux-next: fix ups for clashes between akpm and powerpc trees
Message-ID: <20200604174925.3610fdd1@canb.auug.org.au>
In-Reply-To: <20200604165246.436f02ba@canb.auug.org.au>
References: <20200603202655.0ad0eacc@canb.auug.org.au>
 <20200604165246.436f02ba@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/69NJy6MsPMSFE8YRasJztRC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/69NJy6MsPMSFE8YRasJztRC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 4 Jun 2020 16:52:46 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/=
include/asm/nohash/32/pgtable.h
> index c188a6f64bcd..1927e1b653f2 100644
> --- a/arch/powerpc/include/asm/nohash/32/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
> @@ -205,10 +205,6 @@ static inline void pmd_clear(pmd_t *pmdp)
>  	*pmdp =3D __pmd(0);
>  }
> =20
> -
> -/* to find an entry in a kernel page-table-directory */
> -#define pgd_offset_k(address) pgd_offset(&init_mm, address)
> -
>  /* to find an entry in a page-table-directory */
>  #define pgd_index(address)	 ((address) >> PGDIR_SHIFT)
>  #define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
> @@ -241,7 +237,7 @@ static inline pte_basic_t pte_update(struct mm_struct=
 *mm, unsigned long addr, p
>  	pte_basic_t old =3D pte_val(*p);
>  	pte_basic_t new =3D (old & ~(pte_basic_t)clr) | set;
>  	int num, i;
> -	pmd_t *pmd =3D pmd_offset(pud_offset(pgd_offset(mm, addr), addr), addr);
> +	pmd_t *pmd =3D pmd_offset(pud_offset(p4d_offset(pgd_offset(mm, addr), a=
ddr), addr), addr);
> =20
>  	if (!huge)
>  		num =3D PAGE_SIZE / SZ_4K;
> @@ -341,6 +337,10 @@ static inline int pte_young(pte_t pte)
>  	pfn_to_page((__pa(pmd_val(pmd)) >> PAGE_SHIFT))
>  #endif
> =20
> +#define pte_offset_kernel(dir, addr)	\
> +	(pmd_bad(*(dir)) ? NULL : (pte_t *)pmd_page_vaddr(*(dir)) + \
> +				  pte_index(addr))
> +
>  /*
>   * Encode and decode a swap entry.
>   * Note that the bits we use in a PTE for representing a swap entry

Sorry, that ended up:

diff --cc arch/powerpc/include/asm/nohash/32/pgtable.h
index 639f3b3713ec,eb8538c85077..1927e1b653f2
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@@ -204,13 -205,6 +205,9 @@@ static inline void pmd_clear(pmd_t *pmd
  	*pmdp =3D __pmd(0);
  }
 =20
-=20
- /* to find an entry in a kernel page-table-directory */
- #define pgd_offset_k(address) pgd_offset(&init_mm, address)
-=20
 +/* to find an entry in a page-table-directory */
 +#define pgd_index(address)	 ((address) >> PGDIR_SHIFT)
 +#define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
 =20
  /*
   * PTE updates. This function is called whenever an existing
@@@ -240,7 -234,7 +237,7 @@@ static inline pte_basic_t pte_update(st
  	pte_basic_t old =3D pte_val(*p);
  	pte_basic_t new =3D (old & ~(pte_basic_t)clr) | set;
  	int num, i;
--	pmd_t *pmd =3D pmd_offset(pud_offset(pgd_offset(mm, addr), addr), addr);
++	pmd_t *pmd =3D pmd_offset(pud_offset(p4d_offset(pgd_offset(mm, addr), ad=
dr), addr), addr);
 =20
  	if (!huge)
  		num =3D PAGE_SIZE / SZ_4K;
@@@ -342,15 -334,6 +337,10 @@@ static inline int pte_young(pte_t pte
  	pfn_to_page((__pa(pmd_val(pmd)) >> PAGE_SHIFT))
  #endif
 =20
- /* Find an entry in the third-level page table.. */
- #define pte_index(address)		\
- 	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 +#define pte_offset_kernel(dir, addr)	\
 +	(pmd_bad(*(dir)) ? NULL : (pte_t *)pmd_page_vaddr(*(dir)) + \
 +				  pte_index(addr))
- #define pte_offset_map(dir, addr)	pte_offset_kernel((dir), (addr))
- static inline void pte_unmap(pte_t *pte) { }
 +
  /*
   * Encode and decode a swap entry.
   * Note that the bits we use in a PTE for representing a swap entry

--=20
Cheers,
Stephen Rothwell

--Sig_/69NJy6MsPMSFE8YRasJztRC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7Yp4UACgkQAVBC80lX
0GyHnQf/QfJYu4Zm/K1coGpmfqJ0CrINNBc+VTkdq8SquTaz0YjZM4zwrZl6SHGi
u6QCmXtEKNHepvQ0SXcqjmVvH5LziPld+oarfG8xtAOn2dGj4nti79BfBga/7XCR
zBbZgzBGO3OqFUOoXbKMNxnnpKZQZcZiJXgKzhASpgWJeuEfAproDvdu+yO1m8T2
YiknvWQ3K//h6mjlN/Ik15LY8B5vAok7irW74ALL0BaEEwpltjWtQStyTx/HMqhH
4oi4F2dUzBJkn7wm61q8TElLd1lMn3q90cB5MLsOwYkaZHRqz8smvQXXrTZzk52c
TqyGTGobcOw7NOxiZnx0Z+CdPsAGlg==
=IJ7k
-----END PGP SIGNATURE-----

--Sig_/69NJy6MsPMSFE8YRasJztRC--
