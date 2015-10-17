Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A76231A0762
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2015 00:23:05 +1100 (AEDT)
Message-ID: <1445088167.24309.58.camel@kernel.crashing.org>
Subject: Re: [PATCH V4 00/31] powerpc/mm: Update page table format for
 book3s 64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au, Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Sat, 17 Oct 2015 18:52:47 +0530
In-Reply-To: <1445076522-20527-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1445076522-20527-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-10-17 at 15:38 +0530, Aneesh Kumar K.V wrote:
> Hi All,
> 
> This patch series attempt to update book3s 64 linux page table format to
> make it more flexible. Our current pte format is very restrictive and we
> overload multiple pte bits. This is due to the non-availability of free bits
> in pte_t. We use pte_t to track the validity of 4K subpages. This patch
> series free up pte_t of 11 bits by moving 4K subpage tracking to the
> lower half of PTE page. The pte format is updated such that we have a
> better method for identifying a pte entry at pmd level. This will also enable
> us to implement hugetlb migration(not yet done in this series). 

I still have serious concerns about the fact that we now use 4 times
more memory for page tables than strictly necessary. We were using
twice as much before.

We need to find a way to not allocate all those "other halves" when not
needed.

I understand it's tricky, we tend to notice we need the second half too
late...

Maybe if we could escalate the hash miss into a minor fault when the
second half is needed and not present, we can then allocate it from the

For demotion of the vmap space, we might have to be a bit smarter,
maybe detect at ioremap/vmap time and flag the mm as needed second
halves for everything (and allocate them).

Of course if the machine doesn't do hw 64k, we would always allocate
the second half.

The question then becomes how to reference it from the first half.

A completely parallel tree means a lot more walks for each PTE, is
there something in the PTE page's struct page we can use maybe ?

