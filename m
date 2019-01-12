Return-Path: <SRS0=eeko=PU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBC4C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 12:14:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202D220854
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 12:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CeXJKRaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202D220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43cJZd6gGDzDqw3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 23:14:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="signature verification failed" (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="CeXJKRaX"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43cJX83lYMzDr7f
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 23:12:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=usOnlJ+n0ouIA825JYmyeYCXdfJgDQn6tYUepfZTml4=; b=CeXJKRaXRnkz6fpEkxa+HS++N
 Nv+E3EXqQuvSm/yk5laLWDPmokTjURvDjfdZmxl+sIacD3JunbAZXgk/wDwCE6WvboTyW/u6XFJRd
 Gdg+Zo4Y6iVTTeshlbpORnHbVfYde17ndn1oi8CxCdyGPeltug/EgPYeu+Huue8qXIG1FF0P+1/QE
 OkI4MFeIUyV9CIYVFhzufJVxn8HHs5i26d0rVH1jBwAt+8BO5kc+cNzWSMKYdaRVgV2scxI+ny+G+
 Wx4ZTWnSMg86Ie6pICfmg6HCsUzfLYDchz8liDQCBYyTo+POARPZOFYLKVhnbMr8FAxNbCCaSL5ho
 5wuB4g8tw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1giI9Q-0004Q7-1d; Sat, 12 Jan 2019 12:12:32 +0000
Date: Sat, 12 Jan 2019 04:12:31 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
Message-ID: <20190112121230.GQ6310@bombadil.infradead.org>
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: mark.rutland@arm.com, mhocko@suse.com, linux-sh@vger.kernel.org,
 peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kvmarm@lists.cs.columbia.edu, linux@armlinux.org.uk, mingo@redhat.com,
 vbabka@suse.cz, rientjes@google.com, marc.zyngier@arm.com,
 rppt@linux.vnet.ibm.com, shakeelb@google.com, kirill@shutemov.name,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org, robin.murphy@arm.com, steve.capper@arm.com,
 christoffer.dall@arm.com, james.morse@arm.com, aneesh.kumar@linux.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Jan 12, 2019 at 03:56:38PM +0530, Anshuman Khandual wrote:
> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
> __GFP_ZERO) and using it for allocating page table pages.

Except that's not true.

> +++ b/arch/x86/mm/pgtable.c
> @@ -13,19 +13,17 @@ phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
>  EXPORT_SYMBOL(physical_mask);
>  #endif
>  
> -#define PGALLOC_GFP (GFP_KERNEL_ACCOUNT | __GFP_ZERO)
> -
>  #ifdef CONFIG_HIGHPTE

...

>  pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>  {
> -	return (pte_t *)__get_free_page(PGALLOC_GFP & ~__GFP_ACCOUNT);
> +	return (pte_t *)__get_free_page(GFP_PGTABLE & ~__GFP_ACCOUNT);
>  }

I think x86 was the only odd one out here, but you'll need to try again ...
