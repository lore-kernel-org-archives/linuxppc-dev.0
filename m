Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10B860A2603
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ponlYb2N
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVlfv65TSz2xLF;
	Fri, 20 Nov 2026 04:23:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795108999;
	cv=none; b=oSnkMGPJBxvacicXz/8EjJKx7/GnHNMFVGVQ9oZm/RtOjdE2FCuw0jLV/iVXiZd+iQUIiMNu2FIega746e3XL/rN1PpoStKlWaIAcOks1xfKdzURkSj7OswJtGD4kOlPzQH4LyxiiaotrvG7tkveBOocQXVEfM/2BBb2QvJZZbBR348ig24E8vC/FzJqXtJMut1OufuxAygf8Z3n0JBRYV1plQ4o1BN+25uElOuy3/zag0ekUbRJzDU932lvI6gyJxmpbP0w/BP8r6vT6J8O1Y/qloYiq/X179XDGhVlH/dRmxuITmNG1H+249jRHy07dNEWtc325pcA5NWoARi8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795108999; c=relaxed/relaxed;
	bh=dvwpM6x9UyT5LtxoyNzaw4LyWCYizJm0AMP5Y1DvOYE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=ItsFJxPxqFYAlSYTLbW+zivTtThX/TN+vHp/8wO7tX3qj7dGjL5nviC08EHFGRi2LztYe06WDK0NHarFJ5L3RNHV5pKdZuLG0KLzCDcg6fvUDs415Zvd51WtLIPB6617vQ/5aIa2gq/AAIki4iI08dZFqQwUV2SeoxY7KATKeeCVYGgqEQFNkQIB7IsCsGw52D80xAkxMg/iIlT9vgaxbWQrpronFmi1I9Locbq+Y/Oxx/0e03pCphE8KcHC5+hrOyuMNSIDdbOFsotAxj98x2RoNi0BenslrhSo6yejZkCzNIfQ+wQ/AWK+gXiO7EQezpvXt01kWirSydearB3kHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ponlYb2N; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ponlYb2N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVlfv0qqLz2xL1
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 04:23:18 +1100 (AEDT)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-3282db206d3so6658271eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 09:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108996; x=1795713796; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dvwpM6x9UyT5LtxoyNzaw4LyWCYizJm0AMP5Y1DvOYE=;
        b=ponlYb2NwX09iTHKFCmRY9aYmWxk7V7dGEb5QnmLBF0OJdL1p+MOjxy7ED9QHx3K7J
         QNDBW9EbO17VuvrQZX+1JyA0vpQV9H6zNb/8NCm6Cs24I2bzf0nUT7qKINg8b8sSBhAp
         jd9i551FN4+N7CU+9pbIpW4Wfa0qFcZNajL+KBpODP8XAmDbh9V6JfZWjcr1jy4VCxBv
         z+GPo1eRO+/JpVjX4PKFr58D2drPbeGuY68iiPS+Afi8+55K4/E6kHnMafCtDAD5xfX4
         e09Rpezgcl2E+keHIzHOUYuQSiS+6xrUKVPXuRFRTFS5QXrPNfT3i6TAq7KuwjND+5Oe
         ZLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108996; x=1795713796;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dvwpM6x9UyT5LtxoyNzaw4LyWCYizJm0AMP5Y1DvOYE=;
        b=DWPBEwiGV6nQhu/fndZuGCP0vkcNqu/tQiKGH6/25/NKSHGfe38qSAykM6yeYCsKQA
         TsXq8EDj3Fl/Uw5OSRVpC0FOc8M5c/pJ+w/Inxejl9/aFwRLELs2suPpjDdzlxtrDWLj
         eoIqRE1WNiek71/bxsq2tPE97C4GK0pgfi5LTZOMawwXa5msAnC9uu7YEpbA8VT7iqkk
         vXv8bkp9Nif4CckpJVZLnJ4uH9VStQQUI8Q5TcDeizASiepMlEDu4TCy44kt3Myn+WVb
         cptjPT5jEdPJH0RtmN9EWpuR/sqaDC4rMbn8UCG+iuZTvb6B5a3A85MoBeMc+/LGapGd
         TKRg==
