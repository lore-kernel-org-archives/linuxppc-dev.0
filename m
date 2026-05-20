Return-Path: <linuxppc-dev+bounces-21255-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0156CD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 21:16:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLPVD3JgKz2yLB;
	Thu, 21 May 2026 07:16:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779311780;
	cv=none; b=CkFW+ddiZuldJTFfo5h0Tqleu7xvn8BpNtjHnpKBfn4z/LAvpm7wY4CG7Ur0fwzxzDWBwXlploNa/tkn12JoCwwd1pdU32J+p+jPZ/NKvdw96T1jSvdeRtip00pRcC8vQGsyriygNEly0RzZylsWzu3hgpZSCBSZA8r/0IisZNi9I4DZchI+Mo+Zu7Ae8UHYUqbpzCwt8KZ275axsGCcxFbMxgnvqEZ3nVetmrahiWmpYvIkyoFyEuZWYvdlVeePZQ6znrJNwtM0EvSlyvlALH1dElZyDn4jcJyWc4XUGihln8/Pd+o3aBNg1Jh9mzV72/k6hea1rGIpmKb2reF5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779311780; c=relaxed/relaxed;
	bh=fU02cunUf5qx+CTJ998toCQden5I5L9eTw1htlE14B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX5xZIGfmoltc/07ZkbTo9VYAFh2bKpMRxO7T4YozbgCq2HRINYad1LikxRzQHIKXMwo7bn1FHeBaSjcb4O+fCp/DMCXaw8WRUDGhcAsdkOvztrZRx6u+POXC0eguCOTr0/1l5yS9x7WQnvBayFr86kw7PZ+rzVOlV1b05Si6GSJLqs1xHOsSlsblCA+Fb1yQ4zSLGKGXiH76FF3XH4NEUoUZRfnQxzQjvgDX0q/OcI59Euz03pGMCTTrolQGSWu0/Qa0+DRvHvgOHltx6+SYh02pVAKIkiPtRQm0A75+Ubji9obmhtSOMLJWyztHCQmA/OeOMrptMg8vBLVSf4VvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Ahb0j2Ei; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Ahb0j2Ei;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLPVC437wz2yL8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 07:16:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=fU02cunUf5qx+CTJ998toCQden5I5L9eTw1htlE14B4=; b=Ahb0j2Ei6nx5qSArSbx3QXwe7j
	nN0qnERaYLGpASZAP09LlU+EPQowKBvJPWhRsI00juo+im78mkgYHs+sP5ZWwXXBd7zRVmKWFHh91
	ozzCsrVpwBFURX4JqqoPT0iEmX8E9NvxsJFClE4jAwVlL4pGe782qw3PvR74tDYThCZ3q+fwmuY2k
	TzdU054pRFbgWK4qDrlWLvQekRsHk+y4KM+0uWUFsCECk4H+2CGnBJFwpoiJbHR/MvjI7M4kc/Ssx
	zg1lHxgjWogJBSyWKXMDALCFwuerNCe/Tci5nkDTpyDfHMo2R9PAJoJdp1sxjZy6+MelEhK4vLDAA
	A5g2JMmA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPoGl-00000007air-0tv9;
	Wed, 20 May 2026 21:15:59 +0000
Date: Wed, 20 May 2026 22:15:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <baohua@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>, akpm@linux-foundation.org,
	linux-mm@kvack.org, david@kernel.org, vbabka@kernel.org,
	rppt@kernel.org, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de,
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
Message-ID: <ag4kj84EcKqamdB-@casper.infradead.org>
References: <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer>
 <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <CAGsJ_4zgeE3ebEJ+j7GJFzWVoVYHeiOn4dOoOsmWCLA6s=oECQ@mail.gmail.com>
 <5zdaa5uv5oj27q3taopl3amops57ouxgyfsdveudz4ovmbdw7z@6lwrlyvmhcp2>
 <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com>
 <ag4h87CBd-gph9zX@casper.infradead.org>
 <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>
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
In-Reply-To: <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>

On Thu, May 21, 2026 at 05:14:20AM +0800, Barry Song wrote:
> My understanding is that we should not blame applications here. This is 2026:
> there are basically only two kinds of applications — single-threaded and
> multi-threaded — and single-threaded applications are nearly extinct.

all of the applications i run are either single threaded or don't fork.
what multithreaded applications call fork?

