Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD05F606A33E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bj10BP3M
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWVQb2066z2xpt;
	Sat, 21 Nov 2026 09:30:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::832" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795213815;
	cv=pass; b=g88FRGeMoVPeYPrWbBGIdzjUxj4w7I4cTVNBKxtNz1dDXyKfereChpZ/7m7s+7xMna0Ulc2Y7x4WQkBEhf3tAd55EHpb2fNDasgNF91nsWaJlmeAeFTkvgonyFaxdiRi4cdw+zr7LnOCv7jEl8JT46n0leV/i28Ma8UOHlBADqLm3M7i7CKZfZsnBgRsd0cS996aR/u8EKqugflgx9SswCynCaRhd70B9CXL6kCsNAxcNZmAf7hmbZzBiqu/0Yu0gRZ5wug8SleSZd0eX56j+UP43l2stwnu+Uq7LJQWzVL7yfXeD4UUPWthIYvw1ybRB+UOsTr56ZVyVomoOUl8pA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795213815; c=relaxed/relaxed;
	bh=oSCVbmqxiQi2DoLmGcMaMHvDma566TKArudq046yQIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3qciguCZjjS+kzPZujsbFAZTjAlJ0g758BsZgCWrGhxzVgkfsLFbamU7AZ+1ULMEHuo0jvQaZKeBUGKM4GMq/Dd0StoUEQVzkbwdhOXxnIIJKRX7AldX5+Gsm1bivuCzjjLEjx3G1Jkir2xL8skYRv12s3dYwGTQ0pxAMVcid+2q+xmlX4IreHyHveOX+LNeVF9a8aDz2GBIkXhUXYjYZKl25lxmsuqXNoRQ4ArsorGd/J9ECjGkn4mPgLOn3qphGsCRL9o1xXllTy5HAgfX6NYcIKI1diWCb6mclWw5t6qFOv0hhf73jwvHrNOPa+RdT2CYnsWUfImPed6EWcu5Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bj10BP3M; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bj10BP3M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWVQZ1Rnwz2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 09:30:13 +1100 (AEDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-533202fe429so90251cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 14:30:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795213811; cv=none;
        d=google.com; s=arc-20260327;
        b=e0JvrWHo6e1yudZnmR+xwGNJSnZfdLFadAPM60UWAs8ssdz0HiU0AnqCSRIaYbNYWF
         qFTRw3IcL00I2AzphfTUcEUqAhmQ3Rk90VWPfYd12FlpjywNy9tLIEJuI5Teyc1JZ6H6
         aphbQxwUSzpbad1M/55HvAcEnQjUksWHngT5jj4CDkHgRTA8SxCDK8qPo1opOHbyyG4m
         PEUDH8fWZN9zK0qI4pPRTg+f0bvVAKwycZ2Qew/NBdvI/NDdi28DCejEpD72HsL/WDvf
         /R02ouDn3+FRGpsN1+QhncYhf5A3lkp+Rp1pNMuFMMBxtP7YbaWVbUYKaVWP3oVmzYG3
         vs/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oSCVbmqxiQi2DoLmGcMaMHvDma566TKArudq046yQIs=;
        fh=t2A5/F+btNT9Gdvx4JS1Bai5whn6Cx7gWj14tiTe1fA=;
        b=qLxixpSJZWa6e0R0h0xogTDlMfHXr+ZFcPKUgGg6b3OogxvKFmjsVU4xFyRBoqLDnw
         aY7iUbYPNx6HwPbivYSq/Qshw7LHCbHjPU3WhbNkwXrKO3LZs3RlGV7ov4238bPPo/UG
         PsxJp05HvNn+N/VTaruPrGu4Yq4N+VBi1BQN0k36+rYAY5sROkQEVdbsMP4SPWnKkw7V
         dT4qog8nNUNOaWs7MzPPo0rKmmCN7ysWGI6hsLJMJ3pM5/vsm6NMtvUMMoYfQqM6yjLq
         h9LNbxAJiLsZ4xsLHWE1gPSQ1jINVwx+MQpbnGmiZUE5A81qIXOoVlLUSA7pzXtIatN1
         qpxg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795213811; x=1795818611; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oSCVbmqxiQi2DoLmGcMaMHvDma566TKArudq046yQIs=;
        b=bj10BP3MdDi+TZmLY6NowGmgMaa1UZJYY4ZUt/x4Acqd2OTs+dUOq/t2rbb9ELtC3D
         ynd2lhqknZ8pYgOmT7YfhXVzY4q8R5tQ2IGliaJK3jOdm6RUC+BH5NQkhYlstpGBOotC
         i+FD1HjofIRL0xId1KWkepAB1KN86Cifhk4s3gPggmiPjOFGzbaAaPrAwV+Yag5fiNkp
         all9xezMkI+ZXpdPoXoZG+xBZkePOxip0g+z0HxuzbTHnx7D30erLgXo0yIjMZpm1fDE
         1vRk6Al8H2qII2MkrU/BnDtoBwdxo2/QyuNSKpYgA6ayLFgAS5LyPEMKkGIKqI460svS
         S3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213811; x=1795818611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oSCVbmqxiQi2DoLmGcMaMHvDma566TKArudq046yQIs=;
        b=Ayz1YVgFaVfUtyXQAmwE9JC1jGfZiGJ8XkhOMDb7tVsW5xG5ZUpQey5QlW2JsxScYA
         tQ2RdjqT/aJs2xNcX7MfEuV6SkqKjUX6cfJtROKB59XyC1i4twYMoJFlj8rYDynKKi49
         xp5s9g1A9CWl3zdqapPqmyIGaC2GEeGxoCcNXOf0Mjk8y+5PIjrc4qTt9ACRXoOh4aIZ
         YZ7MzrowJmEFed7gkDWcJ0pCRI5+7Y9eZ8okPC78aHbgmoquOqEsoahgyvEAVQVNpz5S
         hgsuwOBlHFpsC/7E/k3CWBA72GhDqXQRoXYXJTC1tumFJG9rst5ES7jKKVZ/e4j/5Kc+
         RhVg==
X-Forwarded-Encrypted: i=1; AL+hErGfQcYoSORcHyulZcqtWBVEKZnyxED4tM/V9QeGy0tQJ5yuCWHplg5K6HR7moaUigjMR5Fv/gNpp/lvECQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+aTv9VMSHcXsuOK9r6gKMuZcAJOVUIuxBisnJxnyFQCet0MQUg
	x1ARtOzkcHkJWRnvg1efgeFwMU86oc90gXdLmlCoML/PUZzdwAiBwN7TmXWdUyQHnufU88uQ/qx
	cQAmhdHp4jeR+G+ND0rWj63LVUXJyHVTIF5+kTIJ9
X-Gm-Gg: AYBFou2i0hI3Jm0phCEQCjyQU5ksAswCa4q4B/LtHbx0saNqah8NViYi8zgeZNrl/cj
	rQOzyFxDSBEo+IogMHep6ZOUhb8kOt7SMzFAB0PcbM0zDj4dhu7FRSpiVA1O049hfh24/M7P523
	tSN37WZUIjLDlafPlz1N0qGWZ+Rsvd4f23oK1m/hOyMZF8w4KeBrTMiLeE424yymvhArVH0eaij
	qhlU+xYvwaKcIFIIaxcTiWhFM2jzgQydu+fWWBQ+cr25v64y+eBPKGeX92WsoBNunlyiDKot2Ua
	LZ9ykvvdyfZ0us5bg93okB6ZQCsqxD3NRzjlC9rSQZ+qjKjTAuhjXnFWBmFC1rvceOVmIfs2Dco
	QGsl7q0y/Rw6s5bnHIJl9O0q6BhPCJAWjWjEUV86IWGqvZPgneIXE4bq9pWNzeKz7bH3N/KDK3A
	MnzXy5Z+GvPYFCvyAK8a8kOwIi
X-Received: by 2002:a05:622a:2b44:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-55d88013e93mr5507861cf.2.1795213810431; Fri, 20 Nov 2026
 14:30:10 -0800 (PST)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116071325.263682-1-hao.ge@linux.dev> <20261116071325.263682-7-hao.ge@linux.dev>
In-Reply-To: <20261116071325.263682-7-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 20 Nov 2026 22:29:59 +0000
X-Gm-Features: Aa3M54pjipOW7ZzgZHb-E-Af8isX9CFT5XpnqdBhptBuFS7GWS9SCDR86t6dxYw
Message-ID: <CAJuCfpEZ15zhoBsHuO1CD2JpYOQ5SrjOaZ_RkR=y8Gne557qMQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] mm/vmalloc: undo what vmap_page_range() mapped
 on failure
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 7:14=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> ioremap and arch setup code map their ranges with vmap_page_range().
> When the walk fails half way, or the KMSAN metadata fails after the
> walk, the ptes installed so far stay behind. The caller frees the
> vm_area on the error path, so the next mapping that lands on the same
> range trips the BUG() in vmap_pte_range().
>
> vmap_range_noflush() now takes a mapped_end argument that the walk
> levels advance as they install, and vmap_pte_range() BUG()s before
> it installs over a pte that is already set. The ptes below mapped_end
> are therefore all ours, while a pte above it can only have been put
> there by somebody else, for example when the caller's range overlaps
> an existing mapping. On a walk failure the undo is limited to
> [addr, mapped_end), going further would clear ptes that are not
> ours. If the walk completed and only the KMSAN metadata failed, the
> whole range was installed by this call and all of it is undone.
>
> All callers are sleepable, the teardown passes can_resched =3D true.
>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/vmalloc.c | 52 +++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 39 insertions(+), 13 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d99d7710e1ba..5c1eacc2a0ac 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -117,7 +117,8 @@ static __always_inline unsigned long vmap_set_ptes(pt=
e_t *ptep,
>
>  static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long =
end,
>                         phys_addr_t phys_addr, pgprot_t prot,
> -                       unsigned int max_page_shift, pgtbl_mod_mask *mask=
)
> +                       unsigned int max_page_shift, pgtbl_mod_mask *mask=
,
> +                       unsigned long *mapped_end)
>  {
>         pte_t *pte;
>         u64 pfn;
> @@ -143,6 +144,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long a=
ddr, unsigned long end,
>
>                 size =3D vmap_set_ptes(pte, addr, end, pfn, prot, max_pag=
e_shift);
>                 nr_pages =3D PFN_DOWN(size);
> +               *mapped_end =3D addr + size;
>         } while (pte +=3D nr_pages, pfn +=3D nr_pages, addr +=3D size, ad=
dr !=3D end);
>
>         lazy_mmu_mode_disable();
> @@ -188,7 +190,8 @@ static int vmap_try_huge_pmd(pmd_t *pmd, unsigned lon=
g addr, unsigned long end,
>
>  static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long =
end,
>                         phys_addr_t phys_addr, pgprot_t prot,
> -                       unsigned int max_page_shift, pgtbl_mod_mask *mask=
)
> +                       unsigned int max_page_shift, pgtbl_mod_mask *mask=
,
> +                       unsigned long *mapped_end)
>  {
>         pmd_t *pmd;
>         unsigned long next;
> @@ -203,10 +206,12 @@ static int vmap_pmd_range(pud_t *pud, unsigned long=
 addr, unsigned long end,
>                 if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot,
>                                         max_page_shift)) {
>                         *mask |=3D PGTBL_PMD_MODIFIED;
> +                       *mapped_end =3D next;
>                         continue;
>                 }
>
> -               err =3D vmap_pte_range(pmd, addr, next, phys_addr, prot, =
max_page_shift, mask);
> +               err =3D vmap_pte_range(pmd, addr, next, phys_addr, prot,
> +                                    max_page_shift, mask, mapped_end);
>                 if (err)
>                         break;
>         } while (pmd++, phys_addr +=3D (next - addr), addr =3D next, addr=
 !=3D end);
