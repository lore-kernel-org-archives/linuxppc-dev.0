Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6E8D5DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 07:59:49 +1000 (EST)
Subject: Re: [BUG] 2.6.30-rc3: BUG triggered on some hugepage usages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mel Gorman <mel@csn.ul.ie>
In-Reply-To: <20090430205919.GA24279@csn.ul.ie>
References: <alpine.LFD.2.00.0904212014170.3101@localhost.localdomain>
	<20090424095116.GB14283@csn.ul.ie>
	<1240586690.12551.31.camel@localhost>
	<20090430205919.GA24279@csn.ul.ie>
Content-Type: text/plain
Date: Fri, 01 May 2009 07:48:46 +1000
Message-Id: <1241128126.29501.48.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-30 at 21:59 +0100, Mel Gorman wrote:

> This patch fixes the problem by not asseting the PTE is locked for VMAs
> backed by huge pages.

Thanks, will apply.

Cheers,
Ben.

> Signed-off-by: Mel Gorman <mel@csn.ul.ie>
> --- 
>  arch/powerpc/mm/pgtable.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index f5c6fd4..ae1d67c 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -219,7 +219,8 @@ int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
>  		entry = do_dcache_icache_coherency(entry);
>  	changed = !pte_same(*(ptep), entry);
>  	if (changed) {
> -		assert_pte_locked(vma->vm_mm, address);
> +		if (!(vma->vm_flags & VM_HUGETLB))
> +			assert_pte_locked(vma->vm_mm, address);
>  		__ptep_set_access_flags(ptep, entry);
>  		flush_tlb_page_nohash(vma, address);
>  	}
