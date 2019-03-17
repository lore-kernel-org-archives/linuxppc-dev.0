Return-Path: <SRS0=npwJ=RU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D034DC43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Mar 2019 18:33:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49449206DF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Mar 2019 18:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="YvwQjpyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49449206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Mnxq4rvFzDqPy
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 05:33:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="YvwQjpyZ"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44MnvY4MfyzDqNx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 05:31:19 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44MnvN2V0Qz9vRZS;
 Sun, 17 Mar 2019 19:31:12 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=YvwQjpyZ; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id JVw08tBD8Gwx; Sun, 17 Mar 2019 19:31:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44MnvN15cKz9vRZR;
 Sun, 17 Mar 2019 19:31:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552847472; bh=BXWMF2so+GLHhzxMK3cXtfcsNw0MoLzViFfxI4ru5i8=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=YvwQjpyZoMN/ofSSY26zJgdbyA2a0Fdv/idbTQ6ve1SVr0vjTC20l/cgySuLaXF+w
 sBNsozz5jNWIuUX2VFJFtr1Yme5JnXfQP5Dps3uL2P3CjEpE1UgWNGk+GFVrnalDOv
 R/eIwZ7KV70PPTrXczk3tfNozRQ8JC357GmuvVsc=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A25F58B84D;
 Sun, 17 Mar 2019 19:31:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id mKLCnS-MMo5Y; Sun, 17 Mar 2019 19:31:15 +0100 (CET)
Received: from [192.168.232.53] (unknown [192.168.232.53])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 213188B750;
 Sun, 17 Mar 2019 19:31:14 +0100 (CET)
Subject: Re: [PATCH v7 4/4] hugetlb: allow to free gigantic pages regardless
 of the configuration
To: Alexandre Ghiti <alex@ghiti.fr>, aneesh.kumar@linux.ibm.com,
 mpe@ellerman.id.au, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S . Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
References: <20190317162847.14107-1-alex@ghiti.fr>
 <20190317162847.14107-5-alex@ghiti.fr>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <f434892d-80b2-f09d-31d6-754a1be0b97a@c-s.fr>
Date: Sun, 17 Mar 2019 19:31:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190317162847.14107-5-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 190317-2, 17/03/2019), Outbound message
X-Antivirus-Status: Clean
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 17/03/2019 à 17:28, Alexandre Ghiti a écrit :
> On systems without CONTIG_ALLOC activated but that support gigantic pages,
> boottime reserved gigantic pages can not be freed at all. This patch
> simply enables the possibility to hand back those pages to memory
> allocator.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Acked-by: David S. Miller <davem@davemloft.net> [sparc]
> ---
>   arch/arm64/Kconfig                           |  2 +-
>   arch/arm64/include/asm/hugetlb.h             |  4 --
>   arch/powerpc/include/asm/book3s/64/hugetlb.h |  7 ---
>   arch/powerpc/platforms/Kconfig.cputype       |  2 +-
>   arch/s390/Kconfig                            |  2 +-
>   arch/s390/include/asm/hugetlb.h              |  3 --
>   arch/sh/Kconfig                              |  2 +-
>   arch/sparc/Kconfig                           |  2 +-
>   arch/x86/Kconfig                             |  2 +-
>   arch/x86/include/asm/hugetlb.h               |  4 --
>   include/asm-generic/hugetlb.h                | 14 +++++
>   include/linux/gfp.h                          |  2 +-
>   mm/hugetlb.c                                 | 54 ++++++++++++++------
>   mm/page_alloc.c                              |  4 +-
>   14 files changed, 61 insertions(+), 43 deletions(-)
> 

[...]

> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index 71d7b77eea50..aaf14974ee5f 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -126,4 +126,18 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
>   }
>   #endif
>   
> +#ifndef __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
> +#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
> +static inline bool gigantic_page_runtime_supported(void)
> +{
> +	return true;
> +}
> +#else
> +static inline bool gigantic_page_runtime_supported(void)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_ARCH_HAS_GIGANTIC_PAGE */

What about the following instead:

static inline bool gigantic_page_runtime_supported(void)
{
	return IS_ENABLED(CONFIG_ARCH_HAS_GIGANTIC_PAGE);
}


> +#endif /* __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED */
> +
>   #endif /* _ASM_GENERIC_HUGETLB_H */
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 1f1ad9aeebb9..58ea44bf75de 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -589,8 +589,8 @@ static inline bool pm_suspended_storage(void)
>   /* The below functions must be run on a range from a single zone. */
>   extern int alloc_contig_range(unsigned long start, unsigned long end,
>   			      unsigned migratetype, gfp_t gfp_mask);
> -extern void free_contig_range(unsigned long pfn, unsigned nr_pages);
>   #endif
> +extern void free_contig_range(unsigned long pfn, unsigned int nr_pages);

'extern' is unneeded and should be avoided (iaw checkpatch)

Christophe

