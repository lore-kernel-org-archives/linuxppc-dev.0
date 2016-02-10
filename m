Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 08FAD1A03A1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 19:58:52 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 10 Feb 2016 01:58:51 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 626871FF0046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 01:46:58 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1A8wmqN29098148
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 01:58:48 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1A8wltG015783
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 01:58:48 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>, mpe@ellerman.id.au,
 paulus@samba.org, benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/4] powerpc/mm: Handle removing maybe-present bolted HPTEs
In-Reply-To: <1454988763-5580-3-git-send-email-david@gibson.dropbear.id.au>
References: <1454988763-5580-1-git-send-email-david@gibson.dropbear.id.au>
 <1454988763-5580-3-git-send-email-david@gibson.dropbear.id.au>
Date: Wed, 10 Feb 2016 14:28:43 +0530
Message-ID: <877fidx7p8.fsf@linux.vnet.ibm.com>
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

> At the moment the hpte_removebolted callback in ppc_md returns void and
> will BUG_ON() if the hpte it's asked to remove doesn't exist in the first
> place.  This is awkward for the case of cleaning up a mapping which was
> partially made before failing.
>
> So, we add a return value to hpte_removebolted, and have it return ENOENT
> in the case that the HPTE to remove didn't exist in the first place.
>
> In the (sole) caller, we propagate errors in hpte_removebolted to its
> caller to handle.  However, we handle ENOENT specially, continuing to
> complete the unmapping over the specified range before returning the error
> to the caller.
>
> This means that htab_remove_mapping() will work sanely on a partially
> present mapping, removing any HPTEs which are present, while also returning
> ENOENT to its caller in case it's important there.
>
> There are two callers of htab_remove_mapping():
>    - In remove_section_mapping() we already WARN_ON() any error return,
>      which is reasonable - in this case the mapping should be fully
>      present
>    - In vmemmap_remove_mapping() we BUG_ON() any error.  We change that to
>      just a WARN_ON() in the case of ENOENT, since failing to remove a
>      mapping that wasn't there in the first place probably shouldn't be
>      fatal.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  arch/powerpc/include/asm/machdep.h    |  2 +-
>  arch/powerpc/mm/hash_utils_64.c       | 15 ++++++++++++---
>  arch/powerpc/mm/init_64.c             |  9 +++++----
>  arch/powerpc/platforms/pseries/lpar.c |  9 ++++++---
>  4 files changed, 24 insertions(+), 11 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
> index 3f191f5..fa25643 100644
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -54,7 +54,7 @@ struct machdep_calls {
>  				       int psize, int apsize,
>  				       int ssize);
>  	long		(*hpte_remove)(unsigned long hpte_group);
> -	void            (*hpte_removebolted)(unsigned long ea,
> +	int             (*hpte_removebolted)(unsigned long ea,
>  					     int psize, int ssize);
>  	void		(*flush_hash_range)(unsigned long number, int local);
>  	void		(*hugepage_invalidate)(unsigned long vsid,
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 9f7d727..99fbee0 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -269,6 +269,8 @@ int htab_remove_mapping(unsigned long vstart, unsigned long vend,
>  {
>  	unsigned long vaddr;
>  	unsigned int step, shift;
> +	int rc;
> +	int ret = 0;
>  
>  	shift = mmu_psize_defs[psize].shift;
>  	step = 1 << shift;
> @@ -276,10 +278,17 @@ int htab_remove_mapping(unsigned long vstart, unsigned long vend,
>  	if (!ppc_md.hpte_removebolted)
>  		return -ENODEV;
>  
> -	for (vaddr = vstart; vaddr < vend; vaddr += step)
> -		ppc_md.hpte_removebolted(vaddr, psize, ssize);
> +	for (vaddr = vstart; vaddr < vend; vaddr += step) {
> +		rc = ppc_md.hpte_removebolted(vaddr, psize, ssize);
> +		if (rc == -ENOENT) {
> +			ret = -ENOENT;
> +			continue;
> +		}
> +		if (rc < 0)
> +			return rc;
> +	}
>  
> -	return 0;
> +	return ret;
>  }
>  #endif /* CONFIG_MEMORY_HOTPLUG */
>  
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index 379a6a9..baa1a23 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -232,10 +232,11 @@ static void __meminit vmemmap_create_mapping(unsigned long start,
>  static void vmemmap_remove_mapping(unsigned long start,
>  				   unsigned long page_size)
>  {
> -	int mapped = htab_remove_mapping(start, start + page_size,
> -					 mmu_vmemmap_psize,
> -					 mmu_kernel_ssize);
> -	BUG_ON(mapped < 0);
> +	int rc = htab_remove_mapping(start, start + page_size,
> +				     mmu_vmemmap_psize,
> +				     mmu_kernel_ssize);
> +	BUG_ON((rc < 0) && (rc != -ENOENT));
> +	WARN_ON(rc == -ENOENT);
>  }
>  #endif
>  
> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
> index 477290a..2415a0d 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -505,8 +505,8 @@ static void pSeries_lpar_hugepage_invalidate(unsigned long vsid,
>  }
>  #endif
>  
> -static void pSeries_lpar_hpte_removebolted(unsigned long ea,
> -					   int psize, int ssize)
> +static int pSeries_lpar_hpte_removebolted(unsigned long ea,
> +					  int psize, int ssize)
>  {
>  	unsigned long vpn;
>  	unsigned long slot, vsid;
> @@ -515,11 +515,14 @@ static void pSeries_lpar_hpte_removebolted(unsigned long ea,
>  	vpn = hpt_vpn(ea, vsid, ssize);
>  
>  	slot = pSeries_lpar_hpte_find(vpn, psize, ssize);
> -	BUG_ON(slot == -1);
> +	if (slot == -1)
> +		return -ENOENT;
> +
>  	/*
>  	 * lpar doesn't use the passed actual page size
>  	 */
>  	pSeries_lpar_hpte_invalidate(slot, vpn, psize, 0, ssize, 0);
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.5.0
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
