Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdT020lqGzDt3c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 05:34:57 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBDIYjKe123309
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 13:34:56 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27ahmr387b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 13:34:54 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 13 Dec 2016 11:34:50 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Scott Wood <oss@buserror.net>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: Pull request: scottwood/linux.git next
In-Reply-To: <87lgvjrfqj.fsf@linux.vnet.ibm.com>
References: <20161212081731.GA31497@home.buserror.net>
 <87lgvjrfqj.fsf@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 00:04:44 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874m27d6ez.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Scott Wood <oss@buserror.net> writes:
>
>> Highlights include 8xx hugepage support, qbman fixes/cleanup, device
>> tree updates, and some misc cleanup.
>>
>> The following changes since commit 555c16328ae6d75a90e234eac9b51998d68f185b:
>>
>>   powerpc/mm: Correct process and partition table max size (2016-11-17 17:11:53 +1100)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next
>>
>> for you to fetch changes up to baae856ebdeeaefbadd4a02cdb54b7c2277ff4dd:
>>
>>   powerpc/fsl/dts: add FMan node for t1042d4rdb (2016-12-09 23:11:17 -0600)
>>
>> ----------------------------------------------------------------
>> Andy Fleming (1):
>>       powerpc/85xx: Enable gpio power/reset driver
>>
>> Christophe Leroy (3):
>>       powerpc: port 64 bits pgtable_cache to 32 bits
>>       powerpc: get hugetlbpage handling more generic
>>       powerpc/8xx: Implement support of hugepages
>
>
> So i guess it got pulled into linux-next and 4k page size boot on ppc64.
> That is easy to fix such as doing something below.
>  
> -       if (PMD_INDEX_SIZE && !PGT_CACHE(PMD_INDEX_SIZE))
> +       if (PMD_CACHE_INDEX && !PGT_CACHE(PMD_CACHE_INDEX)) {
>                 pgtable_cache_add(PMD_CACHE_INDEX, pmd_ctor);
> +       }
>
> But then we also have crashes when using hugetlb 
>
> [   59.089441] Unable to handle kernel paging request for data at address 0xe8dc493a00000000
> [   59.089591] Faulting instruction address: 0xc000000000054da0
> [   59.089685] Oops: Kernel access of bad area, sig: 11 [#2]
> [   59.089753] SMP NR_CPUS=2048 
> [   59.089797] NUMA 
> [   59.089817] pSeries
> [   59.089840] Modules linked in:
> [   59.089904] CPU: 1 PID: 3689 Comm: hugepage-mmap Tainted: G      D         4.9.0-next-20161213-11823-gff9fa2f-dirty #6
> [   59.090058] task: c00000003efbc900 task.stack: c000000038d5c000
> [   59.090145] NIP: c000000000054da0 LR: c000000000262e38 CTR: 0000000000000000
> NIP: c000000000054da0 LR: c000000000262e38 CTR: 0000000000000000
> REGS: c000000038d5f3b0 TRAP: 0380   Tainted: G      D          (4.9.0-next-20161213-11823-gff9fa2f-dirty)
> MSR: 8000000000001033 <SF,ME,IR,DR,RI,LE>  CR: 28002422  XER: 20000000
> CFAR: c000000000054ebc SOFTE: 0 
> GPR00: 0000000000000007 c000000038d5f630 c000000000de2600 c000000000000000 
> GPR04: 00003efff0000000 0000000000000000 0000000000000000 0000000000000015 
> GPR08: 000000000000007f 0000000000000000 e8dc493a00000000 0000000000000000 
> GPR12: 0000000000000009 c00000000fe00400 00003efff0000000 0000000000000001 
> GPR16: 00003efff0000000 0000000000001000 c00000003ee70eb8 0000000000000000 
> GPR20: 0000000000000000 c00000003e956508 0000000000000000 c000000000ea7478 
> GPR24: c000000038d5f7d0 c1fffffffffff7ff 0000000000000000 00003f0000000000 
> GPR28: 0000000001000000 c00000003ee70a00 0000000000000009 0000000000000010 
> NIP [c000000000054da0] __find_linux_pte_or_hugepte+0x1c0/0x380
> LR [c000000000262e38] __unmap_hugepage_range+0x198/0x6d0
> Call Trace:
> [c000000038d5f630] [c000000000262d80] __unmap_hugepage_range+0xe0/0x6d0 (unreliable)
> [c000000038d5f6f0] [c000000000263390] __unmap_hugepage_range_final+0x20/0x50
> [c000000038d5f720] [c0000000002344fc] unmap_single_vma+0xcc/0x120
> [c000000038d5f760] [c000000000234954] unmap_vmas+0x84/0x120
> [c000000038d5f7b0] [c000000000241438] exit_mmap+0xd8/0x190
> [c000000038d5f870] [c0000000000acf3c] mmput+0x6c/0x1d0
> [c000000038d5f8a0] [c0000000000b6b64] do_exit+0x324/0xcd0
> [c000000038d5f960] [c000000000023900] oops_end+0x150/0x1f0
> [c000000038d5f9e0] [c000000000047118] bad_page_fault+0xd8/0x150
> [c000000038d5fa50] [c000000000025330] slb_miss_bad_addr+0x30/0x70
> [c000000038d5fa70] [c000000000008c38] bad_addr_slb+0x158/0x160
>
> I will see if this is easy to fix. But just want to update the list.

Ok this turned out to be not related to this series. Our 4k page size
little endian config had broken hugetlb for a long time. But we still
need the PMD_CACHE_INDEX changes around code.

I will send the patches after more testing/cross build

-aneesh
