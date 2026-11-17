Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCDB606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 05:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=soXSklK+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTDSC2vgsz2xqL;
	Tue, 17 Nov 2026 16:53:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794894827;
	cv=none; b=kcRElazbUX9x4hQjgQJIl1sNj5d/SfHogQ8yRbBtvu5KmyjLF7HRAk6VgIa1pQpt+jbi/bhuztEEKoDW61ZfYi/D7Y8VRT0OZCWzOI5jwxt/zJOUO8Fv44uWHggYTwqb35sAbTCPbBmAcMiMMCvfK0U/0yJmwqWgtx0ECzqYVUZ5A7n/8lSongMBz3eo2M35t+2lDCcG4AV+Z4GNIa3+CrcosIvT3p4lYcqwCki8yd0sFIvxjIDcnh2OLp5blKnOXdTYYpCtcga7GpK3YNX+iIZW8QeqBb3GtbErqR8DM+K8X9X8r3U67csvIKbsxC9jonlM5H+C/+8AXZtgX0kclg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794894827; c=relaxed/relaxed;
	bh=preYSvRhvln7+HpvLwGVKBTF6qwxYYu7pQfN5NTytYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+6CbmppVndmiEql7gJ2c7uKIsn0UIfFMbNYhbf1yoOZTGOK2yVbZbWIzPPDNwK8zFsVCryKPyN7pJlkwAONS/+tsmVIjvvX36Jt4sf7hBLJEoCBB6mjLrOyoc8uZhSw4Wqt2D502XZBFBbQ7NUhNmrernsoartNbhTcHpTxq/mOXeRORXqm/3lso+XEVOaEd/6CeEfuDXKIhZlhdb+RDFcTDmSaU3DBHZs6ciq43s/syQla4Tb0hWseFbYcQGxHClnkrSwazXS76ZjunSx+3aqDmFL1C4ddR5S00T9jTW6x2lwsVdjaMYHoPCJSnHr+tVe+S2GCtIBsLuCMsez5og==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=soXSklK+; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=soXSklK+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTDS93VPFz2xcB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 16:53:43 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69C311682;
	Mon, 16 Nov 2026 21:53:07 -0800 (PST)
Received: from [10.163.156.60] (unknown [10.163.156.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 282C33F673;
	Mon, 16 Nov 2026 21:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794894790; bh=LeNEd6XybC/0oQxf6tPEXuNsH/uhyc0vnuxHYF7fhAE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=soXSklK+FJaMyX7c81avmAyAcqpvFzRiWZU4JCZehiQO8CLy91r+p5aueoYQaI4om
	 t7tyYU15TqiYoQGlI/BoCP1DY9vNUu0BY9gThGDlvh0HvfLGNprRWeRo7J1dRd7YoH
	 HsnX9MS+DU6Ph5GxQpqgRIVBJ9LuTa9/Rq3k3uFg=
Message-ID: <7191bd56-ba20-4b60-9969-7005e64c086a@arm.com>
Date: Tue, 17 Nov 2026 11:23:00 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/11] mm/vmalloc: reject an unaligned range in
 vmap_page_range()
To: Hao Ge <hao.ge@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org
References: <20261116071325.263682-1-hao.ge@linux.dev>
 <20261116071325.263682-4-hao.ge@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261116071325.263682-4-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 16/11/26 12:43 pm, Hao Ge wrote:
> commit a739e6b557af ("mm: vmalloc: WARN_ON if mapping size is not
> PAGE_SIZE aligned") put the check in vmap_pte_range(), which is too
> late, because the upper levels may already have installed page tables
> for a range that is rejected anyway.
> 
> The pte loop maps whole pages and stops only when addr lands exactly
> on end. An unaligned end lets addr jump over it and the loop keeps
> mapping past the range. An unaligned start maps the page below the
> range and usually misses end too. Such a range is never a legitimate
> request.
> 
> vmap_range_noflush() has a single caller, vmap_page_range(). Warn on
> addr and end there and bail out with -EINVAL before any page table is
> installed, and drop the check from vmap_pte_range().
> 
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Suggested-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


>  mm/vmalloc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 3c0d9e69b886..a168f6f20f4f 100644
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
> @@ -369,6 +366,9 @@ int vmap_page_range(unsigned long addr, unsigned long end,
>  {
>  	int err;
>  
> +	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end)))
> +		return -EINVAL;
> +
>  	err = vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
>  				 ioremap_max_page_shift);
>  	flush_cache_vmap(addr, end);


