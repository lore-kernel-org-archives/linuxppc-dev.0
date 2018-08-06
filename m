Return-Path: <srs0=luge=kw=c-s.fr=christophe.leroy@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41l4CC6VtkzDqZB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 16:20:55 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41l4CC4xDvz8t8b
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 16:20:55 +1000 (AEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41l4CB6817z9rvt
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2018 16:20:54 +1000 (AEST)
Subject: Re: [PATCH] powerpc/mm: Don't report PUDs as memory leaks when using
 kmemleak
To: Michael Ellerman <mpe@ellerman.id.au>, pmenzel@molgen.mpg.de
Cc: linuxppc-dev@ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
References: <20180719143316.23486-1-mpe@ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a8559d4c-45af-6c1e-365c-74530ffcd154@c-s.fr>
Date: Mon, 6 Aug 2018 17:06:45 +0000
MIME-Version: 1.0
In-Reply-To: <20180719143316.23486-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I've got the same issue on PPC32 with hugepages:

unreferenced object 0xc30f8200 (size 512):
   comm "mmap", pid 374, jiffies 4872494 (age 627.630s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<e32b68da>] huge_pte_alloc+0xdc/0x1f8
     [<9e0df1e1>] hugetlb_fault+0x560/0x8f8
     [<7938ec6c>] follow_hugetlb_page+0x14c/0x44c
     [<afbdb405>] __get_user_pages+0x1c4/0x3dc
     [<b8fd7cd9>] __mm_populate+0xac/0x140
     [<3215421e>] vm_mmap_pgoff+0xb4/0xb8
     [<c148db69>] ksys_mmap_pgoff+0xcc/0x1fc
     [<4fcd760f>] ret_from_syscall+0x0/0x38

Used the following app to trigger it:

#include <sys/mman.h>
#include <unistd.h>
#include <stdlib.h>

int main()
{
	long *p;

	p = mmap(NULL, 1024 * 1024, PROT_READ | PROT_WRITE, MAP_PRIVATE | 
MAP_ANONYMOUS | MAP_HUGETLB | MAP_POPULATE, -1, 0);
	*p = 0xdeadbeef;

	for (;;)
		pause();

	exit(0);
}

Christophe

On 07/19/2018 02:33 PM, Michael Ellerman wrote:
> Paul Menzel reported that kmemleak was producing reports such as:
> 
>    unreferenced object 0xc0000000f8b80000 (size 16384):
>      comm "init", pid 1, jiffies 4294937416 (age 312.240s)
>      hex dump (first 32 bytes):
>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      backtrace:
>        [<00000000d997deb7>] __pud_alloc+0x80/0x190
>        [<0000000087f2e8a3>] move_page_tables+0xbac/0xdc0
>        [<00000000091e51c2>] shift_arg_pages+0xc0/0x210
>        [<00000000ab88670c>] setup_arg_pages+0x22c/0x2a0
>        [<0000000060871529>] load_elf_binary+0x41c/0x1648
>        [<00000000ecd9d2d4>] search_binary_handler.part.11+0xbc/0x280
>        [<0000000034e0cdd7>] __do_execve_file.isra.13+0x73c/0x940
>        [<000000005f953a6e>] sys_execve+0x58/0x70
>        [<000000009700a858>] system_call+0x5c/0x70
> 
> Indicating that a PUD was being leaked.
> 
> However what's really happening is that kmemleak is not able to
> recognise the references from the PGD to the PUD, because they are not
> fully qualified pointers.
> 
> We can confirm that in xmon, eg:
> 
> Find the task struct for pid 1 "init":
>    0:mon> P
>         task_struct     ->thread.ksp    PID   PPID S  P CMD
>    c0000001fe7c0000 c0000001fe803960      1      0 S 13 systemd
> 
> Dump virtual address 0 to find the PGD:
>    0:mon> dv 0 c0000001fe7c0000
>    pgd  @ 0xc0000000f8b01000
> 
> Dump the memory of the PGD:
>    0:mon> d c0000000f8b01000
>    c0000000f8b01000 00000000f8b90000 0000000000000000  |................|
>    c0000000f8b01010 0000000000000000 0000000000000000  |................|
>    c0000000f8b01020 0000000000000000 0000000000000000  |................|
>    c0000000f8b01030 0000000000000000 00000000f8b80000  |................|
>                                      ^^^^^^^^^^^^^^^^
> 
> There we can see the reference to our supposedly leaked PUD. But
> because it's missing the leading 0xc, kmemleak won't recognise it.
> 
> We can confirm it's still in use by translating an address that is
> mapped via it:
>    0:mon> dv 7fff94000000 c0000001fe7c0000
>    pgd  @ 0xc0000000f8b01000
>    pgdp @ 0xc0000000f8b01038 = 0x00000000f8b80000 <--
>    pudp @ 0xc0000000f8b81ff8 = 0x00000000037c4000
>    pmdp @ 0xc0000000037c5ca0 = 0x00000000fbd89000
>    ptep @ 0xc0000000fbd89000 = 0xc0800001d5ce0386
>    Maps physical address = 0x00000001d5ce0000
>    Flags = Accessed Dirty Read Write
> 
> The fix is fairly simple. We need to tell kmemleak to ignore PUD
> allocations and never report them as leaks. We can also tell it not to
> scan the PGD, because it will never find pointers in there. However it
> will still notice if we allocate a PGD and then leak it.
> 
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   arch/powerpc/include/asm/book3s/64/pgalloc.h | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> index 01ee40f11f3a..76234a14b97d 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> @@ -9,6 +9,7 @@
>   
>   #include <linux/slab.h>
>   #include <linux/cpumask.h>
> +#include <linux/kmemleak.h>
>   #include <linux/percpu.h>
>   
>   struct vmemmap_backing {
> @@ -82,6 +83,13 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>   
>   	pgd = kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
>   			       pgtable_gfp_flags(mm, GFP_KERNEL));
> +	/*
> +	 * Don't scan the PGD for pointers, it contains references to PUDs but
> +	 * those references are not full pointers and so can't be recognised by
> +	 * kmemleak.
> +	 */
> +	kmemleak_no_scan(pgd);
> +
>   	/*
>   	 * With hugetlb, we don't clear the second half of the page table.
>   	 * If we share the same slab cache with the pmd or pud level table,
> @@ -110,8 +118,19 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
>   
>   static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>   {
> -	return kmem_cache_alloc(PGT_CACHE(PUD_CACHE_INDEX),
> -		pgtable_gfp_flags(mm, GFP_KERNEL));
> +	pud_t *pud;
> +
> +	pud = kmem_cache_alloc(PGT_CACHE(PUD_CACHE_INDEX),
> +			       pgtable_gfp_flags(mm, GFP_KERNEL));
> +	/*
> +	 * Tell kmemleak to ignore the PUD, that means don't scan it for
> +	 * pointers and don't consider it a leak. PUDs are typically only
> +	 * referred to by their PGD, but kmemleak is not able to recognise those
> +	 * as pointers, leading to false leak reports.
> +	 */
> +	kmemleak_ignore(pud);
> +
> +	return pud;
>   }
>   
>   static inline void pud_free(struct mm_struct *mm, pud_t *pud)
> 
