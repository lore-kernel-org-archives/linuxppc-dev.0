Return-Path: <linuxppc-dev+bounces-19105-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0DC109B495
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 15:43:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flXTS1jjSz2ydn;
	Wed, 01 Apr 2026 02:43:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::534" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774971820;
	cv=pass; b=RsShrxNsGluTFAUs8/mSP0USKUwBbVtxVaC4JLxDimCTeILWeVEDC+gtKZ/PXVPhwSpE9Ny9MolTMWPbYLgTyglOZiQj/tABmISHbWZdOcTwcTpbQ00l4T6rezaoBCBVpcaorEkogjjIUfECN5vDGSg89zujf9ZMagL+UtdBH7/UMz7k4kaPwdBjLgUU3QgBBPA0pl5FkGZVg989hhqoWETI6yWS8iGAvC7oX78ijlJvLnlcYbgHVv7yl80focYmK6qq7HdnhGU0xXSgqkrZkT/f+Jay0ctQSkFCMMxuEp2Cqa01mzUdDXqD8vXhDLfRWoqMTHgK8Rf1g+eMPR9+mQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774971820; c=relaxed/relaxed;
	bh=19HitNbsfLUnWLRSqhfCO2KvXn4aeuKUlwucY4LX+VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxgZdZbfUc9sl+oRlyA36epfCyfMOBOH38YLWRu+CBMJYRALcVDJimZaBrpA0FTjFYT/J1XgeZ8iCxziBr992VGJC7yNd3HuQopdGgN5qF2wFYLsSaB1JhwMXZdyYXlY7djSxl9vZJFWuW9RrJFTWd6mQX5FMVcoTVreRoP076hmx53WidG5Cq8dd3OJjAr34lAEu1G2QvSTn/aene6KJDhYCJmiLwdmcr0oEDTObspCgegWDViV1kUmWA3dnIyfjzEtml6pNUXltP2KXMweVvT9fy89AS6ruIwDd0B3GPQHH8Ddt+BGmWTvrKBLd09myviYRD934hgUuzkA7PL3lg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=A2vopxNU; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=A2vopxNU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flXTR02c5z2ybR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 02:43:38 +1100 (AEDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso11663a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 08:43:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774971816; cv=none;
        d=google.com; s=arc-20240605;
        b=FuRBygWkyw+D7TV7gd5V2AClhHJxmIzqran1Z4JZbRZjrLAlLxDjk5xGdMwkwWex1h
         m0G2EPN8+9KLvewEToj2Ulr6taeZH+ptOYFits/aguqOMzrm+hTiBtvFaV+XutEGZmcb
         0w5HNmYU83e0baAF/bLj75jEODCEtoJ/pWvhyIlIYBVUZ0tLePaQXPlhxxB89ghvDJtk
         9+m0Di0wkgueQEhazKd8KWPvprofTgGb1QDj7gwnAquvIKPUDjLyOpgE86SlItRVr06S
         XH8aDsMWiGlACVfgOyftK1dT98uHPQ8ZPgJxY1LvzuGY55GOo8ArFCFcPA65PxQdiiWA
         4q3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=19HitNbsfLUnWLRSqhfCO2KvXn4aeuKUlwucY4LX+VA=;
        fh=/QvHClYx/eGkda8beJM9Uw6OtXBJIWsRYYwJPTtLH+g=;
        b=WB8LBEnHlxr1+9jJ9c2mjo9LLUUAEP+6LJO37kISABzoe2jNgGuZQoc5jx3nh/o/ZL
         aOtokV+kBx/d5vcey+WBf8fZKIe8UcFM6MaJrjVeBPoOhg2hT0v5gVW3Ai2axClokFZU
         yo3mjlpizmsz7/9r6gZj9nQEDbvTbDGusajtxqdGJ5wWJ/u4BSU2Q4YxXqtesFzVBp0m
         LWzOVR3+5VhCjJn9hRv+ju5HwRsQ8N+5xjxC7ZoUV8Lp4FDjIOSZpMMu8QHmQZJ9wwZN
         pcu/bzhPfBu8na4tcF94WuxQBkQFb3Vqc48b2zSk3dboHQArXGfSf5Zgq5prbDcMpg/I
         V8Eg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774971816; x=1775576616; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19HitNbsfLUnWLRSqhfCO2KvXn4aeuKUlwucY4LX+VA=;
        b=A2vopxNUReF59ZdsE6C85J8cQR22SwXHN/t6KoKRNvXSihCCeA6h/YHo6BOrmYrsKq
         j2pq8cQDE/B4KWy8HuQF/qBxmHRVJALFJxDXIF3UhV9QlIHDLsjRrmy0/tNFailbNzBW
         oeunJajqW7FGPLmSc6NUzdGn8n8MDyD9IiqRSkUtZquTZiZrohIKBc4V+XPWmnrQG+Dc
         qg7SlLpAkrRbEO4mvc8LLct9dihIgPzzjqs5RTzv5yuuyNKFVgVoM/KqDqboCr+mPKix
         r7gvIbRIXi1UoOYNcBvzzORpPzmCvop1y5v0qfGSejeDjxgIhvemewkibpWHiH5H6lq2
         e1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971816; x=1775576616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=19HitNbsfLUnWLRSqhfCO2KvXn4aeuKUlwucY4LX+VA=;
        b=n4obvLdG9lhxkiXyFNKkTMRKyu9mn8pWgLQ4WCBUfQJpyFeWQe4rlelYDpJSaAAJ1t
         1GR1WTusaPISvYiGPvCqzMGlIQMQI5KGvwi0i7LNxtQPmg9tAyVeA1CKItc9cS9b0+cK
         WavCuRQ/bEwN9zogQjCS7xngvulWrJ8u9hRnY37gSxCCT2JcXwQg2d8BRNJwE4qxpIMj
         eiQwKL2mVt1OuE2IKQxur7H6Dg3iS1htOiS43GtZq6Uunaj2bAoA3LuC8sz6HhYxoPyd
         I+nZk2vUsfFF/50hBAvaijTngvZpFQ5CPLLI2w1aqL5aOUCP9uKvIrA9o8KZ2Gs3qima
         ikvg==
X-Forwarded-Encrypted: i=1; AJvYcCV7SBgzD9rpOYzdSjtZZB8NmkrQUK+c/7TZExrpB0Pm0NpCOE5s0qzwl+kS08/Y+uJhg0T+ZjGQ8DcsKyk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx7C2ZMh0XMDaXeiAdG5IzTI4xcbAz7gM2OPjOm4RFPu7S8E0AB
	PvF1IO/KHX/ue4M4rmw6vQhcx57Ussv0i3j/LgKCmwS6v6glhIexmf3avxbVzdoxWw4yITaGP/L
	+xiQ7n4SFO7RuBimD/zYLnhRriGyQNeYasyTf4j66
X-Gm-Gg: ATEYQzydsVCIdVXamHhVbTIYjf9JVyxilX4ZzxFJ2of6amaNaLx7GTpmWQ7+O2DZVL1
	yOucO+aST91h/y2JQRHz9M3yIZ54QMTL7X+TNQk9e23gWlkLq9DuN0Co/EiunS6hm9KGZKfO6++
	w3beTBN4LrPGUikP2bU5ALbtPta9eqtHfSax9QorO6+pahym7TRa/n5LeIHkxWlGiEROJrQSQ22
	6IA8MZl+Rin282qqh9pyaDMra7V7pcQAqfcdj6E2nwBefLGvOoxQs9fDuZmzyzWow0fnZAKKzzD
	lCJFQSi4SrgEpKRLt8yh8xc+LHp8a8fIaOQ/7w==
X-Received: by 2002:aa7:d889:0:b0:65a:1240:b8c4 with SMTP id
 4fb4d7f45d1cf-66d95ac7d37mr3182a12.3.1774971815079; Tue, 31 Mar 2026 08:43:35
 -0700 (PDT)
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
References: <20260327205457.604224-1-surenb@google.com> <20260327205457.604224-6-surenb@google.com>
 <4e1c47a9-77a2-4f29-8de5-37f9958f5885@lucifer.local>
In-Reply-To: <4e1c47a9-77a2-4f29-8de5-37f9958f5885@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 31 Mar 2026 08:43:21 -0700
X-Gm-Features: AQROBzCrulzM_NYGi8iXSi5txAuufuUANImipjPaeV3dLXg1MucZzatFvm8IhI4
Message-ID: <CAJuCfpGpq+AiSNDEENAWQZvnDmvegu48o0C_SAixDPOWDEBUjw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] mm: use vma_start_write_killable() in process_vma_walk_lock()
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, 
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

