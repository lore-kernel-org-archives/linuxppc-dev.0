Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD3D61A0993
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 13:48:55 +1000 (EST)
In-Reply-To: <1412073306-13812-10-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>, greg@kroah.com, arnd@arndb.de,
 benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 09/17] powerpc/mm: Add new hash_page_mm()
Message-Id: <20141002034855.8E3D514017E@ozlabs.org>
Date: Thu,  2 Oct 2014 13:48:55 +1000 (EST)
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, imunsie@au.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jk@ozlabs.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-30-09 at 10:34:58 UTC, Michael Neuling wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> This adds a new function hash_page_mm() based on the existing hash_page().
> This version allows any struct mm to be passed in, rather than assuming
> current.  This is useful for servicing co-processor faults which are not in the
> context of the current running process.

I'm not a big fan. hash_page() is already a train wreck, and this doesn't make
it any better.

> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index bbdb054..0a5c8c0 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -904,7 +904,7 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
>  		return;
>  	slice_set_range_psize(mm, addr, 1, MMU_PAGE_4K);
>  	copro_flush_all_slbs(mm);
> -	if (get_paca_psize(addr) != MMU_PAGE_4K) {
> +	if ((get_paca_psize(addr) != MMU_PAGE_4K) && (current->mm == mm)) {
>  		get_paca()->context = mm->context;
>  		slb_flush_and_rebolt();

This is a bit fishy.

If that mm is currently running on another cpu you just failed to update it's
paca. But I think the call to check_paca_psize() in hash_page() will save you
on that cpu.

In fact we might be able to remove that synchronisation from
demote_segment_4k() and always leave it up to check_paca_psize()?

> @@ -989,26 +989,24 @@ static void check_paca_psize(unsigned long ea, struct mm_struct *mm,
>   * -1 - critical hash insertion error
>   * -2 - access not permitted by subpage protection mechanism
>   */
> -int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
> +int hash_page_mm(struct mm_struct *mm, unsigned long ea, unsigned long access, unsigned long trap)
>  {
>  	enum ctx_state prev_state = exception_enter();
>  	pgd_t *pgdir;
>  	unsigned long vsid;
> -	struct mm_struct *mm;
>  	pte_t *ptep;
>  	unsigned hugeshift;
>  	const struct cpumask *tmp;
>  	int rc, user_region = 0, local = 0;
>  	int psize, ssize;
>  
> -	DBG_LOW("hash_page(ea=%016lx, access=%lx, trap=%lx\n",
> -		ea, access, trap);
> +	DBG_LOW("%s(ea=%016lx, access=%lx, trap=%lx\n",
> +		__func__, ea, access, trap);
>  
>  	/* Get region & vsid */
>   	switch (REGION_ID(ea)) {
>  	case USER_REGION_ID:
>  		user_region = 1;
> -		mm = current->mm;
>  		if (! mm) {
>  			DBG_LOW(" user region with no mm !\n");
>  			rc = 1;

What about the VMALLOC case where we do:
		mm = &init_mm;
		
Is that what you want? It seems odd that you pass an mm to the routine, but
then potentially it ends up using a different mm after all depending on the
address.


cheers
