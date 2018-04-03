Return-Path: <srs0=7hay=gy=linux.vnet.ibm.com=prvs=06312cd2c6=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [103.22.144.68])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40FnCR4hrzzF26Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2018 21:38:11 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40FnCR3q6sz8tJy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2018 21:38:11 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40FnCQ6fCRz9s1w
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2018 21:38:10 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w33BYUWL062468
 for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2018 07:38:06 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h4675qs4j-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 03 Apr 2018 07:38:05 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 3 Apr 2018 12:38:04 +0100
Subject: Re: [PATCH v3 6/7] powerpc/fadump: Do not allow hot-remove memory
 from fadump reserved area.
To: Pingfan Liu <kernelfans@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <152265046485.23251.1392824827444770657.stgit@jupiter.in.ibm.com>
 <152265064158.23251.10213309407765206304.stgit@jupiter.in.ibm.com>
 <CAFgQCTu0qLrHuuiaCpPPEoFesz+19V+0CCQY-rjPz2chcNL1gw@mail.gmail.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 3 Apr 2018 17:07:59 +0530
MIME-Version: 1.0
In-Reply-To: <CAFgQCTu0qLrHuuiaCpPPEoFesz+19V+0CCQY-rjPz2chcNL1gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <1177bec0-d2aa-edef-695f-f3e4d4f2f8d3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/03/2018 08:48 AM, Pingfan Liu wrote:
> I think CMA has protected us from hot-remove, so this patch is not necessary.

Yes, but only if the memory from declared CMA region is allocated using
cma_alloc(). The rest of the memory inside CMA region which hasn't been
cma_allocat-ed can still be hot-removed. Hence this patch is necessary.

fadump allocates only 1 page from fadump CMA region for metadata region.
Rest all memory is free to use by applications and vulnerable to hot-remove.

Thanks,
-Mahesh.

> 
> Regards,
> Pingfan
> 
> On Mon, Apr 2, 2018 at 2:30 PM, Mahesh J Salgaonkar
> <mahesh@linux.vnet.ibm.com> wrote:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> For fadump to work successfully there should not be any holes in reserved
>> memory ranges where kernel has asked firmware to move the content of old
>> kernel memory in event of crash. But this memory area is currently not
>> protected from hot-remove operations. Hence, fadump service can fail to
>> re-register after the hot-remove operation, if hot-removed memory belongs
>> to fadump reserved region. To avoid this make sure that memory from fadump
>> reserved area is not hot-removable if fadump is registered.
>>
>> However, if user still wants to remove that memory, he can do so by
>> manually stopping fadump service before hot-remove operation.
>>
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/fadump.h               |    2 +-
>>  arch/powerpc/kernel/fadump.c                    |   10 ++++++++--
>>  arch/powerpc/platforms/pseries/hotplug-memory.c |    7 +++++--
>>  3 files changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
>> index 44b6ebfe9be6..d16dc77107a8 100644
>> --- a/arch/powerpc/include/asm/fadump.h
>> +++ b/arch/powerpc/include/asm/fadump.h
>> @@ -207,7 +207,7 @@ struct fad_crash_memory_ranges {
>>         unsigned long long      size;
>>  };
>>
>> -extern int is_fadump_boot_memory_area(u64 addr, ulong size);
>> +extern int is_fadump_memory_area(u64 addr, ulong size);
>>  extern int early_init_dt_scan_fw_dump(unsigned long node,
>>                 const char *uname, int depth, void *data);
>>  extern int fadump_reserve_mem(void);
>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>> index 59aaf0357a52..2c3c7e655eec 100644
>> --- a/arch/powerpc/kernel/fadump.c
>> +++ b/arch/powerpc/kernel/fadump.c
>> @@ -162,13 +162,19 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
>>
>>  /*
>>   * If fadump is registered, check if the memory provided
>> - * falls within boot memory area.
>> + * falls within boot memory area and reserved memory area.
>>   */
>> -int is_fadump_boot_memory_area(u64 addr, ulong size)
>> +int is_fadump_memory_area(u64 addr, ulong size)
>>  {
>> +       u64 d_start = fw_dump.reserve_dump_area_start;
>> +       u64 d_end = d_start + fw_dump.reserve_dump_area_size;
>> +
>>         if (!fw_dump.dump_registered)
>>                 return 0;
>>
>> +       if (((addr + size) > d_start) && (addr <= d_end))
>> +               return 1;
>> +
>>         return (addr + size) > RMA_START && addr <= fw_dump.boot_memory_size;
>>  }
>>
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> index c1578f54c626..e4c658cda3a7 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> @@ -389,8 +389,11 @@ static bool lmb_is_removable(struct drmem_lmb *lmb)
>>         phys_addr = lmb->base_addr;
>>
>>  #ifdef CONFIG_FA_DUMP
>> -       /* Don't hot-remove memory that falls in fadump boot memory area */
>> -       if (is_fadump_boot_memory_area(phys_addr, block_sz))
>> +       /*
>> +        * Don't hot-remove memory that falls in fadump boot memory area
>> +        * and memory that is reserved for capturing old kernel memory.
>> +        */
>> +       if (is_fadump_memory_area(phys_addr, block_sz))
>>                 return false;
>>  #endif
>>
>>
> 
