Return-Path: <benh@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 551732C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2013 14:13:13 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 4 Dec 2013 13:13:12 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F0BBC3578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2013 14:13:03 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB43Cpcx3604836
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Dec 2013 14:12:51 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB43D3vv002675
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Dec 2013 14:13:03 +1100
Message-ID: <1386126782.16703.137.camel@pasglop>
Subject: Re: [PATCH -V2 3/5] mm: Move change_prot_numa outside
 CONFIG_ARCH_USES_NUMA_PROT_NONE
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 04 Dec 2013 14:13:02 +1100
In-Reply-To: <1384766893-10189-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1384766893-10189-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1384766893-10189-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mm@kvack.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-11-18 at 14:58 +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> change_prot_numa should work even if _PAGE_NUMA != _PAGE_PROTNONE.
> On archs like ppc64 that don't use _PAGE_PROTNONE and also have
> a separate page table outside linux pagetable, we just need to
> make sure that when calling change_prot_numa we flush the
> hardware page table entry so that next page access  result in a numa
> fault.

That patch doesn't look right...

You are essentially making change_prot_numa() do whatever it does (which
I don't completely understand) *for all architectures* now, whether they
have CONFIG_ARCH_USES_NUMA_PROT_NONE or not ... So because you want that
behaviour on powerpc book3s64, you change everybody.

Is that correct ?

Also what exactly is that doing, can you explain ? From what I can see,
it calls back into the core of mprotect to change the protection to
vma->vm_page_prot, which I would have expected is already the protection
there, with the added "prot_numa" flag passed down.

Your changeset comment says "On archs like ppc64 [...] we just need to
make sure that when calling change_prot_numa we flush the
hardware page table entry so that next page access  result in a numa
fault."

But change_prot_numa() does a lot more than that ... it does
pte_mknuma(), do we need it ? I assume we do or we wouldn't have added
that PTE bit to begin with...

Now it *might* be allright and it might be that no other architecture
cares anyway etc... but I need at least some mm folks to ack on that
patch before I can take it because it *will* change behaviour of other
architectures.

Cheers,
Ben.

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  include/linux/mm.h | 3 ---
>  mm/mempolicy.c     | 9 ---------
>  2 files changed, 12 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0548eb201e05..51794c1a1d7e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1851,11 +1851,8 @@ static inline pgprot_t vm_get_page_prot(unsigned long vm_flags)
>  }
>  #endif
>  
> -#ifdef CONFIG_ARCH_USES_NUMA_PROT_NONE
>  unsigned long change_prot_numa(struct vm_area_struct *vma,
>  			unsigned long start, unsigned long end);
> -#endif
> -
>  struct vm_area_struct *find_extend_vma(struct mm_struct *, unsigned long addr);
>  int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
>  			unsigned long pfn, unsigned long size, pgprot_t);
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index c4403cdf3433..cae10af4fdc4 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -613,7 +613,6 @@ static inline int queue_pages_pgd_range(struct vm_area_struct *vma,
>  	return 0;
>  }
>  
> -#ifdef CONFIG_ARCH_USES_NUMA_PROT_NONE
>  /*
>   * This is used to mark a range of virtual addresses to be inaccessible.
>   * These are later cleared by a NUMA hinting fault. Depending on these
> @@ -627,7 +626,6 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
>  			unsigned long addr, unsigned long end)
>  {
>  	int nr_updated;
> -	BUILD_BUG_ON(_PAGE_NUMA != _PAGE_PROTNONE);
>  
>  	nr_updated = change_protection(vma, addr, end, vma->vm_page_prot, 0, 1);
>  	if (nr_updated)
> @@ -635,13 +633,6 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
>  
>  	return nr_updated;
>  }
> -#else
> -static unsigned long change_prot_numa(struct vm_area_struct *vma,
> -			unsigned long addr, unsigned long end)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_ARCH_USES_NUMA_PROT_NONE */
>  
>  /*
>   * Walk through page tables and collect pages to be migrated.
