Return-Path: <linuxppc-dev+bounces-18642-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8CCF483E7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 19:29:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffjsk1158z2yWK;
	Tue, 24 Mar 2026 06:29:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::829" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774294170;
	cv=pass; b=LcKAsol1Wu8nc1rRHqbRXNEMTpX0pvaVP+1Gf+MvyNgsudBYwILrrEvYDGDbCDIWqI8pQBTSFbljDhgtwlaWcK30UtEbGdueZy0hKKEj8sTe1pip3Wh9Sei3ncE6wh+DDoXS+/orucgEt0wyOL+CADMFJkLpF6rnxtAJIjNQWpZrf4JfbV3vUfZQvvi8FsJwfbItAzpKRa6ncItWmOXUFSlbRJ1o8EV2+AE6EbhKKi5W060NQ4E8cCOStOM9pgUDshJbnGTEqdtSBJPCeOAO4EuJtqGwEw3vFR6ZUrvsHCCGOLae9xv0m+Uxe8o+b+bRO+di9uIvRMiXNmoLWgefmQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774294170; c=relaxed/relaxed;
	bh=rL6rgT4p4eg6pWVBxL1qRwcnXbeBJSn9vYxp2HwXMQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ic58Znt6DQM9uMXzAX9E2JMUskG6r7NuLMDBg0uGNXde4aXbVPlhS7jAAcZBy1g2RZr6TpK030YDFJjWVsSOlSVUNjGQZceNj5hwjxKhXoB43m4hZ1ZKMnr6RVHLdC33/x4arcLB4VY1dDBSfDsHtZpFOIlpVjA4YCKUSgUGXp9Ruf2XDut+ZR+FkPkxw2ed+KLggtpIECOzyd+/9FAjbglEZHCWP69QJNyXx+GfZL85SER6Gp1rui/5f6JR+n8gV+0BcH1djFycS5tqNF6ue/HZPpSWzGXvTlPlR91HanY/TB7jkUiDY2seOB8d6Dv/nA5Fz6IUZtLnFk/eFRSAcg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XYXMrP7O; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XYXMrP7O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffjsj1PTHz2xs4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 06:29:28 +1100 (AEDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-509062d829dso11201cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 12:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774294166; cv=none;
        d=google.com; s=arc-20240605;
        b=jL2P+1f5NAWlKMwZNACyf9J1PSPrI4HhPKH/kTL4/q/YvJiymGTFQB09CVFhsWqxhZ
         jtbINHigawv819YL8ekz2ub/tmjLKCS7NWVA5WlwZKfLOyi5TcsurZrz+mv7u2FosarE
         7QZvemCuJsqfkUakOniUsEOHESM/cKvV3TDqGfiO3X9d2lWcYm2ZmtvYtMLLIEH0Mdki
         BWtoakkxdR1kwIIIt0aB4ddc1vY3U40tTVQDUvJRhO0gq7PKmA0JsCjNQS8rNSFjmMnw
         pD44b2O46I4340kwDuIu4hc8EpX7pDz3oqPggpMNX/kuL/dOTH0X6I/KiT7HX5ZbC6cV
         zoOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rL6rgT4p4eg6pWVBxL1qRwcnXbeBJSn9vYxp2HwXMQ4=;
        fh=TJEd4EfpmJ0rLA9/kdJErUdOKVbGOXLzIj2aNhV0ZLs=;
        b=SYhS9cZa9vOdQITh9sCx1dfREKk7D7nOicrfoFGoPKp6lrSrJvWPoVE7x2qOqe4S9r
         4yxk/VbbhoSzOAdyxxR9mb8gZqJcRxwBnG5lbtd1OLK3UMmG52mOdQq2784+Pmda+xSr
         otJsZRFX73CX4q1ujN70KqKNGx6o4AKxDRaatHw++jxgDvuuBF0XWOjp0TNThrX3otTF
         Fe7hZPF6QEsw36pR0BPpXUDpG1+zdrOu4+TniC/Mls/0mvG88eR9InYVAiowhPQ/EgLB
         0vWYoErOT5bXP+JVFGtV4F51J7xAGg0uVJ89/kKoOoeXjn62cHXmvLJzgkK2qTGWe/tj
         XRxg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774294166; x=1774898966; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rL6rgT4p4eg6pWVBxL1qRwcnXbeBJSn9vYxp2HwXMQ4=;
        b=XYXMrP7OZCZDA0oLjL7vPPhQxsmASndfqnSIC7E5YfDImBqvCEHGmmtcoq1gmGNyc3
         KNq7MC24qHmdBrsJ/Q7KYcrPgYbud/Sv4SE0mTfYOXSq2bK6bolCMz1t/E/6GlIjuhoK
         k921dr92Nr5Rwzkk2YWSZivrpFtyB3by+1+aS7AU29gJi5fucftJYCGsnU0O8zK0o1cg
         MRZkJzNsQCh9fN4puCqbrynM8ZWjDJ5+0FkKOy8fcsEbsHLGp8Fd4lQRFMiDlmzYnypc
         glCho6ChWQ9YTZqN0S+rkddvFW0abcjcoMYNxjKNPeebRi9ruAO6SsZ4QZJkV2Tiwyjg
         q3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774294166; x=1774898966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rL6rgT4p4eg6pWVBxL1qRwcnXbeBJSn9vYxp2HwXMQ4=;
        b=D33YD4M6qc58qGELXYpL0eKAJnqs9YQZVuJ51pHUFeyqR113FThQVpTtHhSorxJmyR
         R0+L5lG6242xGXy4Yk3TlGLYsWV0oaZkU6+tGqlPoOCphhocVy3QnsxfMRqJghGbRQto
         HOnBeA8nPku2c//cFf6PfJn9xJX0PqsSRoE2yfxUuNFKM2zpoLUXMGv4GZlSpicf955u
         PFGGvFirhpa33n1dx0DtzYcj4DsAKEzV3fXHfvBPjQ3bzRzOgY1n9TNo2UwHTwj3r9gj
         v9Bh/wBHCYEXQ3IiSxWbMTVSI0IMIquP9N8vCyZpmj9yz0J51qjEduvUrAdaJubsDsbV
         qutQ==
X-Forwarded-Encrypted: i=1; AJvYcCU171vhAtknXsolf2EZUZu6wma5xM14buJPf6MJUrRwoj6wQeFP4p+zuaM23XVHM/G2ZkeoEfPlmBqxzdM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxpBUsc/wRlKRjhnEb0jmSaLTv1kLT1qGnTnZWEsZCvaGHnkszr
	9MPpnwX6xeihah044ZASp1MyO0qRSlCoUeW37yXoG3g/IJPPbxdjMXepu8HKa/keZY9kRUq+XWD
	N2npG7i+LLBL1QLLPICX5htsiImPgD/bC5J4z/M2z
X-Gm-Gg: ATEYQzxPdJYRB6Xwsg5bOCOexIKeCH0e/2xtwcJYLSGANpJkQefq789tPAgaaok7GWm
	KubUiRwZ5aQ2UfukcU6K0prjJX7pCvJZq0E5xj2HS2jdwYiUZFs21olBujaO1sstDVNJJ8baGZf
	2V6glWqcnmDLVBkDbJUDSA3i4IldsDGvFmC8fAZgD9U95tljRkTziErKjpE4swl/iHBT3uRSMKi
	cFLLJWVzZi6CtPQqwHg+30wichPMGnhUYSb9lbcOb2S0/EdgXGMPxW2WczIqupWpGHDiit4D3Jn
	jIrNkuaRd5vXa0sP
X-Received: by 2002:a05:622a:a986:20b0:508:fd42:fd05 with SMTP id
 d75a77b69052e-50b6fe1094amr2337331cf.15.1774294165477; Mon, 23 Mar 2026
 12:29:25 -0700 (PDT)
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
References: <20260322054309.898214-1-surenb@google.com> <20260322054309.898214-5-surenb@google.com>
 <1c44dd0b-4f5a-4fc1-983f-f728b31c9e4d@lucifer.local>
In-Reply-To: <1c44dd0b-4f5a-4fc1-983f-f728b31c9e4d@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 23 Mar 2026 12:29:14 -0700
X-Gm-Features: AQROBzCQaEF_cPLZfBQCzrdp1WYDK-0_JtC25zQIk1w6f-8rEEzfFfTeX5PuZ2c
Message-ID: <CAJuCfpGk3sTw2_owiRZM=V2e0UGDad5MrDbCsPbY3GUvT4u63A@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mm: use vma_start_write_killable() in process_vma_walk_lock()
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org, 
	mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 11:04=E2=80=AFAM Lorenzo Stoakes (Oracle)
<ljs@kernel.org> wrote:
>
> On Sat, Mar 21, 2026 at 10:43:08PM -0700, Suren Baghdasaryan wrote:
> > Replace vma_start_write() with vma_start_write_killable() when
> > process_vma_walk_lock() is used with PGWALK_WRLOCK option.
> > Adjust its direct and indirect users to check for a possible error
> > and handle it. Ensure users handle EINTR correctly and do not ignore
> > it.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/proc/task_mmu.c |  5 ++++-
> >  mm/mempolicy.c     |  1 +
> >  mm/pagewalk.c      | 20 ++++++++++++++------
> >  3 files changed, 19 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index e091931d7ca1..2fe3d11aad03 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1797,6 +1797,7 @@ static ssize_t clear_refs_write(struct file *file=
, const char __user *buf,
> >               struct clear_refs_private cp =3D {
> >                       .type =3D type,
> >               };
> > +             int err;
>
> Maybe better to make it a ssize_t given return type of function?

Ack.

>
> >
> >               if (mmap_write_lock_killable(mm)) {
> >                       count =3D -EINTR;
> > @@ -1824,7 +1825,9 @@ static ssize_t clear_refs_write(struct file *file=
, const char __user *buf,
> >                                               0, mm, 0, -1UL);
> >                       mmu_notifier_invalidate_range_start(&range);
> >               }
> > -             walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
> > +             err =3D walk_page_range(mm, 0, -1, &clear_refs_walk_ops, =
&cp);
> > +             if (err)
> > +                     count =3D err;
>
> Hmm this is gross, but it's an established pattern here, ugh.
>
> Now we have an err though, could we update:
>
>                 if (mmap_write_lock_killable(mm)) {
> -                       count =3D -EINTR;
> +                       err =3D -EINTR;
>                         goto out_mm;
>                 }
>
> Then we can just do:
>
> +               err =3D walk_page_range(mm, 0, -1, &clear_refs_walk_ops, =
&cp);
>
> And at the end do:
>
>         return err ?: count;
>
> Which possibly _necessitates_ err being a ssize_t.

Sounds doable. Let me try that.

>
> >               if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
> >                       mmu_notifier_invalidate_range_end(&range);
> >                       flush_tlb_mm(mm);
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 929e843543cf..bb5b0e83ce0f 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -969,6 +969,7 @@ static const struct mm_walk_ops queue_pages_lock_vm=
a_walk_ops =3D {
> >   *      (a hugetlbfs page or a transparent huge page being counted as =
1).
> >   * -EIO - a misplaced page found, when MPOL_MF_STRICT specified withou=
t MOVEs.
> >   * -EFAULT - a hole in the memory range, when MPOL_MF_DISCONTIG_OK uns=
pecified.
> > + * -EINTR - walk got terminated due to pending fatal signal.
>
> Thanks!
>
> >   */
> >  static long
> >  queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned =
long end,
> > diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> > index eda74273c8ec..a42cd6a6d812 100644
> > --- a/mm/pagewalk.c
> > +++ b/mm/pagewalk.c
> > @@ -438,14 +438,13 @@ static inline void process_mm_walk_lock(struct mm=
_struct *mm,
> >               mmap_assert_write_locked(mm);
> >  }
> >
> > -static inline void process_vma_walk_lock(struct vm_area_struct *vma,
> > +static inline int process_vma_walk_lock(struct vm_area_struct *vma,
>
> NIT: Don't need this to be an inline any longer. May as well fix up while=
 we're
> here.

Ack.

>
> >                                        enum page_walk_lock walk_lock)
> >  {
> >  #ifdef CONFIG_PER_VMA_LOCK
> >       switch (walk_lock) {
> >       case PGWALK_WRLOCK:
> > -             vma_start_write(vma);
> > -             break;
> > +             return vma_start_write_killable(vma);
>
> LGTM
>
> >       case PGWALK_WRLOCK_VERIFY:
> >               vma_assert_write_locked(vma);
> >               break;
> > @@ -457,6 +456,7 @@ static inline void process_vma_walk_lock(struct vm_=
area_struct *vma,
> >               break;
> >       }
> >  #endif
> > +     return 0;
> >  }
> >
> >  /*
> > @@ -500,7 +500,9 @@ int walk_page_range_mm_unsafe(struct mm_struct *mm,=
 unsigned long start,
> >                       if (ops->pte_hole)
> >                               err =3D ops->pte_hole(start, next, -1, &w=
alk);
> >               } else { /* inside vma */
> > -                     process_vma_walk_lock(vma, ops->walk_lock);
> > +                     err =3D process_vma_walk_lock(vma, ops->walk_lock=
);
> > +                     if (err)
> > +                             break;
>
> In every other case we set walk.vma =3D vma or NULL. Is it a problem not =
setting
> it at all in this code path?

IIUC the other cases set walk.vma because they later call
ops->pte_hole(..., walk). In our case we immediately break out of the
loop and exit the function, which pushes "walk" variable out of scope.
So, walk.vma won't be used and setting it would achieve nothing.

>
> >                       walk.vma =3D vma;
> >                       next =3D min(end, vma->vm_end);
> >                       vma =3D find_vma(mm, vma->vm_end);
> > @@ -717,6 +719,7 @@ int walk_page_range_vma_unsafe(struct vm_area_struc=
t *vma, unsigned long start,
> >               .vma            =3D vma,
> >               .private        =3D private,
> >       };
> > +     int err;
> >
> >       if (start >=3D end || !walk.mm)
> >               return -EINVAL;
> > @@ -724,7 +727,9 @@ int walk_page_range_vma_unsafe(struct vm_area_struc=
t *vma, unsigned long start,
> >               return -EINVAL;
> >
> >       process_mm_walk_lock(walk.mm, ops->walk_lock);
> > -     process_vma_walk_lock(vma, ops->walk_lock);
> > +     err =3D process_vma_walk_lock(vma, ops->walk_lock);
> > +     if (err)
> > +             return err;
>
> LGTM
>
> >       return __walk_page_range(start, end, &walk);
> >  }
> >
> > @@ -747,6 +752,7 @@ int walk_page_vma(struct vm_area_struct *vma, const=
 struct mm_walk_ops *ops,
> >               .vma            =3D vma,
> >               .private        =3D private,
> >       };
> > +     int err;
> >
> >       if (!walk.mm)
> >               return -EINVAL;
> > @@ -754,7 +760,9 @@ int walk_page_vma(struct vm_area_struct *vma, const=
 struct mm_walk_ops *ops,
> >               return -EINVAL;
> >
> >       process_mm_walk_lock(walk.mm, ops->walk_lock);
> > -     process_vma_walk_lock(vma, ops->walk_lock);
> > +     err =3D process_vma_walk_lock(vma, ops->walk_lock);
> > +     if (err)
> > +             return err;
>
> LGTM
>
> >       return __walk_page_range(vma->vm_start, vma->vm_end, &walk);
> >  }
> >
> > --
> > 2.53.0.1018.g2bb0e51243-goog
> >
>
> Thanks, Lorenzo