> efore making the changes to the pte format, I am splitting the
> pte header definition such that we now have the below layout for headers
> 
> book3s
>    32
>      hash.h pgtable.h 
>    64
>      hash.h  pgtable.h hash-4k.h hash-64k.h
> booke
>   32
>      pgtable.h pte-40x.h pte-44x.h pte-8xx.h pte-fsl-booke.h
>   64
>     pgtable-4k.h  pgtable-64k.h  pgtable.h
> 
> I have done the header split such that booke headers and modified to the minimum so as to avoid
> causing breakage in booke.
> 
> The patch series can also be found at
> https://github.com/kvaneesh/linux.git book3s-pte-format 
> https://github.com/kvaneesh/linux/commits/book3s-pte-format
> 
> 
> Performance numbers with and without patch series.
> 
> Path length __hash_page_4k
> with patch: 196
> without patch: 142
> 
> Path length __hash_page_64k
> with patch: 219
> without patch: 154
> 
> But even if we have a path lengh increase of around 50 instructions. We don't see
> the impact when running workload. I tried the kernelbuild test. 
> 
> With THP enabled (which is default) we see an improvement. I haven't fully looked at
> the reason. This could be due to reduced contention of ptl lock. __hash_thp_page is
> already a C code.
> 
> make -j64 vmlinux modules 
> With fix:
> ---------
> real    1m35.509s
> user    56m8.565s
> sys     4m34.973s
> 
> real    1m32.174s
> user    57m2.336s
> sys     4m39.142s
> 
> Without fix:
> ---------------
> real    1m37.703s
> user    58m50.783s
> sys     7m52.440s
> 
> real    1m37.890s
> user    57m55.445s
> sys     7m50.501s
> 
> THP disabled:
> 
> make -j64 vmlinux modules 
> With fix:
> ---------
> real    1m37.197s
> user    58m28.672s
> sys     7m58.188s
> 
> real    1m44.638s
> user    58m37.551s
> sys     7m53.960s
> 
> Without fix:
> ------------
> real    1m41.224s
> user    58m46.944s
> sys     7m49.714s
> 
> real    1m42.585s
> user    59m14.019s
> sys     7m52.714s
> 
> 
> Changes from V3:
> * Add missing #define pgprot_*
> * Add Acked-by
> 
> Changes from V2:
> * rebase to -next for powerpc tree
> 
> Changes from V1:
> 1) Build fix with STRICT_MM_TYPES enabled 
> 2) pte_mkwrite fix for nohash
> 3) rebase to latest linus tree.
> 
> 
> Aneesh Kumar K.V (31):
>   powerpc/mm: move pte headers to book3s directory
>   powerpc/mm: move pte headers to book3s directory (part 2)
>   powerpc/mm: make a separate copy for book3s
>   powerpc/mm: make a separate copy for book3s (part 2)
>   powerpc/mm: Move hash specific pte width and other defines to book3s
>   powerpc/mm: Delete booke bits from book3s
>   powerpc/mm: Don't have generic headers introduce functions touching
>     pte bits
>   powerpc/mm: Drop pte-common.h from BOOK3S 64
>   powerpc/mm: Don't use pte_val as lvalue
>   powerpc/mm: Don't use pmd_val,pud_val and pgd_val as lvalue
>   powerpc/mm: Move hash64 PTE bits from book3s/64/pgtable.h to hash.h
>   powerpc/mm: Move PTE bits from generic functions to hash64 functions.
>   powerpc/booke: Move nohash headers (part 1)
>   powerpc/booke: Move nohash headers (part 2)
>   powerpc/booke: Move nohash headers (part 3)
>   powerpc/booke: Move nohash headers (part 4)
>   powerpc/booke: Move nohash headers (part 5)
>   powerpc/mm: Increase the pte frag size.
>   powerpc/mm: Convert 4k hash insert to C
>   powerpc/mm: update __real_pte to take address as argument
>   powerpc/mm: make pte page hash index slot 8 bits
>   powerpc/mm: Don't track subpage valid bit in pte_t
>   powerpc/mm: Increase the width of #define
>   powerpc/mm: Convert __hash_page_64K to C
>   powerpc/mm: Convert 4k insert from asm to C
>   powerpc/mm: Remove the dependency on pte bit position in asm code
>   powerpc/mm: Add helper for converting pte bit to hpte bits
>   powerpc/mm: Move WIMG update to helper.
>   powerpc/mm: Move hugetlb related headers
>   powerpc/mm: Move THP headers around
>   powerpc/mm: Add a _PAGE_PTE bit
> 
>  .../include/asm/{pte-hash32.h => book3s/32/hash.h} |    6 +-
>  .../asm/{pgtable-ppc32.h => book3s/32/pgtable.h}   |  286 ++++--
>  .../{pgtable-ppc64-4k.h => book3s/64/hash-4k.h}    |   58 +-
>  arch/powerpc/include/asm/book3s/64/hash-64k.h      |  296 ++++++
>  arch/powerpc/include/asm/book3s/64/hash.h          |  530 +++++++++++
>  arch/powerpc/include/asm/book3s/64/pgtable.h       |  266 ++++++
>  arch/powerpc/include/asm/book3s/pgtable.h          |   29 +
>  arch/powerpc/include/asm/mmu-hash64.h              |    2 +-
>  .../asm/{pgtable-ppc32.h => nohash/32/pgtable.h}   |   25 +-
>  arch/powerpc/include/asm/{ => nohash/32}/pte-40x.h |    6 +-
>  arch/powerpc/include/asm/{ => nohash/32}/pte-44x.h |    6 +-
>  arch/powerpc/include/asm/{ => nohash/32}/pte-8xx.h |    6 +-
>  .../include/asm/{ => nohash/32}/pte-fsl-booke.h    |    6 +-
>  .../{pgtable-ppc64-4k.h => nohash/64/pgtable-4k.h} |   12 +-
>  .../64/pgtable-64k.h}                              |    6 +-
>  .../asm/{pgtable-ppc64.h => nohash/64/pgtable.h}   |  307 +-----
>  arch/powerpc/include/asm/{ => nohash}/pgtable.h    |  175 ++--
>  arch/powerpc/include/asm/{ => nohash}/pte-book3e.h |    6 +-
>  arch/powerpc/include/asm/page.h                    |   90 +-
>  arch/powerpc/include/asm/pgalloc-32.h              |   34 +-
>  arch/powerpc/include/asm/pgalloc-64.h              |   29 +-
>  arch/powerpc/include/asm/pgtable.h                 |  200 +---
>  arch/powerpc/include/asm/pte-common.h              |    5 +
>  arch/powerpc/include/asm/pte-hash64-4k.h           |   17 -
>  arch/powerpc/include/asm/pte-hash64-64k.h          |  102 --
>  arch/powerpc/include/asm/pte-hash64.h              |   54 --
>  arch/powerpc/kernel/exceptions-64s.S               |   16 +-
>  arch/powerpc/mm/40x_mmu.c                          |   10 +-
>  arch/powerpc/mm/Makefile                           |    9 +-
>  arch/powerpc/mm/hash64_4k.c                        |  123 +++
>  arch/powerpc/mm/hash64_64k.c                       |  313 ++++++
>  arch/powerpc/mm/hash_low_64.S                      | 1003 --------------------
>  arch/powerpc/mm/hash_native_64.c                   |   10 +
>  arch/powerpc/mm/hash_utils_64.c                    |  105 +-
>  arch/powerpc/mm/hugepage-hash64.c                  |   20 +-
>  arch/powerpc/mm/hugetlbpage-hash64.c               |   15 +-
>  arch/powerpc/mm/hugetlbpage.c                      |   58 +-
>  arch/powerpc/mm/pgtable.c                          |    4 +
>  arch/powerpc/mm/pgtable_64.c                       |   28 +-
>  arch/powerpc/mm/tlb_hash64.c                       |    2 +-
>  arch/powerpc/platforms/pseries/lpar.c              |   10 +
>  41 files changed, 2184 insertions(+), 2101 deletions(-)
>  rename arch/powerpc/include/asm/{pte-hash32.h => book3s/32/hash.h} (93%)
>  copy arch/powerpc/include/asm/{pgtable-ppc32.h => book3s/32/pgtable.h} (62%)
>  copy arch/powerpc/include/asm/{pgtable-ppc64-4k.h => book3s/64/hash-4k.h} (71%)
>  create mode 100644 arch/powerpc/include/asm/book3s/64/hash-64k.h
>  create mode 100644 arch/powerpc/include/asm/book3s/64/hash.h
>  create mode 100644 arch/powerpc/include/asm/book3s/64/pgtable.h
>  create mode 100644 arch/powerpc/include/asm/book3s/pgtable.h
>  rename arch/powerpc/include/asm/{pgtable-ppc32.h => nohash/32/pgtable.h} (96%)
>  rename arch/powerpc/include/asm/{ => nohash/32}/pte-40x.h (95%)
>  rename arch/powerpc/include/asm/{ => nohash/32}/pte-44x.h (96%)
>  rename arch/powerpc/include/asm/{ => nohash/32}/pte-8xx.h (95%)
>  rename arch/powerpc/include/asm/{ => nohash/32}/pte-fsl-booke.h (88%)
>  rename arch/powerpc/include/asm/{pgtable-ppc64-4k.h => nohash/64/pgtable-4k.h} (92%)
>  rename arch/powerpc/include/asm/{pgtable-ppc64-64k.h => nohash/64/pgtable-64k.h} (90%)
>  rename arch/powerpc/include/asm/{pgtable-ppc64.h => nohash/64/pgtable.h} (56%)
>  copy arch/powerpc/include/asm/{ => nohash}/pgtable.h (62%)
>  rename arch/powerpc/include/asm/{ => nohash}/pte-book3e.h (95%)
>  delete mode 100644 arch/powerpc/include/asm/pte-hash64-4k.h
>  delete mode 100644 arch/powerpc/include/asm/pte-hash64-64k.h
>  delete mode 100644 arch/powerpc/include/asm/pte-hash64.h
>  create mode 100644 arch/powerpc/mm/hash64_4k.c
>  create mode 100644 arch/powerpc/mm/hash64_64k.c
>  delete mode 100644 arch/powerpc/mm/hash_low_64.S
> 
