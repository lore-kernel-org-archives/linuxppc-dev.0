Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0846860A2604
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Tx+Votwu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWSbB1TpSz2xb9;
	Sat, 21 Nov 2026 08:07:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::836" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795208854;
	cv=pass; b=i7h+srQFwp9f0z++hdrhODkGpDRmIH3A6jZs7yV0VimHZqK19mVmzYsT+8rxIqSvdFsjjpW6MgGjHuMJBsfqW9IynAAAkkrPc7kuwXBIvmBaJB0UN3mxVU7h7K5v3OEnNVE39UjoTwQtmC3JHoSiTbtJVnT0tyq2KpL6+wSHxc4/5uw+ruATt/2jmM7wAf06kUujpg43ozJcorWb1ZEpVFFs6oLMa0Ql0rotfR0uDB5mQe/nKS8UPnb5mpvqm0p9DeenqQkFQb9GIA6w6nyGhCx0bD/UfgJOg8MEc3yP9/G+5GvDCBdetSDf8pYP8ggFQv6GzDc3GIt0PtgU/MUN2g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795208854; c=relaxed/relaxed;
	bh=23FU4s0qSHIWACezHPWGWY27dHdjz6IS0tWZIdmWGk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+fBXiD+UzqoZwM965zLH1mfQhy9H3LCmzV53rl0hNKW1ubCnKyMnyYtwXNS2gnUAONATtl2RNe+d/CGSDC2Oz4cwam9P6VZgp+7bnctu2e4K3i84SjlOvAkC9FDLFvtdFyiACjDdL/MCEsq70AOErSu4Vw956MNxUTksrctQwpZZfP4cFgFHnO3h4+Om7Qo0zR2P/RlFhRR4r5M3wePjykgo+ZPPe+I7J1+OAN3bzjyKerFTF5ZSvUnbMGrAet6sfxmaGtfkbNOI0/WMabDm/WRA7p9SRY3IDv9fxlSRsQA4vJHNC68D83hZcB3h6lWryFKrVjbba3fpxlA4AjG7A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Tx+Votwu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::836; helo=mail-qt1-x836.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Tx+Votwu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::836; helo=mail-qt1-x836.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWSb81jxHz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 08:07:31 +1100 (AEDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-55c7445cf85so14521cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 13:07:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795208848; cv=none;
        d=google.com; s=arc-20260327;
        b=C5BYr5otuBPBq1xi1Jd3o0joNUOHtkcuvgjDWZ5v3ixcXKCQ5u2r6IdiPNgGXpCb5i
         n/q+cRmB2eAJMp3ssemDBGWEu23lTHFXhSQQT3LPpLgYBoklCLi0SB2jE71jJZQdv4hX
         glIrtOcDOTSQfR2VYtQe87g/Aiuxoo/c0Ym0XBZ7zZLu9ayv6LyG+IWwHMd6n3MTXUD5
         xq6nWraayTNpp5u18KQ65HaenNDEbtdp+cMen2u33O5xMl1yqZB8CXfo+9JdqaKneZu/
         qmOT9jU/TP7Zn/gEC9jc2gLK/U/kTwmE0aLNZ7TIzHURFABiA2CmFcFUGV/emfKHMNbW
         +WqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=23FU4s0qSHIWACezHPWGWY27dHdjz6IS0tWZIdmWGk4=;
        fh=g2Hr8gNuMh6zAqVcjrxMBsNvNe+45YGKDk61NA1PJXM=;
        b=jLSqYtQhqZwjUasInZb10gyO/fFwyKNVS2EzA271xoR9QunBJzSo4aPM33r/9Gfs3E
         yvVFY+1YkyB2veyOaY0UNdHIXd1jE57MkFFpN9KaqCk+IaxN5q0kdQVeQ65cJfIgMoMw
         wxXqw5bsPYQirVBDetwpizjbiOuXWEK4n2L5XTbV91NcPeNn9NTl17ydCauaL64Yr4ZP
         n1BTl+yf9OHL7D9qfEM8uXyQUq5/8iP14XCYLfPTVYDN9YBdEhstTnMhp/YYikEhURxA
         Tnj1W0wBsbh7/8C/5jCrcNmAT6IjMgGSFK/KyWOJZTajtnxZk3OBYlwda2e5h0fJg1Z5
         ITWg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795208848; x=1795813648; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=23FU4s0qSHIWACezHPWGWY27dHdjz6IS0tWZIdmWGk4=;
        b=Tx+VotwuES+zXDG3RNk/mkVWAVz/Pvpw5vTZVBYD2qlG4QVSH4Elj2AeVDgvdB1X/p
         koR3ocDZ23PTZm8uxZTsC1utpSEfuDszksSJJINb+EKQos/ur/MxzV9Pnc1dySGwXkDc
         XsX3q5Kewa9YGQMPnamP3fVtFZdKtloLmcDwOnWhM9BnlPf/ZXVg36EfbRaNLgeTanug
         ESAs7rBxylU68mmi+YdemfHwuIlW5MVu8TlSXDnI+dpMZWKMSeUiBrOe/G4R2Evt0iVs
         DByp7X+3GKaa5BF7vqLZ92W1N9EzrNbgysRKHUhxTYDcs+YeqijDKROhEyXUQMydyjys
         xIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795208848; x=1795813648;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=23FU4s0qSHIWACezHPWGWY27dHdjz6IS0tWZIdmWGk4=;
        b=davXKfhJvwudTh8yfIW0oDm6KcIfcNHsJ66RjvfeqTQWNcQLjLBzuWOhurp2Gs85dW
         +cKh7rOf5SnAZM/fQszIz4n2/HJ8YxHHK7vU0rc9RmA7WZxO6XjCVl50D7Hmtl9R7ZMb
         9MSU+MhloXSv3dea/hTN+MamkC41HyJJjLSqLJGI+fhPpfwvhihu1L1FuzajLHsMaCvE
         /wLfPfiSpmSetOh76aBagLTCOTy2JItrAqtJW+Aa321KZfKMi0LediSS6Q8wvxR/EY1K
         3BBWipcakPA3qdzTRuMbawmkZgMRYDbpnMb4m6TWob9eHMFFwlkXB3qZeKJqypzST30R
         ZbLw==
X-Forwarded-Encrypted: i=1; AL+hErHiU9FRwSe13Qq5QcOCRx3tQOtl0+hEpo4x4+DOadf1IhP6cOz9vXbZbXYYGzr5aeMvin3PJuI+q5ZRUeA=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8BZLGRgaq9SwVByJd5F5hIop6GO+TK9/mI1PyB/OEVEsqntMKC
	iCnw3KabKo5SDBEnsOmTg08Fu02h3+zggI8rkMtCkOraY9Z+J57dsed4snVzEGhNOvttTi7NHky
	zdoIAUO4RwkSjW3ypwAFfGZbJXm/7S7InScKL3msq
X-Gm-Gg: AYBFou0rw+2GnuwwCdOH9P8UUCKSwmWSl1NL1CI/oOhvTss1xOR3tTj8f+HTXMJC3GU
	EH9QsStyH1Yp0g34aY0Y49EukDsxgZInLBTqwLNPfHrjGW/xwHVx9ECdL7CXvFXuJaoCzMtgvlu
	y/2yAcqRVOwEfyAqUTBcQuQOaE+qWwhEnp8AvQtikwjp8yzxPCASY1KgYr3kHosAYN6nggWGfcY
	oFBZf2MAwdpz8IIA9ryDDKPk+Ds+dSigc3MQRBqDuzN5+41/X14hGyp/w8es7T1ktASjWevrIxs
	fwnWGIbsB3GrRu5o5GzVoIOczmcVIcBV9dhD73UlNHpbsA3/Po6+6cZ7El89CWr7fSzlnO1IlDE
	PoIcQyRncBomBkNrx3Iz0Z2SYwAJXcFfur+QECDWcNLDpvum3xkZ5h4gTJZ/xpW94fRWGrUbl/n
	J1RKECwuNGLjLRN1C42edoSj4XWcVcydrWqgGb6rYTDen9aA==
X-Received: by 2002:a05:622a:c15:b0:530:e335:4ef with SMTP id
 d75a77b69052e-55d88014944mr3653311cf.2.1795208847503; Fri, 20 Nov 2026
 13:07:27 -0800 (PST)
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
References: <20261116071325.263682-1-hao.ge@linux.dev> <20261116071325.263682-2-hao.ge@linux.dev>
 <1020e36e-83bb-407b-8a6b-7669f04c26c3@arm.com>
In-Reply-To: <1020e36e-83bb-407b-8a6b-7669f04c26c3@arm.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 20 Nov 2026 21:07:15 +0000
X-Gm-Features: Aa3M54oHBR0Q2Es3gvoLgXXE93aLU88piHn6n8RQiRkJo_c2VMPM-YJNeTPQZo8
Message-ID: <CAJuCfpHtWJvs4F2L+QCMe9gMJ-qmcj4Q1G4hqVqFe6Z6gPoQ1Q@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] mm/vmalloc: skip cond_resched() in the vmap
 unmap paths when atomic
