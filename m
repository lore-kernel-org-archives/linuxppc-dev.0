Return-Path: <linuxppc-dev+bounces-21909-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A65ECD6E57
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 15:41:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVFSF1lLVz3bp7;
	Wed, 03 Jun 2026 01:41:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780414909;
	cv=none; b=kMhS/2Lt1hedT6Q9GOSHiPtlBRegnrrDf61ST88PQu5o1iN6Uc0Dkbgyn0/Ji6TvGpX7EbYg/5NMv4G0hVm+offdQZEwBy4rNygzK64adI+YkA6x6ugMZG0m2QCgEyn3L9GCw8ECZJaNMEeU9EGT0UmLlHKQwRTYC3aYVHKTLu0duNCfL3na7MVVQPNSYx7Xq0eyrEBcHF4lbIxn1fMW9rI0D30BvJVDhUi+jfHqjHNZ98lDPi5MquPRkaPrEeyWDmUcCIj2+9TYu+wA+f1unjGoSBY/376d5QFT8M9GBprOAT5tVze/Ln7/NxKpkeTdV5xzIKv7pTkWT9ZGWEkI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780414909; c=relaxed/relaxed;
	bh=u6hjEXFIodlvX2INCmoabWYeGG2q40wKJYAYdqxhbNA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=TYlX/a6AOE8WNTGdqBd/oHA+/ddhV13lJHUlSRFaUpq+A9ktJUFnjIbayR+KLgRkrw5X40xYGW2BoDIqo+X7h1Sg3S6DY8ZxZkTEUtFQJl5IIR55dpkuoW5vfLo6TEOStxId+Rj6w6pdRik1DY8XQfDzdeXF1jt9ymK0qRanrL+1YHEhdTNuC8gHwcnRToCN+tsljayFgk0VTFUQUMxYiPiQq0v4aqL0sKn+kuh6orjHVyY9QekP8UaKyMOxT4qLxJiouXlaEPYTI0uzyG2roc/CnnQdlE8Utu3KracAd8blvzrAp62IsdnDFBBYHDgYVy3ZmzbhLpR/Vc1RgqdYWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUrX/DoB; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUrX/DoB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVFSD48cgz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 01:41:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 80E8440AE3;
	Tue,  2 Jun 2026 15:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667801F00898;
	Tue,  2 Jun 2026 15:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780414906;
	bh=u6hjEXFIodlvX2INCmoabWYeGG2q40wKJYAYdqxhbNA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=jUrX/DoBXHWclZVWAjvP+7tw19ddYYGmISVNtUcGMhSSciNu0hP/H0gsSUgwMVCSC
	 sye1q47DoDLLvQurDGUIXS7wwoz3YAHHPnKvg//QjAeqCyIPPgU9vUg9gQiXULfGEa
	 5AUzO9PrWIuaO0TTP3sPFHnbpyOtxwFYWzrr6EW9jdCu7EzsD5KwjgG0W0msDQxux1
	 7+/4XIJxatx2EXFdz50enwda8JbX/5MjhP02qWQA4ED2/8lTLhD4oAftbOp+eBn0QE
	 gVRNgLQpMTvVG9YrJA/v4eZdv7bdDFfDQBS+6AAcUnP/2eXLJ+YE5odpAPO6DyVE2K
	 yqhqhcg2mQhpg==
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 15/19] mm/hugetlb_vmemmap: Move bootmem HVO setup to
 early init
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
 linuxppc-dev@lists.ozlabs.org, Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20260602101039.1867613-16-songmuchun@bytedance.com>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
 <20260602101039.1867613-16-songmuchun@bytedance.com>
Date: Tue, 02 Jun 2026 18:41:33 +0300
Message-Id: <178041489396.457517.6730523256790632908.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 02 Jun 2026 18:10:35 +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index ea6af85bfec1..464578ee246e 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -745,6 +745,8 @@ static bool vmemmap_should_optimize_bootmem_page(struct huge_bootmem_page *m)
>  	return true;
>  }
>  
> +static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn);
> +

Can we please move the entire function rather than add a forward
declaration?

Other than that

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


