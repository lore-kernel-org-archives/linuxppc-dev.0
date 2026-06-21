Return-Path: <linuxppc-dev+bounces-22861-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC958CD98F0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Jun 2026 20:50:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gk3PD6SBTz2xQD;
	Mon, 22 Jun 2026 06:50:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782075008;
	cv=none; b=WcZvP505aCrVev2uXKTN1jivvvM2uQ8tytQR44c/WfcDakCdPnKcVzDynAThQT7BEBosAU6mIcTkhbYEVUuJHpgQS3sadTRQgcp2VDCBVG8LJFIqKyW9Y4HJdNEZhxn+EuMUi3bNaqbkI/d2xUVvd6ZWsWX5GUvKYFVBpMXhU7VETVK+YTOmLMCjdjesZqwvj5FRpK6eHHIPMT2r+AKK0UabZlOkj3zxgsLrJfY7wWJT+VmKjBLiveMbzgCj0aQU01IVZAkKmOJQJHDl5tL21vNSdharvfnQb4Or/JlzEtScHu4fZEsRLRGb0eewwmSp2ChA0IU800ic/BS0OjHHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782075008; c=relaxed/relaxed;
	bh=M8eA5erpVUaElEed48rJS2wGTR5+Yv1nLd38ESSS2Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h32hcKijF9Ij8hJ8KNl8gilWuMpYQRjWxI7z/T4aXWXmF/GL/1CRpKEoxcPToku7ST1zJ5xM5/a6ibAxU9Gj+x85sT8ylrGRTMmpUvF1iolHPph/+HAT43DO+0VcUPrT0St5afsP1Cwqrk922Tp2J/MU6JjDByYO2+oN8VJ54eomkWCzT0z5sBoIR9VgK3j6iL4xXL6eqiliS/Cz72UKf2wEJYYzp+qdOSS1cNgvcr6f0TjgCK7wwPQoZeRPV7bixGtoMUfI0vW45dK1LEYCVQgSko0F6gFqnKJSoy5xcS4GlFTBvhTaiKaRUCp87ZSowiONLNmdVhZ067Zp0DIqQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=g6iAM/3x; dkim-atps=neutral; spf=pass (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=g6iAM/3x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gk3P70blsz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2026 06:49:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M8eA5erpVUaElEed48rJS2wGTR5+Yv1nLd38ESSS2Rw=; b=g6iAM/3xDdWgV5X+yh4FkmLv62
	OiHp0rJWKrS0azBEgV4lUi6tf73QIx3b1EfxkJWLE9+0vYHZwchHgBudDH0pHDxxXgTjwrWdu/mct
	Pv33b+2kvV7VjO9v7r9ZJhg42qZrzl0nH7+5lsv84CGZePPxYtNzgtc+jHFw/OqqVr5gfB6dJeyht
	Ta+Y3SqdvDLqXkzUCijftXQvtQR1xKMpDX3P8Pi4bp33DePJ+q2Ae6ol72ij7EXyHBJ2UsHVBJ0x9
	+qUBkAxK1+zVPdKdmOAH0oG08P8SIzHjxBxu4r6NIyihQBFDoDV5qvDZCRzyYtm8IkqtseF10HUAj
	vqUbW0Ug==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbP6X-00000002ysn-1JeK;
	Sun, 21 Jun 2026 20:49:21 +0000
Date: Sun, 21 Jun 2026 21:49:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Barry Song <baohua@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>, akpm@linux-foundation.org,
	linux-mm@kvack.org, vbabka@kernel.org, rppt@kernel.org,
	mhocko@suse.com, jack@suse.cz, pfalcato@suse.de,
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com,
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	Nanzhe Zhao <nzzhao@126.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <ajhOUdbWsswgQyl2@casper.infradead.org>
References: <5zdaa5uv5oj27q3taopl3amops57ouxgyfsdveudz4ovmbdw7z@6lwrlyvmhcp2>
 <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com>
 <ag4h87CBd-gph9zX@casper.infradead.org>
 <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>
 <ag4kj84EcKqamdB-@casper.infradead.org>
 <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
 <CAGsJ_4xC5LdhuoWV1=tK-RZ5rkjc8aOKOkmb1L_8BG_3gtJhDg@mail.gmail.com>
 <ahB6QyHgYq8ksj65@lucifer>
 <CAGsJ_4zxLvZ01i19vdo0xA47T1hxa1VRYvxLmiDhy5q1GDKPRg@mail.gmail.com>
 <CAJuCfpHTxaU4KdNmefU7C7cWZSLCFDLPdUrnqV6yzxzN+8RQ0Q@mail.gmail.com>
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
In-Reply-To: <CAJuCfpHTxaU4KdNmefU7C7cWZSLCFDLPdUrnqV6yzxzN+8RQ0Q@mail.gmail.com>

On Sat, Jun 20, 2026 at 04:48:57PM -0700, Suren Baghdasaryan wrote:
> Just checking in on the followup plans. IIUC the RFC mentioned will
> try to implement the solution we discussed at LSFMM: splitting
> VM_FAULT_RETRY into two flags - one for retrying under per-VMA locks
> and another one to fallback to mmap_lock.

I continue to hate this idea.  I don't believe that those who were
pushing for it have ever tried to understand the whole fault path.
It's utterly byzantine.

I defy anyone to make sense of this:

        /*
         * NOTE! This will make us return with VM_FAULT_RETRY, but with
         * the fault lock still held. That's how FAULT_FLAG_RETRY_NOWAIT
         * is supposed to work. We have way too many special cases..
         */
        if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
                return 0;

        *fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
        if (vmf->flags & FAULT_FLAG_KILLABLE) {
                if (__folio_lock_killable(folio)) {
                        /*
                         * We didn't have the right flags to drop the
                         * fault lock, but all fault_handlers only check
                         * for fatal signals if we return VM_FAULT_RETRY,
                         * so we need to drop the fault lock here and
                         * return 0 if we don't have a fpin.
                         */
                        if (*fpin == NULL)
                                release_fault_lock(vmf);
                        return 0;
                }

Wed need to simplify the fault path, not add additional complexity.
Josef has said he wouldn't've done the lock dropping had we had per-VMA
locks.  We should rip it out.

