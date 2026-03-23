Return-Path: <linuxppc-dev+bounces-18641-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA159F483D7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 19:22:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffjk22983z2yWK;
	Tue, 24 Mar 2026 06:22:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774293770;
	cv=pass; b=YLt3wOSph4I7N3abRnrv8hTD84UOU7dSoOMGdkGsoWEvqonu+UUo9P1wCVhaQpMxDCLP//0qt2ZGiukTxVczavXCgLG3TkPHGSRmkbB6ESxPf0htffrZog4G5k1SPRWyGJ07JQJQHTnkPSqNYBkK6dIo+zLR60g8GGkWMLxC2k8L0BVotaNj1riNkMTlBE7uMxaTVZuH9ztNE8/hDbSmWmFttO2h5LGeu7vA1XGqf9M2TiIZB11XGxL0Et9duLwiAYT6daLSBFIDZpHPG6TvmbgOgmvx12S6z4s8ACrhb2gvRikmMKcSqjSubv1Ab9c3FTfPccWgJ1Yq1pAkWzc84g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774293770; c=relaxed/relaxed;
	bh=hhZMNA+jzIVsri788AmGGvsH/fnjM2gWyUC4SEwJrJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCrSs3BEFFDZ+w751cjoUE/4FmFFAopGQcBleZr3NhGVsz9sADTiWpW9hrm21uJssKMuzfzhMgb41Os1yialOd8SDjxbpS3Zq9yHVxFuifhkF78WKPiEZFAgsxalDrgHeJh7KtBWdq2A0ehvsJFLZ7euGIY1c48d7khcVaJ9sjaggSjpQxXEqOYXkx3TBge4uwIp1QsRmEh2HIF/YCPF9uniTFS+hFQcZOhSlpWe5SeNAXa8wdICc76pX4Re2rh+NovsAJRl2AE+gJ0XPmxyelEeWls6A8O8A7W6da2mCPJK2x7kf8HhTsKzqOqHr6tfqEqT75ydnyQLmIwH1y93FA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gTW4QsJI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gTW4QsJI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffjk03GnGz2xs4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 06:22:47 +1100 (AEDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-5091ed02c54so5481cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 12:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774293765; cv=none;
        d=google.com; s=arc-20240605;
        b=UrXieNOdNIiDaBh9sAXcL7d6fnMpgLXh7jgUNqtTqcZNICNLKAzwr8TNMYsMcWTIUU
         2OlOZAU7IrVU36wFm4B2uLD+WtOrMv1LMLmaC/4oo2KUJ8LrfUyM2eMV60DlK5UkWVUF
         o10bWNMTME3NA8MQVsRdjvalxJImUjVty+IP4rpKlrZ3EMAfVjgEJUBeL4t2bAv3Swxg
         cyM7K0pXfiO/YNCBCI9HVmSZ5P2TOgyiqJlcyE23Uxrqp3XtPl6wN8BvyaFPwcCMGxs4
         tNRWFh6XgTLhDr3UL3Zndp/EdTjsSJhulO86yNDmmA6VaJUg0TeNOHVSkrbFPAg1CKzQ
         iiFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hhZMNA+jzIVsri788AmGGvsH/fnjM2gWyUC4SEwJrJ0=;
        fh=YW+EREJqN0ZNlZouP5VkGyJdj8AlGNQA4wkgxGEQZSM=;
        b=lzbf1G8lnrDlprWQuA3cHtlO/5f+jsMshumTN4HOiHSAN+NhGa/k2p3Me0zSvxtX6l
         FkPZP2VsbCtWMcViJnczcBGJ7Du7DIA3qUDp2cPNXnI1bUXFVdTm0RpTkaW4gMPQrbYE
         ZfRZdvc97EtSi0HBwKHOZ8fYhiJvsbLlG5XXGCV7FxS3W3BDJPZxM4Fr5dbtxKdEqZir
         HWN61gGiwsaLdDQ4ldlTnzzXYRc10BlTy3/66i8ZG3lafMYKV2coBej6DEz/0m56Cy24
         gBc1+nm2Rp+GLeMjwUBgTFoKf/ZVPhMR9FCyy9dv3Jc4ohh52O+xtjsbBwSlU1tlBWjN
         5udg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774293765; x=1774898565; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhZMNA+jzIVsri788AmGGvsH/fnjM2gWyUC4SEwJrJ0=;
        b=gTW4QsJI03E9zxasBv+U3aFh0TI+uTQWliYZU3UlT3b1ouMwYTFefwbhsCeD3a8j9Z
         y88KE+EN21qmmL2VV8u7Fz7r582iA2wH0z8H2Vjyipcw7mVtdTGFEHRPIWW1hmVbMhiX
         0AOIbBmcUBqjsL/fWQ6R5llYokajL6NVzPdhIo724bSRmOc8+j+L/94YK2LS4BFOlzGf
         9ibhjGxqQAoqpSJP5c2WfKJT6knEyRNGdqgLK9yoyBK4HcZ2YQ8WFa7CAonCaSoVZh0j
         V2mVihiYFtVekMgr25z0UGXv+nlQHaa7CtbkDGEJT4ik/258oDKq2kK0qQ85XkjysbUo
         zNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774293765; x=1774898565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hhZMNA+jzIVsri788AmGGvsH/fnjM2gWyUC4SEwJrJ0=;
        b=d/MhE+DuJks1wTMt9hYkxw4CTv/4EGOmRWHhPaZ/7hSDmkoPu69cvEEJW1q+Rtkw5f
         hi617yXuWXSoDlXUOP6mqU/TadA9I3WRPS6iZXz8qzS+DRVH+6z27atCN8686IzAsYcB
         9PaMjaGxzRm8dJvOU27aWqz07WoT5a8z8Tz4mfWExP3i7nVHQ8tALYMmB8LtV5ldSgJc
         m1LdTEeq0E6MaZCTBqv2Zm+exXY1ILlsmAyAkamAcieVq9eLKfH4NqyCeDJLkEP2kzcl
         ByzujXv/I9fgYeYQWB1eM6ZDpX9aIyYGsyHooxk/LwOkOaeMMRAObRuT6lKfNltAwlm8
         2JFg==
X-Forwarded-Encrypted: i=1; AJvYcCWGXL9yabBZEyCBBYN+qweVDFy0bQI2hE+sZ/02pIP8/ns18ik7frayQFfhEgnR2ce1k17/x/ZRtJqhCns=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwOSfGMRyX8dCFJB1wdPfrHP7hczFKV96nppwclWctPxE1zKH7L
	B673XaQ4kGEA3sIhjWLTpsTns9LpvJPPOMH8m843jKyi46sS5I7RV4jgpnWNZuab3hWMGpJzNdh
	nVra34nN7Dx3ZlbCOIvMm+nmpQMEZI0cx2za66wWN
X-Gm-Gg: ATEYQzzGaOlAT1ENg0/OrioCfKDtCWd0jSQtdxtxL5YxnZG7wTp1enuw9Oy0NhTYWlH
	zt6Fobj8tCRxFzA96b/h/NHHPwZeB4XTN29f7uE6AW4ziGUQf5WTnVfY05Sv0TESxEUWhzXYtf2
	0uKM6sfnAYBK1Yz8+VbAAnW1QvuLgWw5HgLlWPEKj3BViE/ZOQb4oPWWdsRciaKEEPbyrjgr7N8
	mhnnTph2G+D+tyJeNqLAt86pP4ksD1wFyaETJLtY+W7PliJAG9txxAot55lbsCCsic49YlyhJyo
	ujXWiw==
X-Received: by 2002:a05:622a:a6c7:b0:509:1d4b:f86f with SMTP id
 d75a77b69052e-50b6fc209e3mr2195611cf.14.1774293764021; Mon, 23 Mar 2026
 12:22:44 -0700 (PDT)
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
References: <20260322054309.898214-1-surenb@google.com> <20260322054309.898214-3-surenb@google.com>
 <9845b243-1984-4d74-9feb-d9d28757fba6@lucifer.local>
In-Reply-To: <9845b243-1984-4d74-9feb-d9d28757fba6@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 23 Mar 2026 12:22:32 -0700
X-Gm-Features: AQROBzCVUZnEmrwdmvEWaC2ljiMixbWoKGB4FyKsWWPRJShDJJ_AC9-yE4VaES8
Message-ID: <CAJuCfpGeup5i5T4LTK3M2D3voorgSteSx111twv9nzdDsK5RnQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] mm: replace vma_start_write() with vma_start_write_killable()
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
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 10:49=E2=80=AFAM Lorenzo Stoakes (Oracle)
<ljs@kernel.org> wrote:
>
> On Sat, Mar 21, 2026 at 10:43:06PM -0700, Suren Baghdasaryan wrote:
> > Now that we have vma_start_write_killable() we can replace most of the
> > vma_start_write() calls with it, improving reaction time to the kill
> > signal.
> >
> > There are several places which are left untouched by this patch:
> >
> > 1. free_pgtables() because function should free page tables even if a
> > fatal signal is pending.
> >
> > 2. process_vma_walk_lock(), which requires changes in its callers and
> > will be handled in the next patch.
> >
> > 3. userfaultd code, where some paths calling vma_start_write() can
> > handle EINTR and some can't without a deeper code refactoring.
> >
> > 4. mpol_rebind_mm() which is used by cpuset controller for migrations
> > and operates on a remote mm. Incomplete operations here would result
> > in an inconsistent cgroup state.
> >
> > 5. vm_flags_{set|mod|clear} require refactoring that involves moving
> > vma_start_write() out of these functions and replacing it with
> > vma_assert_write_locked(), then callers of these functions should
> > lock the vma themselves using vma_start_write_killable() whenever
> > possible.
> >
> > In a number of places we now lock VMA earlier than before to avoid
> > doing work and undoing it later if a fatal signal is pending. This
> > is safe because the moves are happening within sections where we
> > already hold the mmap_write_lock, so the moves do not change the
> > locking order relative to other kernel locks.
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com> # powerpc
>
> This really really needs splitting up into separate patches for the vario=
us
> bits you change, I know it might seem pedantic, but it's much harder to
> review this as one big patch, and hurts bisectability/specificity of fixe=
s
> etc.
>
> Come, embrace the stats :)
>
> You are welcome to apply a 'Reviewed-by: Lorenzo Stoakes (Oracle)
> <ljs@kernel.org>' tag to all of the split-out patches where I have said
> LGTM throughout!

