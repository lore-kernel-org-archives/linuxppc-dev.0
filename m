Return-Path: <linuxppc-dev+bounces-28579-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28653CA5FC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 15:05:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvyz04gcMz2y24;
	Thu, 01 Oct 2026 01:05:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790780732;
	cv=none; b=HXz0aHscwKOMg9SgxQSrDb6RZ0H9aoDwiyjwSQ16Nbl8jx5wVdqL8NfOhAl014UkwU0CcWDDB3+aBwhxlQcaaL5XG6lbOnOdhQIAOvBWLa4XIJVkboN+6kb8zrwKAOu6r7/QW7QVMNB/WaKIj9pyrOn55yPxOm+snc+M551WICJ50a42id2hNvMrhxviAHMp0m0AgRX63BTZd29gvn9RPkBfwesju5NlbUtGuaW/edcZuboDjiBjAoQx7W0bikPt/EnAYpxp5iwovh4Rr+pT6LzBFvCLkg0CX7jOXs3hjl2yLZ/dn60TyE0diMREaMfMlTplW3WIizJfVhw4lrPjLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790780732; c=relaxed/relaxed;
	bh=jfRtojeauzUhQb4SePcX378h8gySuQTk235TQqLiiHA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtK+RzWYNizZecc+hM9fMEgzdu4qgxbfurkVeRsJQw6tjA0RneuDjV6ksUukUxvYp50gpTylBGQW25gLXxSXmMOSNVZn0NMWD0AIzLOxLRk7pBQt3P8+h4OJXoW2Tq/z5zIHRVy9OewRkUbYdHwhEzPhog2pzkpvOmELsLUehbB5vaEZDkrC3LkkheAiPP0HR/9Ld7xQJ5CTkbpKF9jUjkDDisZByoMY6Be7w5EG0f7nWttjN9hEEgPKgwl4OR47bUj/ae3cM1bVNh+godVHQWvQJJoXVvGdB6OYgcEoiGjAPB5ErOSznBuBq/KDvQdRtlndUiIEOsrdILl015ZfzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gcsAcS+e; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:34::f; helo=mail-ej2-x0f.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gcsAcS+e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:34::f; helo=mail-ej2-x0f.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com [IPv6:2a00:1450:4864:34::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvyyy4Tjtz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 01:05:29 +1000 (AEST)
Received: by mail-ej2-x0f.google.com with SMTP id a640c23a62f3a-c2e17e5de00so162103066b.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 08:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790780726; x=1791385526; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jfRtojeauzUhQb4SePcX378h8gySuQTk235TQqLiiHA=;
        b=gcsAcS+efhPvClr994C7i1d6/at8xcWoW5LIcZ8/ERyxm7tNA+6xvoTaNrQ9Lg40u5
         OKEp36S9FhC8gnT0v1UjwxXX8Nc/2Lr3Vev4fgXk8gOList9m6VwbD35TxJx3VNQRd3c
         fTUDbuLrpa6N+kUzKtQ4V+ia/EhFOVeNvCkedXl8yYoAFm/prlv9LZ/nZF9uLYhNP8d9
         JdidFMv3laV6NyBL89AXb8hBNltD2FA64MC883nU6shHGGry+qJdgsV964jZ9M98ctZv
         tmLPn/k7U/xr07PKO+r4pPia8m1bs04BYec0vaM75Bc6e/iS1tP5bbSh/Fk7KZmj/b4E
         bTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790780726; x=1791385526;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jfRtojeauzUhQb4SePcX378h8gySuQTk235TQqLiiHA=;
        b=Cr2fGXs6ESR0GVCenSZTRqZTXzLNAgw71x6tDbIcFuJCO1GjE6d7ntynqHSWrR7ksp
         Qslhz8xGEWSZrHKis5IIORA5rL5SaGCTTl9QrlucE24Gy8TNEiY+GFrUi8TSH3frBbYn
         Si4vL6nsHo612HN0keWlJ3M1AtPsKdMBGJizjA8h/q5/QLWqxejnyjRHzCUOtf+fWjNj
         1ry2SonjeTKLAxgf3wf5/mJWGhPzjLy54ZtrM6haSNsHa+9Wvoz6CPWS311uJ0HXN7BC
         XMzdDd1ZaAOfjH2FPwdUZE8f2fWS/55orcV4lDz2ZWBOE7rRVpSK5cnE39HGoyn0MSv7
         L62g==
X-Forwarded-Encrypted: i=1; AKwUvBzfk/PTzNW5CBWEEuDipaKeRdo5IA7xQ+3C6QEJe9v7V1HzHg22ZnMJTCJogZ+0h5NoR+/2iZpfqF3tS7g=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYImSSCY6WQHRiamdk6NvWLXbvTYi2c0Q1KsQV7om86tc9M0o0qB
	mdghhVFsheN6L05U9NG5ljD2PJS0aXjFt5znovM3fOKPy+IV4XfaOXst
X-Gm-Gg: AYBFou37ImQBleFd1Kp1DIvjTnYUxFuOSHd5EYN6PJyNAT20gVIc66RkfTCbOTFCAdf
	qhSG072Ph2pGFe3osomBsAJ4Mgao1JHYPQAiktYhf9HF2pOUUDgPESRbbhiJ4G5UJz5/UnF4tL5
	4wVk1tUT93UaXMMIS7AVBXugvcDcbyecHmeCsK4bre4r1N28HAypw6yAV1tijYJRddpXxdDvDUU
	ZRQRSJ4GE+NoU8qD/FSO86IyqclxLYPDW6vRorxuNgEwfyDBBLbJcLmd7XE6Q7Rdh/LIqQgswWh
	QavrtMlTxB3Ipze0H7qUBj6k9ifxED34vXkDVe+/Xz4JzrwSLVuFUZFYdCZYglkFWl1B2KnqkxY
	Mwcd49IxQ8jAXiftPx5fMuhheNEGt0KSTU13efFoWo9g/lxdKw3jSlyyqmSiKLCvRNqt8+rlHt1
	iEBHCwrXfYXJB+LprcV8HW
X-Received: by 2002:a17:906:ba89:b0:c2d:a4ef:64ca with SMTP id a640c23a62f3a-c2e23e39566mr171362866b.42.1790780725514;
        Wed, 30 Sep 2026 08:05:25 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31a3cc87sm20827866b.6.2026.09.30.08.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:05:24 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 30 Sep 2026 17:05:22 +0200
To: Wen Jiang <jiangwenxiaomi@gmail.com>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org,
	urezki@gmail.com, will@kernel.org, Xueyuan.chen21@gmail.com,
	ajd@linux.ibm.com, anshuman.khandual@arm.com, baohua@kernel.org,
	chleroy@kernel.org, david@kernel.org, dev.jain@arm.com,
	jiangwen6@xiaomi.com, leo.yan@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, rppt@kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v9 09/10] mm/vmalloc: map contiguous pages in batches for
 vmap() if possible