> @@ -245,7 +250,8 @@ static int vmap_try_huge_pud(pud_t *pud, unsigned lon=
g addr, unsigned long end,
>
>  static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long =
end,
>                         phys_addr_t phys_addr, pgprot_t prot,
> -                       unsigned int max_page_shift, pgtbl_mod_mask *mask=
)
> +                       unsigned int max_page_shift, pgtbl_mod_mask *mask=
,
> +                       unsigned long *mapped_end)
>  {
>         pud_t *pud;
>         unsigned long next;
> @@ -260,10 +266,12 @@ static int vmap_pud_range(p4d_t *p4d, unsigned long=
 addr, unsigned long end,
>                 if (vmap_try_huge_pud(pud, addr, next, phys_addr, prot,
>                                         max_page_shift)) {
>                         *mask |=3D PGTBL_PUD_MODIFIED;
> +                       *mapped_end =3D next;
>                         continue;
>                 }
>
> -               err =3D vmap_pmd_range(pud, addr, next, phys_addr, prot, =
max_page_shift, mask);
> +               err =3D vmap_pmd_range(pud, addr, next, phys_addr, prot,
> +                                    max_page_shift, mask, mapped_end);
>                 if (err)
>                         break;
>         } while (pud++, phys_addr +=3D (next - addr), addr =3D next, addr=
 !=3D end);
> @@ -302,7 +310,8 @@ static int vmap_try_huge_p4d(p4d_t *p4d, unsigned lon=
g addr, unsigned long end,
>
>  static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long =
end,
>                         phys_addr_t phys_addr, pgprot_t prot,
> -                       unsigned int max_page_shift, pgtbl_mod_mask *mask=
)
> +                       unsigned int max_page_shift, pgtbl_mod_mask *mask=
,
> +                       unsigned long *mapped_end)
>  {
>         p4d_t *p4d;
>         unsigned long next;
> @@ -317,10 +326,12 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long=
 addr, unsigned long end,
>                 if (vmap_try_huge_p4d(p4d, addr, next, phys_addr, prot,
>                                         max_page_shift)) {
>                         *mask |=3D PGTBL_P4D_MODIFIED;
> +                       *mapped_end =3D next;
>                         continue;
>                 }
>
> -               err =3D vmap_pud_range(p4d, addr, next, phys_addr, prot, =
max_page_shift, mask);
> +               err =3D vmap_pud_range(p4d, addr, next, phys_addr, prot,
> +                                    max_page_shift, mask, mapped_end);
>                 if (err)
>                         break;
>         } while (p4d++, phys_addr +=3D (next - addr), addr =3D next, addr=
 !=3D end);
