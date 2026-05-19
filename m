Return-Path: <linuxppc-dev+bounces-21152-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A86ACD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 13:12:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKZp56Qh1z2xwH;
	Tue, 19 May 2026 23:12:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779196333;
	cv=none; b=S1HA/gOUlvJUKtz4kGzpv8x+D4eJTD6yVdWArSdpa7Dd16GSAAuyECVdUOVSjc7P92APEskOEr+AcQ3y7yQcK76RUCaeBA+ajbu4UDEQn1/BERVLRRSeolZQNELjReY8S5NrKNtSN6gJtj+hSbmcW9tBiJO+hSTapct33vIH4SC2DZcrC7uwHQI81vVHPXF/aBFa+aAs8eknQqt2JkJMrIpMZlXyCrrcjPcAWXE7w5/kSr6HCVJ7Ra36XgiK9qNZnonDiAi6mLNait/7GIWBfXA12sBOn/SfcMNBjluRYh3wHKBunM1Acbou4dKtyekp7OrALynbwl5820EBtNCgng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779196333; c=relaxed/relaxed;
	bh=4iyoWRaoAjssAMcZ3T8TXfOV+ORYjaRo+vLhGU1M3cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=La8JmWSC8a+7S92NkQvzleHOD7ubq0hkdk3ApMsV1ERBx5AfuFeDk09mbGieTa8KpzP03Ge2DlUWibfMg+A293+WuMzVYLOK9nKa+SmOjwqZwD8DM30XnK3ijOUmuA9vBpIfikpy6opASBoBqxA3SO5JUxK8slb1+3Vh9WqYVs7rqVCePpmYFHJkmIc6Ab2SmeYV/Mk4fTHquWZLOuLNFEIa2NE9AzH8diX/tIgGxp88PCmjK8y28x9KwB+Jika7GPaLTV4uX3a9h1iKVo7iv4CimpVhtPLXsBdl3Sw7sAA9kaYsyVc2aGQJXLdVyYu/ZVuSnFKP5rdL0DijUNcA8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YSGPE6UN; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YSGPE6UN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKZp44b8fz2xqv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 23:12:12 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6E0204074F;
	Tue, 19 May 2026 13:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4764BC2BCB3;
	Tue, 19 May 2026 13:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779196330;
	bh=sJ8oiAvqmhr7uHBQf9pYBhQP+kTq5NdeaE/VXHC2rqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YSGPE6UN5Qmce16ldLx9NKEWS+Et8MZjoQPtOf59P5nkhc8U2lrZGD8JkDxEHS0w+
	 jmmMI6+gtKWvDpALbh1cbwf4TAObuSvXatbUzcJkwup0oefI+MAyALMqPabU8jsEVy
	 o3SyWVoBrJpJUBQZ8O+WCJXIGAuAdZa15ZTa4vV/Z5WyNvz77F6F/2+C10LuVJSSFj
	 lZkaneaf1fdSE0EGWCsZZNXbeZR9y51LQPA0IEloovoGevsLaeOHToqEwaUoMlq3z2
	 GXR9n8QZ5VYTJzXhHzeyp2ncWhm/filX4zLxr0FaNcgJ0UEFKIolD9obziY7jvEIAS
	 jmPLXidQ+Gx2Q==
Date: Tue, 19 May 2026 14:12:00 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Yang Shi <shy828301@gmail.com>
Cc: Barry Song <baohua@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	surenb@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Nanzhe Zhao <nzzhao@126.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <agxfLNuLCAT3F4cW@lucifer>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <CAHbLzkrOSoh-jmR=uaNvx73n_wn+vExoKY0UzH5zGcfdAiDbNg@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkrOSoh-jmR=uaNvx73n_wn+vExoKY0UzH5zGcfdAiDbNg@mail.gmail.com>

