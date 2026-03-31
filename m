Return-Path: <linuxppc-dev+bounces-19099-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CED109B481
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 15:01:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flWXs2M21z2yZ6;
	Wed, 01 Apr 2026 02:01:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774969293;
	cv=pass; b=ljDAOz6ccjE26ot5NYkLoj/M55ti9oAwfBzoDEqeMgSrk9Pf0x6PJNum5Knp2WywRUWEfNsBy1wBIjE0O7dA3abltkI0z2zzC2mubiLhi+Tlbasb4z5KR0Ds2b1HPiZjsf5Hcz7LoN43cy2twQ0Ms7DcWjxu92q0Csc6g+d7Btv+PZRcDwevTME89x9tXnuF4GyZybaFnThiDrvHt2LO9+uYxvY32SSUget+XTkKS86x9UlMk5sL92B77ACTwRTkaVKRFxjGL6cpM3iNU+gcy696oknNbOyYswA7MdW3G6pdlloBjyj/7BsKuusuvdG+lC7zEeE1CsGfTVX0pmFd+g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774969293; c=relaxed/relaxed;
	bh=LoS9h+PlMeQ3PEM/ZRkHD+INDCJP8n/o6Cc2zJ/Ogk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIHLUQSvxqFZjYm2RH6MlfwSwbN0B0S8UP+5A467en7RVIEE+9YowFlfsSbmaqbLG+CbB2YybozIyiUIf7dW1IaMUKdgMsj4vSIAl/jo1UipbaIPZP2tij9jT0WRi4XbLcY70LBX7v4ZqjhZ2OXKlXcF8V/HOy6ZBrYrEmzFcL8f3WCLUrIRm9PmFSG95vtNdsAoRmGxexNWhBWU8NgCcA35KjmZ8sTRKQ2bEn/E2rrQ5Hrv6svFav/58t12AcG7kGjUIOmekK2uLOPvuMR66cizjOYt3mf/9SOzKovI/Vbhn81B9O9H1GvImpFfNQBoGoumKt2CQitTEmGBmV89Tw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kMaBpEso; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kMaBpEso;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flWXl16wfz2ySj
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 02:01:26 +1100 (AEDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-50b6c45781aso719461cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 08:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774969283; cv=none;
        d=google.com; s=arc-20240605;
        b=Lw7z7g2/XwmBhYpC0Pbc5fgwjEjUidVIVegQu4ruS6Xa0UOJEufreTU7kFth/OPogW
         HqOoZ/AnKD2bvGuG6xlvPiDqRNK7Ef2rdZKsAYfViqChCpQ0Nk1Vs2mFjdIRkhOQs/te
         qt36FAgrnH5yGTWczmMGnLzsOipvl9qh9h0LUhsnuYeL9gJcguKYfWxUsSSQO6nfo5m2
         GC8W5yy2dG9hxVprR7YatfW6utiMaTX/MlpJ+RxvUe1j6XyyBWxTKoiEOW31GtXoDPEx
         V6Sd77t7gNHagT99AFkskrR21Uck1DDEtIy3oK6kt+BiwtDjAyvRMh4CmN74ZeTrYfSk
         s97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LoS9h+PlMeQ3PEM/ZRkHD+INDCJP8n/o6Cc2zJ/Ogk8=;
        fh=Dk6qZDdfVmkyEIgEUQqkULGZgMOPOx8jEEDGTSWe8GE=;
        b=UsChg55T9tCZ/0qJnexuQTvf4UhUcMhGqbnqECYnnEAri/XTev8JfWoZ/IxXfLsMgB
         0BiE07jrAs/DwI3v/QHpF17/50XDSDry8WcqUOxTgDU/6EEwOu3wvbxz5gKmi1UbJezY
         FS80lgRb8DQmgluZANYCk7Bm+ZwXZymHiP21Es+5YdUK2RzhkZAL7S8rxttjXiXBVDLu
         txbqLi70xt7X9YQ2liUjOIx+KOwY9sD8TeeKQdjpk/TH2uUAjVKld7lILIYeWiWTT2+a
         cu2PeCqwmUb4SW9g/S0j6DNFJ35rOrv5QKvDC7yWwcITGY/vpxemwMVnlrtZZ4Rc9CDV
         YVRw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774969283; x=1775574083; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoS9h+PlMeQ3PEM/ZRkHD+INDCJP8n/o6Cc2zJ/Ogk8=;
        b=kMaBpEsorrRHKeQ21d7HMmNoaVRSe55hHWMiR4/OXiTVjiraiB5t9Fz4GA6+PRkMGi
         BOcTLABEZlQA9Joj3fdT5WY3OcWCs9oFfpj5Ix1yzXMswD2yaZdaQW8dUavNC6vZvUV2
         aumMCpIQzdNaEKd8wHvOqF4p97hPtJPu785R5Jmpoc7JdrTthSeypVac62hRFn/Yhva0
         VjQ+27o0TPt6NVfKD0vg1GFOdHevybPWna1W4XHr4wyfI3pDGHAOgjbiNM6F4lCqrJRh
         /T4Fc28Wfjx69Hcnc5azIUfRwW4iG6GcCsnHPDfGPqtRN+0N5DP8482+Xn00eFm13elk
         hC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774969283; x=1775574083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LoS9h+PlMeQ3PEM/ZRkHD+INDCJP8n/o6Cc2zJ/Ogk8=;
        b=r0HpugWUJ4AiyvwQNpIee8LeXshnFLKCGHuI8yf18itfOQmhYTViin2oF+il6uTqTG
         hnziK1SQOxdzvtubE78OhwM79ZK287SG8RN9/az9NHzz0y1At628YZRv8HCmSX8/xqVM
         L4EPNDrx+HegG01x8Rdf5tNDbiSahKMH6xGuITWhV+RLE9prDkp5GFn4jc2osjJ3mBTP
         MQhXE9d2yAgrE72YWkLp2DW+VNMjf+xkGQIJxnvUFCqMENl607TgvRXvEsUXUzQqFi9a
         49TfQxOpZhNdo5TOFNTI/52x6DzwgwS3BSv4yqJx7udZE5PNBrf136FkpyjO1dhphIYx
         8hBw==
X-Forwarded-Encrypted: i=1; AJvYcCUthsga4OI3ItDA9StVujQo94VSupb5l5TBjWQdUoVMZPFOT0N1Q6d6qOX8PDBWBMH8UgZf9tpLBk/qItQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw4/Rt4gPuJ1NUce4vSu0kbczc/nvi+wvjBf9zqj47Ezngvhsdj
	yUX385RaPB9R6tIIBeXEQNkFG7A/oNAw+Sgfns8AbF3gh2g0gq/KP21cUrwBOhsSYcRDe0TyGl3
	7u+Y9a8W6qg5VeLLAX2+EpIoAack2U5y9rXsU81K0
X-Gm-Gg: ATEYQzyqlRBnM3WELl342TLSyd1GdSfiBeCDlDi5/yEot7vOMvOprk/TF5nVLlnwxH0
	cG4VowR1mvyREagn7UYOlV+zdU1oPp59WUCtUg+AMF3KL6KOhSEWoryur92T7vA/NS7n+FkcPxW
	6qw4uQA006bDTxedO4DYcEflfYVR6O0WgGLZOIS/47ZmkWM8rrre0xnPRWE1nTL7w0MGuv1/rXF
	0iu8zzTY+l+R0APICQtlt7yK3hTsfqwYwPPiPAHSF5zImvtyKySy15aGER+Koo+nnTI3OiNyqKE
	zp4ZjIp8NbJWRTega5g1jHUqzF2UQtnKNEAYXw==
X-Received: by 2002:a05:622a:148e:b0:50b:b9cf:174a with SMTP id
 d75a77b69052e-50d2d5499ddmr16564701cf.10.1774969282508; Tue, 31 Mar 2026
 08:01:22 -0700 (PDT)
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
References: <20260327205457.604224-1-surenb@google.com> <20260327205457.604224-3-surenb@google.com>
 <5d90d998-9b8d-435c-b684-260600311797@lucifer.local>
In-Reply-To: <5d90d998-9b8d-435c-b684-260600311797@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 31 Mar 2026 08:01:11 -0700
X-Gm-Features: AQROBzAe1qnr0miY-J5_JzTg_-AEHID4nChZIGIYiqqiWAm0zj18MBgoLYdvCpQ
Message-ID: <CAJuCfpE5w8r_6Ss=5ZPrEb1RQOTG6HyY8Pivac=iiyqFRZvD4g@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] mm: use vma_start_write_killable() in mm syscalls
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

