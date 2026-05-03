Return-Path: <linuxppc-dev+bounces-20391-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4F7CD3424
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 May 2026 20:39:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g7xTY03jdz2xld;
	Mon, 04 May 2026 06:39:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777840768;
	cv=none; b=IK1drM3mB3tOD6WSkTCY2yflkVWNdEnA9YoT0hZhXfp2i5G+aXNIRlmy4318scSWXoCpz/2QmlbxzyhJcYim5MghSea0HS0zi1gRJLxSLOsmS+0NDrRGR5t3hDqp8My24l+VlwDJEjt07AlRB9XVNoW+XGrXKzWkQXpWG6+nzvWr6EOKR1mg4uQzA7W0oUDU7ikfSKkSiAEehKjfhz/6r3wSqGAYoXzkg3W4u9UoO4LrxBDyQwDqURsSLLcP57mbSnWBw5xaPqbc1EgADSVMe9nqjAUj47ZnuuDmH0nyZQLPOO526PVl3WkSVWJ3hxac4Mev1HoN17RS6URQIf9QTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777840768; c=relaxed/relaxed;
	bh=yy36aEN1ISq3rx8gbkVjtmwzFJPPiPu+6w78nwiNyyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjdL/926NqXW3ytWFbZlvg+gnbbW5tLm0KiA6TKIelgvW2yNTjxckNONEuIt4CdRmtKmZqlxntRsJhdnPzoS4duL50ZqqVdih5DnpXCK9rtRLm3W7NFunfqtbIfA6EvZ8I1RLGC6uKJSnkLCcafQnrXBuUOcN7SO/eROp62fjWOzFjEbsQhs6OdHBeQ4ks4EybyyVLgn6hAQVap56IoYXB4XiGr7R6yf2jA1WkvWiJrYQI0Yiuvo3rFRVs7Kxz1N7IAMIZHZl0HkiMqHiCpW4bLoCijAvRwFAbVAlfnmc4zi9npakoymZCOWs0BmzYjTk0IlhwmlXG3q1muCvjs4ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oQ4dUdb5; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oQ4dUdb5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g7xTW6Yz4z2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 May 2026 06:39:27 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 13E2444475
	for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 May 2026 20:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCCCC4AF0B
	for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 May 2026 20:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777840761;
	bh=OYTEHp7kfu60uKZpC7uNHUoEqcMaDbfVrENwGSgXkAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oQ4dUdb5atMjLxp1+0AQoh6FUEYpAUVniDRpLShr+tgiDJEUcO1b1w0o05Is6rA5e
	 pRFzBXnvnuTLiBO9M3mStfZmj5l2Phir3lVt8nCKUJ9m7GwyIlYqe2uUE/Y02LfVrm
	 OXG5kJ4RwS6QYH8yYF/2j+bhE3ruoMpxNmoR7wk5XFdZOMx3j08I5yywZW/QY0ITmb
	 0TvUcVyWVAXXQMJQ7404OC2maYfXJ4LXXcvP1b87ku9WVIfQN9ujMoudGa4tzmvuD8
	 gE1z7MR8oXxa5U1uOOgfQNng+9fpnnEzw/N2GvhkZ/P3qJXW2C2YRrCxSQular6VTi
	 8Oay8mWUM/23g==
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b62ca1d28eso19487186d6.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 May 2026 13:39:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+GqUF7BNU4xpmYLjxKLzBkZ1XoZThTY6v4TXn+QaNQIN3qgnWji6+/A3ZWNAwbl5T2/gb2XVoo31FpN5U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyIvDlL6nmtNlAKa8zz3DYbIb9E2uzXaGM0/QE2HYC965XmOSr6
	3fFESqT0EIQXZZ3qDcHEUhny13Jig3GK/xqM2DqnVFj54bEvC5b6OAbjOjaAJ79ew1Bvrh/pmyI
	7+R0j3wfVqBcgCx24hk7nAhFDmWuuWIc=
X-Received: by 2002:ad4:5be8:0:b0:8a7:16f8:442a with SMTP id
 6a1803df08f44-8b6691f4b71mr126409566d6.39.1777840759244; Sun, 03 May 2026
 13:39:19 -0700 (PDT)
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
 <afTpoL3FklpQZNMM@casper.infradead.org> <CAGsJ_4x8sNtgv7Y198Gh9NSY+SE2o_JPFAxG9aWE+xXsB9vwGg@mail.gmail.com>
 <afUBXnPVnt7Jt5hh@casper.infradead.org>
In-Reply-To: <afUBXnPVnt7Jt5hh@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Mon, 4 May 2026 04:39:08 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4z3MfP_sx1+qSr00dP5wshOuCAOcbT3RJ_He6Ddz_LnKA@mail.gmail.com>
X-Gm-Features: AVHnY4J-8SFfwvh8WWDAqxVa-cYngpmLlGJISHly6gCLbGvwUy-qMx6Jb2WhZWc
Message-ID: <CAGsJ_4z3MfP_sx1+qSr00dP5wshOuCAOcbT3RJ_He6Ddz_LnKA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 2, 2026 at 3:39=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Sat, May 02, 2026 at 02:25:37AM +0800, Barry Song wrote:
> > On Sat, May 2, 2026 at 1:58=E2=80=AFAM Matthew Wilcox <willy@infradead.=
org> wrote:
> > > Yes, but that still fails to answer "does this actually happen".  How=
 much
> > > performance is all this complexity in the page fault handler buying u=
s?
> > > If you don't answer this question, I'm just going to go in and rip it
> > > all out.

I guess the only way to answer this question is to
remove all retry code for file VMA and run a real test.
For defensive programming, I am generally very cautious
about this approach, but if this is the only way to clarify
whether we still need PF retry for file, I can give it a try
and run a complete test on Android phones after lsf/mm/bpf.

> >
> > I=E2=80=99m getting quite confused. In patch 4/5, you suggest a more
> > restrictive condition using
> > if (folio_test_uptodate(folio) && !folio_test_writeback(folio))
> > rather than if (folio_test_uptodate(folio)), before we decide to skip
> > retrying the page fault [1].
> > That seems to suggest we should be more cautious about when we can skip
> > retrying the page fault.
> >
> > However, in the cover letter, you suggest removing all retry code entir=
ely.
> > Does this suggestion apply only to file-backed page faults?
>
> I'm making sure that if Andrew decides to override me he at least sees

No, I don=E2=80=99t want Andrew to override you unless there is a real PI
issue for file, and only if you still still insist on =E2=80=9Cripping it o=
ut=E2=80=9D
after a thorough test with it removed.

> that there are other problems with this patchset beyond "I don't like
> the additional complexity".

The other issue you are pointing out is that, for anon, we
should be more cautious before deciding to skip PF retry,
which seems to be the opposite direction of what you expect
for file.

>
> And maybe we decide to do the fallback for anon-mm but not file memory.

I was targeting a unified approach for both file-backed
and anonymous memory. For example, if anon requires retry
under the per-VMA lock, we may already have the necessary
branch in place that file-backed cases can also leverage.
For anon cases, high-level language GCs can operate on a
small portion of a large heap requiring VMA writes, which
is fairly common, as I explained to Jan.

> Or maybe it's just something somebody happens upon when reading the
> mailing list (or more likely it's just grist for an AI).

Maybe one or two years from now. For now, at least, there are still
humans working on the kernel :-)

Best Regards
Barry

