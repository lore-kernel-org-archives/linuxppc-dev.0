Return-Path: <linuxppc-dev+bounces-20370-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544E6CCFA13
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 16:11:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6bd667mjz2xGC;
	Sat, 02 May 2026 02:11:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777651882;
	cv=none; b=HAzcQTLqy9RlPPevOOACVHDDvc6zhaQC6XWGqGIcT5svLcYkPxa5BhS/spLaNPCGutQ6Y9hWt8blMf59TTzKY056LyMddItp02VYvlUNMpfhO5loOe54Yy9yKFf1Q/ZZUkqWlUcwba0ds+968PiS9uBsM7/m1qyuOt3A+uA3t7yGebmWKVU+0m7FOJX4pGwWgK8wQ7ZF7W4HwMG434A8wH3whLuqQu0EFczqrJYqG6tjRgh0QLir4irrrLfXeJGiGj0HWqjkW+I3i+5/So/249BLz76T67eETWaUp/0Tq1SQhoEUwwgKmwcz8yWS+jD5JU5yWAGsFfpidOzTO71QOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777651882; c=relaxed/relaxed;
	bh=+CybRlbN4CxbIfeNSZrydRrLn1TjflMMzYAXjMcpWY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GW/M3EQgnis0t80g71rl3C9WcjMkaplYkcwkPKfzONJ+M8weBC+w0SBFFDu0JyHqiswnUNrdPnWVsFdsxLwUSIo7bdmPNco663stFKNPrfylOFwFWPWlAjpi06ZHDlOMaXy2dCivvRAiyCZmmAwJLOXdO41NW4u+qBfOBomBu7YbmMUcEN+3hxuuot3T+olbYxsy9ZH7EIiz06hg2hCDWH+VFzGn6bMzHJg+oyVkSOwNnqAcSu2HB59YdLPpSv1tYdd9lcX7u0Hqw46AGo/xkSeS/d3sktvhU23lJt2/JIyM8MPCxKgCyi6f2ItNYX87LxhnJ/YYg9FpkPru9XNKAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=S+PrOaTu; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=S+PrOaTu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6bd56PnXz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 May 2026 02:11:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+CybRlbN4CxbIfeNSZrydRrLn1TjflMMzYAXjMcpWY4=; b=S+PrOaTuYpMS9yVFL/SRQq4G+T
	EDyv1/76Ou/0SIA3LL0ouPq9EWPMO5l4Z+1N0ptLnqAYO0BqCC4Xm3PO+wTeHKuBAB3IahTX8uA6n
	a7trLSaMY2QWSwvrG+FRQkKWQ18oVU4G7Xnue+id4br5moG5PbXCSji7QEubPHOv5XAVHxDx6zgXt
	wJ7FY6JrVfHfYKvW2+QN3fwPrQPGIgx3RMlpFCjGDCQcXCHPoN+y5K0Lw5lnU6sBd7VbJb/qhMWfh
	UTsBtEsZO5IdNigyrAUUvt2/YmNpV3JbBPOkDvUuz1JBSyohrXzO8wluq9Nh5ga/qGIKeRzyOIxxx
	5YZRXdig==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIqSF-000000091b3-3rae;
	Fri, 01 May 2026 16:11:03 +0000
Date: Fri, 1 May 2026 17:11:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Barry Song (Xiaomi)" <baohua@kernel.org>
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
Subject: Re: [PATCH v2 4/5] mm: Don't retry page fault if folio is uptodate
 during swap-in
Message-ID: <afTQl12XcXVnku9J@casper.infradead.org>
References: <20260430040427.4672-1-baohua@kernel.org>
 <20260430040427.4672-5-baohua@kernel.org>
 <afNMkqwxC00OT134@casper.infradead.org>
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
In-Reply-To: <afNMkqwxC00OT134@casper.infradead.org>

On Thu, Apr 30, 2026 at 01:35:30PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 30, 2026 at 12:04:26PM +0800, Barry Song (Xiaomi) wrote:
> > If we are waiting for long I/O to complete, it makes sense to
> > avoid holding locks for too long. However, if the folio is
> > uptodate, we are likely only waiting for a concurrent PTE
> > update to finish. Retrying the entire page fault seems
> > excessive.
> 
> I think the idea is good, but the implementation is misplaced.
> The check for folio_uptodate() should be inside folio_lock_or_retry()
> rather than tampering with FAULT_FLAG_ALLOW_RETRY in its caller.

Actually it needs to be a little more complex than this.  We
sometimes wait for writeback while holding the folio lock, and
that's a similar latency to reads (or with cheap NAND, maybe longer!)

So I think the test needs to be:

	if (folio_test_uptodate(folio) && !folio_test_writeback(folio))


