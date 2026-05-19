Return-Path: <linuxppc-dev+bounces-21197-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA92BCD4F54
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 22:02:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKpYf0n1wz2xK4;
	Wed, 20 May 2026 08:02:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779228134;
	cv=none; b=HlZB6cXPlsx9XHEr25HmZD+lvV3fAO3XaOinpDRRJaOESAdqaNKUYgcDltRRs2c3a117+ONNgJW8ZaRNydBMe0O0vd12T850s20YBun4e1QOZx7G44Img6WJ1w7c6MZSfN9Z54r/3Luq2eVNxcrqYq0VTZs1SrH/3R7OA1LDaOSeaPWsEAWGJ79F/yKSHpPEwLK6r7RZAepeVV6EOw8VkH0q7xFPacDCMYhfziMKEX3wZvPpxO9DKk6CgAvH17U3XLmJnlxeejYeafybkZRd+9Rczr2K1JG1ePHRFc0HAC4B1iBSa7n4+wtgCRQieh5Y5gGl3JruPZ6C9ezs/oEa3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779228134; c=relaxed/relaxed;
	bh=RrgSUFMhpGIkWoOChuhQyLYVDUdtSZljRgOJt705GjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d//Owys6U33v6AGM1h58Pf7xU9y1CwrAf6A+mRK04kQiKf7CGsdja22PF3J7c2lPkDtMIPQ9MrhVgbhVBTaMmRr+SxS3jzh7rjHHkbNwIAG/h1HcYYkjUOy4TMABo6Rqy+oguu3yaS5AQrKWUwsXzrV6z3Zv2K2woQhs/p7yC4yPRx8BvuGzXY/yMjYW+osp4yrVc4HePtFUTQWGzs0i0h7zt5O0mq4/rJIj4B2yYla/LZt1Vgwlq51yxCUYfajPww5D/05zg+50pBXzF38OoOAEYvwco2L87Wjz2JD715xL5RvdrYR/f5tSUliARZWt9Jvw3BVe+VPldNocIf4kEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEiINEmV; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEiINEmV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKpYc1z88z2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 08:02:12 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C020060252
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 22:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784D71F00898
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 22:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779228129;
	bh=RrgSUFMhpGIkWoOChuhQyLYVDUdtSZljRgOJt705GjA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EEiINEmV/ttnXkHREkmSNrg22w/pd85GQ24kGDom/qX0DitA92kwK7imrN1F7tfHP
	 /WClIpIcz37rNq9FOtLY4huZKlhKLtBg/gq5tOO1/IYaKENgHCq8w5+Lnv5OFXdXSL
	 2sIuISEhYHzkbmfjMHN6eKzTUmO8K/tDIrzQnMmRv3D90x14h5TzWDmjPA+zx7T0oZ
	 IE8SbeYeLv8dhtCTOAuISA3eqbujACiE+Q9q0u8nfuITSR5e6vuWcd5Iclq1d5zdAT
	 HF4oRjC7RA3KX6/I4zDoQ5jAmNSGhxJ1QKqkbIZT/JE9UU3XCdU3Y9b3mu/a4r3yR1
	 lk/+recZ8aGvQ==
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-651c366f7efso4343998d50.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 15:02:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+irXGopkboIwX/PxSi1zRzbN3neynzTe3AOnS8EIM5AwRVUOzhXoJPm6RqbWB981c8VOAMypmupaAB+Wg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyR3Zr9zZim10km6zssJnDNJnmQTd5lX4nEMZw8qgsyfJwuM4Jo
	w7getwRLC3EMqtY7J3kJKQzBh6X2VrnTe7XU6pjaq7GXFbKz5D3sMwJ04jq4WKTW1wdz8Bzeya2
	5eZ6XjoelnbZoFyuAiq4/6RJCMutXMpk=
X-Received: by 2002:a05:690c:38a:b0:7bd:9899:f904 with SMTP id
 00721157ae682-7c95c7ede6bmr245611007b3.39.1779228128311; Tue, 19 May 2026
 15:02:08 -0700 (PDT)
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
References: <afNM-gIqxpyJ6ro7@casper.infradead.org> <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org> <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org> <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer> <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <CAGsJ_4zgeE3ebEJ+j7GJFzWVoVYHeiOn4dOoOsmWCLA6s=oECQ@mail.gmail.com> <5zdaa5uv5oj27q3taopl3amops57ouxgyfsdveudz4ovmbdw7z@6lwrlyvmhcp2>
In-Reply-To: <5zdaa5uv5oj27q3taopl3amops57ouxgyfsdveudz4ovmbdw7z@6lwrlyvmhcp2>
From: Barry Song <baohua@kernel.org>
Date: Wed, 20 May 2026 06:01:56 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com>
X-Gm-Features: AVHnY4KXMvR35lLgRvdk-7E8dkEjtOPBxVO6EaEmgpy8kErjRkXyQizjBsuo3fM
Message-ID: <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: "Liam R. Howlett" <liam@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	david@kernel.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
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