To: Dev Jain <dev.jain@arm.com>
Cc: Hao Ge <hao.ge@linux.dev>, Uladzislau Rezki <urezki@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 5:02=E2=80=AFAM Dev Jain <dev.jain@arm.com> wrote:
>
>
>
> On 16/11/26 12:43 pm, Hao Ge wrote:
> > The vmap failure paths can be reached with GFP_ATOMIC or GFP_NOWAIT
> > since commit b186a94227b7 ("kmsan: remove hard-coded GFP_KERNEL
> > flags") and commit 8da89ba18ed4 ("mm/vmalloc: handle non-blocking
> > GFP in __vmalloc_area_node()"), so an undo of a partially installed
>
> You mention this commit too, implying that vunmap_range_noflush() can
> be called in atomic context right now, but in this patch in
> vunmap_range_noflush() you pass 'true' unconditionally to
> __vunmap_range_noflush()?
>
> Can you give me the call chain existing in current kernel which makes
> this bug trigger? In case it does not exist but is only triggered when
> you add the rollback code later, then this patch is not fixing a bug.

Yeah, IIUC this is a prep patch for later changes and does not fix any
existing issues, therefore should not have any Fixes tags and should
not be CC'ed to stable.

Other than that LGTM.

>
>
> > mapping may have to run in atomic context, where the cond_resched()
> > in vunmap_pmd_range() cannot schedule.
> >
> > Give __vunmap_range_noflush() and kmsan_vunmap_range_noflush() a
> > can_resched argument and skip the cond_resched() when it is false.
> > The existing callers are on sleepable paths and pass true, so nothing
> > changes for them.
> >
> > Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_pa=
ges_range_noflush()")
> > Cc: stable@vger.kernel.org
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/all/sashiko-outbox-178439@kernel.org/
> > Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > ---
> >  include/linux/kmsan.h |  8 ++++++--
> >  mm/kmsan/hooks.c      | 14 +++++++++-----
> >  mm/vmalloc.c          | 24 ++++++++++++++----------
> >  mm/vmalloc.h          |  3 ++-
> >  4 files changed, 31 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
> > index 7da9fd506b39..0016c032d1e7 100644
> > --- a/include/linux/kmsan.h
> > +++ b/include/linux/kmsan.h
> > @@ -150,11 +150,14 @@ int __must_check kmsan_vmap_pages_range_noflush(u=
nsigned long start,
> >   * kmsan_vunmap_kernel_range_noflush() - Notify KMSAN about a vunmap.
> >   * @start: start of vunmapped range.
> >   * @end:   end of vunmapped range.
> > + * @can_resched: whether the unmap walk may call cond_resched(); pass
> > + * false from atomic context.
> >   *
> >   * KMSAN unmaps the contiguous metadata ranges created by
> >   * kmsan_map_kernel_range_noflush().
> >   */
> > -void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end=
);
> > +void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end=
,
> > +                             bool can_resched);
> >
> >  /**
> >   * kmsan_ioremap_page_range() - Notify KMSAN about a ioremap_page_rang=
e() call.
> > @@ -355,7 +358,8 @@ static inline int __must_check kmsan_vmap_pages_ran=
ge_noflush(
> >  }
> >
> >  static inline void kmsan_vunmap_range_noflush(unsigned long start,
> > -                                           unsigned long end)
> > +                                           unsigned long end,
> > +                                           bool can_resched)
> >  {
> >  }
> >
> > diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> > index a706666db097..69008b085658 100644
> > --- a/mm/kmsan/hooks.c
> > +++ b/mm/kmsan/hooks.c
> > @@ -136,10 +136,13 @@ static unsigned long vmalloc_origin(unsigned long=
 addr)
> >                                                KMSAN_META_ORIGIN);
> >  }
> >
> > -void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end=
)
> > +void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end=
,
> > +                             bool can_resched)
> >  {
> > -     __vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end)=
);
> > -     __vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end)=
);
> > +     __vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end)=
,
> > +                            can_resched);
> > +     __vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end)=
,
> > +                            can_resched);
> >       flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
> >       flush_cache_vmap(vmalloc_origin(start), vmalloc_origin(end));
> >  }
> > @@ -168,8 +171,9 @@ static void kmsan_iounmap_pages(unsigned long start=
, unsigned long end)
> >               if (origin)
> >                       __free_pages(origin, KMSAN_IOREMAP_META_ORDER);
> >       }
> > -     __vunmap_range_noflush(shadow_start, shadow_end);
> > -     __vunmap_range_noflush(origin_start, origin_end);
> > +     /* ioremap metadata mappings are always GFP_KERNEL, so resched is=
 safe. */
