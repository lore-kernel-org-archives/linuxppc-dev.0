Return-Path: <linuxppc-dev+bounces-21193-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D975CD5BA4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 20:53:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKn282C5Cz2xwH;
	Wed, 20 May 2026 06:53:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::532" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779224000;
	cv=pass; b=lKCw40FfnitOYm9JvKzvfg23KNzWBKNoNqTLs1MbEJS3IwN8Wlsgj0Fy9NVRFOMT91xmwtf/11lSfwbQ75MRpw+srbTSAWdK3iYD3f+4tG/cSJHgFf7VSIc9x5Vu2SpU7BU+ToQsqJlao86Nztkymwu+yEIKxXu7U890cwkrJbmgPaVdWa8Os3kL2PPi+udVayw5oaIoQ9p9IPr1fBnWMryBYoV2iYgfcd+nVHes//dIWX2XzIMGjUzWJqK7FLyeCOiDjqD0/+5ISarQSftAxP8McMS+Uiv3L+nhYkzpONrPTXbVegfEBLGSSPNAKThE/bxD29pEWDEVa8hk9jpX/A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779224000; c=relaxed/relaxed;
	bh=ae+dijTOTo/8e3HvGN3FEZCQc/7H0q/1pnPZoGZAADo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5kdbR6dCFej9JevouTAha8rU46d2V+V1rgNCNKAbKRboZAgmw1VfhMBgyyxRmb0gSxjZOVUdVKh+1LFtRwjQSzlpAiLTM3L5Or29Ny4Sm5Zw2YKU5gFB2JtJhn00sBWab+BH8hJBFZAQLxXuna+qibWLBR/sfQLYfV8B+HsU6K9cIOdyOi3lc+TbXYlpxd8sugkIt/sYqsXxZQbh8z5y0mGhxy6A4LNC0nHdGu3NdWXngitx5k7vN+xS+Ko4gsrtmJpfj2xoPe5YhbRqP7aGw4b199EoqVWbf3cDjuZ9KyiyS1aXip7D/PWtb02MTs4Z0PKxnWjZQ58dKgLFxf/Ig==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FCP9LiUu; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=shy828301@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FCP9LiUu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=shy828301@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKn264YZlz2xSG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 06:53:17 +1000 (AEST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-67f7caa33easo8771588a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 13:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779223995; cv=none;
        d=google.com; s=arc-20240605;
        b=Z9MPNVZyjZ8C9U5ql/tq9iY00oL/ynG8yFlSXHQe2c6FfIiJ+d75xSnDPMzWFtfM3D
         GB3GPL/q2gxStxbfnaDChsTBmPxHjfv19iPQxbGUZ3423lq+UKpZo/uz8QjKEx2bCpZo
         M83amaZhLpxrHoiT17oYBi1uyMl+5LpNeGmNPYku6DDLizOPqsIS9waNIUIFa/q596NF
         b2cJ8qqk5Ak0zNnETRZQJw7GyojNRipLTZP/pMcWC5dREZxZ74bAYWI1VSB/oyAnP4al
         vm7H6oqmZxr4pi6z3/0qlB3rSjoQScUweE6qbxYi52VoQzCqFypdjJlsq3bRd14tuYEQ
         yg9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ae+dijTOTo/8e3HvGN3FEZCQc/7H0q/1pnPZoGZAADo=;
        fh=tRhMDm4EgoLh39sE2ur1Gz5+BMYO4kWk1g+GzPHchd0=;
        b=EeLGx13LmZqc8mBOyJoh+ETYx+c4WZNN18CmuwedUHcyTq4dFpr3+jPLilNwZR25SW
         5mebwPtxCRPEnmX97ijSd/4qtVoTo+RabOkhZ+h0zXMA+KKbivKECXy8zZnUdds49v/0
         FpLTBBCSAEJcYOYivJWzj+YE5NstLzP9JnzHbKYf6vNML40/mf9JVU2VDykBa0q0hfSr
         cLyaIjEM5PwJglh6SrjW1eTcMYe4Uq4Um89Mbb3s9+4CVLv0a3ypSPUx4Rcrho+cwg9b
         acm25ssnqp1d6alxtCqc81Ahd0xKXSADoT0CTruw9nWRUhLDCIqOHR+czdzhVTM6Ampt
         grQg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779223995; x=1779828795; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ae+dijTOTo/8e3HvGN3FEZCQc/7H0q/1pnPZoGZAADo=;
        b=FCP9LiUun7BR967M+FOZTbJIjetuNqliR2rqvIXOENG6gT5NXfx/pJJUhowQzVjh1j
         87d0KowCSGRo+ft1iuFZwJ2ge0D20z+YRjJuDQVozsKWzCQ4mNh1oL+KIGI/oXf7QdHS
         L45W5MABAI4bjh7VMgzNcYjU5YYbtVDKpQFbJdV+zd2a9k6Y42iTG8tZwSGd4sFlz8Yo
         PyIqJxbXa9xyDHCEAzqsmesptBJ49qe8TFkTlcR4R0BHultghaF2Dw22GUQKYDulLvfU
         5wgB0lkP4uDmrkIwhnNi0Mgk4EKS8/tEPDPFwtQOeyO2OWeHid0zEn1Rj+NgmYivJAMW
         ogPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779223995; x=1779828795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ae+dijTOTo/8e3HvGN3FEZCQc/7H0q/1pnPZoGZAADo=;
        b=PMs6kLn2rnDLKkGlJqTinzvBt91vwGUo1sXs1pK88eKVv5j3EhMqxMKkG7uzc0ehMz
         VVi8B22mSLPQIkDgiPtVlrXSvL5aiPPM6j005ZWxDc7h+RdICv5rqnEkOs4ZP7zOR8ZI
         n7YLlfyX4ATuLWWhLCGyZ5CuiquEZ22kkEWpYkvAtjNxFLKrhgyR/h5NjiQKIvGRXc2L
         sIru82JPzScikd2V6RZnzg+3gKLJVC2dwcqp16kICp+r3xUf1szqy1BKk4bh1fN/LJkE
         9guCpr3tWbFXup0i9AwHrff0Aw3m+IT7oq+LHwze+L4PEhZMJXl4Wq+dHTqEkhT1HKll
         XX9A==
X-Forwarded-Encrypted: i=1; AFNElJ937SB4s4KAhl1emxkB6QryCV9jkxobxA8+nFfJ7IJB54pFqo5aYDwdl5/uHXmWNyzpWFDZrqQ05uY3quE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YymySbif2XRAo14m983YxiHJB/CUIT3qXPqsCtbcUuB2AnSxIoa
	uTlyQj5APM8mF0envtHOgtJ7o97EdkfokNLJgD8eJmr/8lE07NXOSi0KT1QTETvWQNZBKqGSPJ3
	0H1tnlUqV3XdmK11CNjTMkTwtzpscnQs=
X-Gm-Gg: Acq92OHlKTvWJX/q16pBi4EZmxiN/6vaUprk5uPhc7CjzzhmMxsML+DA6uqKascD/bs
	e1Qddz0eeS+H/knvC9VtGisbrzjLNdR5kNCAibqjLP4OcB6nXL7HUq200tYsKmWK0Q4jHAklnDj
	WjxKZRJrBM+3oRWO6KKxdN3GbAJdRuOTFKk5SeDLEFiTpyg/+QRtL6BaSxojZqBwPXurereuDw2
	VkoWH/dCClW7IS9o4wgpVjpSq6OwmJ0PkIY3H7FMpv84wrrTIwIigomDwZEGqm6bCUYUro6o5Vg
	6rbuhJkvBg==
X-Received: by 2002:a05:6402:24ce:b0:683:1cc8:84b5 with SMTP id
 4fb4d7f45d1cf-683bc1b7472mr10554792a12.4.1779223994390; Tue, 19 May 2026
 13:53:14 -0700 (PDT)
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
References: <20260430040427.4672-1-baohua@kernel.org> <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org> <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org> <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <CAHbLzkrOSoh-jmR=uaNvx73n_wn+vExoKY0UzH5zGcfdAiDbNg@mail.gmail.com>
 <CAGsJ_4w_-Y8qNLDeLX9OWpLpK01YG2bF-N6_mGypgsauvfCvkA@mail.gmail.com> <CAHbLzkpbQ4Ca0xC74BJ6iJUVKdpH90qE+E=g7HkDXvcNH1+8+w@mail.gmail.com>
In-Reply-To: <CAHbLzkpbQ4Ca0xC74BJ6iJUVKdpH90qE+E=g7HkDXvcNH1+8+w@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 19 May 2026 13:53:03 -0700
X-Gm-Features: AVHnY4IimOZqeIRblNaSy2KsMS8vB_GzCmlGYie_zXnP_ZtHrsCb1dPTmYJGNBE
Message-ID: <CAHbLzkp7WcXA6Zey2QjBDrcs1w2hP4dhBoda2G3XF+Q0h_hwsQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Barry Song <baohua@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, surenb@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, jack@suse.cz, 
	pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, 
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:50=E2=80=AFAM Yang Shi <shy828301@gmail.com> wro=
te:
>
> On Tue, May 19, 2026 at 4:07=E2=80=AFAM Barry Song <baohua@kernel.org> wr=
ote:
> >
> > On Tue, May 19, 2026 at 5:21=E2=80=AFAM Yang Shi <shy828301@gmail.com> =
wrote:
> > >
> > > On Sun, May 17, 2026 at 1:45=E2=80=AFAM Barry Song <baohua@kernel.org=
> wrote:
> > > >
> > > > On Sat, May 2, 2026 at 1:58=E2=80=AFAM Matthew Wilcox <willy@infrad=
ead.org> wrote:
> > > > >
> > > > > On Sat, May 02, 2026 at 01:44:34AM +0800, Barry Song wrote:
> > > > > > On Fri, May 1, 2026 at 10:57=E2=80=AFPM Matthew Wilcox <willy@i=
nfradead.org> wrote:
> > > > > > >
> > > > > > > On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> > > > > > > > 1. There is no deterministic latency for I/O completion. It=
 depends on
> > > > > > > > both the hardware and the software stack (bio/request queue=
s and the
> > > > > > > > block scheduler). Sometimes the latency is short; at other =
times it can
> > > > > > > > be quite long. In such cases, a high-priority thread perfor=
ming operations
> > > > > > > > such as mprotect, unmap, prctl_set_vma, or madvise may be f=
orced to wait
> > > > > > > > for an unpredictable amount of time.
> > > > > > >
> > > > > > > But does that actually happen?  I find it hard to believe tha=
t thread A
> > > > > > > unmaps a VMA while thread B is in the middle of taking a page=
 fault in
> > > > > > > that same VMA.  mprotect() and madvise() are more likely to h=
appen, but
> > > > > > > it still seems really unlikely to me.
> > > > > >
> > > > > > It doesn=E2=80=99t have to involve unmapping or applying mprote=
ct to
> > > > > > the entire VMA=E2=80=94just a portion of it is sufficient.
> > > > >
> > > > > Yes, but that still fails to answer "does this actually happen". =
 How much
> > > > > performance is all this complexity in the page fault handler buyi=
ng us?
> > > > > If you don't answer this question, I'm just going to go in and ri=
p it
> > > > > all out.
> > > > >
> > > >
> > > > Hi Matthew (and Lorenzo, Jan, and anyone else who may be
> > > > waiting for answers),
> > > >
> > > > As promised during LSF/MM/BPF, we conducted thorough
> > > > testing on Android phones to determine whether performing
> > > > I/O in `filemap_fault()` can block `vma_start_write()`.
> > > > I wanted to give a quick update on this question.
> > > >
> > > > Nanzhe at Xiaomi created tracing scripts and ran various
> > > > applications on Android devices with I/O performed under
> > > > the VMA lock in `filemap_fault()`. We found that:
> > > >
> > > > 1. There are very few cases where unmap() is blocked by
> > > >    page faults. I assume this is due to buggy user code
> > > >    or poor synchronization between reads and unmap().
> > > > So I assume it is not a problem.
> > > >
> > > > 2. We observed many cases where `vma_start_write()`
> > > >    is blocked by page-fault I/O in some applications.
> > > >    The blocking occurs in the `dup_mmap()` path during
> > > >    fork().
> > > >
> > > > With Suren's commit fb49c455323ff ("fork: lock VMAs of
> > > > the parent process when forking"), we now always hold
> > > > `vma_write_lock()` for each VMA. Note that the
> > > > `mmap_lock` write lock is also held, which could lead to
> > > > chained waiting if page-fault I/O is performed without
> > > > releasing the VMA lock.
> > > >
> > > > My gut feeling is that Suren's commit may be overshooting,
> > > > so my rough idea is that we might want to do something like
> > > > the following (we haven't tested it yet and it might be
> > > > wrong):
> > > >
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index 2311ae7c2ff4..5ddaf297f31a 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -1762,7 +1762,13 @@ __latent_entropy int dup_mmap(struct mm_stru=
ct
> > > > *mm, struct mm_struct *oldmm)
> > > >         for_each_vma(vmi, mpnt) {
> > > >                 struct file *file;
> > > >
> > > > -               retval =3D vma_start_write_killable(mpnt);
> > > > +               /*
> > > > +                * For anonymous or writable private VMAs, prevent
> > > > +                * concurrent CoW faults.
> > > > +                */
> > > > +               if (!mpnt->vm_file || (!(mpnt->vm_flags & VM_SHARED=
) &&
> > > > +                                       (mpnt->vm_flags & VM_WRITE)=
))
> > > > +                       retval =3D vma_start_write_killable(mpnt);
> > > >                 if (retval < 0)
> > > >                         goto loop_out;
> > > >                 if (mpnt->vm_flags & VM_DONTCOPY) {
> > >
> > > Maybe a little bit off topic. This is an interesting idea. It seems
> > > possible we don't have to take vma write lock unconditionally. IIUC
> > > the write lock is mainly used to serialize against page fault and
> > > madvise, right? I got a crazy idea off the top of my head. We may be
> > > able to just take vma write lock iff vma->anon_vma is not NULL.
> > >
> > > First of all, write mmap_lock is held, so the vma can't go or be
> > > changed under us.
> > >
> > > Secondly, if vma->anon_vma is NULL, it basically means either no page
> > > fault happened or no cow happened, so there is no page table to copy,
> > > this is also what copy_page_range() does currently. So we can shrink
> > > the critical section to:
> > >
> > > if (vma->anon_vma) {
> > >     vma_start_write_killable(src_vma);
> > >     anon_vma_fork(dst_vma, src_vma);
> > >     copy_page_range(dst_vma, src_vma);
> > > }
> > >
> > > But page fault can happen before write mmap_lock is taken, when we
> > > check vma->anon_vma, it is possible it has not been set up yet. But i=
t
> > > seems to be equivalent to page fault after fork and won't break the
> > > semantic.
> >
> > Re-reading Suren's commit log for fb49c455323ff8
> > ("fork: lock VMAs of the parent process when forking"),
> > it seems that vm_start_write() is used to protect
> > against a race where anon_vma changes from NULL to
> > non-NULL during fork. In that scenario, we hold the
> > mmap_lock write lock, but not vma_start_write(), so a
> > concurrent anon_vma_prepare() could still install an
> > anon_vma.
> >
> > "    A concurrent page fault on a page newly marked read-only by the pa=
ge
> >     copy might trigger wp_page_copy() and a anon_vma_prepare(vma) on th=
e
> >     source vma, defeating the anon_vma_clone() that wasn't done because=
 the
> >     parent vma originally didn't have an anon_vma, but we now might end=
 up
> >     copying a pte entry for a page that has one.
> > "
> >
> > If that is the case, then your change does not work.
> >
> > Nowadays, nobody calls anon_vma_prepare(vma) directly.
> > Instead, vmf_anon_prepare() is used, and we always
> > require the mmap_lock read lock before calling
> > __anon_vma_prepare(). As a result, anon_vma cannot
> > transition from NULL to non-NULL during fork.
> >
> > So the original race condition has effectively
> > disappeared.
>
> anon_vma_prepare() has some usecases too, but it seems like it
> requires taking read mmap_lock too if I read the code correctly.
>
> >
> > You also mentioned the madvise() case. If I understand
> > correctly, madvise() should take mmap_lock before
> > modifying anon_vma. Only some parts of madvise() can
> > support per-VMA locking. Therefore, we probably do not
> > need:
> >
> > if (vma->anon_vma) {
> > vma_start_write_killable(src_vma);
> > ...
> > }
>
> I think we still need write vma lock to serialize anon_vma fork
> otherwise we may see:
>
>         CPU 0                                                 CPU 1
> fork                                                       page fault
>    src vma has no anon_vma
>        skip vma fork
>
> allocate anon_vma for src vma
> vma_needs_copy() sees anon_vma
> copy page
>
> Then we may end up being no anon_vma for dst vma, but with pages mapped i=
n it.

Sorry, this should not happen because creating anon_vma in page fault
needs to take mmap_lock.

Thanks,
Yang

>
> Thanks,
> Yang
>
> >
> > >
> > > Anyway, just a crazy idea, I may miss some corner cases.
> >
> > To me, it seems that we could remove vma_start_write()
> > entirely now. Or is that an even crazier idea?
>
>
> >
> > Thanks
> > Barry

