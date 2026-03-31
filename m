Return-Path: <linuxppc-dev+bounces-19102-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3318B109B492
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 15:34:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flXHL648qz2ybR;
	Wed, 01 Apr 2026 02:34:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::536" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774971294;
	cv=pass; b=cX5Go3wtb3zTbqXrmcXvCeTbdLMAg5zkUFEbjH65TMd+TEBz2hopleX1rHslgHQRveN6Ha6yh9t8eo37Uq/ChUUJ1ckdyd+3A/6SQk/4ODEvf7vvIdEgjjvu8thVa0i5lN7E9YxzMf3JKzg/D7/uDePwhB8cN1EtK2Yt4STOAkKItMavpPoe9n/nSvUIPGpYDXcp7FGAQIQMUsmQL21LGvAoutjdhcHGF76QiOwl60O6rPBmc2usidODmVesGhfWGPsqNKn6ciZ181edeE3iqBY05Q6X1XstptcAr3LE+7NskaXTnPLVgFmxl+xN4NL/uqC3P1e9RvMWtr0mjvs87w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774971294; c=relaxed/relaxed;
	bh=2kbC6DRNJUxFn/ggqNRgjVNMgVXnUw4VaYyyf9fTTGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTrwJ9SupeivE9+o2W96hQj5EZelRjKLfyEOKPF4D4GPo2JVK3i7DnhIp1HSC4Zs3bCpGAG1RV6eBh6CWX5v4MAVuELLWANTTugAR2twLGf4Z0H5K+R5Sr1UknVVrCj7B//44euyNpvsm0zfdHhN3vamFdwVoyZiL9RDtlWfeF2I9pu8G0Yvlzl1xGiVrL5X0t2kGiJwq1tA3X06KoQrqSjwJ9b8matu2Ptgr6xY8Nk91fui2u7UWaK19TPsaHyJ1lhIbmffOyXMWWK1aVrsZuqvNGpED3PyekuHKqJWAas2IsKSMA1KMmKr6ehGsN7QAK3Ud04CrB7Ocxi06ADyQg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=V7OH6biP; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=V7OH6biP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flXHK408qz2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 02:34:52 +1100 (AEDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso11525a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 08:34:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774971288; cv=none;
        d=google.com; s=arc-20240605;
        b=h3mIAdy2Z1QqsJ+BhR50WhKlw7idND2p7gBSPNx8t1wcho/HWCUGftH1oIrKIbT5Yq
         vgR2HsDPI4CsqDpv0lv2hpFylMdk1ZrrnVhGiQahV3NJqVvTaA/KWupHB1iyXGnleNOy
         cw6+thlYLC6tYcNz8pxlExLhtmXaNdOHq0CXHuN3hq+sff5+mcJLCqBhaCMX3uYSI5Zl
         kip6bTDnmwAbqXX0RZ7FzRNAauk9hn/r9PTNrt/CwgKGwtjZcMzo9ZyRW5aj3QhXAofj
         iLnx7Vtxuk3NBvavXkKlqwPi1vMmEo/aiKJjf0VXD60H172WWQgElVvvz4tW7WtgY+QL
         i+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2kbC6DRNJUxFn/ggqNRgjVNMgVXnUw4VaYyyf9fTTGQ=;
        fh=RHXbxGlwfFLJMrL9qT/ymF+YyKvOF4Lzi8CuiX9skOg=;
        b=Y3o2mXQl4ut0JK1tmlogjSNmJj+TjvPqwL/W9nAgxqU5odTStXziI1fRXAA35eK9d4
         qP92n5nIixUMqTu1rLQWeubL/R/htxVANFo1YMCfJ4fwxnBXKqTvNogIQ2xSwA5bb8yB
         TgrHQjmJv4p2zARQmDr4OqYt46JZiugU4QnYjuq175CRGv2mg18gH03te+b9J+4QfXmm
         QKY+sGIk4FqYXsT6KvJXqPOe18hL9Uu1rKQ0TQ+GhjltX8o0fU7Yb9U54T6S/X1FYQkg
         G6/uWw/suo2ia1yV8GHRJmolFrY0L7cwxWCCebHiXvmtUMN26hwIrsWMAJoxK0GlQr8D
         JvSw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774971288; x=1775576088; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kbC6DRNJUxFn/ggqNRgjVNMgVXnUw4VaYyyf9fTTGQ=;
        b=V7OH6biPjc0NJkAdyARFdIqITfFK9HGDxGqKUohyeKLY6Q2N2ldJgi2y/drobAsamR
         saFD+zs9RS0MfTb06hNkocD4oTAXhnouSBUuCDracBthdmQgQsemkFgxwsVeGV3ksM9X
         nrob1k+Wkbl5iyNzTZ4GKSuPzKxDQowgSPSixDL2J6KvqpCIDxxsqzDxBOLpt9Hp9Gzj
         KcSQlFDn7nzjeNq8K23expSJhLCHGOHr0AoDyH2iN3WXVEgm+mAPPLFG0ZOwK4PYYcfL
         ZeDnJldoojwc1Xq+aHIAJLKKPtxs9onwBBZ6m2jkuJ2CXaK8BK5kCRz0eDYucO23j5S8
         4tWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971288; x=1775576088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2kbC6DRNJUxFn/ggqNRgjVNMgVXnUw4VaYyyf9fTTGQ=;
        b=NfMcSAh9CKuPmHQeanWRlKpKYsSm0hlaZD629PS6eapiVM6WkDtgSWxz2lBfXFiqKL
         1NnQcWGhiAoC8Ac5QlaouCk1QgoELZya4Rbuc7XgNVuefx8ijWxfIuvWYboKgNwjMDBT
         3bEEprAhtSI5Epin1hLKTcK7cWve10c4/tTzQDwozNxzPKZFviuO5GsndAWzVQ0DMRZ4
         BjxHcOKJy36wxmi8o1Zm0dCLD0N4sKU/KIyH7PBs/I5mRAr7h4dJnoXzRaroMJZRvCQJ
         yDO7ZJpqS+Rk0kvuwVaS//t/tSRfwHs3j3hWp19FvMy2tOhQEPO7W4ieSzvToEZyvTmD
         05Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUfPTd+pjtlZbGSCZsd6OldSxtToTmT8uQnhDEmPepbRgH16tz+vvb91RBzQtZ11ELBTB/gHHQrmNwhlKI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyxu+xDNci1hJYK6+kkiogZ+dp1H6ioaloEhma25AuCzCPXvq6m
	9C0Y2OcfQc43FqRzFIeFbpF4S4kATdHWnm3ZHON2TdeJeDxHTa4veFY/v2lCbmgxX8/x5jnQdZx
	DIvxGgjLHjIXycIilobWEFq/WdXjJc/iR7LbFIqpk
