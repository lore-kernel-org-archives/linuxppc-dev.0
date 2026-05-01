Return-Path: <linuxppc-dev+bounces-20367-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17CBCD3423
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 14:57:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6Yzr4dGzz2y8d;
	Sat, 02 May 2026 00:57:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777647448;
	cv=none; b=SqCRhCMRCv3s29eAXYHsuu9Fh3yvNEjU13X2Jcfab4mcJtllup0agHx6dzalacsqDl/ej2/skVtGVTIaT1YORij7MzzRVFDIJr48LNIMgfBoW/EjkZmyHb6v0qZ5SWkFwdrLk84WTxej6d/GFetW1fNLIQkQoxB72mcxx0s0K6p3K9PRzvx9ZevJ5cePWb4J3RuDNpG7PaTWt+bsz6cLpCVrB1RQ3uE+oWLqHNhAZwWUk5FhIC0cIxcMtqEYuBNsqsby25cDtxrzK7118flh7S57XRSvvynwAthLXxipdO1cpCRp91eosB+QOKSIrLMRuSuncBNP8SXE27p2B6DVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777647448; c=relaxed/relaxed;
	bh=GWaEOZ6T8RZshC5VNeX+VR+c38seOstsZgFtVZK1Yb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNRn7PD7RdHdhGXDQIe2Fhe0gE5/Py7AjOGO7TorRluX2QA6a8PvVQrV4n780qClEz4somQuKCJJFW79SZfxwTi9nitXHjoPZmXP8fpU4yBwKtK2xubCFiLGYQ7LyAY9OjcVfDEgT7fOXiPiFO0Ysxg06hYgs7yIfB1avotU+0gV62zZEAa6FIxdEJnPTuDN90eL9zgFeDbwRtAKFMUzy/TAP/I0TpMkczRF5lft2r4KwCZWiOvkoKl4blvXjGKqoq9az8obTNW4BJFh5lxUPN/SO61MmQkw84HyuY9FzkDAPYb08nhVTIlIg9lJY8rbtdO2eqEaYSzrrAqjNz0uBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Er8GF8z4; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Er8GF8z4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6Yzj6ygFz2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 May 2026 00:57:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GWaEOZ6T8RZshC5VNeX+VR+c38seOstsZgFtVZK1Yb0=; b=Er8GF8z4i4fcdoqldcSz6UdIrK
	0uV2fMmb401OPsbWUDQlEgY0WImYvRoaOS/51Kt7cci4PwM0IwWZmDRUbGXw7O9IkTUTcXx4Dq2Om
	1ySnKP5ZPsmA0cdTKwQEUsbejJKOkDxp+xsnqOc9et7bCG9WzZFKFYNxcz4UjijcH9lNIaYGg9axV
	D8CvZuRnVnBvGs0WeFCpwaRxMrcj+ZmM+kVA2Q+aDmR35tDfpqtDlNjfzVDU0ieNT7dT3nkuFY8KO
	oBaeuIlQkfSbM8D3+gtqA/Kl4BULEQcG2OPtDBswRpN88NbjoIlZE7bl29JItAlrzNVWRNazfWERT
	lB1uWyaw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIpIN-00000008wbR-3iIK;
	Fri, 01 May 2026 14:56:48 +0000
Date: Fri, 1 May 2026 15:56:47 +0100
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
Message-ID: <afS_L-5XeWIldTXA@casper.infradead.org>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
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
In-Reply-To: <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>

On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> 1. There is no deterministic latency for I/O completion. It depends on
> both the hardware and the software stack (bio/request queues and the
> block scheduler). Sometimes the latency is short; at other times it can
> be quite long. In such cases, a high-priority thread performing operations
> such as mprotect, unmap, prctl_set_vma, or madvise may be forced to wait
> for an unpredictable amount of time.

But does that actually happen?  I find it hard to believe that thread A
unmaps a VMA while thread B is in the middle of taking a page fault in
that same VMA.  mprotect() and madvise() are more likely to happen, but
it still seems really unlikely to me.


