Return-Path: <linuxppc-dev+bounces-21227-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9F1CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 10:07:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL6fX1Vpfz2xqv;
	Wed, 20 May 2026 20:07:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779271652;
	cv=none; b=QEGOnEjYXNkZ0kNlmw9LMKKwFjcFAHEfOZ9rUPlLyDKzNDyuusPqxSCj3r4QM2+64hE3vMkQnp2J5/kFNDEykvy/lV2Qrab0o8qhzwu3x2tgP3ngn4kP2l/Tl/WCjnvTmZfs3zMpjOvGbzD65wqAWC7Rym2U4yJv2ycv1yDm4Iuwk1tGavZW9b0wIrz2Zazax45IVELD6IY9ZNIBaJLOCTSKH8XylAks/P1nLldoxbZTcUPq/x2TOp1bJvH9DDiqmPkmdQ5Wz3vuvOLz8iUwH/EY8vyRJE3Z/5hm/r3nly9j4ROInMDHA7Xc9TLRUQWt0LXdaxH19eZg+mG+OIEzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779271652; c=relaxed/relaxed;
	bh=5uTpCdf27XDZ7rU8VT2nSx6sZs8Bwa/a+nJN9dsTFZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNVqOvv6+g2Y0IOwoMk4/CoX7+1AjDI8GXOkO8G9o/npkX9R2QRJQwEz5vRSQ1HYDjDPiKL2SeKFURIQMwQRuHz9TVWcwMzyHA7gFWxq0Rd++tdNtmjL4FJRKAtZ/3FbWiRvgwx7CiNT1wTh4Z87HFzmLgnZj9i5SbMVWqrqllPOSb+KtCYJIXZ83mS4f6qnToM/za409X80hqTgb7XaQNVAJM92HsDt9wLyNzxihVs0oz8Uasq5FQjwJAH+bRaRU1lLwS36143aTOojN12PsXPuf8MPMvPXOAk1UIXG0SUkFeyWt9vako+Eykgg071bNW5aB/OGfs78yZMfrn2sWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bX7QZvvd; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bX7QZvvd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL6fV6sX4z2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 20:07:30 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F3C3F400E9;
	Wed, 20 May 2026 10:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8006B1F000E9;
	Wed, 20 May 2026 10:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779271647;
	bh=5uTpCdf27XDZ7rU8VT2nSx6sZs8Bwa/a+nJN9dsTFZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bX7QZvvdTxa3YSpPgJR/CpVIiAr4LsFJHToqBiUpqQ7OjAJ3JKFYFh8HzISIXKnFl
	 1E+J/2n87sXxTBfiFUF8qRdzuKZRCrbEiW5rd6ddSTbKXsJZyMjM1T70x1mbw9v0iy
	 YXZDa7aQwxVF+CY8701SKVnLs7kwSt8WRsZCkxc6xexoxRufJyztW+awoUYKcSOR3V
	 ZphoL6Dwc5cIDbOia4oI1lg7iHirtApfH1lnEv5WUDqQL/WaQSKARD2Sz4E/mNZ0i/
	 CCS5/OgWZ5wmRKzFA5XnlGREVMcvJ2weIMSEG1wzLcm4yLFjdP3cRCAdnhnZwf44/+
	 wOJEQPBG/nIXg==
Date: Wed, 20 May 2026 11:07:18 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Barry Song <baohua@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Nanzhe Zhao <nzzhao@126.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <ag2GKrvRHzP4KhOl@lucifer>
References: <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer>
 <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <agxbq1TxJdniMQT3@lucifer>
 <CAGsJ_4zxyZP_xkFCGWfLyXkqomrX6DNqyMVirk=aggtwB1zExw@mail.gmail.com>
 <ag1mk2DSJsiORaxK@lucifer>
 <CAGsJ_4zN5ezh9vvvQDQdMF2KuuDGvkhNjTZWc0y0Lsa-P4Aahw@mail.gmail.com>
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
In-Reply-To: <CAGsJ_4zN5ezh9vvvQDQdMF2KuuDGvkhNjTZWc0y0Lsa-P4Aahw@mail.gmail.com>