X-Gm-Gg: ATEYQzwKnyV6QEBjq2AfUFiUwUDHMSCXniA6CdK2W0KJplrtbzypS8u7eNvGEu7KnUX
	ZDjGcHYIkZAT3hGIavhSwjfEzj+9UXicyWcX0842Fn+VZPhHlgHzaje/mzuTufwjKRZWqRNe4aa
	TE3FbkvmOgnPzcJ2LX+AG1FI5Foeu7G01WF5AqV2d2eTuqxkQxbxl60f1BxuSrVN5EqL+CMPKAd
	elY5WhptevOqV/C6CBeN5u6jEhzHdrsfGQvVVL2R/rMgoflKjJz+sMrLi82a9/0aG9h15V1QDn4
	Ug+NZhNbWzyYl2yFsaQtN6hGUC2qPv9tRqRuiQ==
X-Received: by 2002:aa7:d157:0:b0:66b:ea0e:1782 with SMTP id
 4fb4d7f45d1cf-66d95ac6b83mr3294a12.2.1774971287536; Tue, 31 Mar 2026 08:34:47
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
References: <20260327205457.604224-1-surenb@google.com> <20260327161226.17e680fec33117d67dc8b5f9@linux-foundation.org>
 <f128b795-5577-40f9-8dae-936be4253642@lucifer.local> <CAJuCfpHmUop-UzxM9QN7OiAnXUzj461+9ErgtXrtve_bR0_NjA@mail.gmail.com>
In-Reply-To: <CAJuCfpHmUop-UzxM9QN7OiAnXUzj461+9ErgtXrtve_bR0_NjA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 31 Mar 2026 08:34:34 -0700
X-Gm-Features: AQROBzCjbp_TCkkxwhu_axsyxtZ1SbbwXiNA5twqFRnYfWa0PnszaVM289IvRRY
Message-ID: <CAJuCfpF5CqSMU4yz5mgSOTbSLfMsmATGk4vcKWiqrzV3rGkZEw@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Use killable vma write locking in most places
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, david@kernel.org, 
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

