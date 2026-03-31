Return-Path: <linuxppc-dev+bounces-19103-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03400109B48F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 15:37:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flXLF4Kjlz2ybR;
	Wed, 01 Apr 2026 02:37:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774971445;
	cv=pass; b=YOJSnRshpicc4EsyJqNu+kUi5E1N31U/do2hd8GMUh2IMMI4o8Pjihwi4h3kFK8lQZLIbY96zwZpRLQf//2K09eikwub4BnTLi/IGa8rwAvNMYt5LMVDqGQe/uhxLfZMlb3QffzdvTcQKxh3+ajf5RS2Gz47S1ylhCRgfuzWNDZ2RjjImkEXD1pe4+39/1VHvC0bc7aYe2I3Uu0g2Hc8kykp/MQtvmbkNAg4GQsK4cf4x1MjPhigcagxDONVE/lvqhOyJhktko52oBlBRPQcIUaZu4rsJFrTulJfBZ8pHntVuVogIIbxQeUL3dXjpOdGtGuw/HrviAQgRh626vfNcg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774971445; c=relaxed/relaxed;
	bh=MKbaIn/Erm/OKC3BYhqOYCRieKJ7mZWnRM71s1E5vDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9rZ67c7+SyPQYrx8rDI93ZhkTwrjeow3Vk54zPnB9tHtZc4fnLFx1/C+t7tWbywC1D4Wo0Xl/o9XjymhCw4zqtYTatvWNMui3V6e6lKcHPQKYHS7O09H6rMeEDJkMPaaMcpcjuDzIymvqlEpof+s9Q0Mwzwf3ZO6RKa1RvmWKeMt5KuhVBtnypWbiz3QTT9pmMQphCkcx+U7GVtGpe58dNdbJVrjxoV0pExEncGGZfS6IC3RM/+WvRKTb+O7oFAo+av4q4Fe55WFudttixGLZZ2rSXPuq4HvnB9DZp/8hxC1XAes7eRu0UcNd/0FVTkWi4rEvWmGG2p6ikNEaD/rg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cWhow+fg; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cWhow+fg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flXLD1Ccfz2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 02:37:24 +1100 (AEDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-66bb7118c96so14089a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 08:37:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774971441; cv=none;
        d=google.com; s=arc-20240605;
        b=CEasE8+l8ObzjTQQr2iopl10/Q6Pc6t4j8ATEEHoMINXaTnryfUqBm2tF83rwc2Aly
         AwGUxYDg93crv+5YH4s2qDC21Ul+qO2VzFSFo3rY+O70IrSDGPG6udiVr+T9VOct2XsX
         dIPDziTyIdy5ETI+vqZGMvciEYoDpfYNmq8/tj/j0TwIJqN1rplblldcTFlUASYa2Dc4
         /LjcWxyS63ORXRJn8wURyJ+UqKl6VEss0aSqDuYGFGnD/S+m5WZhzmrOc/ho4qf2k/2m
         qAzV1wjNzh0BzlunwscfYbB3ZPjthZNeDuSpTfZMCCch4glvMjDx+ldiRIBHGhCiEqPs
         eCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MKbaIn/Erm/OKC3BYhqOYCRieKJ7mZWnRM71s1E5vDo=;
        fh=z5th2JNrZ280CTjyWjqhOI6+ysIPweWFm9qLU1dlWWQ=;
        b=S3MWcIDTGdQBkbFmAqJctmMHWCXZ7n4G3Ax6OgZlT13jrZyTt2/RhBE9MsshWbVsdg
         UT/u+H83uJL+gH0RsPCrJzVuBpOiMjgiDf7KXEIG4wXSRV6JDyrb1KUHMlPB7T6j1bZ0
         IiQxPlIfWTp4jatNrmhCNd2B4iTu0jz/MgDCBR+ikXN+On6xD9tgQRII2RCLvYU868oj
         fNzMqkZDqqmnrWvH1fkBiHwP5pHzhss4GSgezBG/c+HqDRwa+rwK7Vx52QH9xVsspK6f
         zCzoBDQ+E4vn3iUPM0hxK04OLYKFKD/8w22Dxc3cGxhbD6YmRU6WtxBzo5rE0P13DyzP
         UMwA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774971441; x=1775576241; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKbaIn/Erm/OKC3BYhqOYCRieKJ7mZWnRM71s1E5vDo=;
        b=cWhow+fgg6Gir2fVCC15VRINwinyj9eKMK/GhWDR36Q+0fxu81MawQ46z55fW9P90V
         SILWtDejD8meiQuyEg1ZfjJkeuBhH8Jkm6Sk5TXVcERmV/QMlp1thC/GjQt2NCAZiFWT
         GLWPZkUGSykFAN4WaNtRTK0M40aTSokifAtCVP79V+6KZ7c8hM0nw+bo5PB3S4T7hrq8
         av/GUW+LKTXSw4cQFKYCQegf9tjDxYUDNyyxus4c2V87GcZJ4nryUPZGDEvK6HTXKhPs
         twh7MFZypNNs5KZq8PnMqoyXRnj7LpneCsKkwPajhOCovEH7x7rl97LOfb8lUIOQvF2m
         T3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971441; x=1775576241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MKbaIn/Erm/OKC3BYhqOYCRieKJ7mZWnRM71s1E5vDo=;
        b=Xnh76P1X1dNTg/2QfiWSsDblQdNFDs+xlWz2XX4nRJH4eA9fQxuXbxhxQgP2avBLnk
         bau4JfeecyvgKpMnvsfhYeMjXdh+269QrwvtQuZvoDMzt26W+54eOBcbGrvFo7hhLCHA
         MmQSpps/68it+IJrwiKRqaiW1UU19pl+qVEWO2yqQ5l4mc8g0snkvQVUnANtmHDIsQJp
         6udpBoz2HnrxtbFH3D1pwuxHaa2lACxtlnuIh8EoIdYhfs3Z6O2WYS+ZAxQ6m3PN7TG8
         sVcEnFqHbWBULIyVNpNodkk47DbioLP7saMyrJcmueOHo6gxo656vdQ0gOvL8nAGaovn
         cO1A==
X-Forwarded-Encrypted: i=1; AJvYcCV31mfMJZAdFGShxW81tYteb9PT5dAt1QLTmDtCNQcFxrW0YzRcygCwtaxszoKXQHyJ9GD3OJjTYQqkqyQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YywcKHTaKzsvMjm3er5oeuTzoS299wiOxWKfxnR9uxZUnXDfW+V
	4V75HIRLHnX1sXzPHe8iNf64uZmowqpPusrBZsSssBsCfAy+sqJfWTdwcOlzsO3VT27kRaVFY6A
	XIX77Gynnk8gaT0NkRm0aZqzxTFf4evL947rP7hlR
X-Gm-Gg: ATEYQzyRmqd+oSJWoFtwMRFe2Jw6/pOPwONDebNENtHgIqouYfnJ04akiTPGkiOEkk7
	urfndpPbYDCdXrGj1POYxrxxueHNfm1jRLcMfIwiYu1aSdGof3Fb7rcXW0l0boMJu2NWhd8z/v1
	5Xi/5csbeYTg2/CjFzgUICbzLcntQ5vRT70RUTzPZIAmKKQNJUQjEL1ja8f7oiPVpmUwZCh6Cf8
	x3ByZsx8vsfr547yvd8NBFwfQMwUE4lzVYyc6OBTIPOLRO56trmF8lEQCAsEGxQIKZ7uVL1YyiK
	ATvKXdMUfGP+fJ25Z9stNUJMpWRXSX9G65jc4g==
X-Received: by 2002:aa7:d889:0:b0:65a:1240:b8c4 with SMTP id
 4fb4d7f45d1cf-66d95ac7d37mr2610a12.3.1774971440376; Tue, 31 Mar 2026 08:37:20
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
References: <20260327205457.604224-1-surenb@google.com> <20260327205457.604224-5-surenb@google.com>
 <e490c85f-e1e6-4722-9399-e4743549a390@lucifer.local>
In-Reply-To: <e490c85f-e1e6-4722-9399-e4743549a390@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 31 Mar 2026 08:37:06 -0700
X-Gm-Features: AQROBzC2ce12XO-wrMbjKgwg4rrHJ7TFHnXAWz9ZLQknqrZfo06VAqH0Uhfwo2M
Message-ID: <CAJuCfpEOynabVz3Z2o6-KZAbE-bT49oXtR68GeS7YmCrYzC6ww@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] mm/vma: use vma_start_write_killable() in vma operations
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

