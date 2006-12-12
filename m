Return-Path: <edi@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ED23967A5E
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 03:04:27 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBCG4N9t003890
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 11:04:23 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBCG4NX5322344
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 09:04:23 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBCG4Nb0024953
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 09:04:23 -0700
Message-ID: <457ED2F7.9070406@linux.vnet.ibm.com>
Date: Tue, 12 Dec 2006 11:04:07 -0500
From: Edi Shmueli <edi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/1] PPC32 : Huge-page support for ppc440 - 2.6.19-rc4
	- revised
References: <45705FA3.4040904@linux.vnet.ibm.com>
	<20061204070100.GB32026@localhost.localdomain>
In-Reply-To: <20061204070100.GB32026@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Fri, Dec 01, 2006 at 12:00:19PM -0500, Edi Shmueli wrote:
>> From: Edi Shmueli <edi@linux.vnet.ibm.com>
>>
>> Following requests to test the patch under the latest kernel, here
>> it is again, tested for 2.6.19-rc4.  This patch enables applications
>> to exploit the PPC440 TLB support for huge-page mapping, to minimize
>> TLB thrashing.  Applications with large memory footprint that
>> exploit this support, experience minimal TLB misses, and boost in
>> performance.  NAS benchmarks tested with this patch indicate
>> hundreds of percent of improvement in performance.
> 
> Ok, I'm still in the process of getting our Ebony set up again so I
> can test this.  In the meantime some observations..
> 
> First things first:  your patch has been hopelessly whitespace
> mangled, probably by Notes.  You'll need to resend with a patch-safe
> mailer.
> 
> Have you attempted to run the testsuite from libhugetlbfs with this?
> It will require some tweaking, since it's not previously been needed
> on ppc32, but it has testcases for a whole pile of potential kernel
> hugepage bugs.
> 
> Also have you looked at how this code compares to the large page
> support on PPC 40x.  40x doesn't support hugetlbfs, but it does have
> about half the necessary bits, since it stores a page size in the PTE
> for implementing large page mapping of the linear mapping.  I'm not
> sure how applicable any of that stuff is to 440.
> 
>> Signed-off-by: Edi Shmueli <edi@linux.vnet.ibm.com>
>> -----
>>
>> Benchmarks and Implementation comments
>> ======================================
>> Below is the NAS IS benchmark results, executing under Linux, with and
>> without this huge-page mapping support.
>> IS Benchmark           4KB pages             16MB pages
>> =======================================================
>>   Class             =   A                     A
>>   Size              =   8388608               8388608
>>   Iterations        =   10                    10
>>   Time in seconds   =   24.44                 6.38
>>   Mop/s total       =   3.43                  13.15
>>   Operation type    =   keys ranked           keys ranked
>>   Verification      =   SUCCESSFUL            SUCCESSFUL
> 
>> Implementation details:
>> =======================
> 
>> This patch is ppc440 architecture-specific. It enables the use of
>> huge-pages by processes executing under the 2.6.16 kernel on the
>> ppc440 processors.  Huge-pages are accessible to user processes
>> using either the hugetlbfs or using shared memory. See
>> Documentation/vs/hugetlbpage.txt.
> 
>> The ppc 32bit kernel uses 64bit PTEs (set by CONFIG_PTE_64BIT).  I
>> exploit a "hole" of 4 unused bits in the PTE MS word (bits 24-27)
>> and code the page size information in those bits.  I then modified
>> the TLB miss handler (head_44x.S) to stop using the constant
>> PPC44x_TLB_4K to set the page size in the TLB.  Instead, when a TLB
>> miss happens, the miss handler reads the size information from the
>> PTE and sets that size in the TLB entry.  This way, different TLB
>> entries get to map different page sizes (e.g., 4KB or 16MB).  The
>> TLB replacement policy remains RR. This means that a huge-page entry
>> in the TLB may be overwritten if not used for a long time, but when
>> accessed it will be set again by the TLB miss handler, with the
>> correct size, as set in the PTE.
> 
>> In arch/ppc/mm/hugetlbpage.c is where page table entries are set to
>> map huge pages:
>> By default , each process has two-level page-tables. It has 2048,
>> 32bit PMD (or PGD) entries at the higher-level, each maps 2MB of the
>> process address spase, and 512, 64bit PTE entries in each
>> lower-level page table.  When a TLB miss happens and no PTE is found
>> by the miss handler to offer the translation, a check is made
>> (memory.c) on whether the faulting address belongs to a huge-page VM
>> region.  If so, the code in set_huge_pte_at() will set the required
>> number of PMDs (e.g.,8 PMDs for huge-pages of size 16MB, or 1 PMD
>> for huge-pages of size 2MB or less) to point to the *same*
>> lower-level PTE page table.  Within the lower-level page table, it
>> will set the required number PTEs (e.g., all 512 PTEs for huge-pages
>> larger than 2MB, or 256 PTEs for huge-pages of size 1MB etc.) to
>> point to the *same* physical huge-page frame.  All these PTEs will
>> be *identical* and have the page-size coded in their MS word as
>> described above.
> 
> Creating an all-equal PTE page even when using pages of a size greater
> than or equal to that mapped by a single PMD seems very wasteful.
> 
>> Once the TLB miss handler copies the mapping (and the size) from the
>> PTE into on of a TLB entry, the process will not suffer any TLB
>> misses for that huge-page.  If the mapping was overwritten by the
>> TLB RR replacement policy, it will be re-loaded again (probably in a
>> different TLB entry) when the process re-access that huge-page.
> 
>> diff -uprP -X linux-2.6.19-rc4-vanilla/Documentation/dontdiff linux-2.6.19-rc4-vanilla/arch/ppc/kernel/head_44x.S my_linux/arch/ppc/kernel/head_44x.S
>> --- linux-2.6.19-rc4-vanilla/arch/ppc/kernel/head_44x.S    2006-11-14 11:16:29.000000000 -0500
>> +++ my_linux/arch/ppc/kernel/head_44x.S    2006-11-14 17:26:13.000000000 -0500
>> @@ -21,12 +21,14 @@
>>    *            debbie_chu@mvista.com
>>    *    Copyright 2002-2005 MontaVista Software, Inc.
>>    *      PowerPC 44x support, Matt Porter <mporter@kernel.crashing.org>
>> + *    Copyright (C) 2006 Edi Shmueli, IBM Corporation.
>> + *    PowerPC 44x handling of huge-page misses.
>>    *
>>    * This program is free software; you can redistribute  it and/or modify it
>>    * under  the terms of  the GNU General  Public License as published by the
>>    * Free Software Foundation;  either version 2 of the  License, or (at your
>>    * option) any later version.
>> - */
>> +*/
> 
> Please try to avoid extraneous changes in your patch.
> 
> [snip]
> 
>> diff -uprP -X linux-2.6.19-rc4-vanilla/Documentation/dontdiff linux-2.6.19-rc4-vanilla/arch/ppc/mm/hugetlbpage.c my_linux/arch/ppc/mm/hugetlbpage.c
>> --- linux-2.6.19-rc4-vanilla/arch/ppc/mm/hugetlbpage.c    1969-12-31 19:00:00.000000000 -0500
>> +++ my_linux/arch/ppc/mm/hugetlbpage.c    2006-11-15
>> 11:44:43.297682864 -0500
> 
> Since this patch is 440 specific, and 40x at least could also support
> hugepages, this should probably go in hugetlbpage_44x.c
> 
>> @@ -0,0 +1,185 @@
>> +/*
>> + * PPC32 (440) Huge TLB Page Support for Kernel.
>> + *
>> + * Copyright (C) 2006 Edi Shmueli, IBM Corporation.
>> + *
>> + * Based on the IA-32 version:
>> + * Copyright (C) 2002, Rohit Seth <rohit.seth@intel.com>
>> + *
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/fs.h>
>> +#include <linux/mm.h>
>> +#include <linux/hugetlb.h>
>> +#include <linux/pagemap.h>
>> +#include <linux/smp_lock.h>
>> +#include <linux/slab.h>
>> +#include <linux/err.h>
>> +#include <linux/sysctl.h>
>> +#include <asm/mman.h>
>> +#include <asm/tlb.h>
>> +#include <asm/tlbflush.h>
>> +
>> +pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
>> +{
>> +  pgd_t *pgd;
> 
> I'm not sure if the bogus indentation here is yours, or the result of
> Notes whitespace mangling.  If the former, please make sure your code
> is formatted as per CodingStyle.
> 
> [snip]
>> +    return pte;
>> +}
>> +
>> +#ifdef ARCH_HAS_SETCLEAR_HUGE_PTE
> 
> This #ifdef makes no sense here.  You already know that this arch will
> need this code.
> 
>> +void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>> pte_t *ptep, pte_t pte){
> 
> Open brace on the next line, as per CodingStyle, please.
> 
> [snip]
>> +int is_aligned_hugepage_range(unsigned long addr, unsigned long len)
>> +{
>> +  if (len & ~HPAGE_MASK)
>> +    return -EINVAL;
>> +  if (addr & ~HPAGE_MASK)
>> +    return -EINVAL;
>> +  return 0;
>> +}
> 
> The is_aligned_hugepage_range() callback was removed quite some time
> ago, please remove.
> 
> [snip]
>> diff -uprP -X linux-2.6.19-rc4-vanilla/Documentation/dontdiff linux-2.6.19-rc4-vanilla/fs/Kconfig my_linux/fs/Kconfig
>> --- linux-2.6.19-rc4-vanilla/fs/Kconfig    2006-11-14 11:17:37.000000000 -0500
>> +++ my_linux/fs/Kconfig    2006-11-14 17:26:13.000000000 -0500
>> @@ -1008,7 +1008,7 @@ config TMPFS_POSIX_ACL
>>
>>   config HUGETLBFS
>>       bool "HugeTLB file system support"
>> -    depends X86 || IA64 || PPC64 || SPARC64 || SUPERH || BROKEN
>> +    depends X86 || IA64 || PPC || PPC64 || SPARC64 || SUPERH || BROKEN
>>       help
>>         hugetlbfs is a filesystem backing for HugeTLB pages, based on
>>         ramfs. For architectures that support it, say Y here and
>>   read
> 
> This needs a test for 44x as well, or this option will be available
> and horribly broken for other ppc32 machines.
> 
>> diff -uprP -X linux-2.6.19-rc4-vanilla/Documentation/dontdiff linux-2.6.19-rc4-vanilla/include/asm-ppc/page.h my_linux/include/asm-ppc/page.h
>> --- linux-2.6.19-rc4-vanilla/include/asm-ppc/page.h    2006-11-14 11:18:00.000000000 -0500
>> +++ my_linux/include/asm-ppc/page.h    2006-11-14 17:26:14.000000000 -0500
>> @@ -7,6 +7,12 @@
>>   #define PAGE_SHIFT    12
>>   #define PAGE_SIZE    (ASM_CONST(1) << PAGE_SHIFT)
>>
>> +#ifdef CONFIG_HUGETLB_PAGE
>> +#define HPAGE_SHIFT     24
>> +#define HPAGE_SIZE      ((1UL) << HPAGE_SHIFT)
>> +#define HPAGE_MASK      (~(HPAGE_SIZE - 1))
>> +#define HUGETLB_PAGE_ORDER      (HPAGE_SHIFT - PAGE_SHIFT)
>> +#endif
>>   /*
>>    * Subtle: this is an int (not an unsigned long) and so it
>>    * gets extended to 64 bits the way want (i.e. with 1s).  -- paulus
>> diff -uprP -X linux-2.6.19-rc4-vanilla/Documentation/dontdiff linux-2.6.19-rc4-vanilla/include/asm-ppc/pgtable.h my_linux/include/asm-ppc/pgtable.h
>> --- linux-2.6.19-rc4-vanilla/include/asm-ppc/pgtable.h    2006-11-14 11:18:00.000000000 -0500
>> +++ my_linux/include/asm-ppc/pgtable.h    2006-11-15 11:40:45.332514013 -0500
>> @@ -263,6 +263,40 @@ extern unsigned long ioremap_bot, iorema
>>   #define    _PAGE_NO_CACHE    0x00000400        /* H: I bit */
>>   #define    _PAGE_WRITETHRU    0x00000800        /* H: W bit */
>>
>> +#if   HPAGE_SHIFT == 10 /*Unsupported*/
>> +#define _PAGE_HUGE      0x0000000000000000ULL   /* H: SIZE=1K bytes */
>> +#define _PTE_MASK       0xfffffff8UL
>> +#define _PTE_CNT        ((1UL) << (PTE_SHIFT - 9))
>> +#elif HPAGE_SHIFT == 12
>> +#define _PAGE_HUGE      0x0000001000000000ULL   /* H: SIZE=4K bytes */
>> +#define _PTE_MASK       0xfffffff8UL
>> +#define _PTE_CNT        ((1UL) << (PTE_SHIFT - 9))
> 
> Yikes!  Please use computed values here, not this ghastly string of
> #ifdefs.
> 
> --
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson


Thanks David,
One step at a time, lets start with libhugetlbfs :-)
I'm successfully able to run most of my tests using the library, backing my data,text and BSS with huge-pages.
There is a major improvement in performance, similar to what I reported above.
Good job with the library !!!

There is a problem though when a program calls "fopen".
I see hugetlbfs does the unmapping/mapping , moves control to main(),
and then a crash with the following error:
"*** glibc detected *** free(): invalid pointer: 0x3002a008 ***"
This happens inside fopen() (....which never returns).

Here is the detailed output.

/bgd-public/edi/IS # ./is.A.linux_ser_hugetlbfs
libhugetlbfs: Hugepage segment 0 (phdr 2): 0x10000000-0x10001b70  (filesz=0x1b70) (prot = 0x5)
libhugetlbfs: Hugepage segment 1 (phdr 3): 0x11000000-0x170006e8  (filesz=0x274) (prot = 0x7)
libhugetlbfs: HUGETLB_SHARE=0, sharing disabled
libhugetlbfs: Got unshared fd as expected -- Preparing
libhugetlbfs: Mapped hugeseg at 0x31000000. Copying 0x1b70 bytes from 0x10000000...
done
libhugetlbfs: Minimal copy was not performed
libhugetlbfs: Prepare succeeded
libhugetlbfs: HUGETLB_SHARE=0, sharing disabled
libhugetlbfs: Got unshared fd as expected -- Preparing
libhugetlbfs: Mapped hugeseg at 0x31000000. Copying 0x274 bytes from 0x11000000...
done
libhugetlbfs: Minimal copy was not performed
libhugetlbfs: Prepare succeeded
*** glibc detected *** free(): invalid pointer: 0x3002a008 ***
Aborted
