Return-Path: <linuxppc-dev+bounces-21487-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8EBCD5BC9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 17:21:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPN3S07rNz2xfB;
	Tue, 26 May 2026 03:21:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779729715;
	cv=none; b=farQE11bRH8NWj5GHuIEw3fTz7hV8p01lUEm5LJKWxViCVRPqlfxpRCdSYLRkqqPD6e74CAWeJFUM9fKZGH9uSmn1yzPYzqkWciLzvX7Sitq0GVug8PC4CG7UOonTfa0u53JVADLsf+MwpwHyHQCj02SUrrOSgha307jo4hXOFXBp3uJsK4HpBO2Jw/+HUue0LELzLZYlkAr1OU2p/ZYKAP3wmNDqGu4O1aHst3NxPf3sALSBRXbungcm6esG9XJl2b53HQ9iE0v5zHgpkB3LLkSpz/8yw8Cz/tc3YGvsl/gWCLGMnYlwewBUXPz/CGWeGoMW0Lv9SJdQr4wRJaY4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779729715; c=relaxed/relaxed;
	bh=Ns+vixeNuP37BFGrljacUY/E2Axl/BTJ39BV75ZKyzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GF4LnJ7gvAQxnVQDrsCSB/oM5timzU3mKI4nu0QD5I43IajpkGionuV4JUIa6LqE0XAjSSKXlVZnminZodPdo+gqUdBRLYfA8DHIrkGeCaGNPxXpSOvAJ89v99pfHJGWMjjQvxbQgkw+9tLacxld0fXKVf0U5OyTODrktdT99U2XqrMxlYzfXcpyWWH9cNI3wKzQYOlFGEPI0tq+KI7gOosu0YUO/MaTf0SY0GlYEvUhP8ibNXPMQW8JekLAsvNnVCoSyumXfC4koDWkaWnVlsQj23a+FRSIJOlZbe3BdrGCgMoVLlApYoeMvNMGfEMQ1DUxYMLUv/qtGrr8VXCBVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G23nJ4o+; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G23nJ4o+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPN3R2yRxz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 03:21:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3FE896008A;
	Mon, 25 May 2026 17:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178DA1F000E9;
	Mon, 25 May 2026 17:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779729713;
	bh=Ns+vixeNuP37BFGrljacUY/E2Axl/BTJ39BV75ZKyzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G23nJ4o+2EDnvWDsMORaOOW4c+DbVz4GQFo63SKudkw36GZc409Y/KHX9j9sdpy1X
	 dtYIfPGIXKXzYsbdLoVyS1FSy6fc5MtMqEsmtKaYm7ES6N0MlgA1/b/T9FczvPqXgK
	 po0e00lCrGIDwP9ffxrC5auvv+hWIJ7e43jdfSwoZWBTRX6UYDG6HHL+v8ZHl0CnEg
	 A5AlUJZ2rmuV1hlKn50tXvZD/te5/GqwEJxM9LvUTGbFanLfC18GUYMXdpsAhDZOKC
	 9JMXC4yCAkbly3wYc+PWjltnBdtSzNJGDvDObXep3a2gg+KR4gfgFmGKlpYYqs964n
	 jxzaijAYQGGRw==
Date: Mon, 25 May 2026 19:21:45 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/69] mm/hugetlb: Refactor early boot gigantic
 hugepage allocation
Message-ID: <ahSFKSTBEMs3bO8T@localhost.localdomain>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-14-songmuchun@bytedance.com>
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
In-Reply-To: <20260513130542.35604-14-songmuchun@bytedance.com>

On Wed, May 13, 2026 at 09:04:41PM +0800, Muchun Song wrote:
> The early boot gigantic hugepage allocation helpers currently mix
> allocation with huge_bootmem_page setup, and leave part of the
> initialization flow in architecture code.
> 
> Refactor the interface to return the allocated huge page pointer and
> move the huge_bootmem_page setup into the generic hugetlb code. This
> makes the architecture-specific paths focus only on finding memory,
> while the common code handles node placement and early page metadata
> setup in one place.
> 
> This also lets powerpc benefit from memblock_reserved_mark_noinit(),
> which it did not enable before.
> 
> In addition, upcoming cross-zone validation for boot-time gigantic
> hugetlb reservation is common logic. With this refactoring, that logic
> can stay in the generic code instead of being duplicated in
> architecture-specific paths.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Same comment as Mike:

Reviewed-by: Oscar Salvador (SUSE) <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

