Return-Path: <linuxppc-dev+bounces-27636-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA114C982D2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 21:44:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm8Rq16Xhz2xns;
	Fri, 18 Sep 2026 07:44:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789681495;
	cv=none; b=Psu+LZof557qYPw/+yylSGY8yKc4ESpjCXviqZL9LBlD2OQNrzbKwqwGfqjjWnJeoQ+OlYzT+TjxxESo8R4uYXJSzdjlsVMK4pdqY0p2pKWei+9ya956m+getmmOcd30bi6wIa1YVMrgWSzCsYGRvgDHmRdqpE7z74LLqw66YayDuMQharxzgZn8mDdW6Z5gPpdfSbbbcNbm5PK6XNoHDiXgCcDxKrQ+OZqv7Wlhvj9uvlXXrGMCM5ymLM4tndMyXNrwDkWEOfH8U3cukUyT8UOkad4ZHRraW032O4WWQtfrPTCWUiEe6HB0wwqYb8AyIgF+MVk618nJfRYAlhtTyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789681495; c=relaxed/relaxed;
	bh=exG/AXyrr+JXl9+ykc8tK7skhSydPCBzrUM83og95Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1MjkxrHx47Ht7jGpg0sFN1Mq9xhGq9oVQQZY8zIPASBypmX9TVmV0lr4Kr93NPTH2W44W9OKqKo+ZhRdzKRYxAxjWPV8Kj3XRofTCVItUnu6NqqPnElfZ9xQCOlFAm2rIO2pF1rm5J7ZB5eBnYiSpemLDJ4c35Kj6jWrSvQ2ea+noYbeawjZqv5nJ9pOgjcZJZHAaJEYylNjQQSbiPeINKrkwxHPrkXq7XFnd2JyP7yVXA5LY37FtCwAuJNjvTtGDxKb7RKEH15lb6Utnnp6zprg3PzcKT8TL7YMGqJW+ihyBoXhl3yyr4tCR/pzh2HJO99SPaYK15aow6GPKqmcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=npcV7UoW; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=npcV7UoW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hm8Rp085Sz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 07:44:53 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E0937600AA
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 21:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA061F00893
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 21:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789681491;
	bh=exG/AXyrr+JXl9+ykc8tK7skhSydPCBzrUM83og95Qc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=npcV7UoWW8Jdj8dCOiJjPz7NjvHEweQKVyJTOE6EGl+6CXaSXa7Cw5OVetwNA0yjL
	 h6TfoM6Dfif4CAsnrhQwtPWh9kFaQNiTS/ftDGCbVLNPOVI9S/lJcEmj5xyQDqYTmN
	 4ggdves30XSDnwvnOFL4hI3msybJF/Lz7+iqcOZPOOzu46+i0EIy/6sj+UOBlD1JFo
	 ILbB39sk6mpXz/GPDWpGqIe4Mx0g+kV9n4XGrwO9HrCL1sQqEDYUt6q1x/2esCOndY
	 FlVZRxvROq3asnpA7qRe55ewDZVxSRiT7yskG6bEOsB4CTOzEyN7jIbb3SY4BaZOsZ
	 ORbUBr6pMgLsA==
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cc46c7so6944785a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 14:44:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwd91q0M2meW84Yir9t1Sppom+xO5vkWGDqqavaDPEGaxtFJHowC58NqPm1KKTlHcCNr7wkIdl1o/Clm+o=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l92+lV9QCGaGmqI4VAP9poOiKvZXsBIfKw4klqzB22VEchLYAJ
	2A1mTGRPbwZ196SJLzJvBzT4D1hvl9chnlAU1F0saq2ER2PdheSo55fqsEfwAkwwrZohqLZiCu5
	3GYSr0nAJDXSsoqUAJQLStPW8yHvYq3Q=
X-Received: by 2002:a05:620a:1a28:b0:939:b099:d52f with SMTP id
 af79cd13be357-93bdc6d9164mr57128485a.20.1789681490948; Thu, 17 Sep 2026
 14:44:50 -0700 (PDT)
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260917052933.188679-1-jiangwenxiaomi@gmail.com>
 <20260917052933.188679-4-jiangwenxiaomi@gmail.com> <27072d94-13bf-4bea-948a-d8a67976601e@kernel.org>
 <CAHKocdE_zyUQT459AiTBDzQHk0jh+VpXuSMDdgHjkg-dAkgBNg@mail.gmail.com>
