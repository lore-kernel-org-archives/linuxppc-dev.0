Return-Path: <linuxppc-dev+bounces-29461-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78948CC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 08:08:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4P3S5KPWz2xWt;
	Wed, 14 Oct 2026 19:08:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791965316;
	cv=none; b=l+Tu/TyVPI/5cxfY3WKKQK13MC5sddmugMKnximKUQt7RXVpfeXM2a9W6nXZvA8bSo79fDM5SzjWqTCMJjIBN+LTNX1Kg5MXSUBzEUsoYtwfxPiSKcGVC1EPFGtcMEjw4wBJ5eivPGZT0Kjf0sWVcegD0E2va9N7cETAsskuAU2d4VzcEHMupU/C9BQUgb3zDJCY/vs0OjdnzXKOYkP5+jxSy73WDqomrt1DzPxGmwTHVzEZp6UXdH3w3IpIpQIYmbOJJQMir45va9yI9GSn5wgEFknRaQrNneIxSHhRSKo6Z8tqqGWOxS9h3ZK3JnSo0YU6Y6c/f1yb+NST+9YyNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791965316; c=relaxed/relaxed;
	bh=YZHQeVBPNU6rc5illaISM5DptVONwmd53i/boebMGqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2RlAGJLQG72RjBmgiWVqHNfRToo0lSW4mKMSb1kflgKAoEJjqtrUFbT6AetOFemJd9LmOCe1OC4ayxEu1TKFKaLbCzfySxZbfUEi0yio559FULaeoUqsznn1wmJBVx3acJfFOrZ9GSQAHuVAQXXOzShXizNeEy1XbsXXReQwNowO4Ufd8FuvMikpyTC0x93AXcgswqI6rUo8u8uPay3R/+ga4DNaFJzwoWndy3ZmkALW10RYXwoV5tozVbfOU56A8PM4y9P9kpFemcoayAYUkjhXI4Iux8rW69Gl3XaGrQdUpKBQZ1w3PraS1qHnEKxXWKa0zudxEArBG/uyb/3vQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=D36suGID; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=D36suGID;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4P3P60Ypz2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 19:08:31 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56E2F1576;
	Wed, 14 Oct 2026 01:07:55 -0700 (PDT)
Received: from [10.164.19.62] (unknown [10.164.19.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28C6B3F7B4;
	Wed, 14 Oct 2026 01:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791965278; bh=MUie6VSnW5OquybNhX7YpynpIviFja/SPKRkeO/X0wM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D36suGIDWLUtoLdWoMaoApXTyWb2dzsEOXw/86kfMa+KgI93jY3cyZhzJ4faej4Sh
	 JoeimUdc+OnzEu/p97k/KVlKyD++ribIOtPYH/XLmQ5DbwSBE4LVzCjncH4gY/3l/L
	 763i0DKSevsHZIg/cPifkmIZayELI65poLThF0W0=
Message-ID: <1a34d980-4520-464a-b8d9-7720136bdacf@arm.com>
Date: Wed, 14 Oct 2026 13:37:50 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/10] arm64/hugetlb: drop the init_mm special case in
 clear_flush()
To: Wen Jiang <jiangwenxiaomi@gmail.com>, akpm@linux-foundation.org,
 catalin.marinas@arm.com, linux-mm@kvack.org, urezki@gmail.com,
 will@kernel.org
Cc: Xueyuan.chen21@gmail.com, ajd@linux.ibm.com, anshuman.khandual@arm.com,
 baohua@kernel.org, chleroy@kernel.org, david@kernel.org,
 jiangwen6@xiaomi.com, leo.yan@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, rppt@kernel.org,
 ryan.roberts@arm.com
References: <20261002090947.869220-1-jiangwen6@xiaomi.com>
 <20261002090947.869220-5-jiangwen6@xiaomi.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261002090947.869220-5-jiangwen6@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02/10/26 2:39 pm, Wen Jiang wrote:
> clear_flush() calls flush_tlb_kernel_range() when mm is &init_mm. This
> was added by commit 06fc959fcff7 ("arm64/mm: Support huge pte-mapped
> pages in vmap") because vmap called set_huge_pte_at(&init_mm, ...).
> 
> Now that vmap uses pte_set_huge()/pte_clear_huge(), mm/vmalloc.c is no
> longer a caller of set_huge_pte_at() on arm64. The only remaining
> callers passing &init_mm are in arch/powerpc, which uses its own
> implementation. Remove the dead branch.
> 
> No functional change.
> 
> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> Reviewed-by: Barry Song <baohua@kernel.org>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


>  arch/arm64/mm/hugetlbpage.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 8e799c1fe0aa6..ce247b06fe03d 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -206,10 +206,7 @@ static void clear_flush(struct mm_struct *mm,
>  	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
>  		__ptep_get_and_clear_anysz(mm, addr, ptep, pgsize);
>  
> -	if (mm == &init_mm)
> -		flush_tlb_kernel_range(saddr, addr);
> -	else
> -		__flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, TLBF_NOWALKCACHE);
> +	__flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, TLBF_NOWALKCACHE);
>  }
>  
>  void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,


