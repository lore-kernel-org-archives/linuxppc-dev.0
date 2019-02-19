Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD09C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 05:55:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA8121848
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 05:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLoKS61c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA8121848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443VMN1XxqzDqHj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 16:55:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="XLoKS61c"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443VKW6r5GzDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 16:53:51 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id s1so9843002plp.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 21:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=GVJaudI3Q1iyISabBlXTNEhbVSLmw924yvGWQc2k0GA=;
 b=XLoKS61ci7x+VFqDbXMRcFaW1qMkQNWJeBLm2luKkqsAyqLXwJEq/QPZ3H3pOTjpeE
 9wFfGsphX5u7hbco7IJbt5Ec8yg9KFMNxxGvS4rs88HsYlaPBYHywjGxKSWkacTmlr/b
 VFxCvzXAJM6meEASiDkRSoAXgt2MvxjlM1rU408NpCId/fhTAwHkJgXT19vGXmKeyDuC
 JY6YZwO/liy0BOOJuzd0A92SmfJMD0GMbnMg5S5TtS88JMQLym7xhZ3o6zQYk0t+bq+H
 iaSmiiBwIyasQeyq5bMwjlJlz9ba4yWV6waSDet8zaNUPV6lOAHraklJ0NF4fLgZMhML
 Dx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=GVJaudI3Q1iyISabBlXTNEhbVSLmw924yvGWQc2k0GA=;
 b=GKMlXDwdDQgAoJnmMvxIAlyWsZiPv6gZFUyUoEVWnJR5LJ2ZrcI56QzPE7E4QI1JWu
 OYv8b0y0xeSqbH2sqM7v58GtIV1vozWa/3UoictInCK6v+SOcuGzx+ez4i7tkJt+gOrx
 9XYPC7KtWahRNul5oqNKXSkpG5P0pmE0YzcPC/qLtsBYZhS3g7sWJ/4WLRALjVFnQVta
 UD+E1WiiNGHAd3oUbOahvwr2kBMNcn/FgR+RE72MxrmrJem0pHbI2m7VyFWx4zfdHIuA
 SmDwBJL7o6lnkJtjR9VIn/4UR0wRBcwzdAZWAg1u1WY20WmM45gBTJ0uj1r9GVX6dX/J
 S1mw==
X-Gm-Message-State: AHQUAub56uUyQdLM/pX5FxTOEhbccssI0c57jpcM36CBNmyT0Sh4NHPf
 DQVm689TJohQoMQOW9KjKWoJDhHg
X-Google-Smtp-Source: AHgI3Iau91ykl2Bi6ec8RQHDkiK5Us/i502+DhKObmh9pVKEfqvH/Kci00+5SMd5hoVEEgCTwAwGCA==
X-Received: by 2002:a17:902:31a4:: with SMTP id
 x33mr28539208plb.198.1550555629707; 
 Mon, 18 Feb 2019 21:53:49 -0800 (PST)
Received: from localhost ([61.69.157.156])
 by smtp.gmail.com with ESMTPSA id r6sm17924108pgk.91.2019.02.18.21.53.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 21:53:48 -0800 (PST)
Date: Tue, 19 Feb 2019 15:53:42 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/book3s: Remove a few page table update interfaces.
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, benh@kernel.crashing.org, 
 mpe@ellerman.id.au, paulus@samba.org
References: <20190214064540.26597-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190214064540.26597-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1550555411.zijyo53gzp.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Aneesh Kumar K.V's on February 14, 2019 4:45 pm:
> When updating page tables, we need to make sure we fill the page table
> entry valid bit. We should be using page table populate interface for
> updating the table entries. The page table 'set' interface allows
> updating the raw value of page table entry. This can result in
> updating the entry wrongly. Remove the 'set' interface so that we avoid
> its future usage.

Removing a pointless indirection is fine by me, but I can't
figure out how this change could help to prevent entry being updated
incorrectly.

Thanks,
Nick

>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgalloc.h |  8 ++++----
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 14 --------------
>  2 files changed, 4 insertions(+), 18 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/=
include/asm/book3s/64/pgalloc.h
> index 9c1173283b96..138bc2ecc0c4 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> @@ -111,7 +111,7 @@ static inline void pgd_free(struct mm_struct *mm, pgd=
_t *pgd)
> =20
>  static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t =
*pud)
>  {
> -	pgd_set(pgd, __pgtable_ptr_val(pud) | PGD_VAL_BITS);
> +	*pgd =3D  __pgd(__pgtable_ptr_val(pud) | PGD_VAL_BITS);
>  }
> =20
>  static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long a=
ddr)
> @@ -138,7 +138,7 @@ static inline void pud_free(struct mm_struct *mm, pud=
_t *pud)
> =20
>  static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t =
*pmd)
>  {
> -	pud_set(pud, __pgtable_ptr_val(pmd) | PUD_VAL_BITS);
> +	*pud =3D __pud(__pgtable_ptr_val(pmd) | PUD_VAL_BITS);
>  }
> =20
>  static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
> @@ -176,13 +176,13 @@ static inline void __pmd_free_tlb(struct mmu_gather=
 *tlb, pmd_t *pmd,
>  static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
>  				       pte_t *pte)
>  {
> -	pmd_set(pmd, __pgtable_ptr_val(pte) | PMD_VAL_BITS);
> +	*pmd =3D __pmd(__pgtable_ptr_val(pte) | PMD_VAL_BITS);
>  }
> =20
>  static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
>  				pgtable_t pte_page)
>  {
> -	pmd_set(pmd, __pgtable_ptr_val(pte_page) | PMD_VAL_BITS);
> +	*pmd =3D __pmd(__pgtable_ptr_val(pte_page) | PMD_VAL_BITS);
>  }
> =20
>  static inline pgtable_t pmd_pgtable(pmd_t pmd)
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/=
include/asm/book3s/64/pgtable.h
> index dc71e2b92003..a24e00fb7fa7 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -853,11 +853,6 @@ static inline bool pte_ci(pte_t pte)
>  	return false;
>  }
> =20
> -static inline void pmd_set(pmd_t *pmdp, unsigned long val)
> -{
> -	*pmdp =3D __pmd(val);
> -}
> -
>  static inline void pmd_clear(pmd_t *pmdp)
>  {
>  	*pmdp =3D __pmd(0);
> @@ -889,11 +884,6 @@ static inline int pmd_bad(pmd_t pmd)
>  	return hash__pmd_bad(pmd);
>  }
> =20
> -static inline void pud_set(pud_t *pudp, unsigned long val)
> -{
> -	*pudp =3D __pud(val);
> -}
> -
>  static inline void pud_clear(pud_t *pudp)
>  {
>  	*pudp =3D __pud(0);
> @@ -936,10 +926,6 @@ static inline bool pud_access_permitted(pud_t pud, b=
ool write)
>  }
> =20
>  #define pgd_write(pgd)		pte_write(pgd_pte(pgd))
> -static inline void pgd_set(pgd_t *pgdp, unsigned long val)
> -{
> -	*pgdp =3D __pgd(val);
> -}
> =20
>  static inline void pgd_clear(pgd_t *pgdp)
>  {
> --=20
> 2.20.1
>=20
>=20
=