On Tue, Mar 31, 2026 at 8:06=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Mar 31, 2026 at 2:51=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@ker=
nel.org> wrote:
> >
> > On Fri, Mar 27, 2026 at 04:12:26PM -0700, Andrew Morton wrote:
> > > On Fri, 27 Mar 2026 13:54:51 -0700 Suren Baghdasaryan <surenb@google.=
com> wrote:
> > >
> > > > Now that we have vma_start_write_killable() we can replace most of =
the
> > > > vma_start_write() calls with it, improving reaction time to the kil=
l
> > > > signal.
> > > >
> > > > There are several places which are left untouched by this patchset:
> > > >
> > > > 1. free_pgtables() because function should free page tables even if=
 a
> > > > fatal signal is pending.
> > > >
> > > > 2. userfaultd code, where some paths calling vma_start_write() can
> > > > handle EINTR and some can't without a deeper code refactoring.
> > > >
> > > > 3. mpol_rebind_mm() which is used by cpusset controller for migrati=
ons
> > > > and operates on a remote mm. Incomplete operations here would resul=
t
> > > > in an inconsistent cgroup state.
> > > >
> > > > 4. vm_flags_{set|mod|clear} require refactoring that involves movin=
g
> > > > vma_start_write() out of these functions and replacing it with
> > > > vma_assert_write_locked(), then callers of these functions should
> > > > lock the vma themselves using vma_start_write_killable() whenever
> > > > possible.
> > >
> > > Updated, thanks.
> >
> > Andrew - sorry I think we need to yank this and defer to next cycle,
> > there's too many functional changes here.
> >
> > (There was not really any way for me to predict this would happen ahead=
 of
> > time, unfortunately.)
>
> Ok, no objections from me. I'll post v6 removing the part Lorenzo
> objects to and you can pick it up whenever you deem appropriate.

Just saw Lorenzo's other reply about reworking some vma error handling
first. I'll wait for that rework before posting the new version.

