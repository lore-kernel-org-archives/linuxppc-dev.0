Return-Path: <linuxppc-dev+bounces-20369-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA822CCFA13
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 16:06:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6bWc2RRhz2xGC;
	Sat, 02 May 2026 02:06:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777651596;
	cv=none; b=KNYyF+JNmVEE2R6B1dHvee+spbiutzMdGzakkYzyUXgePsKo/BiUPt+8G7l8EU8wENC5BRJLORI6n2OrZH5AYUDRKtdIHViLERGeE2g0sCa2C2yOqXWOnTvf0bHQ5yvxdaTrgSBQggcn6KgdBNjXmQX2EY/YB5W2dSPzW3ouseAK3dqhYSg83R+AvAxx+jq6+4ICwo1OP7fzmelbR0ZrcQuO6XbQdcOdaUut5mqkHBZaxiLO7XvFagd0aJ7JtgRU/5qUNZqa3r7jX+vsU/Gc2XlDj8s5YHwCK64iequduS75gdF7Kw2vGT7IGQpio0pVtHTDXZGogT2TQiyYDsCBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777651596; c=relaxed/relaxed;
	bh=HCOnYxAIgiWvR0Bg9Z3oQP7NtLB+AbBygf9mhxuV9oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dk4DTI35Lx6SuEr6kQID4r2SyxZjONz1FGvNNnpszR4HyCLUoVOTVdW85bd7a/rx+Ia5S3/4wwQ53NaExyXy9Yu3c2zJUSdq8aK6hocAdH7L9piW6V+nCxrk6fcKc6yw7ytO7/I5N42J3ofaz/MkrbIx3YBD4ctP3UfiG02L65CLymzWWT8iq6eSVtppnkEGxYrW/t/ZqUr8KC0/1B02z8CFljdPUTizbP+/vg6NnFqPyJHoB7ydMWHO0kmTr3hk2YQrJjbTQIohDVzhK4zAgdisiSHfEDBiPiDrCVbwfUmw6di8RddRv40NRnf9JkydYYdg0STxsPjkW84u0dWKjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=WFSklIdw; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=WFSklIdw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6bWZ1423z2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 May 2026 02:06:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HCOnYxAIgiWvR0Bg9Z3oQP7NtLB+AbBygf9mhxuV9oQ=; b=WFSklIdwMHQLNKo0hSt8FUEdor
	8PWAceSimwETsGI72z85Zv4wA/tsNlycLa8f6sQG/Aw6w8RnhXi0Af5mjum18LwybDyAvb1+Uxh9f
	Eq5T7ug+O10pWFjftTfOmniisY01PyMq7+2peSvdamJ+AAvHZRIQTazUoIUXsplGALDIdW/42jR8p
	U9uUO/7PltvaGp/EEhx55GmxP2PijjP4N8jL7/SdhnE0m0apJTc1yrnAE6WrXuehMZUnK54FJ0YvF
	M5qMff6H54NLzO+TN+U51R/JiQDmY0k5rW4FXREurwavyb9AebilT1ieN2HbK2yQvGHgLvA2FHU0e
	rgYRe6xw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIqNP-000000091GR-0gTr;
	Fri, 01 May 2026 16:06:03 +0000
Date: Fri, 1 May 2026 17:06:02 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Barry Song (Xiaomi)" <baohua@kernel.org>, akpm@linux-foundation.org,
	linux-mm@kvack.org, david@kernel.org, liam@infradead.org,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, jack@suse.cz, pfalcato@suse.de,
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com,
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <afTPamwDbtY_tgk_@casper.infradead.org>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <afTKsSj0i-ZkRZN5@lucifer>
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
In-Reply-To: <afTKsSj0i-ZkRZN5@lucifer>

On Fri, May 01, 2026 at 04:52:12PM +0100, Lorenzo Stoakes wrote:
> After a brief eyeball I share Matthew's assessment, I really don't like this
> series, it's piling on complexity for what seem like niche cases.

I don't think they're niche cases ... I think it's a real problem.
While our current code performs better for this workload than the
pre-vma-lock code did, it doesn't perform as well as it could.

> We already have enough weirdness in fault code honestly.
> 
> Let's maybe discuss at LSF if you're attending?

Not only is he attending, there's a topic scheduled (currently 10:30 on
Wednesday).

