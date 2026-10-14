Return-Path: <linuxppc-dev+bounces-29464-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF9BCC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 08:38:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4Pk068JBz2xrC;
	Wed, 14 Oct 2026 19:38:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791967112;
	cv=none; b=BwORRPpDsmek4PeAiUJV/oGIFNZJ+L97/sy6xPiRjJqRFZdSzDr4/vCx8xZsNr1Hp6RMxue/n2ip5zvmgl/ySbgyiqjnliBmU/S3PF1MTWH2lt6tgfaPSJMQ3oziPTNoo3DLexZkiP+XU/r3+wLV+JbPR5gA9rsEa9udHDkm8k2rS3eMvLfX3sw95AFw439cSmIQpqo95I2k345fEgftQXX2/am6mR+MHY+WvhG4S6wFU06uFhJLJdD/yxFFm63lWacBGOiFO6MJ1GntC+0UC5yLijkLhvbCgD1ov13Ybhq8PWrfYT6AtVsePkzKCpXmwW9ZAxF/JjIt3GCeiu//6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791967112; c=relaxed/relaxed;
	bh=rpfbp7+09VSVLT2brzHvfoYrBS7F6mk+5majLqh1Ny0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DyDWDctCAVZFXvCzGlIa2AcDOFrvnca2KDb1ZvOKAjTMI0NRzFODzI0BsVbQ/qjdZYtzjnrrcGJ99cViViq05aK7tkjbBKipi1zg8OzSyrwg71ESISBjNsUb/ikbzMWyGqPx38p8UbTzn8VOAxOPNL6A3hUVhdxZuHcSamqokAuLpJbQd5Sz2qzbTtmcRgyUTuk6fGt3LLuD3SGsmFSQF2LGdm485m+jjAHzcY34pRXW73usAdPd3Rdh85KxQkfXDBX8qGX6zlGeijQlLDbreVHxjRXQT5uVszD4ps8c+he4kTc60Gi1HUymMBGpmwSs6mWyjCEmArQJSmDixUSGjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YW+O5SxZ; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YW+O5SxZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4Pk01b7Cz2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 19:38:31 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BC551596;
	Wed, 14 Oct 2026 01:37:57 -0700 (PDT)
Received: from [10.164.19.62] (unknown [10.164.19.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C018B3F7B4;
	Wed, 14 Oct 2026 01:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791967080; bh=Lvh1ebzqQWLVy/QzryOeVmDqirZlakF61dyc2OgQxSQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YW+O5SxZcPWoxb2kG3EQpKGLvC8F36KUBW01MWK6X9q57dGo6HKRHPLgvQ6s2VAKU
	 P1X7INSncDesFr7A7sT/tuUyrkfiKfCdFHG5ahDf+NUh+8hSrgfzD92ECUDiEdb2lH
	 w1XLvv7Z80od/QksxuojE4SaYRCMTIxQkcYwlU3g=
Message-ID: <498336e2-8a48-4cd4-80fd-b3da571ded12@arm.com>
Date: Wed, 14 Oct 2026 14:07:52 +0530
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
Subject: Re: [PATCH v10 08/10] mm/vmalloc: extract vm_shift() to consolidate
 mapping shift selection
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
 <20261002090947.869220-9-jiangwen6@xiaomi.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261002090947.869220-9-jiangwen6@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02/10/26 2:39 pm, Wen Jiang wrote:
> Extract the vmalloc mapping shift selection from
> __vmalloc_node_range_noprof() into vm_shift(), preparing for reuse by the
> vmap batching path.
> 
> No functional change.
> 
> Suggested-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


>  mm/vmalloc.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 99bd22c086bf8..aae6141aaebf5 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3568,6 +3568,14 @@ void vunmap(const void *addr)
>  }
>  EXPORT_SYMBOL(vunmap);
>  
> +static inline unsigned int vm_shift(pgprot_t prot, unsigned long size)
> +{
> +	if (arch_vmap_pmd_supported(prot) && size >= PMD_SIZE)
> +		return PMD_SHIFT;
> +
> +	return arch_vmap_pte_supported_shift(size);
> +}
> +
>  /**
>   * vmap - map an array of pages into virtually contiguous space
>   * @pages: array of page pointers
> @@ -4079,11 +4087,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  		 * supporting them.
>  		 */
>  
> -		if (arch_vmap_pmd_supported(prot) && size >= PMD_SIZE)
> -			shift = PMD_SHIFT;
> -		else
> -			shift = arch_vmap_pte_supported_shift(size);
> -
> +		shift = vm_shift(prot, size);
>  		align = max(original_align, 1UL << shift);
>  	}
>  


