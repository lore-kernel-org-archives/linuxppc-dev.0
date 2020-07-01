Return-Path: <SRS0=cW2d=AM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06555C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2020 07:43:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D6D20722
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2020 07:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D6D20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49xYBJ2qRmzDqtd
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2020 17:43:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=huawei.com;
 envelope-from=lizefan@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49xXp538hVzDqkX
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jul 2020 17:26:04 +1000 (AEST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B0C0A65D660C38B54DB0;
 Wed,  1 Jul 2020 15:10:40 +0800 (CST)
Received: from [10.174.178.86] (10.174.178.86) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 1 Jul 2020
 15:10:36 +0800
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
To: Nicholas Piggin <npiggin@gmail.com>, <linux-mm@kvack.org>
References: <20200413125303.423864-1-npiggin@gmail.com>
 <20200413125303.423864-5-npiggin@gmail.com>
From: Zefan Li <lizefan@huawei.com>
Message-ID: <d148f86c-b27b-63fb-31d2-35b8f52ec540@huawei.com>
Date: Wed, 1 Jul 2020 15:10:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200413125303.423864-5-npiggin@gmail.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.86]
X-CFilter-Loop: Reflected
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

>  static void *__vmalloc_node(unsigned long size, unsigned long align,
> -			    gfp_t gfp_mask, pgprot_t prot,
> -			    int node, const void *caller);
> +			gfp_t gfp_mask, pgprot_t prot, unsigned long vm_flags,
> +			int node, const void *caller);
>  static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> -				 pgprot_t prot, int node)
> +				 pgprot_t prot, unsigned int page_shift,
> +				 int node)
>  {
>  	struct page **pages;
> +	unsigned long addr = (unsigned long)area->addr;
> +	unsigned long size = get_vm_area_size(area);
> +	unsigned int page_order = page_shift - PAGE_SHIFT;
>  	unsigned int nr_pages, array_size, i;
>  	const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
>  	const gfp_t alloc_mask = gfp_mask | __GFP_NOWARN;
>  	const gfp_t highmem_mask = (gfp_mask & (GFP_DMA | GFP_DMA32)) ?
> -					0 :
> -					__GFP_HIGHMEM;
> +					0 : __GFP_HIGHMEM;
>  
> -	nr_pages = get_vm_area_size(area) >> PAGE_SHIFT;
> +	nr_pages = size >> page_shift;

while try out this patchset, we encountered a BUG_ON in account_kernel_stack()
in kernel/fork.c.

BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);

which obviously should be updated accordingly.

>  	array_size = (nr_pages * sizeof(struct page *));
>  
>  	/* Please note that the recursion is strictly bounded. */
>  	if (array_size > PAGE_SIZE) {
>  		pages = __vmalloc_node(array_size, 1, nested_gfp|highmem_mask,
> -				PAGE_KERNEL, node, area->caller);
> +				PAGE_KERNEL, 0, node, area->caller);
>  	} else {
>  		pages = kmalloc_node(array_size, nested_gfp, node);
>  	}

