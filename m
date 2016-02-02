Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-x233.google.com (mail-yk0-x233.google.com
 [IPv6:2607:f8b0:4002:c07::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D958C1A01D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 00:49:36 +1100 (AEDT)
Received: by mail-yk0-x233.google.com with SMTP id r207so138090870ykd.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Feb 2016 05:49:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1454045043-25545-4-git-send-email-david@gibson.dropbear.id.au>
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-4-git-send-email-david@gibson.dropbear.id.au>
Date: Tue, 2 Feb 2016 16:49:34 +0300
Message-ID: <CAOJe8K3ebax=_9_7aDWgNRG4c35QqX7dQOdJpaQgUqb6XmhAQg@mail.gmail.com>
Subject: Re: [RFCv2 3/9] arch/powerpc: Handle removing maybe-present bolted
 HPTEs
From: Denis Kirjanov <kda@linux-powerpc.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: paulus@samba.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 aik@ozlabs.ru, lvivier@redhat.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 1/29/16, David Gibson <david@gibson.dropbear.id.au> wrote:
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
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  arch/powerpc/include/asm/machdep.h    |  2 +-
>  arch/powerpc/mm/hash_utils_64.c       | 10 +++++++---
>  arch/powerpc/mm/init_64.c             |  9 +++++----
>  arch/powerpc/platforms/pseries/lpar.c |  7 +++++--
>  4 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/machdep.h
> b/arch/powerpc/include/asm/machdep.h
> index 3f191f5..a7d3f66 100644
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -54,7 +54,7 @@ struct machdep_calls {
>  				       int psize, int apsize,
>  				       int ssize);
>  	long		(*hpte_remove)(unsigned long hpte_group);
> -	void            (*hpte_removebolted)(unsigned long ea,
> +	long            (*hpte_removebolted)(unsigned long ea,
>  					     int psize, int ssize);
>  	void		(*flush_hash_range)(unsigned long number, int local);
>  	void		(*hugepage_invalidate)(unsigned long vsid,
> diff --git a/arch/powerpc/mm/hash_utils_64.c
> b/arch/powerpc/mm/hash_utils_64.c
> index 9f7d727..0737eae 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -269,6 +269,7 @@ int htab_remove_mapping(unsigned long vstart, unsigned
> long vend,
>  {
>  	unsigned long vaddr;
>  	unsigned int step, shift;
> +	int rc = 0;
>
>  	shift = mmu_psize_defs[psize].shift;
>  	step = 1 << shift;
> @@ -276,10 +277,13 @@ int htab_remove_mapping(unsigned long vstart, unsigned
> long vend,
>  	if (!ppc_md.hpte_removebolted)
>  		return -ENODEV;
>
> -	for (vaddr = vstart; vaddr < vend; vaddr += step)
> -		ppc_md.hpte_removebolted(vaddr, psize, ssize);
> +	for (vaddr = vstart; vaddr < vend; vaddr += step) {
> +		rc = ppc_md.hpte_removebolted(vaddr, psize, ssize);
but the function proto return type is long.

> +		if ((rc < 0) && (rc != -ENOENT))
> +			return rc;
> +	}
>
> -	return 0;
> +	return rc;
>  }
>  #endif /* CONFIG_MEMORY_HOTPLUG */
>
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index 379a6a9..baa1a23 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -232,10 +232,11 @@ static void __meminit vmemmap_create_mapping(unsigned
> long start,
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
> diff --git a/arch/powerpc/platforms/pseries/lpar.c
> b/arch/powerpc/platforms/pseries/lpar.c
> index 477290a..92d472d 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -505,7 +505,7 @@ static void pSeries_lpar_hugepage_invalidate(unsigned
> long vsid,
>  }
>  #endif
>
> -static void pSeries_lpar_hpte_removebolted(unsigned long ea,
> +static long pSeries_lpar_hpte_removebolted(unsigned long ea,
>  					   int psize, int ssize)
>  {
>  	unsigned long vpn;
> @@ -515,11 +515,14 @@ static void pSeries_lpar_hpte_removebolted(unsigned
> long ea,
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
