Return-Path: <linuxppc-dev+bounces-21216-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70694CD5BA4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 08:11:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL44k5dzmz2xqv;
	Wed, 20 May 2026 18:11:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779264694;
	cv=none; b=fZiC3LAt9n6t93CN41hRCPrYTdF3LpABFfrs1k6aOec0ZXrRN3CG9wx+KvmX2Rcouw1BTUrvLJqr7i2eFDqrawOTNqsiPTPph7KJbEWSEbdvri4FAd/L3eNkAdbXAkVwyLm3GsqbAJfqiWzEhqI/jSTLAAqEeL3QCV7k5DCCrnRDTO4NVItJedLSTF3OdmwQ+cafXvQmA75xk0WRJCqHSt95vIfvfrGqc/TfQ4WGoJH1M8IohurtrlZV9bS9tN47RtuiuMQh8C7nsQwr/8YhpjghUi7XOFZ7Bn5HgDX2dYVQmyNeT6u8ySROw6k8aDPf0QjqSPwnwimHP89+UC02NA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779264694; c=relaxed/relaxed;
	bh=CXxzzbCeNo3sDfk3dzWGFhN8IehnqsFdAWbxh92ducY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQ0vIh/oX4MzaGOQea226ygnOjsKc9k3iUq1+F/iY8TsUHIiidkxeElt7yH+VYGqTy+U64AIp2PIWk57x/mf8Blp9tutb58sd4/LDx6NT1LPiNSGyrDzKRXvwgo0VlfqrHVyh1mAMayVVXeejw4NG8dq+1UKP/9V6JLSFD5FU9k5Nxvddp3NfLi3Rz3csQrJesuxCd1044f3Oa0/gWz7tp8kev8v1K1O7+tZQxgo63va/ZQ3swkBMo3Xccm/nt3918NC71SJG4klAgTHHiUBqlmLZaobV+8xWvMv+bosjEonr68uCWrsYhgix1yosZuxitj66kthsiFG3MxYyBngUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnkpa3Fz; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnkpa3Fz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL44j6306z2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 18:11:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1089060129;
	Wed, 20 May 2026 08:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B3F1F000E9;
	Wed, 20 May 2026 08:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779264690;
	bh=CXxzzbCeNo3sDfk3dzWGFhN8IehnqsFdAWbxh92ducY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bnkpa3FzKkUUdWFG0smRQZfU40dk46M5NgdqdIyfXEPD1h20NL7bKr72VFJoHgNPK
	 Zpt0f97bM5yOlAFtMWk1oRJvIjsf1+ECrk3QzWUIz/BWNXDJW0ZYJ2FFouGZZmuMrM
	 Wo4p0Vkb6/RLl4doyo6ixLI4oE7LpahGy1KRkeyMwou5u+LN+Sw4rNKaJQ+5yI6oFf
	 vB2uTeyCpF+Vdg78uiOeOk2xvyBn7mhcgugFMKCdMzmjrO0Fwf6NwhxUTUhIuawNn+
	 NrJZl4Ke/LYbTbo3EkZd4QjkXwxp4OdeRjoSgwxJx/swz4bFwcKMo8A4KVWXBu3sjy
	 W937Gs5yLpfaw==
Date: Wed, 20 May 2026 09:11:20 +0100
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
Message-ID: <ag1qo0q_bfePgOzx@lucifer>
References: <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <CAHbLzkrOSoh-jmR=uaNvx73n_wn+vExoKY0UzH5zGcfdAiDbNg@mail.gmail.com>
 <agxfLNuLCAT3F4cW@lucifer>
 <agxnJ8R-G3CRjeTR@lucifer>
 <CAHbLzkpjOLrdRSUF3-G4d9uz6tn6QYwgB66UU9bud5WHr5FWEw@mail.gmail.com>
 <CAHbLzkrTF7w+T5mGsQuDRuhnTk6evTKBNRcH4oS=nRcUg2zpsg@mail.gmail.com>
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
In-Reply-To: <CAHbLzkrTF7w+T5mGsQuDRuhnTk6evTKBNRcH4oS=nRcUg2zpsg@mail.gmail.com>

On Tue, May 19, 2026 at 02:02:09PM -0700, Yang Shi wrote:
> On Tue, May 19, 2026 at 11:41 AM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > >
> > > > >
> > > > > Secondly, if vma->anon_vma is NULL, it basically means either no page
> > > > > fault happened or no cow happened, so there is no page table to copy,
> > > > > this is also what copy_page_range() does currently. So we can shrink
> > > > > the critical section to:
> > > >
> > > > Firstly, with no VMA write lock, !vma->anon_vma means a fault can race and
> > > > secondly copy_page_range() checks vma_needs_copy(), there are other cases - PFN
> > > > maps, mixed maps, UFFD W/P (ugh), guard regions.
> > > >
> > > > So yeah this isn't sufficient.
> > >
> > > However this is true...
> >
> > Yes, fault can race with fork. Basically this is actually the purpose
> > of this idea. We can have improved page fault scalability. In my
> > proposal (take write vma lock if vma->anon_vma is not NULL), the race
> > just happens on the VMAs which page fault has not happened on before.
>
> Sorry, this is incorrect. Page fault can't happen on those VMAs
> because page fault needs to create anon_vma, but it requires taking
> mmap_lock.
> If anon_vma is not NULL, vma write lock will serialize against page
> fault. So there should be no race with page fault. Removing vma write
> lock suggested by Barry may increase race.

Firstly, let's none of us be worried about making mistakes here, the anon_vma
stuff is confusing, and I've stared at it more than mostly, and even so I
managed to make mistakes (as corrected here) and forget details :))

It's a sign it all needs simplifying, but hey that's what my scalable CoW
project is (partly) about :)

Removing the VMA write lock would cause races with page fault which can result
in page tables being installed which are then not correctly duplicated for
ranges that must be.

And again I think the underlying thing here overall I think is:

1. Clearly many cases require serialisation (any that cause copy_page_range() to
   fire).

2. If we were to decide not to take a lock with concurrent page faults, that
   lays a trap for any future change that (reasonably) assumes that page tables
   cannot be simultaneously copied while being accessible to page fault
   handlers, which is bug prone.

3. As per 2, even if we were to only take the lock when we felt we absolutely
   needed to, we still cause risk through adding yet another 'you just have to
   know' risk to this part of mm.

4. The serialisation is quite likely relied upon by other things, this is often
   the case in mm, and we may only realise that such serialisation is critical
   at the point a subtle issue arises out of it.

5. Fork is one of the most sensitive, intuation-defying, complicated, and
   corner- case-problem-baiting areas of mm and I really oppose us changing
   fundamental behaviour here unless incredibly well justified.

On this basis, let's let the sleeping dogs lie and leave fork alone I think :)

I think I am far more inclined to take Barry's fault approach (as I've said to
him) vs. changing fork behaviour.

But I want to make sure there's not a 'third way' that could avoid either!

I am going to have a look through Barry's series in detail so we can have some
movement on this one way or another :)

>
> Thanks,
> Yang
>

Cheers, Lorenzo

