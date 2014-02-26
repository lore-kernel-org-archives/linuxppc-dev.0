Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 12ED82C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 05:39:12 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 27 Feb 2014 04:39:05 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 655942CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 05:39:02 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1QIcmfH6029602
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 05:38:49 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1QId1Ck008206
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 05:39:01 +1100
Date: Thu, 27 Feb 2014 00:08:48 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/crashdump : fix page frame number check in
 copy_oldmem_page
Message-ID: <20140226183848.GA7282@in.ibm.com>
References: <20140224163055.7263.86979.stgit@nimbus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140224163055.7263.86979.stgit@nimbus>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Reply-To: mahesh@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014-02-24 17:30:55 Mon, Laurent Dufour wrote:
> In copy_oldmem_page, the current check using max_pfn and min_low_pfn to
> decide if the page is backed or not, is not valid when the memory layout is
> not continuous.
> 
> This happens when running as a QEMU/KVM guest, where RTAS is mapped higher
> in the memory. In that case max_pfn points to the end of RTAS, and a hole
> between the end of the kdump kernel and RTAS is not backed by PTEs. As a
> consequence, the kdump kernel is crashing in copy_oldmem_page when accessing
> in a direct way the pages in that hole.
> 
> This fix relies on the memblock's service memblock_is_region_memory to
> check if the read page is part or not of the directly accessible memory.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Tested on PowerNV (BE), where without this patch we see cp and 
makedumpfile fails with "Bad address" while reading /proc/vmcore.
With this patch makedumpfile and cp succeeds.

Tested-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

> ---
>  arch/powerpc/kernel/crash_dump.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
> index 11c1d06..7a13f37 100644
> --- a/arch/powerpc/kernel/crash_dump.c
> +++ b/arch/powerpc/kernel/crash_dump.c
> @@ -98,17 +98,19 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
>  			size_t csize, unsigned long offset, int userbuf)
>  {
>  	void  *vaddr;
> +	phys_addr_t paddr;
>  
>  	if (!csize)
>  		return 0;
>  
>  	csize = min_t(size_t, csize, PAGE_SIZE);
> +	paddr = pfn << PAGE_SHIFT;
>  
> -	if ((min_low_pfn < pfn) && (pfn < max_pfn)) {
> -		vaddr = __va(pfn << PAGE_SHIFT);
> +	if (memblock_is_region_memory(paddr, csize)) {
> +		vaddr = __va(paddr);
>  		csize = copy_oldmem_vaddr(vaddr, buf, csize, offset, userbuf);
>  	} else {
> -		vaddr = __ioremap(pfn << PAGE_SHIFT, PAGE_SIZE, 0);
> +		vaddr = __ioremap(paddr, PAGE_SIZE, 0);
>  		csize = copy_oldmem_vaddr(vaddr, buf, csize, offset, userbuf);
>  		iounmap(vaddr);
>  	}
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
Mahesh J Salgaonkar