Message-ID: <ar0lMkKxugZV7xyw@milan>
References: <20260923062832.479455-1-jiangwen6@xiaomi.com>
 <20260923062832.479455-10-jiangwen6@xiaomi.com>
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
In-Reply-To: <20260923062832.479455-10-jiangwen6@xiaomi.com>

On Wed, Sep 23, 2026 at 02:28:31PM +0800, Wen Jiang wrote:
> From: "Barry Song (Xiaomi)" <baohua@kernel.org>
> 
> In many cases, the pages passed to vmap() may include high-order
> pages. For example, the systemheap often allocates pages in descending
> order: order 8, then 4, then 0. Currently, vmap() iterates over every
> page individually—even pages inside a high-order block are handled
> one by one.
> 
> This patch detects physically contiguous pages (regardless of whether
> they are compound or non-compound) by scanning with
> num_pages_contiguous(), and maps them as a single contiguous block
> whenever possible. The mapping order is determined by taking the
> minimum of the contiguous page count and the pfn alignment, allowing
> graceful degradation when pfn alignment is less than the contiguous
> range.
> 
> Pages with the same page_shift are coalesced and mapped via
> vmap_pages_range_noflush_walk() to avoid page table rewalk.
> 
> As users typically allocate memory in descending orders (e.g.
> 8 → 4 → 0), once an order-0 page is encountered, we stop scanning
> for contiguous pages since subsequent pages are likely order-0 as well.
> 
> Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
> Co-developed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> ---
>  mm/vmalloc.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 80 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a43965016eb4d..37cddb7f45a4f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3576,6 +3576,85 @@ static inline unsigned int vm_shift(pgprot_t prot, unsigned long size)
>  	return arch_vmap_pte_supported_shift(size);
>  }
>  
> +static inline int get_vmap_batch_order(struct page **pages,
> +		pgprot_t prot, unsigned int nr_pages)
>
get_vmap_mapping_order()?

> +{
> +	unsigned long pfn;
> +	unsigned int nr_contig;
> +	int order;
> +
> +	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
> +		return 0;
> +
> +	/* Limit nr_pages by pfn alignment */
> +	pfn = page_to_pfn(*pages);
> +	if (pfn > 0)
> +		nr_pages = min_t(size_t, nr_pages, 1UL << __ffs(pfn));
> +
> +	nr_contig = num_pages_contiguous(pages, nr_pages);
> +	if (nr_contig < 2)
> +		return 0;
> +
> +	order = ilog2(nr_contig);
> +
> +	if (vm_shift(prot, PAGE_SIZE << order) == PAGE_SHIFT)
> +		return 0;
> +
> +	return order;
> +}
> +
> +static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
> +		pgprot_t prot, struct page **pages)
> +{
> +	const unsigned int nr_pages = (end - addr) >> PAGE_SHIFT;
> +	unsigned int prev_shift = 0, batch_idx = 0;
> +	unsigned long batch_start = addr, batch_end = addr;
> +	int err;
> +
> +	err = kmsan_vmap_pages_range_noflush(addr, end, prot, pages,
> +					     PAGE_SHIFT, GFP_KERNEL);
> +
> +	if (err)
> +		goto out;
> +
> +	for (unsigned int i = 0; i < nr_pages; ) {
> +		unsigned int shift = PAGE_SHIFT +
> +			get_vmap_batch_order(pages + i, prot, nr_pages - i);
> +
> +		if (!i)
> +			prev_shift = shift;
> +
> +		if (shift != prev_shift) {
> +			err = vmap_pages_range_noflush_walk(batch_start, batch_end,
> +					prot, pages + batch_idx, prev_shift);
> +			if (err)
> +				goto out;
> +			prev_shift = shift;
> +			batch_start = batch_end;
> +			batch_idx = i;
> +		}
> +
> +		/*
> +		 * Once we fail to batch pages, we expect to fail batching
> +		 * for all remaining pages, so just give up.
> +		 */
> +		if (shift == PAGE_SHIFT)
> +			break;
> +
> +		batch_end += 1UL << shift;
> +		i += 1U << (shift - PAGE_SHIFT);
> +	}
> +
> +	/* Remaining */
> +	if (batch_start < end)
> +		err = vmap_pages_range_noflush_walk(batch_start, end, prot,
> +				pages + batch_idx, prev_shift);
> +
> +out:
> +	flush_cache_vmap(addr, end);
> +	return err;
>
On error, if kmsan_vmap_pages_range_noflush() succeed you do not do a
proper cleanup?

i.e. to cleanup KMSAN metadata: kmsan_vunmap_range_noflush(addr, end);

> +}
> +
>  /**
>   * vmap - map an array of pages into virtually contiguous space
>   * @pages: array of page pointers
> @@ -3619,8 +3698,7 @@ void *vmap(struct page **pages, unsigned int count,
>  		return NULL;
>  
>  	addr = (unsigned long)area->addr;
> -	if (vmap_pages_range(addr, addr + size, pgprot_nx(prot),
> -				pages, PAGE_SHIFT) < 0) {
> +	if (vmap_pages_range_batched(addr, addr + size, pgprot_nx(prot), pages) < 0) {
>  		vunmap(area->addr);
>  		return NULL;
>  	}
> -- 
> 2.34.1
> 