Thanks!
How would you suggest splitting the patch? I'm outlining one possible
division below. Let me know if you want to slice it differently:

>
> > ---
> >  arch/powerpc/kvm/book3s_hv_uvmem.c |   5 +-

The above one can obviously be split as it's powerpc specific.

> >  mm/khugepaged.c                    |   5 +-
> >  mm/madvise.c                       |   4 +-
> >  mm/memory.c                        |   2 +

The changes in the above files are almost one-liners with the last one
being just a comment change. Should each one go into a separate patch?

> >  mm/mempolicy.c                     |  12 ++-

I guess mempolicy one can be a separate patch.

> >  mm/mlock.c                         |  28 +++++--
> >  mm/mprotect.c                      |   5 +-
> >  mm/mremap.c                        |   4 +-

Maybe the above 3 can go together?

> >  mm/vma.c                           | 117 +++++++++++++++++++++--------
> >  mm/vma_exec.c                      |   6 +-

The above two files I think can go together and this is the most sizable on=
e.


> >  10 files changed, 142 insertions(+), 46 deletions(-)
> >
> > diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book=
3s_hv_uvmem.c
> > index 5fbb95d90e99..0a28b48a46b8 100644
> > --- a/arch/powerpc/kvm/book3s_hv_uvmem.c
> > +++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
> > @@ -410,7 +410,10 @@ static int kvmppc_memslot_page_merge(struct kvm *k=
vm,
> >                       ret =3D H_STATE;
> >                       break;
> >               }
> > -             vma_start_write(vma);
> > +             if (vma_start_write_killable(vma)) {
> > +                     ret =3D H_STATE;
> > +                     break;
> > +             }
>
> LGTM
>
> >               /* Copy vm_flags to avoid partial modifications in ksm_ma=
dvise */
> >               vm_flags =3D vma->vm_flags;
> >               ret =3D ksm_madvise(vma, vma->vm_start, vma->vm_end,
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 4b0e59c7c0e6..e2f263076084 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1159,7 +1159,10 @@ static enum scan_result collapse_huge_page(struc=
t mm_struct *mm, unsigned long a
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out_up_write;
> >       /* check if the pmd is still valid */
> > -     vma_start_write(vma);
> > +     if (vma_start_write_killable(vma)) {
> > +             result =3D SCAN_FAIL;
> > +             goto out_up_write;
> > +     }
>
> LGTM
>
> >       result =3D check_pmd_still_valid(mm, address, pmd);
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out_up_write;
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 69708e953cf5..feaa16b0e1dc 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -175,7 +175,9 @@ static int madvise_update_vma(vm_flags_t new_flags,
> >       madv_behavior->vma =3D vma;
> >
> >       /* vm_flags is protected by the mmap_lock held in write mode. */
> > -     vma_start_write(vma);
> > +     if (vma_start_write_killable(vma))
> > +             return -EINTR;
> > +
>
> LGTM
>
> >       vma->flags =3D new_vma_flags;
> >       if (set_new_anon_name)
> >               return replace_anon_vma_name(vma, anon_name);
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 68cc592ff0ba..b930459e32ec 100644
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
>
> Nice.
>
> >   *
> >   * The vma_end differs from the pg_end when a dup_mmap() failed and th=
e tree has
> >   * unrelated data to the mm_struct being torn down.
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index e5528c35bbb8..929e843543cf 100644
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
> > @@ -1801,13 +1802,20 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsign=
ed long, start, unsigned long, le
> >                       err =3D -EOPNOTSUPP;
> >                       break;
> >               }
> > +             /*
> > +              * Lock the VMA early to avoid extra work if fatal signal
> > +              * is pending.
> > +              */
> > +             if (vma_start_write_killable(vma)) {
> > +                     err =3D -EINTR;
> > +                     break;
> > +             }
>
> LGTM, one nitty thing - wonder if we shouldn't pass through the error fro=
m
> vma_start_write_killable()? OTOH, it's not really a big deal. I don't
> foresee us ever returning anything but -EINTR or 0 :)

Ack. I'll change err to record vma_start_write_killable() return value inst=
ead.

>
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
> > index 8c227fefa2df..efbb9c783f25 100644
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
>
> LGTM
>
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
> > @@ -506,11 +511,13 @@ static int mlock_fixup(struct vma_iterator *vmi, =
struct vm_area_struct *vma,
> >        */
> >       if (vma_flags_test(&new_vma_flags, VMA_LOCKED_BIT) &&
> >           vma_flags_test(&old_vma_flags, VMA_LOCKED_BIT)) {
> > +             ret =3D vma_start_write_killable(vma);
> > +             if (ret)
> > +                     goto out;
>
> LGTM
>
> >               /* No work to do, and mlocking twice would be wrong */
> > -             vma_start_write(vma);
> >               vma->flags =3D new_vma_flags;
> >       } else {
> > -             mlock_vma_pages_range(vma, start, end, &new_vma_flags);
> > +             ret =3D mlock_vma_pages_range(vma, start, end, &new_vma_f=
lags);
>
> LGTM
>
> >       }
> >  out:
> >       *prev =3D vma;
> > @@ -739,9 +746,18 @@ static int apply_mlockall_flags(int flags)
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
>
> LGTM, and thanks for careful explanation, hopefully addresses Matthew's
> concerns ([0]).

That was my goal :)

>
> [0]:https://lore.kernel.org/all/aaiBX5Mm36Kg0wq1@casper.infradead.org/
>
> > +
> > +                     /* Ignore errors, but prev needs fixing up. */
> >                       prev =3D vma;
> > +             }
> >               cond_resched();
> >       }
> >  out:
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 110d47a36d4b..ae6ed882b600 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -768,7 +768,10 @@ mprotect_fixup(struct vma_iterator *vmi, struct mm=
u_gather *tlb,
> >        * vm_flags and vm_page_prot are protected by the mmap_lock
> >        * held in write mode.
> >        */
> > -     vma_start_write(vma);
> > +     error =3D vma_start_write_killable(vma);
> > +     if (error)
> > +             goto fail;
> > +
>
> LGTM
>
> >       vma_flags_reset_once(vma, &new_vma_flags);
> >       if (vma_wants_manual_pte_write_upgrade(vma))
> >               mm_cp_flags |=3D MM_CP_TRY_CHANGE_WRITABLE;
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index e9c8b1d05832..dec39ec314f9 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -1356,7 +1356,9 @@ static unsigned long move_vma(struct vma_remap_st=
ruct *vrm)
> >               return -ENOMEM;
> >
> >       /* We don't want racing faults. */
> > -     vma_start_write(vrm->vma);
> > +     err =3D vma_start_write_killable(vrm->vma);
> > +     if (err)
> > +             return err;
>
> Yeah this is subtle, I saw sashiko flagged it, so I checked and this isn'=
t
> being accounted properly.
>
> vrm_calc_charge() charges via
> security_vm_enough_memory_mm()->__vm_enough_memory()->vm_acct_memory()
>
> And we only uncharge via vrm_uncharge()->vm_unacct_memory()
>
> The other error function there is:
>
>         err =3D copy_vma_and_data(vrm, &new_vma);
>         ...
>         if (err && !new_vma)
>                 return err;
>
> And in copy_vma_and_data():
>
>         if (!new_vma) {
>                 vrm_uncharge(vrm);
>                 *new_vma_ptr =3D NULL;
>                 return -ENOMEM;
>         }
>
> So that's already taken care of for us.
>
> It's stuff like this that is why it's important to separate this patch in=
to
> separate patches :)
>
> We also do some weird and wonderful stuff with error handling where we tr=
y
> to back out the remapped page tables, having swapped the new and old VMAs
> around so the unmapping of the source VMA is done on the destination (yea=
h
> it's horrible).
>
> So this is all very subtle really.
>
> Honestly you might just be better off moving the vma_start_write_killable=
()
> above vrm_calc_charge()?

Yes I'll try that...

>
> If not, you'd just need to replace this with:
>
>         err =3D vma_start_write_killable(vrm->vma);
>         if (err) {
>                 vrm_uncharge(vrm);
>                 return err;
>         }

and if it doesn't work will do the above.

>
> >
> >       /* Perform copy step. */
> >       err =3D copy_vma_and_data(vrm, &new_vma);
> > diff --git a/mm/vma.c b/mm/vma.c
> > index ba78ab1f397a..7930a4270eb9 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -524,6 +524,17 @@ __split_vma(struct vma_iterator *vmi, struct vm_ar=
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
> > +     err =3D vma_start_write_killable(new);
> > +     if (err)
> > +             goto out_free_vma;
> > +
>
> LGTM
>
> >       err =3D -ENOMEM;
> >       vma_iter_config(vmi, new->vm_start, new->vm_end);
> >       if (vma_iter_prealloc(vmi, new))
> > @@ -543,9 +554,6 @@ __split_vma(struct vma_iterator *vmi, struct vm_are=
a_struct *vma,
> >       if (new->vm_ops && new->vm_ops->open)
> >               new->vm_ops->open(new);
> >
> > -     vma_start_write(vma);
> > -     vma_start_write(new);
> > -
>
> LGTM
>
> >       init_vma_prep(&vp, vma);
> >       vp.insert =3D new;
> >       vma_prepare(&vp);
> > @@ -900,12 +908,16 @@ static __must_check struct vm_area_struct *vma_me=
rge_existing_range(
> >       }
> >
> >       /* No matter what happens, we will be adjusting middle. */
> > -     vma_start_write(middle);
> > +     err =3D vma_start_write_killable(middle);
> > +     if (err)
> > +             goto abort;
>
> I mean looking at this again the vmg_oom() etc. stuff is horrible and I
> definitely need to rework it. Sorry about that!
>
> I think we need to update vma_modify():
>
>         /* First, try to merge. */
>         merged =3D vma_merge_existing_range(vmg);
>         if (merged)
>                 return merged;
>         if (vmg_nomem(vmg))
>                 return ERR_PTR(-ENOMEM);
> +       if (fatal_signal_pending(current))

We need to be careful here. I think there are cases when vma is
modified from a context of a different process, for example in
process_madvise(). fatal_signal_pending(current) would yield incorrect
result because vma->vm_mm is not the same as current->mm.

> +               return -EINTR;
>
> So we can just get out early in this case. I _think_ that should be safe?
> :)
>
> If not, we could hack things here by doing:
>
>         if (err) {
>                 /* Ensure error propagated. */
>                 vmg->give_up_on_oom =3D false;
>                 goto abort;
>         }

I think that would be safer.

>
> And I can just go fix this all up afterwards.
>
> I still don't want a vmg_intr() or anything though, I will rework this in=
to
> something saner!
>
> Anyway apologies, it's entirely my fault that this is a bit of a mess :)

No worries. We all make mistakes that become obvious only later.
Hindsight is always 20/20.

>
> >
> >       if (merge_right) {
> >               vma_flags_t next_sticky;
> >
> > -             vma_start_write(next);
> > +             err =3D vma_start_write_killable(next);
> > +             if (err)
> > +                     goto abort;
>
> Obv not withstanding above LGTM
>
> >               vmg->target =3D next;
> >               next_sticky =3D vma_flags_and_mask(&next->flags, VMA_STIC=
KY_FLAGS);
> >               vma_flags_set_mask(&sticky_flags, next_sticky);
> > @@ -914,7 +926,9 @@ static __must_check struct vm_area_struct *vma_merg=
e_existing_range(
> >       if (merge_left) {
> >               vma_flags_t prev_sticky;
> >
> > -             vma_start_write(prev);
> > +             err =3D vma_start_write_killable(prev);
> > +             if (err)
> > +                     goto abort;
>
> Ditto
>
> >               vmg->target =3D prev;
> >
> >               prev_sticky =3D vma_flags_and_mask(&prev->flags, VMA_STIC=
KY_FLAGS);
> > @@ -1170,10 +1184,12 @@ int vma_expand(struct vma_merge_struct *vmg)
> >       vma_flags_t sticky_flags =3D
> >               vma_flags_and_mask(&vmg->vma_flags, VMA_STICKY_FLAGS);
> >       vma_flags_t target_sticky;
> > -     int err =3D 0;
> > +     int err;
> >
> >       mmap_assert_write_locked(vmg->mm);
> > -     vma_start_write(target);
> > +     err =3D vma_start_write_killable(target);
> > +     if (err)
> > +             return err;
>
> Yeah dup_anon stuff will not be done yet so this LGTM
>
> >
> >       target_sticky =3D vma_flags_and_mask(&target->flags, VMA_STICKY_F=
LAGS);
> >
> > @@ -1201,6 +1217,13 @@ int vma_expand(struct vma_merge_struct *vmg)
> >        * we don't need to account for vmg->give_up_on_mm here.
> >        */
> >       if (remove_next) {
> > +             /*
> > +              * Lock the VMA early to avoid extra work if fatal signal
> > +              * is pending.
> > +              */
> > +             err =3D vma_start_write_killable(next);
> > +             if (err)
> > +                     return err;
>
> Same here, so LGTM
>
> >               err =3D dup_anon_vma(target, next, &anon_dup);
> >               if (err)
> >                       return err;
> > @@ -1214,7 +1237,6 @@ int vma_expand(struct vma_merge_struct *vmg)
> >       if (remove_next) {
> >               vma_flags_t next_sticky;
> >
> > -             vma_start_write(next);
>
> LGTM
>
> >               vmg->__remove_next =3D true;
> >
> >               next_sticky =3D vma_flags_and_mask(&next->flags, VMA_STIC=
KY_FLAGS);
> > @@ -1252,9 +1274,14 @@ int vma_shrink(struct vma_iterator *vmi, struct =
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
> > @@ -1263,8 +1290,6 @@ int vma_shrink(struct vma_iterator *vmi, struct v=
m_area_struct *vma,
> >       if (vma_iter_prealloc(vmi, NULL))
> >               return -ENOMEM;
> >
> > -     vma_start_write(vma);
> > -
>
> We will hold the VMA write lock even though we return -ENOMEM, but I gues=
s
> not a big deal as we will drop the mmap write lock on error at the earlie=
st
> opportunity anyway.
>
> So LGTM
>
> >       init_vma_prep(&vp, vma);
> >       vma_prepare(&vp);
> >       vma_adjust_trans_huge(vma, start, end, NULL);
> > @@ -1453,7 +1478,9 @@ static int vms_gather_munmap_vmas(struct vma_munm=
ap_struct *vms,
> >                       if (error)
> >                               goto end_split_failed;
> >               }
> > -             vma_start_write(next);
> > +             error =3D vma_start_write_killable(next);
> > +             if (error)
> > +                     goto munmap_gather_failed;
>
> LGTM
>
> >               mas_set(mas_detach, vms->vma_count++);
> >               error =3D mas_store_gfp(mas_detach, next, GFP_KERNEL);
> >               if (error)
> > @@ -1848,12 +1875,16 @@ static void vma_link_file(struct vm_area_struct=
 *vma, bool hold_rmap_lock)
> >  static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
> >  {
> >       VMA_ITERATOR(vmi, mm, 0);
> > +     int err;
> > +
> > +     err =3D vma_start_write_killable(vma);
> > +     if (err)
> > +             return err;
>
> LGTM
>
> >
> >       vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
> >       if (vma_iter_prealloc(&vmi, vma))
> >               return -ENOMEM;
> >
> > -     vma_start_write(vma);
>
> LGTM
>
> >       vma_iter_store_new(&vmi, vma);
> >       vma_link_file(vma, /* hold_rmap_lock=3D */false);
> >       mm->map_count++;
> > @@ -2239,9 +2270,8 @@ int mm_take_all_locks(struct mm_struct *mm)
> >        * is reached.
> >        */
> >       for_each_vma(vmi, vma) {
> > -             if (signal_pending(current))
> > +             if (signal_pending(current) || vma_start_write_killable(v=
ma))
>
> Hmm, surely signal_pending() should catch it :) but I suppose there could
> be a (very very tight) timing issue here, but case to be made for not
> converting this?

I want to convert all possible vma_start_write() cases in the hopes
that over time I might be able to deprecate vma_start_write()
completely. It's not possible right now (see the changelog) but with
some effort we might get there eventually.

>
> OTOH it doesn't really make much difference I guess.
>
> >                       goto out_unlock;
> > -             vma_start_write(vma);
> >       }
> >
> >       vma_iter_init(&vmi, mm, 0);
> > @@ -2540,8 +2570,8 @@ static int __mmap_new_vma(struct mmap_state *map,=
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
> > @@ -2552,6 +2582,14 @@ static int __mmap_new_vma(struct mmap_state *map=
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
>
> LGTM
>
> >       vma_iter_config(vmi, map->addr, map->end);
> >       vma_set_range(vma, map->addr, map->end, map->pgoff);
> >       vma->flags =3D map->vma_flags;
> > @@ -2582,8 +2620,6 @@ static int __mmap_new_vma(struct mmap_state *map,=
 struct vm_area_struct **vmap,
> >       WARN_ON_ONCE(!arch_validate_flags(map->vm_flags));
> >  #endif
> >
> > -     /* Lock the VMA since it is modified after insertion into VMA tre=
e */
> > -     vma_start_write(vma);
>
> LGTM
>
> >       vma_iter_store_new(vmi, vma);
> >       map->mm->map_count++;
> >       vma_link_file(vma, action->hide_from_rmap_until_complete);
> > @@ -2878,6 +2914,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
> >                unsigned long addr, unsigned long len, vma_flags_t vma_f=
lags)
> >  {
> >       struct mm_struct *mm =3D current->mm;
> > +     int err;
>
> LGTM
>
> >
> >       /*
> >        * Check against address space limits by the changed size
> > @@ -2910,24 +2947,33 @@ int do_brk_flags(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
> >
> >               if (vma_merge_new_range(&vmg))
> >                       goto out;
> > -             else if (vmg_nomem(&vmg))
> > +             if (vmg_nomem(&vmg)) {
> > +                     err =3D -ENOMEM;
> >                       goto unacct_fail;
> > +             }
>
> LGTM
>
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
>
> LGTM
>
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
>
> LGTM
>
> > +     if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL)) {
> > +             err =3D -ENOMEM;
> >               goto mas_store_fail;
> > +     }
>
> LGTM
>
> >
> >       mm->map_count++;
> >       validate_mm(mm);
> > @@ -2942,10 +2988,11 @@ int do_brk_flags(struct vma_iterator *vmi, stru=
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
>
> LGTM
>
> >  }
> >
> >  /**
> > @@ -3112,8 +3159,8 @@ int expand_upwards(struct vm_area_struct *vma, un=
signed long address)
> >       struct mm_struct *mm =3D vma->vm_mm;
> >       struct vm_area_struct *next;
> >       unsigned long gap_addr;
> > -     int error =3D 0;
> >       VMA_ITERATOR(vmi, mm, vma->vm_start);
> > +     int error;
>
> LGTM
>
> >
> >       if (!vma_test(vma, VMA_GROWSUP_BIT))
> >               return -EFAULT;
> > @@ -3149,12 +3196,14 @@ int expand_upwards(struct vm_area_struct *vma, =
unsigned long address)
> >
> >       /* We must make sure the anon_vma is allocated. */
> >       if (unlikely(anon_vma_prepare(vma))) {
> > -             vma_iter_free(&vmi);
> > -             return -ENOMEM;
> > +             error =3D -ENOMEM;
> > +             goto vma_prep_fail;
>
> Hm, but before we weren't calling validate_mm() here, and now we will be,=
 I
> suspect we probably don't want to do that on error. Will comment on it
> below in that bit of the code.
>
> Otherwise, LGTM.
>
> >       }
> >
> >       /* Lock the VMA before expanding to prevent concurrent page fault=
s */
> > -     vma_start_write(vma);
> > +     error =3D vma_start_write_killable(vma);
> > +     if (error)
> > +             goto vma_lock_fail;
>
> LGTM
>
> >       /* We update the anon VMA tree. */
> >       anon_vma_lock_write(vma->anon_vma);
> >
> > @@ -3183,6 +3232,8 @@ int expand_upwards(struct vm_area_struct *vma, un=
signed long address)
> >               }
> >       }
> >       anon_vma_unlock_write(vma->anon_vma);
> > +vma_lock_fail:
> > +vma_prep_fail:
>
> LGTM
>
> >       vma_iter_free(&vmi);
> >       validate_mm(mm);
>
> Maybe this should be put before the labels?
>
> Then again, I guess there's no harm in it. But I'm not sure taking a long
> time to check the entire maple tree when CONFIG_DEBUG_VM_MAPLE_TREE is
> enabled is a good idea with a fatal signal pending?

That makes sense. Validating a tree when we know something went wrong
is probably meaningless. I'll move it before the jump labels.

>
> >       return error;
> > @@ -3197,8 +3248,8 @@ int expand_downwards(struct vm_area_struct *vma, =
unsigned long address)
> >  {
> >       struct mm_struct *mm =3D vma->vm_mm;
> >       struct vm_area_struct *prev;
> > -     int error =3D 0;
> >       VMA_ITERATOR(vmi, mm, vma->vm_start);
> > +     int error;
>
> LGTM
>
> >
> >       if (!vma_test(vma, VMA_GROWSDOWN_BIT))
> >               return -EFAULT;
> > @@ -3228,12 +3279,14 @@ int expand_downwards(struct vm_area_struct *vma=
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
> > @@ -3263,6 +3316,8 @@ int expand_downwards(struct vm_area_struct *vma, =
unsigned long address)
> >               }
> >       }
> >       anon_vma_unlock_write(vma->anon_vma);
> > +vma_lock_fail:
> > +vma_prep_fail:
>
> Obv same comments for expand_upwards() apply here also.
>
> >       vma_iter_free(&vmi);
> >       validate_mm(mm);
> >       return error;
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
>
> LGTM

Thanks for the detailed review!

>
> >
> >       /*
> >        * move the page tables downwards, on failure we rely on
> > --
> > 2.53.0.1018.g2bb0e51243-goog
> >
>
> Thanks, Lorenzo

