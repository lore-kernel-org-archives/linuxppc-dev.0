Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 214EA1A1969
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 15:20:03 +1000 (AEST)
Message-ID: <5590D581.1020903@ozlabs.org>
Date: Mon, 29 Jun 2015 13:20:01 +0800
From: Jeremy Kerr <jk@ozlabs.org>
MIME-Version: 1.0
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RESEND PATCH] powerpc/powernv: Fix vma page prot flags in
 opal-prd driver
References: <20150629051150.17663.63753.stgit@drishya>
In-Reply-To: <20150629051150.17663.63753.stgit@drishya>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Vaidy,

> opal-prd driver will mmap() firmware code/data area as private
> mapping to prd user space daemon.  Write to this page will
> trigger COW faults.  The new COW pages are normal kernel RAM
> pages accounted by the kernel and are not special.
> 
> vma->vm_page_prot value will be used at page fault time
> for the new COW pages, while pgprot_t value passed in
> remap_pfn_range() is used for the initial page table entry.
> 
> Hence:
> * Do not add _PAGE_SPECIAL in vma, but only for remap_pfn_range()
> * Also remap_pfn_range() will add the _PAGE_SPECIAL flag using
>   pte_mkspecial() call, hence no need to specify in the driver
> 
> This fix resolves the page accounting warning shown below:
> BUG: Bad rss-counter state mm:c0000007d34ac600 idx:1 val:19
> 
> The above warning is triggered since _PAGE_SPECIAL was incorrectly
> being set for the normal kernel COW pages.
> 
> Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

Acked-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy
