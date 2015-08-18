Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C173C1A0153
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 15:34:44 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 18 Aug 2015 11:04:42 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3F679E0058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 11:03:59 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7I5Ycer43188478
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 11:04:39 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7I5Ybxd013895
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 11:04:38 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH V1 7/8] powerpc/mm: kasan: Add kasan support for ppc64
In-Reply-To: <55D1CFE7.2070801@gmail.com>
References: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1439793400-18147-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <55D1CFE7.2070801@gmail.com>
Date: Tue, 18 Aug 2015 11:04:37 +0530
Message-ID: <877fotp3bm.fsf@linux.vnet.ibm.com>
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

Andrey Ryabinin <ryabinin.a.a@gmail.com> writes:

> On 08/17/2015 09:36 AM, Aneesh Kumar K.V wrote:
>> We use the region with region ID 0xe as the kasan shadow region. Since
>> we use hash page table, we can't have the early zero page based shadow
>> region support. Hence we disable kasan in the early code and runtime
>> enable this. We could imporve the condition using static keys. (but
>> that is for a later patch). We also can't support inline instrumentation
>> because our kernel mapping doesn't give us a large enough free window
>> to map the entire range. For VMALLOC and VMEMMAP region we just
>> return a zero page instead of having a translation bolted into the
>> htab. This simplifies handling VMALLOC and VMEMAP area. Kasan is not
>> tracking both the region as of now
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/kasan.h         | 74 ++++++++++++++++++++++++++++++++
>>  arch/powerpc/include/asm/pgtable-ppc64.h |  1 +
>>  arch/powerpc/include/asm/ppc_asm.h       | 10 +++++
>>  arch/powerpc/include/asm/string.h        | 13 ++++++
>>  arch/powerpc/kernel/Makefile             |  1 +
>>  arch/powerpc/kernel/prom_init_check.sh   |  2 +-
>>  arch/powerpc/kernel/setup_64.c           |  3 ++
>>  arch/powerpc/lib/mem_64.S                |  6 ++-
>>  arch/powerpc/lib/memcpy_64.S             |  3 +-
>>  arch/powerpc/lib/ppc_ksyms.c             | 10 +++++
>>  arch/powerpc/mm/Makefile                 |  3 ++
>>  arch/powerpc/mm/kasan_init.c             | 44 +++++++++++++++++++
>>  arch/powerpc/mm/slb_low.S                |  4 ++
>>  arch/powerpc/platforms/Kconfig.cputype   |  1 +
>>  14 files changed, 171 insertions(+), 4 deletions(-)
>>  create mode 100644 arch/powerpc/include/asm/kasan.h
>>  create mode 100644 arch/powerpc/mm/kasan_init.c
>> 
>
> Did you disable stack instrumentation (in scripts/Makefile.kasa),
> or you version of gcc doesn't support it (e.g. like 4.9.x on x86) ?

I guess the later, because i do see this during compile

scripts/Makefile.kasan:23: CONFIG_KASAN: compiler does not support all options. Trying minimal configuration
scripts/kconfig/conf  --silentoldconfig Kconfig


> Because this can't work with stack instrumentation as you don't have shadow for stack in early code.
>
> But this should be doable, as I think. All you need is to setup shadow for init task's
> stack before executing any instrumented function. 

I still need to look at stack and global support. So that is not yet
there.

-aneesh