X-Forwarded-Encrypted: i=1; AL+hErE5MXG47y/18LrirbuV/ZvTKlWLqX4xMO3z/wJaa6jx52qzUW+0IW0Zoobzt467ukcMOkouvpNTNBPqRys=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8olxNhszFqwovifiuwQYpIQhVvI5wlmVI4lToSwic2ytI+QAjN
	P69hrduMxKyyJBSIfXwJFKJWIbnsh/1TuZVq+J/Z/jl7kgrUSRZ3IUqK
X-Gm-Gg: AZFdTZfpRZw1bIhlmjHOv9DT4ZzVQUgJHS7eED8wWYqDVTOuS1JvYrKNzete+F4L1v+
	VXwx7yHVVIefTCY9KmD7ik+VUGllyhcY5/xP0GfuyApeBznpB/DYygru/BLShaHhqZfUO0IHVrn
	i+DqvZ8AwbmEd+mj3IQortmrgxJAnSDp257S4PHhdhFHB9BwpeTfePge8Dc+9nmPbeH5KRmRaf6
	J9S/ugAy6CLfvHKOS8AmW/AEp30+WyXmesIM1VpulrkNA1iF2fSGysLTl3WHobHZrzhEARGGSek
	bcTQepoHHdYwj1hVZPfkTv84eHdYRtO/OawxPdpUj4OeqFuUgm9ZcIDHZDLvP9CHtubyL87IvKS
	Dri4TG+uH/o/Ckic5VSx4XXiO/YsdtzerAzeBjMC5W4qkWwmNFqxbj7jYvHnMqZvJo/WoAPxVEP
	+n3CSxaaZk3jgCEqtnJ41W4n5WMrdKeQBnSorQpxfKiWNph6xyqmYFpPdNhmce+tGIAwKAWyJjn
	y5f3uLg9bTxyrLyw2KEaibJxMEislyZ5a6wwQJ10Mhq8guQLOMKusjcZjzInsGJymfzAGjp4+Bo
	bCcUJ53ln2YJKDdHMTWh13LjHRiuuHPGdeTQBGSgzcJ6hTvd
X-Received: by 2002:a05:693c:829b:10b0:383:a0bd:275a with SMTP id 5a478bee46e88-3856e947850mr47370eec.7.1795108996234;
        Thu, 19 Nov 2026 09:23:16 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm265231eec.26.2026.11.19.09.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:23:15 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, Thomas
	Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
	Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v3 5/8] powerpc/mm: handle highmem pages in arch_dma_prep_coherent()
In-Reply-To: <20261119151520.2383226-6-m.szyprowski@samsung.com>
Date: Thu, 19 Nov 2026 22:45:22 +0530
Message-ID: <33swlp3p.ritesh.list@gmail.com>
References: <20261119151520.2383226-1-m.szyprowski@samsung.com> <CGME20261119151531eucas1p2be2ec1360d1d94c80b200c53b25f292c@eucas1p2.samsung.com> <20261119151520.2383226-6-m.szyprowski@samsung.com>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> arch_dma_prep_coherent() performs the cache maintenance on the address
> returned by page_address(). On 32-bit powerpc with CONFIG_HIGHMEM that
> is NULL for a highmem page which is not kmapped, so the flush would
> operate on the wrong virtual range and leave the dirty lines of the
> buffer in place.
>
> The generic DMA code may pass highmem pages to this hook:
> dma_direct_alloc() handles a highmem page returned by
> dma_alloc_contiguous() by forcing the remap path, which calls
> arch_dma_prep_coherent() on that page before creating the uncached
> mapping. This cannot happen on powerpc today only because it does not
> select HAVE_DMA_CONTIGUOUS, so dma-direct never gets a highmem page
> there, but nothing in the hook's contract rules it out.

That is correct.

>
> Use __dma_sync_page() with DMA_BIDIRECTIONAL, which the
> arch_sync_dma_for_*() hooks already use and which kmaps highmem pages
> one at a time. Without CONFIG_HIGHMEM it does the same
> flush_dcache_range() on the linear mapping as before.
>
> Fixes: f2902a2fb40c ("powerpc: use the generic dma coherent remap allocator")

I don't think we need a Fixes tag here for the reason you quoted above.
I’m afraid that adding a Fixes tag might cause this patch to be
backported without the previous patch, which would result in extra work
for lowmem pages on highmem-enabled kernels

I think we should drop the "Fixes" tag here.

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/powerpc/mm/dma-noncoherent.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Otherwise, LGTM. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