On Mon, May 18, 2026 at 02:21:14PM -0700, Yang Shi wrote:
> On Sun, May 17, 2026 at 1:45 AM Barry Song <baohua@kernel.org> wrote:
> >
> > On Sat, May 2, 2026 at 1:58 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Sat, May 02, 2026 at 01:44:34AM +0800, Barry Song wrote:
> > > > On Fri, May 1, 2026 at 10:57 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> > > > > > 1. There is no deterministic latency for I/O completion. It depends on
> > > > > > both the hardware and the software stack (bio/request queues and the
> > > > > > block scheduler). Sometimes the latency is short; at other times it can
> > > > > > be quite long. In such cases, a high-priority thread performing operations
> > > > > > such as mprotect, unmap, prctl_set_vma, or madvise may be forced to wait
> > > > > > for an unpredictable amount of time.
> > > > >
> > > > > But does that actually happen?  I find it hard to believe that thread A
> > > > > unmaps a VMA while thread B is in the middle of taking a page fault in
> > > > > that same VMA.  mprotect() and madvise() are more likely to happen, but
> > > > > it still seems really unlikely to me.
> > > >
> > > > It doesn’t have to involve unmapping or applying mprotect to
> > > > the entire VMA—just a portion of it is sufficient.
> > >
> > > Yes, but that still fails to answer "does this actually happen".  How much
> > > performance is all this complexity in the page fault handler buying us?
> > > If you don't answer this question, I'm just going to go in and rip it
> > > all out.
> > >
> >
> > Hi Matthew (and Lorenzo, Jan, and anyone else who may be
> > waiting for answers),
> >
> > As promised during LSF/MM/BPF, we conducted thorough
> > testing on Android phones to determine whether performing
> > I/O in `filemap_fault()` can block `vma_start_write()`.
> > I wanted to give a quick update on this question.
> >
> > Nanzhe at Xiaomi created tracing scripts and ran various
> > applications on Android devices with I/O performed under
> > the VMA lock in `filemap_fault()`. We found that:
> >
> > 1. There are very few cases where unmap() is blocked by
> >    page faults. I assume this is due to buggy user code
> >    or poor synchronization between reads and unmap().
> > So I assume it is not a problem.
> >
> > 2. We observed many cases where `vma_start_write()`
> >    is blocked by page-fault I/O in some applications.
> >    The blocking occurs in the `dup_mmap()` path during
> >    fork().
> >
> > With Suren's commit fb49c455323ff ("fork: lock VMAs of
> > the parent process when forking"), we now always hold
> > `vma_write_lock()` for each VMA. Note that the
> > `mmap_lock` write lock is also held, which could lead to
> > chained waiting if page-fault I/O is performed without
> > releasing the VMA lock.
> >
> > My gut feeling is that Suren's commit may be overshooting,
> > so my rough idea is that we might want to do something like
> > the following (we haven't tested it yet and it might be
> > wrong):
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 2311ae7c2ff4..5ddaf297f31a 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1762,7 +1762,13 @@ __latent_entropy int dup_mmap(struct mm_struct
> > *mm, struct mm_struct *oldmm)
> >         for_each_vma(vmi, mpnt) {
> >                 struct file *file;
> >
> > -               retval = vma_start_write_killable(mpnt);
> > +               /*
> > +                * For anonymous or writable private VMAs, prevent
> > +                * concurrent CoW faults.
> > +                */
> > +               if (!mpnt->vm_file || (!(mpnt->vm_flags & VM_SHARED) &&
> > +                                       (mpnt->vm_flags & VM_WRITE)))
> > +                       retval = vma_start_write_killable(mpnt);
> >                 if (retval < 0)
> >                         goto loop_out;
> >                 if (mpnt->vm_flags & VM_DONTCOPY) {
>
> Maybe a little bit off topic. This is an interesting idea. It seems
> possible we don't have to take vma write lock unconditionally. IIUC
> the write lock is mainly used to serialize against page fault and
> madvise, right? I got a crazy idea off the top of my head. We may be

Err no, it serialises against literally any modification or read of any
characteristic of VMAs.

> able to just take vma write lock iff vma->anon_vma is not NULL.

Except if we don't take it and vma->anon_vma is NULL, then somebody can
anon_vma_prepare() and change vma->anon_vma midway through a fork and completely
screw up the anon_vma fork hierarchy.

So no.

>
> First of all, write mmap_lock is held, so the vma can't go or be
> changed under us.

vma->anon_vma can be changed.

>
> Secondly, if vma->anon_vma is NULL, it basically means either no page
> fault happened or no cow happened, so there is no page table to copy,
> this is also what copy_page_range() does currently. So we can shrink
> the critical section to:

Firstly, with no VMA write lock, !vma->anon_vma means a fault can race and
secondly copy_page_range() checks vma_needs_copy(), there are other cases - PFN
maps, mixed maps, UFFD W/P (ugh), guard regions.

So yeah this isn't sufficient.

>
> if (vma->anon_vma) {
>     vma_start_write_killable(src_vma);
>     anon_vma_fork(dst_vma, src_vma);
>     copy_page_range(dst_vma, src_vma);
> }

Yeah that's totally broken fo reasons above as I said :)

>
> But page fault can happen before write mmap_lock is taken, when we
> check vma->anon_vma, it is possible it has not been set up yet. But it
> seems to be equivalent to page fault after fork and won't break the
> semantic.

It will totally break how the anon_vma hierarchy works :) See the links at the
top of https://ljs.io/talks for a link to various slides on anon_vma behaviour
(it's really a pain to think about because it's a super broken abstraction).

You could end up with a CoW mapping that's unreachable from rmap and you could
get some nasty issues with page table entries pointing at freed folios :)

>
> Anyway, just a crazy idea, I may miss some corner cases.

Yeah sorry to push back here but this is just not a viable approach.

And this is forgetting that we have relied on page faults being blocked by fork
_forever_, who knows what else has baked in assumptions about that
serialisation.

Forking is one of the nastiest parts of mm and has had multiple, subtle, corner
case breakages that have been a nightmare to deal with.

So I'm very much against changing this behaviour to try to fix something in the
fault path.

We should address the fault path issues in the fault path :)

>
> Thanks,
> Yang
>
> }
>
> >
> > Based on the above, we may want to re-check whether fork()
> > can be blocked by page faults. At the same time, if Suren,
> > you, or anyone else has any comments, please feel free to
> > share them.
> >
> > Best Regards
> > Barry
> >

Cheers, Lorenzo

