Return-Path: <linuxppc-dev+bounces-21482-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DEACD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 17:09:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPMmb3n4fz2xfB;
	Tue, 26 May 2026 03:09:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779728943;
	cv=none; b=Ve6OKWvp8i5sdtS06izt8BeiDONfpxw+rFgjoRZmE42Hyh4WxGdoVa1o6gIakICSOk7Wl+6FrN9xN5Om2V2/trJkz7IAcT8HQy2fVB38Xtq4T3WJtYP7RwmDzTHc1xEJX+3KqA/D/fj08lK6y+nMChbfWJX/V8ZwBK9AYkrgRbnkJY+gQk8wFfLHRk6QuJwgqdNHy0SZtbQtMoSj0/ePfr8hEB2EoOa/wQalDGINcLWfkM+8NTclz43ThYLRrzDPFw1K22VSu5ymUApKjYGTQlOLlNBipiSZknHs9eK/4EwMe/jyGwQYobVmK6DcHJaKtxaEQm42yf/KTOlLkyg/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779728943; c=relaxed/relaxed;
	bh=U1fgZMD3fJTNAghOf0xJr1uHYb54/6TV0xW4BVaYFe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3qRuMYcAIxH0FPt3e72QIANiomTUgCHDhMonSRNA66qia6vBJxHitnbBCh5f+0FF9wgc3DHZHXGOXm32AHOntDkqnFom3jpyFNJ9vnOLmhMFaWsqqonsyaYhwXsPgZOF+qCZSqfmfrCip/0kfCPJKeU1qXUts1O1TGGRZvKzgvJTWwxIWUT9MdIdtaY6jdMzjskRBmaJAFrYjQfgMlPxTJfLZoJzqKbl6FTV4z5PT4OpAl/1SRJBtnVi5LiSJ7hzMKQq0RuQ9Z6gWstNTrToMQo1u2j+QBNLtjN82k9J9nG6cX7vBekz8lLtzkH6c3OPZRKo8iI8GHKzV9embAhyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRjDshvC; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRjDshvC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPMmZ2mMtz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 03:09:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B378E6008A;
	Mon, 25 May 2026 17:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA601F000E9;
	Mon, 25 May 2026 17:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779728939;
	bh=U1fgZMD3fJTNAghOf0xJr1uHYb54/6TV0xW4BVaYFe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jRjDshvCJuJBUTSjrWSgZwa3oyAjxYMnp9jMj7Zk1PtO7XWQSD943spa1Ydul96c5
	 hRjV98B+z6Q6Bj4K2qggydXo6oBllxOj7Vin6BTULdDHy0vhrmJ+QM8MYOiV3FAwkP
	 2Kq9vVZettTcSTHxbEUFdqVWNZlr26oqdazIb4Lb+5hKCVARpb7Az7cs7QS0CB9Wh4
	 ZzwmR6Sf4hJbhZG8cHQ4gIwn7G9sFZq7ls97UbuQaYTdVz0AwA0SKNShBkU4M9YWrf
	 F6mlXaWr94EO3oiyW6NRJuuJCHqo6Ux3DmOO/qGTtewIAiX/UHy5xNULWMuOvkkAwa
	 k7i0K3OtcgvrQ==
Date: Mon, 25 May 2026 19:08:49 +0200
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
Subject: Re: [PATCH v2 09/69] mm/mm_init: Defer hugetlb reservation until
 after zone initialization
Message-ID: <ahSCITkk9FkNyszC@localhost.localdomain>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-10-songmuchun@bytedance.com>
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
In-Reply-To: <20260513130542.35604-10-songmuchun@bytedance.com>

On Wed, May 13, 2026 at 09:04:37PM +0800, Muchun Song wrote:
> hugetlb_cma_reserve() and hugetlb_bootmem_alloc() currently run before
> free_area_init(), so HugeTLB reservation happens before zone state is
> initialized.
> 
> Move the reservation step after free_area_init() so the relevant zone
> information is available before HugeTLB reserves memory. This is needed
> for later hugetlb changes that validate boot-time HugeTLB reservations
> against zone boundaries.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs

