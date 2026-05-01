Return-Path: <linuxppc-dev+bounces-20373-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BDFCD3423
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 17:58:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6f0W0fGlz2xnZ;
	Sat, 02 May 2026 03:58:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777658298;
	cv=none; b=isFS68oKANq6BNxBVFTSnnGjgRNkPfPnJudAZzrCtzyeCKSl/TX61ToDvGyE0TRUudrR5qEr7mdxJli7Ny3MlWdfDJ9Vt3JhecEx10anNV8rVAIEUr88L2RpG4fjlNsOUPWwY2HWm3yukhksb//WaDs1x0wyZubazJUalU9vqHoUTq/iA9WfFHvkBzJdJK8lrf5f+pHVn7d2OEpzFxIJKQ53ytM4vmrVKG+u3vHuzDOSveLzPAE+wcHRf33SjfSpXkYh/eg76dN4vwLv6hchlq/8rNIc61qQtV8c4qCUx2boY+Eq+MIs2f2cCyvs3cuCToqcojfS11onKty/TLDm2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777658298; c=relaxed/relaxed;
	bh=u/+O11I2l5uEWQtHiF9iLIDtrtif7F+7W2x9HgtS2Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCUAbMijguwP8h1wFEf8j7GUAU7DP44Y7n56UvQz08eaxPAobhsNRupIm/3Mxx93qgi6puc92bL1S4ncPRVd5CIrZC36MlOqeb5QjHlMdohIl9v0Z2rMQxBKpr7lkQcgzOOPSr6EAmIZjLTzXLl8TH9tEw3ms0zjaa5TxvjIp676GGa75SRcVYXISDlDGPaWskpcsDlOdU4NFIf9qvZQ6s8EXP4cNl0wp2MgUBkc7Q6QYJefGZloQEVRqrsV8JOPj5uv67hN5kbLIROklsG2VFRKN2TNTp2n9ImeBK19fW0haagGL9RrV6eKMZF96Iogz4pVl0MdkD/m1oFBKS6uMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=cS0FYwD2; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=cS0FYwD2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6f0S5WtPz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 May 2026 03:58:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=u/+O11I2l5uEWQtHiF9iLIDtrtif7F+7W2x9HgtS2Zk=; b=cS0FYwD2XOEYVbuKnpFKh9ZiSM
	0EwDyUhzf4L/Z7u5RfwH9F/lLM1NhuqZPIwTkUmNl1PS4VMevXWN1PepuvnRy9E8BXEEBe1NqpbST
	JCuDyJciLjPMlOgK/msGkQ/Etm/ww5vna/xrv//xWjQSuG3YKtTWGFNZVR8+M3tsp34wr0aQKFWkJ
	uFsTeHHXdKUGothOh1mQqNx0qA+TQ+SY8myKKpSqt0cEDRnA3Sr7IVPyxsjySvvgY2FjAsXzlkA0p
	PsB/KjAACHCD+NoUMzQlqunyAml2flv3i9OPzaSZZMasw49lDXCUAuGtnBBvR4d+htLsXvVM7+CgM
	/hohbFOw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIs7c-000000098SG-2Rmh;
	Fri, 01 May 2026 17:57:52 +0000
Date: Fri, 1 May 2026 18:57:52 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, jack@suse.cz,
	pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn,
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com,
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com,
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <afTpoL3FklpQZNMM@casper.infradead.org>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
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
In-Reply-To: <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>

On Sat, May 02, 2026 at 01:44:34AM +0800, Barry Song wrote:
> On Fri, May 1, 2026 at 10:57 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> > > 1. There is no deterministic latency for I/O completion. It depends on
> > > both the hardware and the software stack (bio/request queues and the
> > > block scheduler). Sometimes the latency is short; at other times it can
> > > be quite long. In such cases, a high-priority thread performing operations
> > > such as mprotect, unmap, prctl_set_vma, or madvise may be forced to wait
> > > for an unpredictable amount of time.
> >
> > But does that actually happen?  I find it hard to believe that thread A
> > unmaps a VMA while thread B is in the middle of taking a page fault in
> > that same VMA.  mprotect() and madvise() are more likely to happen, but
> > it still seems really unlikely to me.
> 
> It doesn’t have to involve unmapping or applying mprotect to
> the entire VMA—just a portion of it is sufficient.

Yes, but that still fails to answer "does this actually happen".  How much
performance is all this complexity in the page fault handler buying us?
If you don't answer this question, I'm just going to go in and rip it
all out.

> BTW, the chain can propagate: a page fault occurs, B wants to write this
> VMA, and C (a higher-priority task) wants to write another VMA. D may need
> to iterate VMAs under mmap_lock, so B can end up blocking both C and D.

I know.

