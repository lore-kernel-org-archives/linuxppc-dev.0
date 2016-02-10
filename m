Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D03581A0549
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 19:56:56 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 10 Feb 2016 01:56:55 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E5CAA19D8042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 01:44:49 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1A8uptU30408838
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 01:56:51 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1A8uoe0030887
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 01:56:51 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>, mpe@ellerman.id.au,
 paulus@samba.org, benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/4] powerpc/mm: Clean up error handling for
 htab_remove_mapping
In-Reply-To: <1454988763-5580-2-git-send-email-david@gibson.dropbear.id.au>
References: <1454988763-5580-1-git-send-email-david@gibson.dropbear.id.au>
 <1454988763-5580-2-git-send-email-david@gibson.dropbear.id.au>
Date: Wed, 10 Feb 2016 14:26:46 +0530
Message-ID: <87a8n9x7sh.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Gibson <david@gibson.dropbear.id.au> writes:

> Currently, the only error that htab_remove_mapping() can report is -EINVAL,
> if removal of bolted HPTEs isn't implemeted for this platform.  We make
> a few clean ups to the handling of this:
>
>  * EINVAL isn't really the right code - there's nothing wrong with the
>    function's arguments - use ENODEV instead
>  * We were also printing a warning message, but that's a decision better
>    left up to the callers, so remove it
>  * One caller is vmemmap_remove_mapping(), which will just BUG_ON() on
>    error, making the warning message redundant, so no change is needed
>    there.
>  * The other caller is remove_section_mapping().  This is called in the
>    memory hot remove path at a point after vmemmap_remove_mapping() so
>    if hpte_removebolted isn't implemented, we'd expect to have already
>    BUG()ed anyway.  Put a WARN_ON() here, in lieu of a printk() since this
>    really shouldn't be happening.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  arch/powerpc/mm/hash_utils_64.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index ba59d59..9f7d727 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -273,11 +273,8 @@ int htab_remove_mapping(unsigned long vstart, unsigned long vend,
>  	shift = mmu_psize_defs[psize].shift;
>  	step = 1 << shift;
>  
> -	if (!ppc_md.hpte_removebolted) {
> -		printk(KERN_WARNING "Platform doesn't implement "
> -				"hpte_removebolted\n");
> -		return -EINVAL;
> -	}
> +	if (!ppc_md.hpte_removebolted)
> +		return -ENODEV;
>  
>  	for (vaddr = vstart; vaddr < vend; vaddr += step)
>  		ppc_md.hpte_removebolted(vaddr, psize, ssize);
> @@ -641,8 +638,10 @@ int create_section_mapping(unsigned long start, unsigned long end)
>  
>  int remove_section_mapping(unsigned long start, unsigned long end)
>  {
> -	return htab_remove_mapping(start, end, mmu_linear_psize,
> -			mmu_kernel_ssize);
> +	int rc = htab_remove_mapping(start, end, mmu_linear_psize,
> +				     mmu_kernel_ssize);
> +	WARN_ON(rc < 0);
> +	return rc;
>  }
>  #endif /* CONFIG_MEMORY_HOTPLUG */
>  
> -- 
> 2.5.0