In-Reply-To: <CAHKocdE_zyUQT459AiTBDzQHk0jh+VpXuSMDdgHjkg-dAkgBNg@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 18 Sep 2026 05:44:39 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yJ-KCHbJ9S2GKXfO51KB8g-y2Q_MikqE9-6VesR-RC9Q@mail.gmail.com>
X-Gm-Features: AcwNN1UtqgSSOa91gBxdyOasYnD1juDs3qwDvpJofhPchMKWgrPs9IOwN7QDNfg
Message-ID: <CAGsJ_4yJ-KCHbJ9S2GKXfO51KB8g-y2Q_MikqE9-6VesR-RC9Q@mail.gmail.com>
Subject: Re: [PATCH v8 03/10] mm/vmalloc: use pte_set_huge()/pte_clear_huge()
 for PTE-level block mappings
To: Wen Jiang <jiangwenxiaomi@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, akpm@linux-foundation.org, catalin.marinas@arm.com, 
	linux-mm@kvack.org, urezki@gmail.com, will@kernel.org, 
	Xueyuan.chen21@gmail.com, ajd@linux.ibm.com, anshuman.khandual@arm.com, 
	david@kernel.org, dev.jain@arm.com, jiangwen6@xiaomi.com, leo.yan@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, rppt@kernel.org, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 10:41=E2=80=AFPM Wen Jiang <jiangwenxiaomi@gmail.co=
m> wrote:
>
> On Thu, 17 Sept 2026 at 22:00, Christophe Leroy (CS GROUP)
> <chleroy@kernel.org> wrote:
> >
> >
> >
> > Le 17/09/2026 =C3=A0 07:29, Wen Jiang a =C3=A9crit :
> > > From: Wen Jiang <jiangwen6@xiaomi.com>
> > >
> > > vmap installs PTE-level block mappings by reusing set_huge_pte_at() a=
nd
> > > huge_ptep_get_and_clear() under #ifdef CONFIG_HUGETLB_PAGE. This make=
s
> > > the feature silently unavailable on CONFIG_HUGETLB_PAGE=3Dn kernels a=
nd
> > > couples mm/vmalloc.c to HugeTLB internals it does not otherwise need.
> > >
> > > Now that arm64 and powerpc/8xx provide pte_set_huge() and
> > > pte_clear_huge(), add the generic fallbacks next to the existing
> > > pmd/pud_set_huge() family and convert vmap_pte_range() and
> > > vunmap_pte_range() to the new helpers. The CONFIG_HUGETLB_PAGE guards
> > > around the block-mapping paths are dropped, so PTE-level block mappin=
gs
> > > now also work on CONFIG_HUGETLB_PAGE=3Dn kernels, and mm/vmalloc.c no
> > > longer includes <linux/hugetlb.h>.
> > >
> > > The fallbacks exist only to keep the build working on architectures
> > > without PTE-level block mapping support. They are unreachable there:
> > > the callers only run when arch_vmap_pte_range_map_size() or
> > > arch_vmap_pte_range_unmap_size() return a size other than PAGE_SIZE,
> > > which requires an arch implementation. WARN_ON_ONCE() makes that
> > > explicit rather than silently doing nothing.
> > >
> > > Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> > > ---
> > >   include/linux/pgtable.h | 29 +++++++++++++++++++++++++++++
> > >   mm/vmalloc.c            | 19 ++++++-------------
> > >   2 files changed, 35 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > > index cdd68ed3ae1a9..349ced999f959 100644
> > > --- a/include/linux/pgtable.h
> > > +++ b/include/linux/pgtable.h
> > > @@ -2134,6 +2134,35 @@ static inline int pmd_free_pte_page(pmd_t *pmd=
, unsigned long addr)
> > >   }
> > >   #endif      /* CONFIG_HAVE_ARCH_HUGE_VMAP */
> > >
> > > +/*
> > > + * PTE-level block mappings for vmap.
> > > + *
> > > + * pte_set_huge() only has to be implemented by architectures whose
> > > + * arch_vmap_pte_range_map_size() can return a size other than PAGE_=
SIZE.
> > > + */
> > > +#ifndef __HAVE_ARCH_PTE_SET_HUGE
> > > +static inline void pte_set_huge(pte_t *ptep, unsigned long addr,
> > > +                             phys_addr_t phys, pgprot_t prot,
> > > +                             unsigned long size)
> > > +{
> > > +     WARN_ON_ONCE(1);
> >
> > BUILD_BUG_ON() would be better here.
> >
> > It should be possible because fallback arch_vmap_pte_range_map_size()
> > will constant-fold PAGE_SIZE so pte_set_huge() will never be called.
> >
>
> Agreed. These fallbacks exist only to keep the build working on
> architectures with PTE-level block mappings and should never actually
> be reached, so BUILD_BUG_ON() is right. I'll make that change in v9.
>

I am not quite sure. It won't be called at runtime because
`vmap size`/`unmap size` return `PAGE_SIZE`, so the code won't
reach this branch. But it will still be built.

So, would a `BUILD_BUG_ON()` trigger a build failure here?

Best Regards
Barry

