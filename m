Return-Path: <SRS0=2k7H=2A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB72C43603
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 12:54:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6558E2073D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 12:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6558E2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47XKkZ1whNzDqcl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 23:53:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.cz
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47XKf35k9xzDqP5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2019 23:50:03 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E26C9AF76;
 Tue, 10 Dec 2019 12:49:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id 84F101E0B23; Tue, 10 Dec 2019 13:49:57 +0100 (CET)
Date: Tue, 10 Dec 2019 13:49:57 +0100
From: Jan Kara <jack@suse.cz>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v8 23/26] mm/gup: pass flags arg to __gup_device_*
 functions
Message-ID: <20191210124957.GG1551@quack2.suse.cz>
References: <20191209225344.99740-1-jhubbard@nvidia.com>
 <20191209225344.99740-24-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191209225344.99740-24-jhubbard@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 David Airlie <airlied@linux.ie>, Dave Chinner <david@fromorbit.com>,
 dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 linux-kselftest@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-rdma@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Vlastimil Babka <vbabka@suse.cz>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
 linux-media@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-block@vger.kernel.org,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, bpf@vger.kernel.org,
 Magnus Karlsson <magnus.karlsson@intel.com>, Jens Axboe <axboe@kernel.dk>,
 netdev@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon 09-12-19 14:53:41, John Hubbard wrote:
> A subsequent patch requires access to gup flags, so pass the flags
> argument through to the __gup_device_* functions.
> 
> Also placate checkpatch.pl by shortening a nearby line.
> 
> TODO: Christoph Hellwig requested folding this into the patch the uses
> the gup flags arguments.

You should probably implement this TODO? :)

								Honza

> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/gup.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 73aedcefa4bd..687d48506f04 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1957,7 +1957,8 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  
>  #if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
>  static int __gup_device_huge(unsigned long pfn, unsigned long addr,
> -		unsigned long end, struct page **pages, int *nr)
> +			     unsigned long end, unsigned int flags,
> +			     struct page **pages, int *nr)
>  {
>  	int nr_start = *nr;
>  	struct dev_pagemap *pgmap = NULL;
> @@ -1983,13 +1984,14 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
>  }
>  
>  static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
> -		unsigned long end, struct page **pages, int *nr)
> +				 unsigned long end, unsigned int flags,
> +				 struct page **pages, int *nr)
>  {
>  	unsigned long fault_pfn;
>  	int nr_start = *nr;
>  
>  	fault_pfn = pmd_pfn(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
> -	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr))
> +	if (!__gup_device_huge(fault_pfn, addr, end, flags, pages, nr))
>  		return 0;
>  
>  	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
> @@ -2000,13 +2002,14 @@ static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  }
>  
>  static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
> -		unsigned long end, struct page **pages, int *nr)
> +				 unsigned long end, unsigned int flags,
> +				 struct page **pages, int *nr)
>  {
>  	unsigned long fault_pfn;
>  	int nr_start = *nr;
>  
>  	fault_pfn = pud_pfn(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
> -	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr))
> +	if (!__gup_device_huge(fault_pfn, addr, end, flags, pages, nr))
>  		return 0;
>  
>  	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
> @@ -2017,14 +2020,16 @@ static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  }
>  #else
>  static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
> -		unsigned long end, struct page **pages, int *nr)
> +				 unsigned long end, unsigned int flags,
> +				 struct page **pages, int *nr)
>  {
>  	BUILD_BUG();
>  	return 0;
>  }
>  
>  static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long addr,
> -		unsigned long end, struct page **pages, int *nr)
> +				 unsigned long end, unsigned int flags,
> +				 struct page **pages, int *nr)
>  {
>  	BUILD_BUG();
>  	return 0;
> @@ -2136,7 +2141,8 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  	if (pmd_devmap(orig)) {
>  		if (unlikely(flags & FOLL_LONGTERM))
>  			return 0;
> -		return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr);
> +		return __gup_device_huge_pmd(orig, pmdp, addr, end, flags,
> +					     pages, nr);
>  	}
>  
>  	page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
> @@ -2157,7 +2163,8 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  }
>  
>  static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
> -		unsigned long end, unsigned int flags, struct page **pages, int *nr)
> +			unsigned long end, unsigned int flags,
> +			struct page **pages, int *nr)
>  {
>  	struct page *head, *page;
>  	int refs;
> @@ -2168,7 +2175,8 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  	if (pud_devmap(orig)) {
>  		if (unlikely(flags & FOLL_LONGTERM))
>  			return 0;
> -		return __gup_device_huge_pud(orig, pudp, addr, end, pages, nr);
> +		return __gup_device_huge_pud(orig, pudp, addr, end, flags,
> +					     pages, nr);
>  	}
>  
>  	page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
> -- 
> 2.24.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