> @@ -329,7 +340,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long a=
ddr, unsigned long end,
>
>  static int vmap_range_noflush(unsigned long addr, unsigned long end,
>                         phys_addr_t phys_addr, pgprot_t prot,
> -                       unsigned int max_page_shift)
> +                       unsigned int max_page_shift, unsigned long *mappe=
d_end)
>  {
>         pgd_t *pgd;
>         unsigned long start;
> @@ -346,11 +357,12 @@ static int vmap_range_noflush(unsigned long addr, u=
nsigned long end,
>         BUG_ON(addr >=3D end);
>
>         start =3D addr;
> +       *mapped_end =3D addr;
>         pgd =3D pgd_offset_k(addr);
>         do {
>                 next =3D pgd_addr_end(addr, end);
>                 err =3D vmap_p4d_range(pgd, addr, next, phys_addr, prot,
> -                                       max_page_shift, &mask);
> +                                       max_page_shift, &mask, mapped_end=
);
>                 if (err)
>                         break;
>         } while (pgd++, phys_addr +=3D (next - addr), addr =3D next, addr=
 !=3D end);
> @@ -364,18 +376,32 @@ static int vmap_range_noflush(unsigned long addr, u=
nsigned long end,
>  int vmap_page_range(unsigned long addr, unsigned long end,
>                     phys_addr_t phys_addr, pgprot_t prot)
>  {
> +       unsigned long mapped_end =3D addr;
>         int err;
>
>         if (WARN_ON_ONCE(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end)))
>                 return -EINVAL;
>
>         err =3D vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
> -                                ioremap_max_page_shift);
> -       if (!err)
> +                                ioremap_max_page_shift, &mapped_end);
> +       if (err) {
> +               /* Undo the part the walk installed before it failed. */
> +               if (mapped_end > addr)
> +                       __vunmap_range_noflush(addr, mapped_end, true);
> +       } else {
>                 err =3D kmsan_ioremap_page_range(addr, end, phys_addr, pr=
ot,
>                                                ioremap_max_page_shift);
> -       if (!err)
> -               flush_cache_vmap(addr, end);
> +               if (err) {
> +                       /*
> +                        * Only the KMSAN metadata failed, the walk mappe=
d
> +                        * the whole range. Undo it all. The callers are
> +                        * ioremap and arch setup code, always sleepable.
> +                        */
> +                       __vunmap_range_noflush(addr, end, true);
> +               } else {
> +                       flush_cache_vmap(addr, end);

This again skips TLB flushing after __vunmap_range_noflush(). I'm not
sure that's ok even if there was no explicit access.

> +               }
> +       }
>
>         return err;
>  }
> --
> 2.25.1
>