On Tue, May 19, 2026 at 10:17=E2=80=AFPM Liam R. Howlett <liam@infradead.or=
g> wrote:
>
> On 26/05/19 05:14AM, Barry Song wrote:
> > On Tue, May 19, 2026 at 3:57=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Mon, May 18, 2026 at 4:26=E2=80=AFAM Barry Song <baohua@kernel.org=
> wrote:
> > > >
> > > > On Mon, May 18, 2026 at 5:47=E2=80=AFPM Lorenzo Stoakes <ljs@kernel=
.org> wrote:
> > > > >
> > > > > On Sun, May 17, 2026 at 04:45:15PM +0800, Barry Song wrote:
> > [...]
> > > >
> > > > I think we either need to fix `fork()`, or keep the current
> > > > behavior of dropping the VMA lock before performing I/O.
> > >
> > > I see. So, this problem arises from the fact that we are changing the
> > > pagefaults requiring I/O operation to hold VMA lock...
> > > And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> > > is_cow_mapping(vma->vm_flags). So, we will be blocking page faults fo=
r
> > > anonymous and COW VMAs only while holding mmap_write_lock, preventing
> > > any VMA modification. On the surface, that looks ok to me but I might
> > > be missing some corner cases. If nobody sees any obvious issues, I
> > > think it's worth a try.
>
> From Barry's description, I think what he is saying is that the vma
> locking has caused the mmap_lock to become unfair?  I think what is

For now, we do not have this problem. Before per-VMA
locks, we dropped mmap_lock before doing I/O in the
page-fault path and then retried the page fault. After
per-VMA locks, we dropped the VMA lock before doing I/O in
the page-fault path and then retried the page fault.

The problem only starts to exist if we decide to perform
I/O without releasing the VMA lock =E2=80=94 which is what Matthew
is suggesting, because it would allow us to rip out a large
amount of page-fault retry code.

> implied is that the per-vma locking may stall mmap_lock writes for
> longer than if the mmap_lock was taken in read mode?  Barry, is that
> correct?

Not the case =E2=80=94 the actual situation is (if we modify the
current kernel to perform I/O without releasing VMA read locks):

thread 1 PF: lock vma1 read ----  IO ----- ;
thread 2 PF: lock vma2 read ----- IO ----- ;
thread 3 PF:  lock vma3 read ---- IO ----- ;
thread 4 fork:  mmap_lock_write ---- lock vma1, vma2, vma3 write ;
thread 5 :  take mmap_lock for any read/write reason

Now you can see that thread 4 has to wait for the I/O of
VMA1, VMA2, and VMA3 to complete, and thread 5 then has to
wait for thread 4 to release mmap_lock. Both thread 4 and
thread 5 can become extremely slow, because I/O may be stuck
anywhere in the bio/request queue or filesystem GC.

So now we have two choices:

1. Change fork() to avoid taking the vma write lock for vma1/2/3 where poss=
ible;
2. Keep the current kernel behavior and drop the VMA lock before I/O:

thread 1 PF: lock vma1 read; drop vma1 read_lock ----  IO ----- retry PF
thread 2 PF: lock vma2 read; drop vma2 read_lock ----- IO ----- retry PF
thread 3 PF:  lock vma3 read; drop vma3 read_lock ---- IO ----- retry PF

Option 2 is what mainline is currently doing, and what this
patchset also follows. The only difference in this patchset is
that page faults are retried under the VMA read lock, rather
than under mmap_lock as in the current kernel, which is causing
mmap_lock contention.

>
> Since Android is doing something (according to Barry) that should not be
> done (according to Willy), both of these together are causing slow down?

The only thing that would cause slowdown is holding the VMA
lock while performing I/O in the page-fault path, which is not
happening today. It would only happen if we insist on doing I/O
under the VMA lock without changing fork().

>
> >
> > Thanks. Besides the creation of processes via fork(), I
> > am also beginning to worry about the death of processes.
> >
> > One thing that came to my mind this morning
> > is that when lowmemorykiller decides to kill an app, we
> > want the memory to be released as quickly as possible so
> > the new app or user scenario can get memory sooner.
> >
> > In that case, if the app being killed is performing I/O
> > while holding the VMA lock, the unmapping procedure
> > could end up being blocked as well.
> >
> > If we release the VMA lock as we currently do, we allow
> > process exit to proceed.
> >
> > I haven't thought it through very clearly yet, and I
> > may be wrong. I'd like to do more investigation. I hope
> > the apps being killed stay very still, but who knows=E2=80=94we
> > have so many applications in the market.
> >
> > Meanwhile, if you have any comments regarding the death
> > of processes, they would be very welcome.
>
> The oom killer only cleans out anon/not shared vmas [1].  So, what this
> would hold up would be the actual process exit path.  Although that
> would have resources associated with it, the amount of resources should
> be relatively low compared to the amount freed by the oom reaper, right?
>
> The other entry point that's mostly to do with android,
> process_mrelease() [2] will end up in the same  __oom_reap_task_mm()
> function.
>
> So, for the most part, the memory will be freed while the file backed
> vma completes IO and that sounds like the right thing to do anyways.

Thanks very much for your valuable input!
I=E2=80=99m going to run more experiments to dig deeper into this.

>
> Thanks,
> Liam
>
> [1]. https://elixir.bootlin.com/linux/v7.1-rc4/source/mm/oom_kill.c#L547
> [2]. https://elixir.bootlin.com/linux/v6.18.6/source/mm/oom_kill.c#L1210
>

Best Regards
Barry

