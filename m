Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRTW22ynjzDqKY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:24:14 +1000 (AEST)
Subject: Re: [v3 9/9] s390: teach platforms not to zero struct pages memory
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, borntraeger@de.ibm.com, davem@davemloft.net
References: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
 <1494003796-748672-10-git-send-email-pasha.tatashin@oracle.com>
 <20170508113624.GA4876@osiris>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <0669a945-4540-096e-799a-2d2b3c18abaa@oracle.com>
Date: Mon, 15 May 2017 14:24:00 -0400
MIME-Version: 1.0
In-Reply-To: <20170508113624.GA4876@osiris>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Heiko,

Thank you for looking at this patch. I am worried to make the proposed 
change, because, as I understand in this case we allocate memory not for 
"struct page"s but for table that hold them. So, we will change the 
behavior from the current one, where this table is allocated zeroed, but 
now it won't be zeroed.

Pasha

> 
> If you add the hunk below then this is
> 
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index ffe9ba1aec8b..bf88a8b9c24d 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -272,7 +272,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
>   		if (pte_none(*pt_dir)) {
>   			void *new_page;
>   
> -			new_page = vmemmap_alloc_block(PAGE_SIZE, node, true);
> +			new_page = vmemmap_alloc_block(PAGE_SIZE, node, VMEMMAP_ZERO);
>   			if (!new_page)
>   				goto out;
>   			pte_val(*pt_dir) = __pa(new_page) | pgt_prot;
> 
