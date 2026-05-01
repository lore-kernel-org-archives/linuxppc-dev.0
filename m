Return-Path: <linuxppc-dev+bounces-20376-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34344CD3423
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 19:39:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6hFS5Bvfz2xfB;
	Sat, 02 May 2026 05:39:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777664380;
	cv=none; b=Qi1v295xDa8E8K60RiF0W+JB84y+nCU21GoVVSM/18lDSgpgFiT6btcdMf/nUHUldI2QXUTRsg3+jAK57i6umXqcoxw9W2JpxltOBL0x5exouv3YaFOOSD/tq/dlar0wz8usIs5U5INDCcfj/tVOa+oK8OxvBleufo7MWb5EiXkhEYE1j9fUpwpFE0MoIUKQCOQ/eaji42CGCB+pndDpwZ61gvt+UGLQcpk0LthrxftZJOBlwfaUcBAoIvy/O8LCnCgv37BQVrMiqzx2+3M4gOWnbF5X3NCwX2XFkqaap1X8Ch6s91M1V35sHbOabxtvytHNRJSoiNHe3zmNCIYtWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777664380; c=relaxed/relaxed;
	bh=rp8f/WeQia8QAD+YJmPABxXPXrvHyOM5hZfBchCKMDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ucc7iBDpzmXbSaQ0acMAOHtavKI+sRvHNsdPU7PfvNZb2May3pgjgI70YZJ3PLxMq9yweh2HDZjDeYqL16TgEqrmiE/0vYltX1V1kGOg2aBEd7Jil05XWZSwpEsb2BVIeRIDEDsPppO99IIo4rt07jStF/xNGSLtCU7OtGW9xTMtcjBZO5HX36TRxGYc5RaTtNjXA3KZhBi/4SRtGJiWsIkglp5dDln1985zjOqfA+qRryhCyeHloHtyD6qo5Nc7nl9cHipf/NjtcipCjxGaV1w2Zn9Ft6vG2mSnbLFjQNT2Gx2kTMVWUe8AE+wyh6lqciz56R4PfZ08n3+Q8KdmHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=uHjHrPPD; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=uHjHrPPD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6hFQ2dx1z2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 May 2026 05:39:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=rp8f/WeQia8QAD+YJmPABxXPXrvHyOM5hZfBchCKMDA=; b=uHjHrPPD2LeDk5mLziBh3YyqEj
	pfhR1tJpiKuUsooCkGqL2JZsb+D6vXBCRLBIbK0Q44xOCZOqwgtOj5wLR1q5KX9Q3NvcP0rciSd+G
	ckgC0Zlz14TMgm+JsN7ZyOCt1Uvx4cReuGP0X3rwHMIqy2VNYPteQIn4/oeQedWAMeFvYDZOK+5J9
	gMu8Q18KidiWTxvlLNVjdpduJUbW8ext7a3iuodZcXYJM4buozO5xWvugDSnEUtY1AeZRzE+j32qI
	9Rxm90eK24xcN0FvxD+xBCl3zDGmbqcxwWSaplpXlbRREhdZ7Fj4povFbiHlxELsrOySKt4514WFP
	5emRWH6A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIthf-00000009F6Q-0jSu;
	Fri, 01 May 2026 19:39:11 +0000
Date: Fri, 1 May 2026 20:39:10 +0100
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
Message-ID: <afUBXnPVnt7Jt5hh@casper.infradead.org>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4x8sNtgv7Y198Gh9NSY+SE2o_JPFAxG9aWE+xXsB9vwGg@mail.gmail.com>
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
In-Reply-To: <CAGsJ_4x8sNtgv7Y198Gh9NSY+SE2o_JPFAxG9aWE+xXsB9vwGg@mail.gmail.com>

On Sat, May 02, 2026 at 02:25:37AM +0800, Barry Song wrote:
> On Sat, May 2, 2026 at 1:58 AM Matthew Wilcox <willy@infradead.org> wrote:
> > Yes, but that still fails to answer "does this actually happen".  How much
> > performance is all this complexity in the page fault handler buying us?
> > If you don't answer this question, I'm just going to go in and rip it
> > all out.
> 
> I’m getting quite confused. In patch 4/5, you suggest a more
> restrictive condition using
> if (folio_test_uptodate(folio) && !folio_test_writeback(folio))
> rather than if (folio_test_uptodate(folio)), before we decide to skip
> retrying the page fault [1].
> That seems to suggest we should be more cautious about when we can skip
> retrying the page fault.
> 
> However, in the cover letter, you suggest removing all retry code entirely.
> Does this suggestion apply only to file-backed page faults?

I'm making sure that if Andrew decides to override me he at least sees
that there are other problems with this patchset beyond "I don't like
the additional complexity".

And maybe we decide to do the fallback for anon-mm but not file memory.
Or maybe it's just something somebody happens upon when reading the
mailing list (or more likely it's just grist for an AI).

