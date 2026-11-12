Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1108606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dFL0oFGj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQKLS2tFNz308H;
	Thu, 12 Nov 2026 23:23:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794486224;
	cv=none; b=fGflQvN0+cbJ28ejk98KQEw0/FDUMNj1tAMF4yiFBlTDPc0jSXqusuUo4Pf5mC8iTaCgVsr+BzWKMgR6lqIPXtpRVZJEiCjGuiqF9t6gDijtWD39hWoO99T9UcRNaBYtWAQNpx9Ne8J59HYADtZbE4pN8pnSAvXILNhfHEZ+2CeONeE1Gq0Ozpg+eN6bBBs1zcDLDyrAgCZy5dZPQAP6WeO8V9YvfzRe/w3tVwrzF6XVOKkYz5XlLjVDn7j6OyNHiHcTGkWbRA7r8SBr8T+G+Ylj0oEDFLpJatxacgcW69RwFdnNfkVQEBD18qWpqv+nqWo9S1gAdK80NFLMAy6xNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794486224; c=relaxed/relaxed;
	bh=My+EyMv7kUK9PriD5W/MVAD9Fcc5R9RWddctNSFBcso=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6cje8uzzY2zfxTX+bfEdZVJUVQraw6mKuf0SIOVLLU706YOl3zxyPfzdyXVay7760pYkc0CnPNXLcmjsWsheYGoM6xHqpWlyvTOffIWm2j6fFAuzXdCFhsXr5vLSX4tDh1NUvSeh+mpvEuMNYDmLneg4gaXwtXeh4d4wFXzMt8+fQ+Gnqm9cpUwJ+PTiW1Dfi4FJV7WCV19Q8O26TuhmWzgD6jDUjVqmS4keapkewZUIIkJ9LDq5i/Pmtshnui/di/W5dEKhjtXlY1xDDAKm7lCFGtao3NdczMcpJW0X8jZuc+6Pp8anlpgJlkX03uPiCl9lXHaWtAy1sOy5YTivQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dFL0oFGj; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dFL0oFGj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQKLR2cmJz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 23:23:43 +1100 (AEDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-6b56c428212so5495873a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 04:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794486220; x=1795091020; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=My+EyMv7kUK9PriD5W/MVAD9Fcc5R9RWddctNSFBcso=;
        b=dFL0oFGjwDwyCKL6Fdi/bWa/b9OShzKTEz4BT4cTP7+24kzlQCC8XLhmATHEyPXzb/
         orOL3IWuUViVK5qgdcvW9U+HqtiQFogTZocT4oFotO3pcVg7yso2zysqq5b2XlVqhmUc
         tbqkD1kv6XPQpWtBfhkbVMceDVrg4iK1xgL4C934Ce3AzCdmSZpr0g9BF/RBFq/+a7yB
         /xYavY9Cf4vQAWvq5xOYyqtMtWWAH1aUbLMUM7ZDZhaxpHgBB+S6MHADLVqTbIkj0zGl
         0SHAOB+k2lP718P+NnpF/ZqadwPpWuUVWKoiLR9/HeEZdEUaWdWDgH0stIFVknd8+gCm
         HrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794486220; x=1795091020;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=My+EyMv7kUK9PriD5W/MVAD9Fcc5R9RWddctNSFBcso=;
        b=aGFNJP9fHxJ7Rg49cVvHdkTWdy4v5Y2GFUdzNWF0Y3qRsEpualyFBaAUZiMfsCwGv9
         EIZeOKWScTMXCqzZ/cTYxzXD/UHbzPJALfF27Z1A3ziXEv0e3w0e+w5omEdL6M6XuXrn
         mN/51o4gbKA9/+DzbHXkmnGz3xWfRhdV6qAe8D/VJyYi9LrQAGJ88tLmnFsrCankQdLM
         qWQNCm8LxKC9NQZtRG7rERqPnPRB6mn7eifLEZCDZ40uCy4GTgGZlQFt5uiYRKfbiHy3
         jr73c4QAzxGqAOhUyg7B1REbIqTmVYbq2gx6L6Dj3yHNpg2dbz7QGyX6WpbkjzXpjj0z
         iv+g==
X-Forwarded-Encrypted: i=1; AL+hErGI8dYnSfsS0eic0b45oRrip1VSjjXo74Ph7U9yri1Lk7M8Sn6InaNalBUVSfc5u+MYWnwef9SHiaHPP64=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z84wbkcdzgjF1WCm1ZJrZf3cim3qxUdYdRmOotezoGfT0QfsQld
	kRTZY4HBM3FrfHh+PgYTFsNK5TL4NHhC1iUXSIJ1FmHDsLuL7MY3vv/r
X-Gm-Gg: AYBFou3HBOLzAJWbLpJQVPl0nYf5o2/GW6SoX9lAf+WDJa1e5b+dWPsvuzFMnBDkcyk
	+xVRU6qcgN0lk2oyT0jPqDls5kCbbXNvRM3ElWIiEKwun2yzvFO0w6pbq+VWd2t5Uo0BvkwYb/R
	q0Z5Ga/GaxoHKiJ9wrynXq6iay5z8vc+Zw/8qwWm8gOTqIeFxQpu2s3vfL3qb5U6jl2seW2A53x
	wNGAEnKlwozF2uDOLrC23/DStk8mdt7x5jM7eN2PCOeeSWp+mwxwEyzxnSMaPT2s4M3ZDoK7OaX
	a892FycrP+qGZvzHmPWAxKibo1K2Yycxy0SrTE022+LiAMjE1Ul5WTAZ6K88BPnDRnoY9lIuHsM
	S7qFG/1itZzlIKhhOmVZtWyvJXAer45Zzj9IumeCr43H5Hz1QaUx2mI1nX+/U02Zxa1dX97WyNo
	lYHhKxkEZ3nnLJYB5845XaWAzzzTRjaGxz2Bnq4hlYRI24w9KVdGMlsp6v2FOfCphTPaXrGr9Yg
	LjODeKgvJ7At2BQB2VzXZCjLQ9XSkwd2iydDLsnbaRG9KYayv+Z8EryqYhDqgOClNDQOA==
X-Received: by 2002:a05:6402:2108:b0:6b1:e8e1:a3cd with SMTP id 4fb4d7f45d1cf-6b777828d1dmr4207046a12.35.1794486219647;
        Thu, 12 Nov 2026 04:23:39 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7578eb0b1sm3345874a12.22.2026.11.12.04.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:23:39 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 12 Nov 2026 13:23:36 +0100
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 3/9] mm/vmalloc: BUG_ON() on an unaligned range in
 vmap_range_noflush()