On Wed, May 20, 2026 at 05:07:16PM +0800, Barry Song wrote:
> On Wed, May 20, 2026 at 3:50 PM Lorenzo Stoakes <ljs@kernel.org> wrote:
> >
> > On Wed, May 20, 2026 at 05:18:52AM +0800, Barry Song wrote:
> > > On Tue, May 19, 2026 at 8:53 PM Lorenzo Stoakes <ljs@kernel.org> wrote:
> > > >
> > > > On Mon, May 18, 2026 at 12:56:59PM -0700, Suren Baghdasaryan wrote:
> > > >
> > > > > >
> > > > > > I think we either need to fix `fork()`, or keep the current
> > > > > > behavior of dropping the VMA lock before performing I/O.
> > > > >
> > > > > I see. So, this problem arises from the fact that we are changing the
> > > > > pagefaults requiring I/O operation to hold VMA lock...
> > > > > And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> > > > > is_cow_mapping(vma->vm_flags). So, we will be blocking page faults for
> > > > > anonymous and COW VMAs only while holding mmap_write_lock, preventing
> > > > > any VMA modification. On the surface, that looks ok to me but I might
> > > > > be missing some corner cases. If nobody sees any obvious issues, I
> > > > > think it's worth a try.
> > > >
> > > > Not sure if you noticed but I did raise concerns ;)
> > > >
> > > > I wonder if you've confused the fault path and fork here, as I think Barry has
> > > > been a little unclear on that.
> > >
> > > I think I’ve been absolutely clear :-)
> >
> > On this point sure, I would argue less so around the fork stuff but I responded
> > on that specifically elsewhere so let's keep things moving :>)
> >
> > > We should either stick to the current behavior - drop
> > > the VMA lock before doing I/O, or change fork() so that it
> > > does not wait on vma_start_write().
> >
> > Again, as I said elsewhere, I think there might be a 3rd way possibly. It's a
> > big mistake to assume that there are only specific solutions to problems in the
> > kernel then to present a false dichotomy.
>
> I recalled that when we discussed this part in my slides:
>
> ‘For simplicity, rather than using a whitelist mechanism for
> per-VMA retry, we could use a blacklist instead: default to
> always retry via the VMA lock, and only allow mmap_lock-based
> page-fault retry for specific cases such as
> __vmf_anon_prepare().’

Yeah that's an itneresting approach actually, sorry if I missed that.

>
> Suren mentioned introducing a FALLBACK flag. With the
> FALLBACK flag, we would retry via mmap_lock; with the RETRY
> flag, we would retry via the VMA lock.

Yeah, and honestly I'm beginning to wonder if we don't just have to pay the
complexity tax anyway and eat the fact we have to deal with that.

But as per Josef's comment re: this whole mechanism, simply not waiting for
file-backed I think is another option (but I don't recall where we left that
conversation actually?)

Anyway I want to make sure any complexity we add is necessary so will take a
look through patches and have a think (and obviously others will have their own
opinions!)

>
> Not sure whether this could really be called a ‘third way,’
> but it seems more like a shift from a whitelist model to a
> blacklist model, without changing the fundamental design, but
> it does change where we would need to touch the source code.

Right yeah, good to have more options.

>
> >
> > We absolutely hear you on this being a problem and it WILL be addressed one way
> > or another.
>
> Thanks. This is a bit of light in what has felt like a fairly
> dark situation. I really appreciate your thoughtful and
> responsible approach.

Yes, sorry, I maybe was a bit too harsh in my tone here, I didn't really intend
to be negative as to addresisng the problem as a whole.

Moreso I've been concerned about the fork approach, and that is what's led to me
being shall we say 'emphatic' about it :)

But of course I sometimes make mistakes in quite how my tone comes across, so
apologies if it came across overly negatively - I am negative (on a technical
level) about the fork approach, but not the fact we should address this.

To be clear - I'm very glad you've brought this up, it's important, as much as
it's painful that we have this issue in the first place! :)

>
> >
> > Of the two approaches, as I said elsewhere, I prefer what you've done in this
> > series to anything touching fork.
> >
> > But give me time to look through the series please (I'd also suggest RFC'ing
> > when it's something kinda fundamental that might generate converastion, makes
> > life a bit easier on the review side :)
>
> Thanks! Sure, I’m happy to wait and there’s no urgency.
>
> Last year you made quite a significant contribution to the work
> when I tried to remove mmap_lock in madvise. I really
> appreciated it. Now we’re back to the same lock again, just in
> different places.

Yeah :) one day maybe we can get rid of it altogether (maybe I'm dreaming :)

>
> Best Regards
> Barry

Cheers, Lorenzo

