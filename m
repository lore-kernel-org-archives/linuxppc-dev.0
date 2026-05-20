Return-Path: <linuxppc-dev+bounces-21239-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D787ACD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 12:56:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLBP91KrZz2xqv;
	Wed, 20 May 2026 22:56:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779281773;
	cv=none; b=EPW2HHOIXUqDglG7wz3C/6UCy2bJlELBjQmIjnRebMlarvU+4ye9HG2K3sP6K0HQ8/fGyxy0pBoXAntBDejYKXVkCYJF3U9AS0Q3SYV9Ons9t7uyVYvS6H9xaC92mAvOfcbYOywJUXf57COjCmVBp+A/qQfT8rq+/ccYjfTkcRFlrkJ3t4UWsClFK276XRyBi8JikU6s04MMhqgflsaTwiRq++rNmUUfJncO//OCB071targfgSMzQn/U0/7pVvK9K0dn+GJBlLh2SA67XbjtBtvrKJHsnIIMWnOtwQT4sDcemMLhU/bdgJh7gJ8+rnQj8OJuMFYK+tWXvzhzxGrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779281773; c=relaxed/relaxed;
	bh=IHcIhsCGtp+zFimfYJhlVXiifBlHPpWiDOsOVHQEJSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIFbaIYTP3mVkbXyQv51bNRKsIDfqSFYLfR6XQWEYRFfeu6eBklU1cWFNxMNpK/DcWNBoLrlg+K7s94O9OSAFly0HJ4B4pCD9sD3utctxn1Ymusmo3VJt0l0husnjslQWpzXba8Oh2ZFsV4QjuJoTidvhOsxF9w3iQ8IXY0ncMGPu9Jyp/OuQ9iGiAKZtVw/gmXnX7sdot52DziKAQYlzxvhCgS4Ro/ahd7L9tKL0gd2+vdmAWtz1g6cFidqpH9NUXqjdfXp3vAdxWgxZY0kDf51yG/WSWxfhDxFaD/znrU3XLbwFj4BmXomPRp7E/4g3yUfWS3CotX9R23B1oavsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=odw+ysF2; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=odw+ysF2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLBP76BDlz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 22:56:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C1BEF4184E;
	Wed, 20 May 2026 12:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195301F000E9;
	Wed, 20 May 2026 12:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779281768;
	bh=IHcIhsCGtp+zFimfYJhlVXiifBlHPpWiDOsOVHQEJSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=odw+ysF2fSGs0CYgREQtSvLkA7C1vnjLq+yTGH8uUyZQL5gIwy8l0sgOhMQFrvR/U
	 uhiwWUqoaRwvkgB0dpBHlc/BUJ1q5+UUOAqod11j8iXpTYoTcMdKWbeJzuR6xMAqQ+
	 OvTmgxH6iYYQP1hB8J7APtE6URdQBmktp1g/AVzlcWRxqXXJ8L/XVRnaqQo7zC7Xng
	 ETzTvLZhkt1SvKxjfJTjvTYcMABci75fb1o2/YPfIpAPbJkiRERe++WMYYQiw7kmc/
	 0b+T91xT73D5pkQltTZRR+EMWtVC4246AhUUcvutCmfPfiXeX8053NtPz89QYDfQc2
	 xRaHqWoL1+79g==
Date: Wed, 20 May 2026 13:55:58 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Barry Song <baohua@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Nanzhe Zhao <nzzhao@126.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <ag2vKm3K00wCiwUV@lucifer>
References: <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer>
 <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <agxbq1TxJdniMQT3@lucifer>
 <e6d1017a-e4c5-493e-bfca-932c6d64eaac@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6d1017a-e4c5-493e-bfca-932c6d64eaac@kernel.org>

On Wed, May 20, 2026 at 12:33:56PM +0200, David Hildenbrand (Arm) wrote:
> On 5/19/26 14:53, Lorenzo Stoakes wrote:
> > On Mon, May 18, 2026 at 12:56:59PM -0700, Suren Baghdasaryan wrote:
> >
> >>>
> >>> I think we either need to fix `fork()`, or keep the current
> >>> behavior of dropping the VMA lock before performing I/O.
> >>
> >> I see. So, this problem arises from the fact that we are changing the
> >> pagefaults requiring I/O operation to hold VMA lock...
> >> And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> >> is_cow_mapping(vma->vm_flags). So, we will be blocking page faults for
> >> anonymous and COW VMAs only while holding mmap_write_lock, preventing
> >> any VMA modification. On the surface, that looks ok to me but I might
> >> be missing some corner cases. If nobody sees any obvious issues, I
> >> think it's worth a try.
> >
> > Not sure if you noticed but I did raise concerns ;)
> >
> > I wonder if you've confused the fault path and fork here, as I think Barry has
> > been a little unclear on that.
> >
> > What's being suggested in this thread is to fundamentally change fork behaviour
> > so it's different from the entire history of the kernel (or - presumably - at
> > least recent history :)
> I don't want fork() to become different in that regard.
>
> There is already a slight difference with vs. without per-VMA locks, because
> there is a window in-between us taking the write mmap_lock and all the per-VMA
> locks. I raised that previously [1] and assumed that it is probably fine.
>
> I also raised in the past why I think we must not allow concurrent page faults,
> at least as soon as anonymous memory is involved [2].
>
> ... and I raised that this is pretty much slower by design right now: "Well, the
> design decision that CONFIG_PER_VMA_LOCK made for now to make page faults fast
> and to make blocking any page faults from happening to  be slower ..." [3]

Thanks for the background will read through! :)

But yeah I think the transition from !vma->anon_vma -> vma->anon_vma being a bit
slow is kinda ok most page faults will of course have anon_vma populated.

Be interesting with CoW context, because we won't need to mmap read lock there
at all :)

>
> [1] https://lore.kernel.org/all/970295ab-e85d-7af3-76e6-df53a5c52f8b@redhat.com/
> [2] https://lore.kernel.org/all/7e3f35cc-59b9-bf12-b8b1-4ed78223844a@redhat.com/
> [3] https://lore.kernel.org/all/2efa2c89-3765-721d-2c3c-00590054aa5b@redhat.com/
>
> --
> Cheers,
>
> David

Cheers, Lorenzo