On Tue, Mar 31, 2026 at 2:35=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> On Fri, Mar 27, 2026 at 01:54:53PM -0700, Suren Baghdasaryan wrote:
> > Replace vma_start_write() with vma_start_write_killable() in syscalls,
> > improving reaction time to the kill signal.
> >
> > In a number of places we now lock VMA earlier than before to avoid
> > doing work and undoing it later if a fatal signal is pending. This
> > is safe because the moves are happening within sections where we
> > already hold the mmap_write_lock, so the moves do not change the
> > locking order relative to other kernel locks.
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> I think Sashiko (presumably) has regressed this series :/
>
> > ---
> >  mm/madvise.c   | 13 ++++++++++---
> >  mm/memory.c    |  2 ++
> >  mm/mempolicy.c | 11 +++++++++--
> >  mm/mlock.c     | 30 ++++++++++++++++++++++++------
> >  mm/mprotect.c  | 25 +++++++++++++++++--------
> >  mm/mremap.c    |  8 +++++---
> >  mm/mseal.c     | 24 +++++++++++++++++++-----
> >  7 files changed, 86 insertions(+), 27 deletions(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 69708e953cf5..f2c7b0512cdf 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -172,10 +172,17 @@ static int madvise_update_vma(vm_flags_t new_flag=
s,
> >       if (IS_ERR(vma))
> >               return PTR_ERR(vma);
> >
> > -     madv_behavior->vma =3D vma;
> > +     /*
> > +      * If a new vma was created during vma_modify_XXX, the resulting
> > +      * vma is already locked. Skip re-locking new vma in this case.
> > +      */
>
> well you're not re-locking, in vma_start_write_killable() we have:
>
>         if (__is_vma_write_locked(vma))
>                 return 0;
>
> So I'm not sure this is really worth the effort? Was this a sashiko 'find=
'?
>
> And is 're-locking' the right thing to say here? Probably nitty but that =
to me
> implies you're locking again when in fact you're just calling the functio=
n only
> to check seq nums uselessly and have a nop.
>
> But it's not like we're on a hotpath here where we're sweating every litt=
le
> thing, we're already taking the mmap write lock and doing heavy operation=
s
> etc. so not sure we care all that much.
>
> OTOH, it's hardly like this is a bad thing so don't want to hold up serie=
s.
>
> > +     if (vma =3D=3D madv_behavior->vma) {
> > +             if (vma_start_write_killable(vma))
> > +                     return -EINTR;
> > +     } else {
> > +             madv_behavior->vma =3D vma;
> > +     }
>
> This is kind of ugly.
>
> Can't we just do:
>
>         const struct vm_area_struct *old_vma =3D madv_behavior->vma;
>         struct vm_area_struct *vma =3D old_vma;
>
> ...
>         madv_behavior->vma =3D vma;
>         /* If the VMA didn't change, it isn't locked yet. */
>         if (vma =3D=3D old_vma && vma_start_write_killable(vma))
>                 return -EINTR;
>
> Instead? That is, assuming we really need to care about this at all.
>
> But I think I don't like this change at all?

Yeah, this was the part I wasn't sure if it's worth adding. With your
vote confirming my scepticism I'll go ahead and remove the parts I
added to avoid extra vma_start_write_killable() call (3 instances in
all) and will post v7.
Thanks,
Suren.

>
> >
> > -     /* vm_flags is protected by the mmap_lock held in write mode. */
> > -     vma_start_write(vma);
> >       vma->flags =3D new_vma_flags;
> >       if (set_new_anon_name)
> >               return replace_anon_vma_name(vma, anon_name);
> > diff --git a/mm/memory.c b/mm/memory.c
> > index e44469f9cf65..9f99ec634831 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -366,6 +366,8 @@ void free_pgd_range(struct mmu_gather *tlb,
> >   * page tables that should be removed.  This can differ from the vma m=
appings on
> >   * some archs that may have mappings that need to be removed outside t=
he vmas.
> >   * Note that the prev->vm_end and next->vm_start are often used.
> > + * We don't use vma_start_write_killable() because page tables should =
be freed
> > + * even if the task is being killed.
> >   *
> >   * The vma_end differs from the pg_end when a dup_mmap() failed and th=
e tree has
> >   * unrelated data to the mm_struct being torn down.
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index fd08771e2057..c38a90487531 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -1784,7 +1784,8 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned=
 long, start, unsigned long, le
> >               return -EINVAL;
> >       if (end =3D=3D start)
> >               return 0;
> > -     mmap_write_lock(mm);
> > +     if (mmap_write_lock_killable(mm))
> > +             return -EINTR;
> >       prev =3D vma_prev(&vmi);
> >       for_each_vma_range(vmi, vma, end) {
> >               /*
> > @@ -1801,13 +1802,19 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsign=
ed long, start, unsigned long, le
> >                       err =3D -EOPNOTSUPP;
> >                       break;
> >               }
> > +             /*
> > +              * Lock the VMA early to avoid extra work if fatal signal
> > +              * is pending.
> > +              */
> > +             err =3D vma_start_write_killable(vma);
> > +             if (err)
> > +                     break;
> >               new =3D mpol_dup(old);
> >               if (IS_ERR(new)) {
> >                       err =3D PTR_ERR(new);
> >                       break;
> >               }
> >
> > -             vma_start_write(vma);
> >               new->home_node =3D home_node;
> >               err =3D mbind_range(&vmi, vma, &prev, start, end, new);
> >               mpol_put(new);
> > diff --git a/mm/mlock.c b/mm/mlock.c
> > index 8c227fefa2df..2ed454db7cf7 100644
> > --- a/mm/mlock.c
> > +++ b/mm/mlock.c
> > @@ -419,8 +419,10 @@ static int mlock_pte_range(pmd_t *pmd, unsigned lo=
ng addr,
> >   *
> >   * Called for mlock(), mlock2() and mlockall(), to set @vma VM_LOCKED;
> >   * called for munlock() and munlockall(), to clear VM_LOCKED from @vma=
.
> > + *
> > + * Return: 0 on success, -EINTR if fatal signal is pending.
> >   */
> > -static void mlock_vma_pages_range(struct vm_area_struct *vma,
> > +static int mlock_vma_pages_range(struct vm_area_struct *vma,
> >       unsigned long start, unsigned long end,
> >       vma_flags_t *new_vma_flags)
> >  {
> > @@ -442,7 +444,9 @@ static void mlock_vma_pages_range(struct vm_area_st=
ruct *vma,
> >        */
> >       if (vma_flags_test(new_vma_flags, VMA_LOCKED_BIT))
> >               vma_flags_set(new_vma_flags, VMA_IO_BIT);
> > -     vma_start_write(vma);
> > +     if (vma_start_write_killable(vma))
> > +             return -EINTR;
> > +
> >       vma_flags_reset_once(vma, new_vma_flags);
> >
> >       lru_add_drain();
> > @@ -453,6 +457,7 @@ static void mlock_vma_pages_range(struct vm_area_st=
ruct *vma,
> >               vma_flags_clear(new_vma_flags, VMA_IO_BIT);
> >               vma_flags_reset_once(vma, new_vma_flags);
> >       }
> > +     return 0;
> >  }
> >
> >  /*
> > @@ -506,11 +511,15 @@ static int mlock_fixup(struct vma_iterator *vmi, =
struct vm_area_struct *vma,
> >        */
> >       if (vma_flags_test(&new_vma_flags, VMA_LOCKED_BIT) &&
> >           vma_flags_test(&old_vma_flags, VMA_LOCKED_BIT)) {
> > +             ret =3D vma_start_write_killable(vma);
> > +             if (ret)
> > +                     goto out; /* mm->locked_vm is fine as nr_pages =
=3D=3D 0 */
> >               /* No work to do, and mlocking twice would be wrong */
> > -             vma_start_write(vma);
> >               vma->flags =3D new_vma_flags;
> >       } else {
> > -             mlock_vma_pages_range(vma, start, end, &new_vma_flags);
> > +             ret =3D mlock_vma_pages_range(vma, start, end, &new_vma_f=
lags);
> > +             if (ret)
> > +                     mm->locked_vm -=3D nr_pages;
> >       }
> >  out:
> >       *prev =3D vma;
> > @@ -739,9 +748,18 @@ static int apply_mlockall_flags(int flags)
> >
> >               error =3D mlock_fixup(&vmi, vma, &prev, vma->vm_start, vm=
a->vm_end,
> >                                   newflags);
> > -             /* Ignore errors, but prev needs fixing up. */
> > -             if (error)
> > +             if (error) {
> > +                     /*
> > +                      * If we failed due to a pending fatal signal, re=
turn
> > +                      * now. If we locked the vma before signal arrive=
d, it
> > +                      * will be unlocked when we drop mmap_write_lock.
> > +                      */
> > +                     if (fatal_signal_pending(current))
> > +                             return -EINTR;
> > +
> > +                     /* Ignore errors, but prev needs fixing up. */
> >                       prev =3D vma;
> > +             }
> >               cond_resched();
> >       }
> >  out:
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 110d47a36d4b..d6227877465f 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -700,6 +700,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu=
_gather *tlb,
> >       const vma_flags_t old_vma_flags =3D READ_ONCE(vma->flags);
> >       vma_flags_t new_vma_flags =3D legacy_to_vma_flags(newflags);
> >       long nrpages =3D (end - start) >> PAGE_SHIFT;
> > +     struct vm_area_struct *new_vma;
> >       unsigned int mm_cp_flags =3D 0;
> >       unsigned long charged =3D 0;
> >       int error;
> > @@ -756,19 +757,27 @@ mprotect_fixup(struct vma_iterator *vmi, struct m=
mu_gather *tlb,
> >               vma_flags_clear(&new_vma_flags, VMA_ACCOUNT_BIT);
> >       }
> >
> > -     vma =3D vma_modify_flags(vmi, *pprev, vma, start, end, &new_vma_f=
lags);
> > -     if (IS_ERR(vma)) {
> > -             error =3D PTR_ERR(vma);
> > +     new_vma =3D vma_modify_flags(vmi, *pprev, vma, start, end,
> > +                                &new_vma_flags);
> > +     if (IS_ERR(new_vma)) {
> > +             error =3D PTR_ERR(new_vma);
> >               goto fail;
> >       }
> >
> > -     *pprev =3D vma;
> > -
> >       /*
> > -      * vm_flags and vm_page_prot are protected by the mmap_lock
> > -      * held in write mode.
> > +      * If a new vma was created during vma_modify_flags, the resultin=
g
> > +      * vma is already locked. Skip re-locking new vma in this case.
> >        */
> > -     vma_start_write(vma);
> > +     if (new_vma =3D=3D vma) {
> > +             error =3D vma_start_write_killable(vma);
> > +             if (error)
> > +                     goto fail;
> > +     } else {
> > +             vma =3D new_vma;
> > +     }
>
> I mean again this is hideous and I don't know why we're bothering? This j=
ust
> introduces even more open-coded VMA lock specific stuff everywhere.
>
> And the comment is just not correct, we're not re-locking anything if it'=
s
> already locked...
>
> > +
> > +     *pprev =3D vma;
> > +
> >       vma_flags_reset_once(vma, &new_vma_flags);
> >       if (vma_wants_manual_pte_write_upgrade(vma))
> >               mm_cp_flags |=3D MM_CP_TRY_CHANGE_WRITABLE;
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index e9c8b1d05832..0860102bddab 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -1348,6 +1348,11 @@ static unsigned long move_vma(struct vma_remap_s=
truct *vrm)
> >       if (err)
> >               return err;
> >
> > +     /* We don't want racing faults. */
> > +     err =3D vma_start_write_killable(vrm->vma);
> > +     if (err)
> > +             return err;
> > +
> >       /*
> >        * If accounted, determine the number of bytes the operation will
> >        * charge.
> > @@ -1355,9 +1360,6 @@ static unsigned long move_vma(struct vma_remap_st=
ruct *vrm)
> >       if (!vrm_calc_charge(vrm))
> >               return -ENOMEM;
> >
> > -     /* We don't want racing faults. */
> > -     vma_start_write(vrm->vma);
> > -
> >       /* Perform copy step. */
> >       err =3D copy_vma_and_data(vrm, &new_vma);
> >       /*
> > diff --git a/mm/mseal.c b/mm/mseal.c
> > index 603df53ad267..1ea19fd3d384 100644
> > --- a/mm/mseal.c
> > +++ b/mm/mseal.c
> > @@ -70,14 +70,28 @@ static int mseal_apply(struct mm_struct *mm,
> >
> >               if (!vma_test(vma, VMA_SEALED_BIT)) {
> >                       vma_flags_t vma_flags =3D vma->flags;
> > +                     struct vm_area_struct *new_vma;
> >
> >                       vma_flags_set(&vma_flags, VMA_SEALED_BIT);
> >
> > -                     vma =3D vma_modify_flags(&vmi, prev, vma, curr_st=
art,
> > -                                            curr_end, &vma_flags);
> > -                     if (IS_ERR(vma))
> > -                             return PTR_ERR(vma);
> > -                     vma_start_write(vma);
> > +                     new_vma =3D vma_modify_flags(&vmi, prev, vma, cur=
r_start,
> > +                                                curr_end, &vma_flags);
> > +                     if (IS_ERR(new_vma))
> > +                             return PTR_ERR(new_vma);
> > +
> > +                     /*
> > +                      * If a new vma was created during vma_modify_fla=
gs,
> > +                      * the resulting vma is already locked.
> > +                      * Skip re-locking new vma in this case.
> > +                      */
> > +                     if (new_vma =3D=3D vma) {
> > +                             int err =3D vma_start_write_killable(vma)=
;
> > +                             if (err)
> > +                                     return err;
> > +                     } else {
> > +                             vma =3D new_vma;
> > +                     }
> > +
>
> I mean this is the exact same open-coded block all over this patch, and a=
gain I
> don't see the point...
>
> The VMA locking is tricky enough that I don't think doing this is a good =
idea,
> especially on the basis of 'avoid looking at sequence numbers under mmap =
write
> lock' or something.
>
> >                       vma_set_flags(vma, VMA_SEALED_BIT);
> >               }
> >
> > --
> > 2.53.0.1018.g2bb0e51243-goog
> >

