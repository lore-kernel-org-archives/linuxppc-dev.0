Return-Path: <linuxppc-dev+bounces-20390-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA50FF886F
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 May 2026 19:56:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g7wWN6XTsz2xg8;
	Mon, 04 May 2026 05:56:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777838160;
	cv=none; b=K7f1fnXIKOu1XU5I7EUFjNJx9xCdiic1v3QDw2ouPja5eeA2TvDGfyCVuARwX5jRMdI8lajYEIf188X9mhnUwUBpXjS3+C0COUCmuxrS35Ezxn7BoVhhc4ui/T4FHIAOJb88zEal4/QtJx+mZ7wci5Cak34T0a5Jms9STyeUJ7nTlg3pZOpHVPdT5vaRRSOJaGSl5kedNOb3bqr5Daws2ShCOS8wTSbE7RyooK965BhX11FEQdQKMGLg9T5lgcgAnxo2QT5KC97hTty8qfzuy8dNHtm51i7xbHEL7pAMC0Uu2wCP7hutuMxnYm/qkmFDLPG0zkDW+NA2+BhHN0ECSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777838160; c=relaxed/relaxed;
	bh=7bhFmIB4GpwZzfLoiO6pcKAFE9QNelEpmmS09GV+5aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQi8EF3nU2BcL3MzUu/4ISaURvtieGeKMbSEwEqIttL4x3g53dRCv3WsctrkBqEnK9ueuE6G+QsUhmwx8O7QQeRm0yJCF8g2Rww8+aZF7Dawa3enjCMN5bZ9uY255ggG47Y401oih6aqHneLCkjW81xKq+DH3YOdlKuQckofjy//2EXBve+ISIAvXWgfUotSgAMAwkDCVydZLg+JaCxlQDpErdTOPuCdOC88faL4gQUL1jL5BHBjJx0b6qnketQUNqXlec4XmiHwGVz/zZ4fxr3ExUNu+wyj5duvg3ZxGiBOjECymElimixSI7Z5CGaeyCuogpRqQZu4QGsOJ2o8gQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I2LrCfTK; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I2LrCfTK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g7wWL5VN0z2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 May 2026 05:55:58 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B1C18443BF
	for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 May 2026 19:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBA5C2BCFC
	for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 May 2026 19:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777838155;
	bh=q0YQtTiiL7ieGdsHU5xDXtyCdqIQKThOK+46A5C32Gs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I2LrCfTKxq4IVaLNDuZ1S09XfDfyfhD4jomMUPbzrmQVVmcYTxvqMttecoq9syWRx
	 j2vqFmHkN3FN4QFvwP4rqOmeCxhkL3/9+Bf9OwTlICDDmZv2TBM43XaoWDOVyoxB9O
	 uXfZCP7LEJ1jMnUHvhQL84OeO100SA13TNQodxkYjrsA0+sOi7PC/ZW73GD+6l+XD/
	 Xm0wkYGd28jiSG0a9eJ3ab+nn3cED9SDxF2uHkNytaBziig812s1tkcKSi+3YhsN76
	 r/1UtWafHIKEOYHQJo2v3bIDjTh7LI+ZVE8DI4a3fwLchTaxIVBaugdBeS7ao0E3yy
	 OWM41KwIlqxxg==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8ef45a6d9dfso390377885a.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 May 2026 12:55:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/a762s3gjLkV/RkeBAoophvqfj2Hc4hWEN1MstyUVJV03rgIzPHlIT+jjspdmoeE0teg+Puq1GEY6w9Y4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzgxDQJakqUyHbts7724ICACuajEXZSgbGrtMA5WT1nfphQ3zc5
	lwspQJW52YHZ1UXStkfvwstDtKE2goBGhRuQwfwaLj5CiihVi+yt1Km7qqNEIC0tiMJHztaQGU1
	tMxg4HsRPqCY+tqlQsTaDXXw9V8fFQNU=
X-Received: by 2002:a05:620a:4706:b0:8ee:f390:8f85 with SMTP id
 af79cd13be357-8fd154fbfdemr1048725085a.3.1777838154653; Sun, 03 May 2026
 12:55:54 -0700 (PDT)
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
 <afTpoL3FklpQZNMM@casper.infradead.org> <yezmezj26xntushmylductlmytfgvwsnbnzlhffkfwugfxkt6m@gleq22spziyk>
In-Reply-To: <yezmezj26xntushmylductlmytfgvwsnbnzlhffkfwugfxkt6m@gleq22spziyk>
From: Barry Song <baohua@kernel.org>
Date: Mon, 4 May 2026 03:55:43 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4y8JtCxEy9hVxVd8eaf8D9WC8BcRQp9afUVu=FJA1-awA@mail.gmail.com>
X-Gm-Features: AVHnY4Ib9xDIPW1tJ1arRI_zR4ugsASIRuQ44tzF-c_n00UjvUcn8YpRrQawfp8
Message-ID: <CAGsJ_4y8JtCxEy9hVxVd8eaf8D9WC8BcRQp9afUVu=FJA1-awA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 2:17=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 01-05-26 18:57:52, Matthew Wilcox wrote:
> > On Sat, May 02, 2026 at 01:44:34AM +0800, Barry Song wrote:
> > > On Fri, May 1, 2026 at 10:57=E2=80=AFPM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > > >
> > > > On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> > > > > 1. There is no deterministic latency for I/O completion. It depen=
ds on
> > > > > both the hardware and the software stack (bio/request queues and =
the
> > > > > block scheduler). Sometimes the latency is short; at other times =
it can
> > > > > be quite long. In such cases, a high-priority thread performing o=
perations
> > > > > such as mprotect, unmap, prctl_set_vma, or madvise may be forced =
to wait
> > > > > for an unpredictable amount of time.
> > > >
> > > > But does that actually happen?  I find it hard to believe that thre=
ad A
> > > > unmaps a VMA while thread B is in the middle of taking a page fault=
 in
> > > > that same VMA.  mprotect() and madvise() are more likely to happen,=
 but
> > > > it still seems really unlikely to me.
> > >
> > > It doesn=E2=80=99t have to involve unmapping or applying mprotect to
> > > the entire VMA=E2=80=94just a portion of it is sufficient.
> >
> > Yes, but that still fails to answer "does this actually happen".  How m=
uch
> > performance is all this complexity in the page fault handler buying us?
> > If you don't answer this question, I'm just going to go in and rip it
> > all out.
>
> I fully agree with you we should verify whether the retry code still brin=
gs
> in real-world advantage today with VMA locks. After all the retry logic h=
as
> been introduced in 2010. That being said if there are realistic loads whe=
re
> one thread needs VMA write lock while another thread is faulting the VMA,
> then the latencies can be indeed extreme. For example things like cgroup =
IO
> throttling happen on the IO path and thus can throttle IO of a low-priori=
ty
> thread for a long time.

I=E2=80=99m quite sure that swap-in and VMA writes can occur
concurrently, and this is fairly common. For example,
Java GC may use mprotect or userfaultfd on a small
portion of a large Java heap while other portions are
still under do_swap_page().

If we start exploring different approaches for anon and
file, I agree I can revisit this on an Android phone if
there is a real, serious case where a file VMA can be
written and a page fault occurs at the same time.

Please note that, as an Android developer, I am particularly
cautious about priority inversion. A recent issue causing
severe priority inversion is zram attempting to support
preemption[1]. When a task performing compression or
decompression is migrated to another CPU and then preempted
by other tasks, high-priority tasks waiting on the mutex may
be significantly delayed, impacting user experience.

>
> BTW I'm not sure I quite understand Barry's priority inversion problem
> since I'd expect all threads of a task to generally be treated with the
> same priority...

Exactly not. Maybe these slides[2] and this project[3] can give
you a hint=E2=80=94they aim to standardize things on Linux by
learning from Apple OS. Basically, tasks are classified
into five types:

USER_INTERACTIVE: Requires immediate response.
USER_INITIATED: Tolerates a short delay, but must respond quickly still.
UTILITY: Tolerates long delays, but not prolonged ones.
BACKGROUND: Doesn=E2=80=99t mind prolonged delays.
DEFAULT: System default behavior.

[1] https://lore.kernel.org/linux-mm/20250303022425.285971-3-senozhatsky@ch=
romium.org/
[2] https://lpc.events/event/19/contributions/2089/attachments/1797/3877/Us=
erspace%20Assisted%20Scheduling%20via%20Sched%20QoS.pdf
[3] https://lore.kernel.org/lkml/20260415000910.2h5misvwc45bdumu@airbuntu/

Thanks
Barry

