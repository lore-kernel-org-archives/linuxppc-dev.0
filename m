Return-Path: <linuxppc-dev+bounces-21484-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5A7CD5BC9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 17:10:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPMp32VRGz2ySY;
	Tue, 26 May 2026 03:10:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779729019;
	cv=none; b=UOsKjWtMlhCNHkYdBfvdUjePi1RPSaKXafQm4QZ4d6D9Q/BaNQjetVfoaVL/suIL2zrMpWXvYfElIaB4VQaqIdC0H9jmftPSvZ6YzofA/55e6PwWVHoZZExgnNVtxC2Y+GNunwNSt3dL9flBODUAocn61P3oS72EygSKq8tn3gsfPOu6t67ExWh+XVOLfiGS4OKKX7rD2zwJcUx3UfRH1UqSxBXuNezCaKP7ijC5wFi899n5Otwd1pMIV/rXmuSpk+mkasBH7gZdlWcF4bLBjz5ruhUjpfa+pwzXz2tbFdEIKz41KB1XDH+x2DrKraL+y8cT43UNPFQmKX9aXZ7E3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779729019; c=relaxed/relaxed;
	bh=DZaQ+QowX0C8gRVWN1yv5DhtG5U/Mg2xarM9pU/7iWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/gN+1TaMb/QAEwehOdVO0SE7+t9P228zjNxOCvlSuMwrZF1fZ3RxHW5JW5CS5RSDHOM/43tpe1eRe5iIKSXt4g3EV/m+kMheLLn1izpTnF6iI8/1u6wCOSV7AEdmlnYINoZAZXqLGdiJglB4PqCksyIxcqYltT8ot+oaJRtRbAOgrwV4APLafIW2DX3WpsOZ7pBbzltxGH+qxa9pd13B7M0NS3qU/Uus02110fIq3KGczv8L45KNfaQI5WOAeTPje0Qets0NcXNmKvjnf+TCeKtRjM4hrAAWay7bPxNYaVFbJV1nWJlKrC6z0Osfl9sRvL/9J+LdWQgsi4BwVrqCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GiP9hJTq; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GiP9hJTq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPMp23F4jz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 03:10:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E17DE6008A;
	Mon, 25 May 2026 17:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7976B1F0155D;
	Mon, 25 May 2026 17:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779729015;
	bh=DZaQ+QowX0C8gRVWN1yv5DhtG5U/Mg2xarM9pU/7iWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GiP9hJTqjMH2adM0ONX5oIwwpXnd6BF9MvgXhQBNMAl7X3kWDwmw7Iv4kMmggikRq
	 nBqNPSvSUbp/u1YDnraMMzc2Sh/Osc6eLDC7h64gYmz4kaKH8XJE94fh8f49381r4d
	 Q9vZ1zpMEq+Yd7ouvXHGlcDwaPkoV2UNygDW0KvJlEyVzeugFcnImi0qdHpzm8aIFN
	 1y4FJMxWw2SATyOvoT8cyZECWGQ3kD2+Ni2EhmlAXPXtDxb/iVRRKnKXGA83g9QKzz
	 +NeD+E09qdCKYj2LiW6gvpZVcrQWEW/Ow77g1UcLED7dHYmEbkAwg3DtTbpvtvX5Ys
	 TeKiRmjRDug+w==
Date: Mon, 25 May 2026 19:10:05 +0200
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
Subject: Re: [PATCH v2 10/69] mm/mm_init: Remove set_pageblock_order() call
 from sparse_init()
Message-ID: <ahSCbVglzNQlsDMK@localhost.localdomain>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-11-songmuchun@bytedance.com>
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
In-Reply-To: <20260513130542.35604-11-songmuchun@bytedance.com>

On Wed, May 13, 2026 at 09:04:38PM +0800, Muchun Song wrote:
> free_area_init() already sets pageblock_order before sparse_init() runs
> for CONFIG_HUGETLB_PAGE_SIZE_VARIABLE, so sparse_init() does not need to
> call set_pageblock_order() again.
> 
> With that call removed, set_pageblock_order() is only used in mm/mm_init.c.
> Make it static.
> 
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