>   
>   #ifdef CONFIG_CMA
>   /* CMA stuff */
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index afef61656c1e..4e55aa38704f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1058,6 +1058,7 @@ static void free_gigantic_page(struct page *page, unsigned int order)
>   	free_contig_range(page_to_pfn(page), 1 << order);
>   }
>   
> +#ifdef CONFIG_CONTIG_ALLOC
>   static int __alloc_gigantic_page(unsigned long start_pfn,
>   				unsigned long nr_pages, gfp_t gfp_mask)
>   {
> @@ -1142,11 +1143,20 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
>   
>   static void prep_new_huge_page(struct hstate *h, struct page *page, int nid);
>   static void prep_compound_gigantic_page(struct page *page, unsigned int order);
> +#else /* !CONFIG_CONTIG_ALLOC */
> +static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
> +					int nid, nodemask_t *nodemask)
> +{
> +	return NULL;
> +}
> +#endif /* CONFIG_CONTIG_ALLOC */
>   
>   #else /* !CONFIG_ARCH_HAS_GIGANTIC_PAGE */
> -static inline bool gigantic_page_supported(void) { return false; }
>   static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
> -		int nid, nodemask_t *nodemask) { return NULL; }
> +					int nid, nodemask_t *nodemask)
> +{
> +	return NULL;
> +}
>   static inline void free_gigantic_page(struct page *page, unsigned int order) { }
>   static inline void destroy_compound_gigantic_page(struct page *page,
>   						unsigned int order) { }
> @@ -1156,7 +1166,7 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>   {
>   	int i;
>   
> -	if (hstate_is_gigantic(h) && !gigantic_page_supported())
> +	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>   		return;
>   
>   	h->nr_huge_pages--;
> @@ -2276,13 +2286,27 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
>   }
>   
>   #define persistent_huge_pages(h) (h->nr_huge_pages - h->surplus_huge_pages)
> -static unsigned long set_max_huge_pages(struct hstate *h, unsigned long count,
> -						nodemask_t *nodes_allowed)
> +static int set_max_huge_pages(struct hstate *h, unsigned long count,
> +			      nodemask_t *nodes_allowed)
>   {
>   	unsigned long min_count, ret;
>   
> -	if (hstate_is_gigantic(h) && !gigantic_page_supported())
> -		return h->max_huge_pages;
> +	spin_lock(&hugetlb_lock);
> +
> +	/*
> +	 * Gigantic pages runtime allocation depend on the capability for large
> +	 * page range allocation.
> +	 * If the system does not provide this feature, return an error when
> +	 * the user tries to allocate gigantic pages but let the user free the
> +	 * boottime allocated gigantic pages.
> +	 */
> +	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
> +		if (count > persistent_huge_pages(h)) {
> +			spin_unlock(&hugetlb_lock);
> +			return -EINVAL;
> +		}
> +		/* Fall through to decrease pool */
> +	}
>   
>   	/*
>   	 * Increase the pool size
> @@ -2295,7 +2319,6 @@ static unsigned long set_max_huge_pages(struct hstate *h, unsigned long count,
>   	 * pool might be one hugepage larger than it needs to be, but
>   	 * within all the constraints specified by the sysctls.
>   	 */
> -	spin_lock(&hugetlb_lock);
>   	while (h->surplus_huge_pages && count > persistent_huge_pages(h)) {
>   		if (!adjust_pool_surplus(h, nodes_allowed, -1))
>   			break;
> @@ -2350,9 +2373,10 @@ static unsigned long set_max_huge_pages(struct hstate *h, unsigned long count,
>   			break;
>   	}
>   out:
> -	ret = persistent_huge_pages(h);
> +	h->max_huge_pages = persistent_huge_pages(h);
>   	spin_unlock(&hugetlb_lock);
> -	return ret;
> +
> +	return 0;
>   }
>   
>   #define HSTATE_ATTR_RO(_name) \
> @@ -2404,7 +2428,7 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>   	int err;
>   	NODEMASK_ALLOC(nodemask_t, nodes_allowed, GFP_KERNEL | __GFP_NORETRY);
>   
> -	if (hstate_is_gigantic(h) && !gigantic_page_supported()) {
> +	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported()) {
>   		err = -EINVAL;
>   		goto out;
>   	}
> @@ -2428,15 +2452,13 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>   	} else
>   		nodes_allowed = &node_states[N_MEMORY];
>   
> -	h->max_huge_pages = set_max_huge_pages(h, count, nodes_allowed);
> +	err = set_max_huge_pages(h, count, nodes_allowed);
>   
> +out:
>   	if (nodes_allowed != &node_states[N_MEMORY])
>   		NODEMASK_FREE(nodes_allowed);
>   
> -	return len;
> -out:
> -	NODEMASK_FREE(nodes_allowed);
> -	return err;
> +	return err ? err : len;
>   }
>   
>   static ssize_t nr_hugepages_store_common(bool obey_mempolicy,
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ac9c45ffb344..a4547d90fa7a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8234,8 +8234,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>   				pfn_max_align_up(end), migratetype);
>   	return ret;
>   }
> +#endif /* CONFIG_CONTIG_ALLOC */
>   
> -void free_contig_range(unsigned long pfn, unsigned nr_pages)
> +void free_contig_range(unsigned long pfn, unsigned int nr_pages)
>   {
>   	unsigned int count = 0;
>   
> @@ -8247,7 +8248,6 @@ void free_contig_range(unsigned long pfn, unsigned nr_pages)
>   	}
>   	WARN(count != 0, "%d pages are still in use!\n", count);
>   }
> -#endif
>   
>   #ifdef CONFIG_MEMORY_HOTPLUG
>   /*
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

