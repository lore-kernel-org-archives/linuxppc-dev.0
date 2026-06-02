Return-Path: <linuxppc-dev+bounces-21913-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDD7CD6E60
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 15:42:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVFSb1yjpz2ysb;
	Wed, 03 Jun 2026 01:42:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780414927;
	cv=none; b=nT7LuvyByGL/NysdTrH6WeUK1UqQm4rd8MlzysNCxtJQGr8ZHHIIj+KrgplBcLKW9LKwrgy+3xQbfXKHA6CrQa1nb7Iov6KjwLG9j/c05ZXaMcxe/5MCZUxqbx80DToMyKZyVw3EUW2Sckvsq2tBbDVHB8XHt0GV77HasnvDG4h9c1Feiaq3zpJh4mJOdEfOrsts3ySKNNZn1YatpfV/hit57weVoP0aT2AMU5E7twogM16USP4/Rjrzy0WRq7QXJ1ChMRbfnC9lXi+xzcP2D756z7uXvFeemBg5ezWM0e6nrN59CRIsTErQH7HgRZMg1d3eLza90tC4CMATHOLo4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780414927; c=relaxed/relaxed;
	bh=e2iPxik+gt/K9tv+LiH1rAAW4SyqMQzYLDmc1qnwxLM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=VDed4+4Y69dySPElNdidDAV7TIy24m43tdWXdk1eO13ACaxmdrPLzrWum2k5RQOVSOQ1uRZQdeg+W3k4kFB7AS3nToYkq6mhPYmY8Z3JBKBh1eltm6cTq6Oev33Mfvr+1ZT6LWp437+AkRUI564E9hz+Xc9AEnN7haJ1ZA8NDcjYJKxcbv067rJu4GIsEqkB/TcoB4es5OdDs3sJYADujv4DJRMRumTyt+TV9M4i7eG4a8GRYbyHPdqb69pZjLIcOPRJbrbm6pI88Kc1T5l+sIpN+wZOIQfPlFUXjUNOZYyfh1Z1w4OuAoiOxKS9KAmO3RJRfo7tF2SEfGRF8BGhnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GgUThQiV; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GgUThQiV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVFSZ4Rqzz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 01:42:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9D890601E2;
	Tue,  2 Jun 2026 15:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B4A1F00893;
	Tue,  2 Jun 2026 15:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780414924;
	bh=e2iPxik+gt/K9tv+LiH1rAAW4SyqMQzYLDmc1qnwxLM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=GgUThQiVtXfAn3sygsENtWy2bNcoEtDTKqD+k+4/dxd/WiRCuyxnl9FNmv6OIJ77y
	 n61AQDGralQUr1hgbaUDNeTezd62bqW93pXWmQ4mzltanuxw6RYc043O9G1+XSuwmN
	 oCrz8Fexug5hS+AzzYrnxpGJnJ1qfUUfNAqTiYpkhNSFZPwWnpVw34d6YD/b9H/iTa
	 yCLC9pFCfN5EZo6/RN5il4tU0859XGgEkzcqcvQ7BEu1ZAYRKuWCBwGu7onNxF6Elj
	 GGY+l0vvny2VAZOCXjjRCGM6FR/syqL2X+I30lSXL7AGM3536mCck0Rt8jP6ITh1mP
	 hs3aSoD6zTLmw==
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
Subject: Re: [PATCH v3 19/19] mm/mm_init: Fold __init_page_from_nid() into
 __init_deferred_page()
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
In-Reply-To: <20260602101039.1867613-20-songmuchun@bytedance.com>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
 <20260602101039.1867613-20-songmuchun@bytedance.com>
Date: Tue, 02 Jun 2026 18:41:34 +0300
Message-Id: <178041489408.457517.2991925440539441241.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 02 Jun 2026 18:10:39 +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 41b83dd18c01..f1bbf3b9a321 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -771,10 +746,27 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
>  
>  static void __meminit __init_deferred_page(unsigned long pfn, int nid)
>  {
> +	pg_data_t *pgdat;
> +	int zid;
> +
>  	if (early_page_initialised(pfn, nid))
>  		return;
>  
> -	__init_page_from_nid(pfn, nid);
> +	pgdat = NODE_DATA(nid);

Nit: we can initialize pgdat at declaration line, other than that

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


