Return-Path: <linuxppc-dev+bounces-21182-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE530CD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 18:41:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKk6V3hLwz2xwH;
	Wed, 20 May 2026 04:41:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::532" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779216114;
	cv=pass; b=NqB8m69vfb6y9t2omBcGlIzJ0DckHa76y4sgqSVxGnh2SBc3w7lINnaiTy94C0kVGO7vboRd7ZErlRDVDhfB8Oa5o7AYZTVrYzSd/moyzj2wJA2aCroC9I52/xIzTaealrzJLmlEqYGSbe6PdQuOICg4nY62ee3vzLcqh1JEtlv30+s3UW69kTbkFKTFBTJohmWgjp8tIIPrIHCJefj6WJs3wJU5B26i2Ic4kOGnjDz2acqpS9TisUhP6XTd/7oh3q8BYLKYoDSBbTuOMPU9VID21m0PNNfRiyX9VJcvqJtdZWC/f9nC6w3tUMfNth2O0q/dZJsHxkzo9JMFE96Eqg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779216114; c=relaxed/relaxed;
	bh=sgMtJYuaR0izLLaK1FUWPlLIzmxQrZ1MxrGID/mYXGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLZS9UWeqhKbf21sPnZFdx1JypFutbCjebeaPYUQi+Ofs5m2cblAwe2obvsz/Cx5UiLhNbHpbjr5OL4EPMq6Rymo1ztyR1nYVX7nJBwiFMFPa7J/LLndlJqNRnbyhQAyb34hwrhYfLFiEjD8Q5kcFPJV3xfzA/K02OocsQwsVIsMsVuyhethM55YVmryRSIHFoZdqtHi//G5I7lXkpoAIxWqHAvv5ouM7NOL9Reqh6Q9ZE/KXPrqYAW69K8l+IQuX53Nz1UTrU/s0vckjndWd3UqunT9+0Q6mlm4K7p10KXM3HgHrJ4/gwtMHOr3B8m9ErT3HfT/s031uHNh3rBa6g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=izdmSJoj; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=shy828301@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=izdmSJoj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=shy828301@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKk6S2Rfwz2xqv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 04:41:51 +1000 (AEST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-67c1e0229acso6583236a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 11:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779216103; cv=none;
        d=google.com; s=arc-20240605;
        b=KF9bT3PH37CQADSxXVonincPbtVc8efJJcHcf9YpD3+IVNG9pMNtyNwgh1WTB+IWIu
         E3PmrMh2MQRluL9ocQ35pnvqLd6ES5rsgOTnrqj4TecAw2VR6NuNxWuTAgbG8swUuyK/
         SoqstyA2E7PFsrY7dRsT0vfWBhG1KLFLT84wYTAJJSwx3UhyIkNSAG3s6F6Mnf7Y/qef
         NdKH9VxwvNjUEbPMK9roF0s8xbQTritp04CdzoltSRmfqyYvA3EBlJ7ss7Vor2qUO4w2
         W4PjR9XX3hswH5MnsB60f+svorZ5wqgkzKCf0OTMLR5K5T5cbgGZRp+gf+HBIpC2T2/G
         63yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sgMtJYuaR0izLLaK1FUWPlLIzmxQrZ1MxrGID/mYXGU=;
        fh=SPVuk7BtjdP43e3hcydsLiDv2Xd8x913haASued3JtQ=;
        b=PThJQwlwHQjbV2TqAt/zYF7JJwngEquBjYjH5hWhQcmAbwfqZKA6PN0tHNYz68uJOB
         dIPsh2JDJuu+PN2MdaF7yGTp6SL0b7J1qxNBn6jbepURgbg7uArh0o+40I4t+14ZCNaD
         4JKLKjgAJMkHsEFaVrMslix1zH2dQipfNFfSwkvNm+qX53GbHtbTGbHY6DMl00X5pmHO
         Um9xj4mrde9F99UY2CXclKIPkFr5j4bCTrIE5Zt9p4tgqeqbghx6Slve6pxDgHSgnKU6
         ZIjWrRUSK1VCFlXhfGy9JR0x84Cr4hGpbeQmMK1i0ayYxDdyYQBcxIT/9Do/Q1acg9uK
         MGeA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779216103; x=1779820903; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgMtJYuaR0izLLaK1FUWPlLIzmxQrZ1MxrGID/mYXGU=;
        b=izdmSJojjmnYZhUEg1b009mAdIqY1fp1tncz9r6n+bKgESXl87OF5wDSZVHd7Z5s1T
         XEKWq2k/lS5mWjwWdWPlo2sq5D79Zq2bjnKbP8iHgl3Y13FvogpgLG1cp15Gj5AYXXAh
         NImXK04NA4cZQUTDg4BUUphb7c9DFV8NiklOWzbL/jCmS/1tx1elMSc2Vhd/6J0HQMCE
         vIunjeNJmFxcW7CtPRWDhsWJVR4LG9UWbCHLZFyGKSXAWMHCuaFMYdVIuJgTpA4MtvWO
         19R15AsohNuQNrDx39FEJxqMiid4VOmoyPsG455MePlmFo+DXCQBzWJ9OqcxI+88KxSw
         sLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216103; x=1779820903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sgMtJYuaR0izLLaK1FUWPlLIzmxQrZ1MxrGID/mYXGU=;
        b=rqv5EVR128cQtpWaEhXFWQkbQgnakJ6wMkDV5IHDOxjk52Mei60AMaWxT7wDzu4g4l
         50jgriOrBQgeoPxkauEdiyqsef1NCbTKoGnoyXpNTYiVJbqRw2bqB+umhiuLjt9+Vg+f
         KZQ5vFKSCd2CkysaC7389NqSUHFQ01QGw4dJmumOovzgH4gt12OdtBoaxJ5ReouEaeCu
         +od34gr64Sau34XKOoTgUxaMn4xNgmIZC4WVEsJD8tFsmLYFa0ESDrhxlyjKXFDbhe9m
         JbuKAkyPJP+oczcg/4fzfXDzs35ouDdQRHV+hkJKVemhvPhTDmhzLK2Lm7ET9MEhew1l
         DpXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9squ7+b1yzBiAqW1yS7mManqsA2xO/bfIu8gVmCAz0Px+j0YQ58Q1RgUaNM91wZwk/N29bdltX6mvH07k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxEEc/Ap98yn6jRGNtTbmzLqSU0vyeWCyEwmxjnVL2v4qdfjtDt
	4hsHIR9lxY9Qw9lUcrT8C9Ua0E7z/zzoIbDQ+X34OtpEaXMVyEU7Bmz8ws95PF05McarajAFduM
	4l1iSKHSwKtHRvEMsE/G6NogZgtgJwWo=