>
> >
> > >
> > > > Changes since v5 [1]:
> > > > - Added Reviewed-by for unchanged patches, per Lorenzo Stoakes
> > > >
> > > > Patch#2:
> > > > - Fixed locked_vm counter if mlock_vma_pages_range() fails in
> > > > mlock_fixup(), per Sashiko
> > > > - Avoid VMA re-locking in madvise_update_vma(), mprotect_fixup() an=
d
> > > > mseal_apply() when vma_modify_XXX creates a new VMA as it will alre=
ady be
> > > > locked. This prevents the possibility of incomplete operation if si=
gnal
> > > > happens after a successful vma_modify_XXX modified the vma tree,
> > > > per Sashiko
> >
> > Prevents the possibility of an incomplete operation? But
> > vma_write_lock_killable() checks to see if you're _already_ write locke=
d
> > and would make the operation a no-op? So how is this even a delta?
> >
> > It's a brave new world, arguing with sashiko via a submitter... :)
>
> Yeah, this is not really a problem but I thought I would change it up
> to make it apparent that the extra vma_write_lock_killable() is not
> even called.
>
> >
> > > > - Removed obsolete comment in madvise_update_vma() and mprotect_fix=
up()
> > > >
> > > > Patch#4:
> > > > - Added clarifying comment for vma_start_write_killable() when lock=
ing a
> > > > detached VMA
> > > > - Override VMA_MERGE_NOMERGE in vma_expand() to prevent callers fro=
m
> > > > falling back to a new VMA allocation, per Sashiko
> > > > - Added a note in the changelog about temporary workaround of using
> > > > ENOMEM to propagate the error in vma_merge_existing_range() and
> > > > vma_expand()
> > > >
> > > > Patch#5:
> > > > - Added fatal_signal_pending() check in do_mbind() to detect
> > > > queue_pages_range() failures due to a pendig fatal signal, per Sash=
iko
> > >
> > > Changes since v5:
> > >
> > >
> > >  mm/madvise.c   |   15 ++++++++++-----
> > >  mm/mempolicy.c |    9 ++++++++-
> > >  mm/mlock.c     |    2 ++
> > >  mm/mprotect.c  |   26 ++++++++++++++++----------
> > >  mm/mseal.c     |   27 +++++++++++++++++++--------
> > >  mm/vma.c       |   20 ++++++++++++++++++--
> > >  6 files changed, 73 insertions(+), 26 deletions(-)
> > >
> > > --- a/mm/madvise.c~b
> > > +++ a/mm/madvise.c
> > > @@ -172,11 +172,16 @@ static int madvise_update_vma(vm_flags_t
> > >       if (IS_ERR(vma))
> > >               return PTR_ERR(vma);
> > >
> > > -     madv_behavior->vma =3D vma;
> > > -
> > > -     /* vm_flags is protected by the mmap_lock held in write mode. *=
/
> > > -     if (vma_start_write_killable(vma))
> > > -             return -EINTR;
> > > +     /*
> > > +      * If a new vma was created during vma_modify_XXX, the resultin=
g
> > > +      * vma is already locked. Skip re-locking new vma in this case.
> > > +      */
> > > +     if (vma =3D=3D madv_behavior->vma) {
> > > +             if (vma_start_write_killable(vma))
> > > +                     return -EINTR;
> > > +     } else {
> > > +             madv_behavior->vma =3D vma;
> > > +     }
> > >
> > >       vma->flags =3D new_vma_flags;
> > >       if (set_new_anon_name)
> > > --- a/mm/mempolicy.c~b
> > > +++ a/mm/mempolicy.c
> > > @@ -1546,7 +1546,14 @@ static long do_mbind(unsigned long start
> > >                       flags | MPOL_MF_INVERT | MPOL_MF_WRLOCK, &pagel=
ist);
> > >
> > >       if (nr_failed < 0) {
> > > -             err =3D nr_failed;
> > > +             /*
> > > +              * queue_pages_range() might override the original erro=
r with -EFAULT.
> > > +              * Confirm that fatal signals are still treated correct=
ly.
> > > +              */
> > > +             if (fatal_signal_pending(current))
> > > +                     err =3D -EINTR;
> > > +             else
> > > +                     err =3D nr_failed;
> > >               nr_failed =3D 0;
> > >       } else {
> > >               vma_iter_init(&vmi, mm, start);
> > > --- a/mm/mlock.c~b
> > > +++ a/mm/mlock.c
> > > @@ -518,6 +518,8 @@ static int mlock_fixup(struct vma_iterat
> > >               vma->flags =3D new_vma_flags;
> > >       } else {
> > >               ret =3D mlock_vma_pages_range(vma, start, end, &new_vma=
_flags);
> > > +             if (ret)
> > > +                     mm->locked_vm -=3D nr_pages;
> > >       }
> > >  out:
> > >       *prev =3D vma;
> > > --- a/mm/mprotect.c~b
> > > +++ a/mm/mprotect.c
> > > @@ -716,6 +716,7 @@ mprotect_fixup(struct vma_iterator *vmi,
> > >       const vma_flags_t old_vma_flags =3D READ_ONCE(vma->flags);
> > >       vma_flags_t new_vma_flags =3D legacy_to_vma_flags(newflags);
> > >       long nrpages =3D (end - start) >> PAGE_SHIFT;
> > > +     struct vm_area_struct *new_vma;
> > >       unsigned int mm_cp_flags =3D 0;
> > >       unsigned long charged =3D 0;
> > >       int error;
> > > @@ -772,21 +773,26 @@ mprotect_fixup(struct vma_iterator *vmi,
> > >               vma_flags_clear(&new_vma_flags, VMA_ACCOUNT_BIT);
> > >       }
> > >
> > > -     vma =3D vma_modify_flags(vmi, *pprev, vma, start, end, &new_vma=
_flags);
> > > -     if (IS_ERR(vma)) {
> > > -             error =3D PTR_ERR(vma);
> > > +     new_vma =3D vma_modify_flags(vmi, *pprev, vma, start, end,
> > > +                                &new_vma_flags);
> > > +     if (IS_ERR(new_vma)) {
> > > +             error =3D PTR_ERR(new_vma);
> > >               goto fail;
> > >       }
> > >
> > > -     *pprev =3D vma;
> > > -
> > >       /*
> > > -      * vm_flags and vm_page_prot are protected by the mmap_lock
> > > -      * held in write mode.
> > > +      * If a new vma was created during vma_modify_flags, the result=
ing
> > > +      * vma is already locked. Skip re-locking new vma in this case.
> > >        */
> > > -     error =3D vma_start_write_killable(vma);
> > > -     if (error)
> > > -             goto fail;
> > > +     if (new_vma =3D=3D vma) {
> > > +             error =3D vma_start_write_killable(vma);
> > > +             if (error)
> > > +                     goto fail;
> > > +     } else {
> > > +             vma =3D new_vma;
> > > +     }
> > > +
> > > +     *pprev =3D vma;
> > >
> > >       vma_flags_reset_once(vma, &new_vma_flags);
> > >       if (vma_wants_manual_pte_write_upgrade(vma))
> > > --- a/mm/mseal.c~b
> > > +++ a/mm/mseal.c
> > > @@ -70,17 +70,28 @@ static int mseal_apply(struct mm_struct
> > >
> > >               if (!vma_test(vma, VMA_SEALED_BIT)) {
> > >                       vma_flags_t vma_flags =3D vma->flags;
> > > -                     int err;
> > > +                     struct vm_area_struct *new_vma;
> > >
> > >                       vma_flags_set(&vma_flags, VMA_SEALED_BIT);
> > >
> > > -                     vma =3D vma_modify_flags(&vmi, prev, vma, curr_=
start,
> > > -                                            curr_end, &vma_flags);
> > > -                     if (IS_ERR(vma))
> > > -                             return PTR_ERR(vma);
> > > -                     err =3D vma_start_write_killable(vma);
> > > -                     if (err)
> > > -                             return err;
> > > +                     new_vma =3D vma_modify_flags(&vmi, prev, vma, c=
urr_start,
> > > +                                                curr_end, &vma_flags=
);
> > > +                     if (IS_ERR(new_vma))
> > > +                             return PTR_ERR(new_vma);
> > > +
> > > +                     /*
> > > +                      * If a new vma was created during vma_modify_f=
lags,
> > > +                      * the resulting vma is already locked.
> > > +                      * Skip re-locking new vma in this case.
> > > +                      */
> > > +                     if (new_vma =3D=3D vma) {
> > > +                             int err =3D vma_start_write_killable(vm=
a);
> > > +                             if (err)
> > > +                                     return err;
> > > +                     } else {
> > > +                             vma =3D new_vma;
> > > +                     }
> > > +
> > >                       vma_set_flags(vma, VMA_SEALED_BIT);
> > >               }
> > >
> > > --- a/mm/vma.c~b
> > > +++ a/mm/vma.c
> > > @@ -531,6 +531,10 @@ __split_vma(struct vma_iterator *vmi, st
> > >       err =3D vma_start_write_killable(vma);
> > >       if (err)
> > >               goto out_free_vma;
> > > +     /*
> > > +      * Locking a new detached VMA will always succeed but it's just=
 a
> > > +      * detail of the current implementation, so handle it all the s=
ame.
> > > +      */
> > >       err =3D vma_start_write_killable(new);
> > >       if (err)
> > >               goto out_free_vma;
> > > @@ -1197,8 +1201,14 @@ int vma_expand(struct vma_merge_struct *
> > >
> > >       mmap_assert_write_locked(vmg->mm);
> > >       err =3D vma_start_write_killable(target);
> > > -     if (err)
> > > +     if (err) {
> > > +             /*
> > > +              * Override VMA_MERGE_NOMERGE to prevent callers from
> > > +              * falling back to a new VMA allocation.
> > > +              */
> > > +             vmg->state =3D VMA_MERGE_ERROR_NOMEM;
> > >               return err;
> > > +     }
> > >
> > >       target_sticky =3D vma_flags_and_mask(&target->flags, VMA_STICKY=
_FLAGS);
> > >
> > > @@ -1231,8 +1241,14 @@ int vma_expand(struct vma_merge_struct *
> > >                * is pending.
> > >                */
> > >               err =3D vma_start_write_killable(next);
> > > -             if (err)
> > > +             if (err) {
> > > +                     /*
> > > +                      * Override VMA_MERGE_NOMERGE to prevent caller=
s from
> > > +                      * falling back to a new VMA allocation.
> > > +                      */
> > > +                     vmg->state =3D VMA_MERGE_ERROR_NOMEM;
> > >                       return err;
> > > +             }
> > >               err =3D dup_anon_vma(target, next, &anon_dup);
> > >               if (err)
> > >                       return err;
> > > _
> > >