Message-ID: <avWvyNo5qHbuk9hA@milan>
References: <20261110112546.261415-1-hao.ge@linux.dev>
 <20261110112546.261415-4-hao.ge@linux.dev>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110112546.261415-4-hao.ge@linux.dev>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 07:25:40PM +0800, Hao Ge wrote:
> commit a739e6b557af ("mm: vmalloc: WARN_ON if mapping size is not
> PAGE_SIZE aligned") put the check in vmap_pte_range(), which is too
> late, because the upper levels may already have installed page
> tables for a range that is rejected anyway.
> 
> The pte loop maps whole pages and stops only when addr lands
> exactly on end.  An unaligned end lets addr jump over it and the
> loop keeps mapping past the range.  An unaligned start maps the
> page below the range and usually misses end too.  Such a range is
> never a legitimate request, and the corruption it leaves behind is
> hard to attribute to the caller afterwards, so bug out on addr and
> end at the entry of vmap_range_noflush() and drop the check from
> vmap_pte_range().
> 
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/vmalloc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 093b8d5f7b0e..27f2674a5556 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -125,9 +125,6 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  	unsigned long size;
>  	unsigned int nr_pages;
>  
> -	if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
> -		return -EINVAL;
> -
>  	pfn = phys_addr >> PAGE_SHIFT;
>  	pte = pte_alloc_kernel_track(pmd, addr, mask);
>  	if (!pte)
> @@ -347,6 +344,7 @@ static int vmap_range_noflush(unsigned long addr, unsigned long end,
>  	 */
>  	might_sleep();
>  	BUG_ON(addr >= end);
> +	BUG_ON(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end));
>  
>  	start = addr;
>  	pgd = pgd_offset_k(addr);
> -- 
> 2.25.1
> 
Like Suren proposed, there is only one user of vmap_range_noflush() it
is vmap_page_range() function. You can add warn-on-once() there and
bail out.

Do not add BUG_ON().

--
Uladzislau Rezki