X-Gm-Gg: Acq92OFTOwxYI8zFE69smtfTedBqB6lxGBpdA148n6Zw6+rz0hjzsFuFwxf5YJLVtJr
	as3HAEpxSb3h9a7KEMXlx6iYLBpGttvZk3xE2Y6IrZlvQBiZGwxX6ohzFUi13bUjKYGqNOSTDWM
	0iDM4zxRrNE4UEsFeBhAY3IcEgYzKWzYyHHlQvd5eBwd5YtfuPZJoFetyRMpuTtchWFlzR79DE3
	qyoD28q5eKHv4guNjBuiHgbefsyrctcbSJ3CqFr1VYwMLCWPwLHEvvFZXZvnvaC2r+O+/ukQZrK
	9sK8TnFkaw==
X-Received: by 2002:a05:6402:524c:b0:67c:96e7:3427 with SMTP id
 4fb4d7f45d1cf-683bad350f8mr10588073a12.0.1779216103209; Tue, 19 May 2026
 11:41:43 -0700 (PDT)
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
 <agxfLNuLCAT3F4cW@lucifer> <agxnJ8R-G3CRjeTR@lucifer>
In-Reply-To: <agxnJ8R-G3CRjeTR@lucifer>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 19 May 2026 11:41:30 -0700
X-Gm-Features: AVHnY4KjLtyViRy-FP1MJx-LYZJZfACCXodkXf2RGwVY3_NriDPxFvXtK5Jn_zQ
Message-ID: <CAHbLzkpjOLrdRSUF3-G4d9uz6tn6QYwgB66UU9bud5WHr5FWEw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Matthew Wilcox <willy@infradead.org>, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, 
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 6:39=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org> wr=
ote:
>
> On Tue, May 19, 2026 at 02:12:10PM +0100, Lorenzo Stoakes wrote:
> > On Mon, May 18, 2026 at 02:21:14PM -0700, Yang Shi wrote:
> > > Maybe a little bit off topic. This is an interesting idea. It seems
> > > possible we don't have to take vma write lock unconditionally. IIUC
> > > the write lock is mainly used to serialize against page fault and
> > > madvise, right? I got a crazy idea off the top of my head. We may be
> >
> > Err no, it serialises against literally any modification or read of any
> > characteristic of VMAs.

If I remember correctly, you are not supposed to change VMA
flags/size/mm pointer/vm_file/pgoff/prot, etc, under read vma lock or
read mmap_lock.