On Tue, Mar 31, 2026 at 3:24=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> On Fri, Mar 27, 2026 at 01:54:55PM -0700, Suren Baghdasaryan wrote:
> > Replace vma_start_write() with vma_start_write_killable(), improving
> > reaction time to the kill signal.
> > Replace vma_start_write() calls when we operate on VMAs.
> >
> > To propagate errors from vma_merge_existing_range() and vma_expand()
> > we fake an ENOMEM error when we fail due to a pending fatal signal.
> > This is a temporary workaround. Fixing this requires some refactoring
> > and will be done separately in the future.
> >
> > In a number of places we now lock VMA earlier than before to avoid
> > doing work and undoing it later if a fatal signal is pending. This
> > is safe because the moves are happening within sections where we
> > already hold the mmap_write_lock, so the moves do not change the
> > locking order relative to other kernel locks.
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/vma.c      | 146 ++++++++++++++++++++++++++++++++++++++------------
> >  mm/vma_exec.c |   6 ++-
> >  2 files changed, 117 insertions(+), 35 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index ba78ab1f397a..cc382217f730 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -524,6 +524,21 @@ __split_vma(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
> >               new->vm_pgoff +=3D ((addr - vma->vm_start) >> PAGE_SHIFT)=
;
> >       }
> >
> > +     /*
> > +      * Lock VMAs before cloning to avoid extra work if fatal signal
> > +      * is pending.
> > +      */
> > +     err =3D vma_start_write_killable(vma);
> > +     if (err)
> > +             goto out_free_vma;
> > +     /*
> > +      * Locking a new detached VMA will always succeed but it's just a
> > +      * detail of the current implementation, so handle it all the sam=
e.
> > +      */
> > +     err =3D vma_start_write_killable(new);
> > +     if (err)
> > +             goto out_free_vma;
> > +
> >       err =3D -ENOMEM;
> >       vma_iter_config(vmi, new->vm_start, new->vm_end);
> >       if (vma_iter_prealloc(vmi, new))
> > @@ -543,9 +558,6 @@ __split_vma(struct vma_iterator *vmi, struct vm_are=
a_struct *vma,
> >       if (new->vm_ops && new->vm_ops->open)
> >               new->vm_ops->open(new);
> >
> > -     vma_start_write(vma);
> > -     vma_start_write(new);
> > -
> >       init_vma_prep(&vp, vma);
> >       vp.insert =3D new;
> >       vma_prepare(&vp);
> > @@ -900,12 +912,22 @@ static __must_check struct vm_area_struct *vma_me=
rge_existing_range(
> >       }
> >
> >       /* No matter what happens, we will be adjusting middle. */
> > -     vma_start_write(middle);
> > +     err =3D vma_start_write_killable(middle);
> > +     if (err) {
> > +             /* Ensure error propagates. */
> > +             vmg->give_up_on_oom =3D false;
> > +             goto abort;
> > +     }
> >
> >       if (merge_right) {
> >               vma_flags_t next_sticky;
> >
> > -             vma_start_write(next);
> > +             err =3D vma_start_write_killable(next);
> > +             if (err) {
> > +                     /* Ensure error propagates. */
> > +                     vmg->give_up_on_oom =3D false;
> > +                     goto abort;
> > +             }
> >               vmg->target =3D next;
> >               next_sticky =3D vma_flags_and_mask(&next->flags, VMA_STIC=
KY_FLAGS);
> >               vma_flags_set_mask(&sticky_flags, next_sticky);
> > @@ -914,7 +936,12 @@ static __must_check struct vm_area_struct *vma_mer=
ge_existing_range(
> >       if (merge_left) {
> >               vma_flags_t prev_sticky;
> >
> > -             vma_start_write(prev);
> > +             err =3D vma_start_write_killable(prev);
> > +             if (err) {
> > +                     /* Ensure error propagates. */
> > +                     vmg->give_up_on_oom =3D false;
> > +                     goto abort;
> > +             }
> >               vmg->target =3D prev;
> >
> >               prev_sticky =3D vma_flags_and_mask(&prev->flags, VMA_STIC=
KY_FLAGS);
> > @@ -1170,10 +1197,18 @@ int vma_expand(struct vma_merge_struct *vmg)
> >       vma_flags_t sticky_flags =3D
> >               vma_flags_and_mask(&vmg->vma_flags, VMA_STICKY_FLAGS);
> >       vma_flags_t target_sticky;
> > -     int err =3D 0;
> > +     int err;
> >
> >       mmap_assert_write_locked(vmg->mm);
> > -     vma_start_write(target);
> > +     err =3D vma_start_write_killable(target);
> > +     if (err) {
> > +             /*
> > +              * Override VMA_MERGE_NOMERGE to prevent callers from
> > +              * falling back to a new VMA allocation.
> > +              */
> > +             vmg->state =3D VMA_MERGE_ERROR_NOMEM;
> > +             return err;
> > +     }
> >
> >       target_sticky =3D vma_flags_and_mask(&target->flags, VMA_STICKY_F=
LAGS);
> >
> > @@ -1201,6 +1236,19 @@ int vma_expand(struct vma_merge_struct *vmg)
> >        * we don't need to account for vmg->give_up_on_mm here.
> >        */
> >       if (remove_next) {
> > +             /*
> > +              * Lock the VMA early to avoid extra work if fatal signal
> > +              * is pending.
> > +              */
> > +             err =3D vma_start_write_killable(next);
> > +             if (err) {
> > +                     /*
> > +                      * Override VMA_MERGE_NOMERGE to prevent callers =
from
> > +                      * falling back to a new VMA allocation.
> > +                      */
>
> I don't think we need huge, duplicated comments everywhere.
>
> I don't like us effectively lying about an OOM.
>
> Here's what I said on v4:
>
> https://lore.kernel.org/all/9845b243-1984-4d74-9feb-d9d28757fba6@lucifer.=
local/
>
>         I think we need to update vma_modify():
>
>                 /* First, try to merge. */
>                 merged =3D vma_merge_existing_range(vmg);
>                 if (merged)
>                         return merged;
>                 if (vmg_nomem(vmg))
>                         return ERR_PTR(-ENOMEM);
>         +       if (fatal_signal_pending(current))
>         +               return -EINTR;
>
> OK I see you replied:
>
>         We need to be careful here. I think there are cases when vma is
>         modified from a context of a different process, for example in
>         process_madvise(). fatal_signal_pending(current) would yield inco=
rrect
>         result because vma->vm_mm is not the same as current->mm.
>
> Sorry missed that.
>
> That's utterly horrible, yes.
>
> I'm sorry but I think this series then is going to have to wait for me to=
 rework
> this code, unfortunately.
>
> I can't really stand you returning a fake error code it's too confusing.
>
> I guess I'll have to go do that as a priority then and maybe queue it up =
so it's
> kinda ready for 7.2.
>
> In any case I said in reply to the cover, I think this series is going to=
 have
> to wait for next cycle (i.e. 7.2), sorry. Just too many functional change=
s in
> this revision.

Sounds reasonable. I'm not a fan of faking the error code myself, so
hopefully, this change becomes much simpler after your rework.

>
> > +                     vmg->state =3D VMA_MERGE_ERROR_NOMEM;
> > +                     return err;
> > +             }
> >               err =3D dup_anon_vma(target, next, &anon_dup);
> >               if (err)
> >                       return err;
> > @@ -1214,7 +1262,6 @@ int vma_expand(struct vma_merge_struct *vmg)
> >       if (remove_next) {
> >               vma_flags_t next_sticky;
> >
> > -             vma_start_write(next);
> >               vmg->__remove_next =3D true;
> >
> >               next_sticky =3D vma_flags_and_mask(&next->flags, VMA_STIC=
KY_FLAGS);
> > @@ -1252,9 +1299,14 @@ int vma_shrink(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
> >              unsigned long start, unsigned long end, pgoff_t pgoff)
> >  {
> >       struct vma_prepare vp;
> > +     int err;
> >
> >       WARN_ON((vma->vm_start !=3D start) && (vma->vm_end !=3D end));
> >
> > +     err =3D vma_start_write_killable(vma);
> > +     if (err)
> > +             return err;
> > +
> >       if (vma->vm_start < start)
> >               vma_iter_config(vmi, vma->vm_start, start);
> >       else
> > @@ -1263,8 +1315,6 @@ int vma_shrink(struct vma_iterator *vmi, struct v=
m_area_struct *vma,
> >       if (vma_iter_prealloc(vmi, NULL))
> >               return -ENOMEM;
> >
> > -     vma_start_write(vma);
> > -
> >       init_vma_prep(&vp, vma);
> >       vma_prepare(&vp);
> >       vma_adjust_trans_huge(vma, start, end, NULL);
> > @@ -1453,7 +1503,9 @@ static int vms_gather_munmap_vmas(struct vma_munm=
ap_struct *vms,
> >                       if (error)
> >                               goto end_split_failed;
> >               }
> > -             vma_start_write(next);
> > +             error =3D vma_start_write_killable(next);
> > +             if (error)
> > +                     goto munmap_gather_failed;
> >               mas_set(mas_detach, vms->vma_count++);
> >               error =3D mas_store_gfp(mas_detach, next, GFP_KERNEL);
> >               if (error)
> > @@ -1848,12 +1900,16 @@ static void vma_link_file(struct vm_area_struct=
 *vma, bool hold_rmap_lock)
> >  static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
> >  {
> >       VMA_ITERATOR(vmi, mm, 0);
> > +     int err;
> > +
> > +     err =3D vma_start_write_killable(vma);
> > +     if (err)
> > +             return err;
> >
> >       vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
> >       if (vma_iter_prealloc(&vmi, vma))
> >               return -ENOMEM;
> >
> > -     vma_start_write(vma);
> >       vma_iter_store_new(&vmi, vma);
> >       vma_link_file(vma, /* hold_rmap_lock=3D */false);
> >       mm->map_count++;
> > @@ -2239,9 +2295,8 @@ int mm_take_all_locks(struct mm_struct *mm)
> >        * is reached.
> >        */
> >       for_each_vma(vmi, vma) {
> > -             if (signal_pending(current))
> > +             if (signal_pending(current) || vma_start_write_killable(v=
ma))
> >                       goto out_unlock;
> > -             vma_start_write(vma);
> >       }
> >
> >       vma_iter_init(&vmi, mm, 0);
> > @@ -2540,8 +2595,8 @@ static int __mmap_new_vma(struct mmap_state *map,=
 struct vm_area_struct **vmap,
> >       struct mmap_action *action)
> >  {
> >       struct vma_iterator *vmi =3D map->vmi;
> > -     int error =3D 0;
> >       struct vm_area_struct *vma;
> > +     int error;
> >
> >       /*
> >        * Determine the object being mapped and call the appropriate
> > @@ -2552,6 +2607,14 @@ static int __mmap_new_vma(struct mmap_state *map=
, struct vm_area_struct **vmap,
> >       if (!vma)
> >               return -ENOMEM;
> >
> > +     /*
> > +      * Lock the VMA early to avoid extra work if fatal signal
> > +      * is pending.
> > +      */
> > +     error =3D vma_start_write_killable(vma);
> > +     if (error)
> > +             goto free_vma;
> > +
> >       vma_iter_config(vmi, map->addr, map->end);
> >       vma_set_range(vma, map->addr, map->end, map->pgoff);
> >       vma->flags =3D map->vma_flags;
> > @@ -2582,8 +2645,6 @@ static int __mmap_new_vma(struct mmap_state *map,=
 struct vm_area_struct **vmap,
> >       WARN_ON_ONCE(!arch_validate_flags(map->vm_flags));
> >  #endif
> >
> > -     /* Lock the VMA since it is modified after insertion into VMA tre=
e */
> > -     vma_start_write(vma);
> >       vma_iter_store_new(vmi, vma);
> >       map->mm->map_count++;
> >       vma_link_file(vma, action->hide_from_rmap_until_complete);
> > @@ -2878,6 +2939,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
> >                unsigned long addr, unsigned long len, vma_flags_t vma_f=
lags)
> >  {
> >       struct mm_struct *mm =3D current->mm;
> > +     int err;
> >
> >       /*
> >        * Check against address space limits by the changed size
> > @@ -2910,24 +2972,33 @@ int do_brk_flags(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
> >
> >               if (vma_merge_new_range(&vmg))
> >                       goto out;
> > -             else if (vmg_nomem(&vmg))
> > +             if (vmg_nomem(&vmg)) {
> > +                     err =3D -ENOMEM;
> >                       goto unacct_fail;
> > +             }
> >       }
> >
> >       if (vma)
> >               vma_iter_next_range(vmi);
> >       /* create a vma struct for an anonymous mapping */
> >       vma =3D vm_area_alloc(mm);
> > -     if (!vma)
> > +     if (!vma) {
> > +             err =3D -ENOMEM;
> >               goto unacct_fail;
> > +     }
> >
> >       vma_set_anonymous(vma);
> >       vma_set_range(vma, addr, addr + len, addr >> PAGE_SHIFT);
> >       vma->flags =3D vma_flags;
> >       vma->vm_page_prot =3D vm_get_page_prot(vma_flags_to_legacy(vma_fl=
ags));
> > -     vma_start_write(vma);
> > -     if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
> > +     if (vma_start_write_killable(vma)) {
> > +             err =3D -EINTR;
> > +             goto vma_lock_fail;
> > +     }
> > +     if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL)) {
> > +             err =3D -ENOMEM;
> >               goto mas_store_fail;
> > +     }
> >
> >       mm->map_count++;
> >       validate_mm(mm);
> > @@ -2942,10 +3013,11 @@ int do_brk_flags(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
> >       return 0;
> >
> >  mas_store_fail:
> > +vma_lock_fail:
> >       vm_area_free(vma);
> >  unacct_fail:
> >       vm_unacct_memory(len >> PAGE_SHIFT);
> > -     return -ENOMEM;
> > +     return err;
> >  }
> >
> >  /**
> > @@ -3112,8 +3184,8 @@ int expand_upwards(struct vm_area_struct *vma, un=
signed long address)
> >       struct mm_struct *mm =3D vma->vm_mm;
> >       struct vm_area_struct *next;
> >       unsigned long gap_addr;
> > -     int error =3D 0;
> >       VMA_ITERATOR(vmi, mm, vma->vm_start);
> > +     int error;
> >
> >       if (!vma_test(vma, VMA_GROWSUP_BIT))
> >               return -EFAULT;
> > @@ -3149,12 +3221,14 @@ int expand_upwards(struct vm_area_struct *vma, =
unsigned long address)
> >
> >       /* We must make sure the anon_vma is allocated. */
> >       if (unlikely(anon_vma_prepare(vma))) {
> > -             vma_iter_free(&vmi);
> > -             return -ENOMEM;
> > +             error =3D -ENOMEM;
> > +             goto vma_prep_fail;
> >       }
> >
> >       /* Lock the VMA before expanding to prevent concurrent page fault=
s */
> > -     vma_start_write(vma);
> > +     error =3D vma_start_write_killable(vma);
> > +     if (error)
> > +             goto vma_lock_fail;
> >       /* We update the anon VMA tree. */
> >       anon_vma_lock_write(vma->anon_vma);
> >
> > @@ -3183,8 +3257,10 @@ int expand_upwards(struct vm_area_struct *vma, u=
nsigned long address)
> >               }
> >       }
> >       anon_vma_unlock_write(vma->anon_vma);
> > -     vma_iter_free(&vmi);
> >       validate_mm(mm);
> > +vma_lock_fail:
> > +vma_prep_fail:
> > +     vma_iter_free(&vmi);
> >       return error;
> >  }
> >  #endif /* CONFIG_STACK_GROWSUP */
> > @@ -3197,8 +3273,8 @@ int expand_downwards(struct vm_area_struct *vma, =
unsigned long address)
> >  {
> >       struct mm_struct *mm =3D vma->vm_mm;
> >       struct vm_area_struct *prev;
> > -     int error =3D 0;
> >       VMA_ITERATOR(vmi, mm, vma->vm_start);
> > +     int error;
> >
> >       if (!vma_test(vma, VMA_GROWSDOWN_BIT))
> >               return -EFAULT;
> > @@ -3228,12 +3304,14 @@ int expand_downwards(struct vm_area_struct *vma=
, unsigned long address)
> >
> >       /* We must make sure the anon_vma is allocated. */
> >       if (unlikely(anon_vma_prepare(vma))) {
> > -             vma_iter_free(&vmi);
> > -             return -ENOMEM;
> > +             error =3D -ENOMEM;
> > +             goto vma_prep_fail;
> >       }
> >
> >       /* Lock the VMA before expanding to prevent concurrent page fault=
s */
> > -     vma_start_write(vma);
> > +     error =3D vma_start_write_killable(vma);
> > +     if (error)
> > +             goto vma_lock_fail;
> >       /* We update the anon VMA tree. */
> >       anon_vma_lock_write(vma->anon_vma);
> >
> > @@ -3263,8 +3341,10 @@ int expand_downwards(struct vm_area_struct *vma,=
 unsigned long address)
> >               }
> >       }
> >       anon_vma_unlock_write(vma->anon_vma);
> > -     vma_iter_free(&vmi);
> >       validate_mm(mm);
> > +vma_lock_fail:
> > +vma_prep_fail:
> > +     vma_iter_free(&vmi);
> >       return error;
> >  }
> >
> > diff --git a/mm/vma_exec.c b/mm/vma_exec.c
> > index 5cee8b7efa0f..8ddcc791d828 100644
> > --- a/mm/vma_exec.c
> > +++ b/mm/vma_exec.c
> > @@ -41,6 +41,7 @@ int relocate_vma_down(struct vm_area_struct *vma, uns=
igned long shift)
> >       struct vm_area_struct *next;
> >       struct mmu_gather tlb;
> >       PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
> > +     int err;
> >
> >       BUG_ON(new_start > new_end);
> >
> > @@ -56,8 +57,9 @@ int relocate_vma_down(struct vm_area_struct *vma, uns=
igned long shift)
> >        * cover the whole range: [new_start, old_end)
> >        */
> >       vmg.target =3D vma;
> > -     if (vma_expand(&vmg))
> > -             return -ENOMEM;
> > +     err =3D vma_expand(&vmg);
> > +     if (err)
> > +             return err;
> >
> >       /*
> >        * move the page tables downwards, on failure we rely on
> > --
> > 2.53.0.1018.g2bb0e51243-goog
> >

