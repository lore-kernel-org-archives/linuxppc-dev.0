Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD33606A31A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YcTvULNQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGCS970kQz30RN;
	Fri, 30 Oct 2026 18:30:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793345433;
	cv=none; b=hZHsxXsGuZaK9GPLn9HDL6HE/E17vPCN3F8gSbTngNO9fkLeChUOT9L8fRd+dTlIAPRCkJBDhGncKItUr1x3yS8wLgwkNdAkJOBEQZ/D/1jxwzFaZZy41DHWdpPDrjtUAJirQkIylNqeKJ0s1lzKYooYHLMUaVGV5mYmp+D2q6fxM8ABLl3DKYAB2BapqkEKw0rmBbhHzSNMillwyYBYBupzxRbhDGWHp7nEA0otaSHG9M39cqdI9OQBh0sTOtMyqGmrFb/cejnzTlvpZ/z58QUOuZQVUD5cQA+hvcYtHCxuZvjGYehAlrcqZ2dFMX3vc9dRO0ZqIVLZczXoEDBwig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793345433; c=relaxed/relaxed;
	bh=oyfKDjJKfboeY0ufdBsjhuOQtM906D+prVVlHL4BJww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqVp3nFNXqppJFXTMnZKE4zsix9mR73TaywukF86gPYUeXMEX4NTTyfVn3V16SjXfsZTOQa0vNY7ZDc7L9MLz0iZFa/VHZ6fMRhK5Ij6x3xyN4Z2RSa3kMzdQnU27FKS1XrrDkANRGcw50yizRm8y0bFADXgMHmeW0fVLKW8dMUuHtFd8e3D7ZqjkiTtFaHibT+7OTiUqBXutXvWcbv0QMZ78PuiRIXmVYoAFg0ZzJ1MXz7jkIAwF0r+PyctBX6hchZuDKAlOSqmg+uRsX5F5dn05MgPUNsiZUjcnLiLKArzosDQ2jPtT+dIIE+KMtvSxKdr/dFjBzu0JU/qakBbow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YcTvULNQ; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YcTvULNQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGCS85ykwz30C6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 18:30:31 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E19F1682;
	Fri, 30 Oct 2026 00:29:57 -0700 (PDT)
Received: from [10.163.152.232] (unknown [10.163.152.232])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA59D3F7B4;
	Fri, 30 Oct 2026 00:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793345400; bh=C0mcHAl4LVJ8G9Pi84zcG+F9QdADyGft2/o2o+f0aCs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YcTvULNQBDbtCwZfjjgbZnJd9x9ynp64awrXns5yOXqR8Z+sGJVfTapd6gvVsFgUJ
	 57bMm++PQke8e3TIZX02+sOLDz+2oCiQuvUscLQCxTQAkheHl0XTz1g21phraKC/Qz
	 /l8zfyfjg1A8PATkbHb82RqGtQKE9AHDFttxKiWo=
Message-ID: <e1cfd568-8fdf-4aa1-a8c5-961bb8d7efba@arm.com>
Date: Fri, 30 Oct 2026 12:59:50 +0530
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
Subject: Re: [PATCH v3 04/10] mm/vmalloc: propagate errors in
 vmap_pages_p*d_range()
To: Hao Ge <hao.ge@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 Uladzislau Rezki <urezki@gmail.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org
References: <20261026080329.140244-1-hao.ge@linux.dev>
 <20261026080329.140244-5-hao.ge@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261026080329.140244-5-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 26/10/26 1:33 pm, Hao Ge wrote:
> vmap_pages_pmd_range(), vmap_pages_pud_range() and
> vmap_pages_p4d_range() return -ENOMEM whenever the level below them
> fails.  But vmap_pages_pte_range() can also return -EINVAL for a
> page without a valid pfn and -EBUSY for a pte that is already
> mapped.  Pass the error up as-is instead, like the vmap_p*d_range()
> helpers for vmap_page_range() do.
> 
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---

Fixes?

Reviewed-by: Dev Jain <dev.jain@arm.com>


>  mm/vmalloc.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 7131f60d1a8e..d60b99b81ec9 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -600,16 +600,18 @@ static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr,
>  {
>  	pmd_t *pmd;
>  	unsigned long next;
> +	int err = 0;
>  
>  	pmd = pmd_alloc_track(&init_mm, pud, addr, mask);
>  	if (!pmd)
>  		return -ENOMEM;
>  	do {
>  		next = pmd_addr_end(addr, end);
> -		if (vmap_pages_pte_range(pmd, addr, next, prot, pages, nr, mask))
> -			return -ENOMEM;
> +		err = vmap_pages_pte_range(pmd, addr, next, prot, pages, nr, mask);
> +		if (err)
> +			break;
>  	} while (pmd++, addr = next, addr != end);
> -	return 0;
> +	return err;
>  }
>  
>  static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr,
> @@ -618,16 +620,18 @@ static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr,
>  {
>  	pud_t *pud;
>  	unsigned long next;
> +	int err = 0;
>  
>  	pud = pud_alloc_track(&init_mm, p4d, addr, mask);
>  	if (!pud)
>  		return -ENOMEM;
>  	do {
>  		next = pud_addr_end(addr, end);
> -		if (vmap_pages_pmd_range(pud, addr, next, prot, pages, nr, mask))
> -			return -ENOMEM;
> +		err = vmap_pages_pmd_range(pud, addr, next, prot, pages, nr, mask);
> +		if (err)
> +			break;
>  	} while (pud++, addr = next, addr != end);
> -	return 0;
> +	return err;
>  }
>  
>  static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
> @@ -636,16 +640,18 @@ static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
>  {
>  	p4d_t *p4d;
>  	unsigned long next;
> +	int err = 0;
>  
>  	p4d = p4d_alloc_track(&init_mm, pgd, addr, mask);
>  	if (!p4d)
>  		return -ENOMEM;
>  	do {
>  		next = p4d_addr_end(addr, end);
> -		if (vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask))
> -			return -ENOMEM;
> +		err = vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask);
> +		if (err)
> +			break;
>  	} while (p4d++, addr = next, addr != end);
> -	return 0;
> +	return err;
>  }
>  
>  static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,