> >
> > > able to just take vma write lock iff vma->anon_vma is not NULL.
> >
> > Except if we don't take it and vma->anon_vma is NULL, then somebody can
> > anon_vma_prepare() and change vma->anon_vma midway through a fork and c=
ompletely
> > screw up the anon_vma fork hierarchy.
>
> correction: this won't happen as per Barry (see - I managed to confuse my=
self
> here :), since for vma->anon_vma install we take the mmap read lock.
>
> BUT we also have to consider other cases.
>
> >
> > So no.
> >
> > >
> > > First of all, write mmap_lock is held, so the vma can't go or be
> > > changed under us.
> >
> > vma->anon_vma can be changed.
>
> Correction: no it can't :)

Yes, vma->anon_vma change should require taking read mmap_lock.

>
> >
> > >
> > > Secondly, if vma->anon_vma is NULL, it basically means either no page
> > > fault happened or no cow happened, so there is no page table to copy,
> > > this is also what copy_page_range() does currently. So we can shrink
> > > the critical section to:
> >
> > Firstly, with no VMA write lock, !vma->anon_vma means a fault can race =
and
> > secondly copy_page_range() checks vma_needs_copy(), there are other cas=
es - PFN
> > maps, mixed maps, UFFD W/P (ugh), guard regions.
> >
> > So yeah this isn't sufficient.
>
> However this is true...

Yes, fault can race with fork. Basically this is actually the purpose
of this idea. We can have improved page fault scalability. In my
proposal (take write vma lock if vma->anon_vma is not NULL), the race
just happens on the VMAs which page fault has not happened on before.
vma_needs_copy() also skips the VMAs which don't have vma->anon_vma.
So there is basically no difference in semantics other than more page
fault races IIUC. It should be safe as long as we can guarantee there
is no writable PTE point to a shared page after fork.

For guard regions, it can be serialized by vma write lock if
vma->anon_vma exists. If vma->anon_vma is NULL, it will prepare
anon_vma, which will take read mmap_lock if I read the code correctly.

I have not investigated UFFD yet.

>
> >
> > >
> > > if (vma->anon_vma) {
> > >     vma_start_write_killable(src_vma);
> > >     anon_vma_fork(dst_vma, src_vma);
> > >     copy_page_range(dst_vma, src_vma);
> > > }
> >
> > Yeah that's totally broken fo reasons above as I said :)
> >
> > >
> > > But page fault can happen before write mmap_lock is taken, when we
> > > check vma->anon_vma, it is possible it has not been set up yet. But i=
t
> > > seems to be equivalent to page fault after fork and won't break the
> > > semantic.
> >
> > It will totally break how the anon_vma hierarchy works :) See the links=
 at the
> > top of https://ljs.io/talks for a link to various slides on anon_vma be=
haviour
> > (it's really a pain to think about because it's a super broken abstract=
ion).
> >
> > You could end up with a CoW mapping that's unreachable from rmap and yo=
u could
> > get some nasty issues with page table entries pointing at freed folios =
:)
>
> Correction: actually we should be safe given mmap read lock on anon_vma i=
nstall.
>
> >
> > >
> > > Anyway, just a crazy idea, I may miss some corner cases.
> >
> > Yeah sorry to push back here but this is just not a viable approach.

No worries. Thanks for all the feedback. Just tried to explore whether
such an idea is feasible or not.

> >
> > And this is forgetting that we have relied on page faults being blocked=
 by fork
> > _forever_, who knows what else has baked in assumptions about that
> > serialisation.
> >
> > Forking is one of the nastiest parts of mm and has had multiple, subtle=
, corner
> > case breakages that have been a nightmare to deal with.

Yes, this might be the biggest concern. The page fault can race with
fork. If some applications rely on such subtle behavior, it may break,
but such applications are fragile too.

> >
> > So I'm very much against changing this behaviour to try to fix somethin=
g in the
> > fault path.
> >
> > We should address the fault path issues in the fault path :)

Yeah, this idea was inspired by Barry's "not take vma read lock
unconditionally" idea. Maybe irrelevant to Barry's priority inversion
problem, just an idea for further optimization on page fault
scalability. This probably should be a separate topic.

Thanks,
Yang

>
> Above still all true though.
>
> >
> > >
> > > Thanks,
> > > Yang
> > >
> > > }
> > >
> > > >
> > > > Based on the above, we may want to re-check whether fork()
> > > > can be blocked by page faults. At the same time, if Suren,
> > > > you, or anyone else has any comments, please feel free to
> > > > share them.
> > > >
> > > > Best Regards
> > > > Barry
> > > >
> >
> > Cheers, Lorenzo
>
> So still a nope :)
>
> Cheers, Lorenzo