On Tue, Mar 31, 2026 at 3:39=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> On Fri, Mar 27, 2026 at 01:54:56PM -0700, Suren Baghdasaryan wrote:
> > Replace vma_start_write() with vma_start_write_killable() when
> > process_vma_walk_lock() is used with PGWALK_WRLOCK option.
> > Adjust its direct and indirect users to check for a possible error
> > and handle it. Ensure users handle EINTR correctly and do not ignore
> > it. When queue_pages_range() fails, check whether it failed due to
> > a fatal signal or some other reason and return appropriate error.
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/proc/task_mmu.c | 12 ++++++------
> >  mm/mempolicy.c     | 10 +++++++++-
> >  mm/pagewalk.c      | 22 +++++++++++++++-------
> >  3 files changed, 30 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index e091931d7ca1..33e5094a7842 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1774,15 +1774,15 @@ static ssize_t clear_refs_write(struct file *fi=
le, const char __user *buf,
> >       struct vm_area_struct *vma;
> >       enum clear_refs_types type;
> >       int itype;
> > -     int rv;
> > +     int err;
> >
> >       if (count > sizeof(buffer) - 1)
> >               count =3D sizeof(buffer) - 1;
> >       if (copy_from_user(buffer, buf, count))
> >               return -EFAULT;
> > -     rv =3D kstrtoint(strstrip(buffer), 10, &itype);
> > -     if (rv < 0)
> > -             return rv;
> > +     err =3D kstrtoint(strstrip(buffer), 10, &itype);
> > +     if (err)
> > +             return err;
> >       type =3D (enum clear_refs_types)itype;
> >       if (type < CLEAR_REFS_ALL || type >=3D CLEAR_REFS_LAST)
> >               return -EINVAL;
> > @@ -1824,7 +1824,7 @@ static ssize_t clear_refs_write(struct file *file=
, const char __user *buf,
> >                                               0, mm, 0, -1UL);
> >                       mmu_notifier_invalidate_range_start(&range);
> >               }
> > -             walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
> > +             err =3D walk_page_range(mm, 0, -1, &clear_refs_walk_ops, =
&cp);
> >               if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
> >                       mmu_notifier_invalidate_range_end(&range);
> >                       flush_tlb_mm(mm);
> > @@ -1837,7 +1837,7 @@ static ssize_t clear_refs_write(struct file *file=
, const char __user *buf,
> >       }
> >       put_task_struct(task);
> >
> > -     return count;
> > +     return err ? : count;
> >  }
> >
> >  const struct file_operations proc_clear_refs_operations =3D {
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index c38a90487531..51f298cfc33b 100644
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
> >   */
> >  static long
> >  queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned =
long end,
> > @@ -1545,7 +1546,14 @@ static long do_mbind(unsigned long start, unsign=
ed long len,
> >                       flags | MPOL_MF_INVERT | MPOL_MF_WRLOCK, &pagelis=
t);
> >
> >       if (nr_failed < 0) {
> > -             err =3D nr_failed;
> > +             /*
> > +              * queue_pages_range() might override the original error =
with -EFAULT.
> > +              * Confirm that fatal signals are still treated correctly=
.
> > +              */
> > +             if (fatal_signal_pending(current))
> > +                     err =3D -EINTR;
> > +             else
> > +                     err =3D nr_failed;
>
> Is that really a big deal? Does it really matter if the caller doesn't ge=
t
> -EINTR in this case? This feels like another sashiko nitpick and is addin=
g a
> bunch of additional complexity here.

I think there is a difference in that the userspace caller will never
see EINTR, as Matthew explained in an earlier version, while EFAULT
will be seen and can be handled. I don't see why we wouldn't want to
report the correct error, and the code doing that seems clear and
straight-forward to me. That was in fact your suggested solution for
not checking for EINTR :)

>
> I mean if you 'filter' error messages you might always end up with an err=
or
> that's different than the original...
>
> >               nr_failed =3D 0;
> >       } else {
> >               vma_iter_init(&vmi, mm, start);
> > diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> > index 3ae2586ff45b..eca7bc711617 100644
> > --- a/mm/pagewalk.c
> > +++ b/mm/pagewalk.c
> > @@ -443,14 +443,13 @@ static inline void process_mm_walk_lock(struct mm=
_struct *mm,
> >               mmap_assert_write_locked(mm);
> >  }
> >
> > -static inline void process_vma_walk_lock(struct vm_area_struct *vma,
> > -                                      enum page_walk_lock walk_lock)
> > +static int process_vma_walk_lock(struct vm_area_struct *vma,
> > +                              enum page_walk_lock walk_lock)
> >  {
> >  #ifdef CONFIG_PER_VMA_LOCK
> >       switch (walk_lock) {
> >       case PGWALK_WRLOCK:
> > -             vma_start_write(vma);
> > -             break;
> > +             return vma_start_write_killable(vma);
> >       case PGWALK_WRLOCK_VERIFY:
> >               vma_assert_write_locked(vma);
> >               break;
> > @@ -462,6 +461,7 @@ static inline void process_vma_walk_lock(struct vm_=
area_struct *vma,
> >               break;
> >       }
> >  #endif
> > +     return 0;
> >  }
> >
> >  /*
> > @@ -505,7 +505,9 @@ int walk_page_range_mm_unsafe(struct mm_struct *mm,=
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
> >                       walk.vma =3D vma;
> >                       next =3D min(end, vma->vm_end);
> >                       vma =3D find_vma(mm, vma->vm_end);
> > @@ -722,6 +724,7 @@ int walk_page_range_vma_unsafe(struct vm_area_struc=
t *vma, unsigned long start,
> >               .vma            =3D vma,
> >               .private        =3D private,
> >       };
> > +     int err;
> >
> >       if (start >=3D end || !walk.mm)
> >               return -EINVAL;
> > @@ -729,7 +732,9 @@ int walk_page_range_vma_unsafe(struct vm_area_struc=
t *vma, unsigned long start,
> >               return -EINVAL;
> >
> >       process_mm_walk_lock(walk.mm, ops->walk_lock);
> > -     process_vma_walk_lock(vma, ops->walk_lock);
> > +     err =3D process_vma_walk_lock(vma, ops->walk_lock);
> > +     if (err)
> > +             return err;
> >       return __walk_page_range(start, end, &walk);
> >  }
> >
> > @@ -752,6 +757,7 @@ int walk_page_vma(struct vm_area_struct *vma, const=
 struct mm_walk_ops *ops,
> >               .vma            =3D vma,
> >               .private        =3D private,
> >       };
> > +     int err;
> >
> >       if (!walk.mm)
> >               return -EINVAL;
> > @@ -759,7 +765,9 @@ int walk_page_vma(struct vm_area_struct *vma, const=
 struct mm_walk_ops *ops,
> >               return -EINVAL;
> >
> >       process_mm_walk_lock(walk.mm, ops->walk_lock);
> > -     process_vma_walk_lock(vma, ops->walk_lock);
> > +     err =3D process_vma_walk_lock(vma, ops->walk_lock);
> > +     if (err)
> > +             return err;
> >       return __walk_page_range(vma->vm_start, vma->vm_end, &walk);
> >  }
> >
> > --
> > 2.53.0.1018.g2bb0e51243-goog
> >