> > +     __vunmap_range_noflush(shadow_start, shadow_end, true);
> > +     __vunmap_range_noflush(origin_start, origin_end, true);
> >       flush_tlb_kernel_range(shadow_start, shadow_end);
> >       flush_tlb_kernel_range(origin_start, origin_end);
> >  }
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index ccaf158c5b7f..3c0d9e69b886 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -429,7 +429,7 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned l=
ong addr, unsigned long end,
> >  }
> >
> >  static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned =
long end,
> > -                          pgtbl_mod_mask *mask)
> > +                          pgtbl_mod_mask *mask, bool can_resched)
> >  {
> >       pmd_t *pmd;
> >       unsigned long next;
> > @@ -451,12 +451,14 @@ static void vunmap_pmd_range(pud_t *pud, unsigned=
 long addr, unsigned long end,
> >                       continue;
> >               vunmap_pte_range(pmd, addr, next, mask);
> >
> > -             cond_resched();
> > +             /* The undo path may run in atomic context. */
> > +             if (can_resched)
> > +                     cond_resched();
> >       } while (pmd++, addr =3D next, addr !=3D end);
> >  }
> >
> >  static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned =
long end,
> > -                          pgtbl_mod_mask *mask)
> > +                          pgtbl_mod_mask *mask, bool can_resched)
> >  {
> >       pud_t *pud;
> >       unsigned long next;
> > @@ -476,12 +478,12 @@ static void vunmap_pud_range(p4d_t *p4d, unsigned=
 long addr, unsigned long end,
> >               }
> >               if (pud_none_or_clear_bad(pud))
> >                       continue;
> > -             vunmap_pmd_range(pud, addr, next, mask);
> > +             vunmap_pmd_range(pud, addr, next, mask, can_resched);
> >       } while (pud++, addr =3D next, addr !=3D end);
> >  }
> >
> >  static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned =
long end,
> > -                          pgtbl_mod_mask *mask)
> > +                          pgtbl_mod_mask *mask, bool can_resched)
> >  {
> >       p4d_t *p4d;
> >       unsigned long next;
> > @@ -496,7 +498,7 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned l=
ong addr, unsigned long end,
> >
> >               if (p4d_none_or_clear_bad(p4d))
> >                       continue;
> > -             vunmap_pud_range(p4d, addr, next, mask);
> > +             vunmap_pud_range(p4d, addr, next, mask, can_resched);
> >       } while (p4d++, addr =3D next, addr !=3D end);
> >  }
> >
> > @@ -512,7 +514,8 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned l=
ong addr, unsigned long end,
> >   *
> >   * This is an internal function only. Do not use outside mm/.
> >   */
> > -void __vunmap_range_noflush(unsigned long start, unsigned long end)
> > +void __vunmap_range_noflush(unsigned long start, unsigned long end,
> > +                         bool can_resched)
> >  {
> >       unsigned long next;
> >       pgd_t *pgd;
> > @@ -527,7 +530,7 @@ void __vunmap_range_noflush(unsigned long start, un=
signed long end)
> >                       mask |=3D PGTBL_PGD_MODIFIED;
> >               if (pgd_none_or_clear_bad(pgd))
> >                       continue;
> > -             vunmap_p4d_range(pgd, addr, next, &mask);
> > +             vunmap_p4d_range(pgd, addr, next, &mask, can_resched);
> >       } while (pgd++, addr =3D next, addr !=3D end);
> >
> >       if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> > @@ -536,8 +539,9 @@ void __vunmap_range_noflush(unsigned long start, un=
signed long end)
> >
> >  void vunmap_range_noflush(unsigned long start, unsigned long end)
> >  {
> > -     kmsan_vunmap_range_noflush(start, end);
> > -     __vunmap_range_noflush(start, end);
> > +     /* The unmap paths are sleepable, keep the resched point. */
> > +     kmsan_vunmap_range_noflush(start, end, true);
> > +     __vunmap_range_noflush(start, end, true);
> >  }
> >
> >  /**
> > diff --git a/mm/vmalloc.h b/mm/vmalloc.h
> > index d8372a4f65c4..4ec114a75f04 100644
> > --- a/mm/vmalloc.h
> > +++ b/mm/vmalloc.h
> > @@ -44,6 +44,7 @@ int __must_check __vmap_pages_range_noflush(unsigned =
long addr,
> >
> >  void vunmap_range_noflush(unsigned long start, unsigned long end);
> >
> > -void __vunmap_range_noflush(unsigned long start, unsigned long end);
> > +void __vunmap_range_noflush(unsigned long start, unsigned long end,
> > +                         bool can_resched);
> >
> >  #endif /* __MM_VMALLOC_H */
>

