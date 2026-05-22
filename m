Return-Path: <linuxppc-dev+bounces-21409-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08F9CD5BB4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 15:39:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMTwk2dP3z2xSN;
	Sat, 23 May 2026 01:39:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779464374;
	cv=none; b=TWrDGJQkGw7zlBCGWAXY8B0WqBJlKk7aJuAe45rn3+VEafZeV8oSOeonbXbmcTUAgQii+CFyKa3ZZi1755k0eOlsCTfAEL8fFH2LC5lpBpYrPMEJnzE0nyiSVU2hpXSrfLbTwVCiaRJhd4uHw9TPJ4VlmCRaa3qlUfcjAFUtT8jXvHIXWUZWL/w+dfAVAsGfr8O9GIAie+o6uGmJz9X+GnRD0KmWlUMCwKv/97peNaq92FJoQCdYpJqYd5lnPH7mSCgpBSs8GPpnUtG6ogGdyogM983IHdR3cYxVG3K0v9xMPngAjIvldKcxyolF90LGU4hE362zWfH1TmdFRYS+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779464374; c=relaxed/relaxed;
	bh=PhXZNDewQIU/RtpMf+wfAqV2sivH+vGmM2cktxerE4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEGxs45+hOm/w7db2UUKeAVk4Fm+fnXmgud2XHkJWlJPzhiYpwp4Ivl1gqfHb6/WPgfBLqQJkCwsZGW8HDYy/ufoTIOzLTDCWlmzepuAcFhzn5Z3wXFPGJPQY9uJ5yUaYHa6K7NPgUmZu9L9t6VGmiC9mQCSAUyrZJlfhlxvjLcxO5q3Uk3uSwDc+nl0Ld8AhHv4wEmUW52KHzQbBLcF2AEa7wYR4SZFscoIvrOuizr0ksEi55xQeqeG0odXSj93mmLecZ16M3q8zywKU64fzSNq+0/s9p7fKvIyYCE6RFVtSmbTeBVnDE5BqUQmhkotjpBqL1bYCB5hSxmlgvgcHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i257pqtM; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i257pqtM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMTwj3nsvz2xK4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 01:39:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C2F5C60172;
	Fri, 22 May 2026 15:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38B41F000E9;
	Fri, 22 May 2026 15:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464370;
	bh=PhXZNDewQIU/RtpMf+wfAqV2sivH+vGmM2cktxerE4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i257pqtM2kYPACyD1ngfUggI4iSRxqjUdYlFKKxzVufZViVIVT2xBOEl0SpU6DInE
	 ROGVAZb/3/W0IvbwFMxor6HFcVcNrG5Q21A1mRVWwKOQBsih1iPdGeTznGeoJB3DO+
	 Fn3PvCB8+2fNVtuS/MJbVyshSkcM02OLF0I9W6ZI0pMtT9j53IMpWiV0ZX8JC6M9P/
	 FaQjM533MNXthFgpwvWbAxK8bl8eUM9XMOgr6DAoXK73ugQpZzruTM8OshFacd6BC7
	 PNNlBh7PgBgxYyU+EgAcx28busgrsz6DinxYMoEk9F2NneTnICrdURcILPdeHr1TFa
	 GSUpZYp++RtDg==
Date: Fri, 22 May 2026 16:39:20 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Barry Song <baohua@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, kunwu.chan@gmail.com, 
	liyangouwen1@oppo.com, chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <ahB4fJkNVH2UIglX@lucifer>
References: <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer>
 <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <agxbq1TxJdniMQT3@lucifer>
 <CAJuCfpG2Zmpf5N_ejB6ZDv8LDjpVtTfA_tYQ6sW+Noc9Y+XhdA@mail.gmail.com>
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
In-Reply-To: <CAJuCfpG2Zmpf5N_ejB6ZDv8LDjpVtTfA_tYQ6sW+Noc9Y+XhdA@mail.gmail.com>

On Wed, May 20, 2026 at 05:51:23AM +0000, Suren Baghdasaryan wrote:
> On Tue, May 19, 2026 at 12:53 PM Lorenzo Stoakes <ljs@kernel.org> wrote:
> >
> > On Mon, May 18, 2026 at 12:56:59PM -0700, Suren Baghdasaryan wrote:
> >
> > > >
> > > > I think we either need to fix `fork()`, or keep the current
> > > > behavior of dropping the VMA lock before performing I/O.
> > >
> > > I see. So, this problem arises from the fact that we are changing the
> > > pagefaults requiring I/O operation to hold VMA lock...
> > > And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> > > is_cow_mapping(vma->vm_flags). So, we will be blocking page faults for
> > > anonymous and COW VMAs only while holding mmap_write_lock, preventing
> > > any VMA modification. On the surface, that looks ok to me but I might
> > > be missing some corner cases. If nobody sees any obvious issues, I
> > > think it's worth a try.
> >
> > Not sure if you noticed but I did raise concerns ;)
>
> Sorry, I didn't realize your first comment was a conceptual objection
> to this approach of allowing page faults to race with the fork.

Ah yeah it's understandable I think there's been so many threads in this
conversation that it's easy to get lost :)

>
>
> >
> > I wonder if you've confused the fault path and fork here, as I think Barry has
> > been a little unclear on that.
> >
> > What's being suggested in this thread is to fundamentally change fork behaviour
> > so it's different from the entire history of the kernel (or - presumably - at
> > least recent history :) and permit concurrent page faults to occur on a forking
> > process.
> >
> > I absolutely object to this for being pretty crazy. I mean I'm not sure we
> > really want to be simultaneously modifying page tables while invoking
> > copy_page_range()? No?
> >
> > OK you cover anon and MAP_PRIVATE file-backed but hang on there's
> > VM_COPY_ON_FORK too.. so PFN mapped, mixed map and (the accursed) UFFD W/P as
> > well as possibly-guard region containing VMAs now can have page tables raced.
>
> Ugh, yeah, I realize now this is a minefield. Resolving all possible
> races there would not be trivial and might introduce other performance
> issues.

Yeah, it's dangerous waters :)

>
> >
> > That's not to mention anything else that relies on serialisation here (this
> > would be changing how forking has been done in general) that we may or may not
> > know about.
> >
> > The risk level is high, for what amounts to a hack to work around the fault
> > issue.
> >
> > I suggest that if we have a problem with the fault path, let's look at the fault
> > path :)
> >
> > So yeah I'm very opposed to this unless I'm somehow horribly mistaken here or a
> > very convincing argument is made.
>
> So, current approach of dropping locks during I/O sounds like still
> the best solution.

Yeah _of those proposed_ I think importantly. This doesn't mean there aren't
other potential solutions.

Thanks, Lorenzo

>
> >
> >
> > >
> > >
> > >
> > >
> > > >
> > > > >
> > > > > I'd also like to get Suren's input, however.
> > > >
> > > > Yes. of course.
> > > >
> > > > >
> > > > > Thanks, Lorenzo
> > > >
> > > > Best Regards
> > > > Barry
> >
> > Cheers, Lorenzo

