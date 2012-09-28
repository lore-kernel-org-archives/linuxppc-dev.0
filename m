Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2A1DB2C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 13:50:41 +1000 (EST)
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 8CE623EE0BD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 12:50:38 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6F0A645DEC4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 12:50:38 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5397A45DEBC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 12:50:38 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3FCF01DB8042
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 12:50:38 +0900 (JST)
Received: from G01JPEXCHYT21.g01.fujitsu.local
 (G01JPEXCHYT21.g01.fujitsu.local [10.128.193.104])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id D90C51DB803F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 12:50:37 +0900 (JST)
Message-ID: <50651E68.3040208@jp.fujitsu.com>
Date: Fri, 28 Sep 2012 12:50:00 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Ni zhan Chen <nizhan.chen@gmail.com>
Subject: Re: [RFC v9 PATCH 01/21] memory-hotplug: rename remove_memory() to
 offline_memory()/offline_pages()
References: <1346837155-534-1-git-send-email-wency@cn.fujitsu.com>
 <1346837155-534-2-git-send-email-wency@cn.fujitsu.com>
 <506509E4.1090000@gmail.com>
In-Reply-To: <506509E4.1090000@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 wency@cn.fujitsu.com, linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org,
 len.brown@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 cmetcalf@tilera.com, linux-mm@kvack.org, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 sparclinux@vger.kernel.org, cl@linux.com, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Chen,

2012/09/28 11:22, Ni zhan Chen wrote:
> On 09/05/2012 05:25 PM, wency@cn.fujitsu.com wrote:
>> From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>>
>> remove_memory() only try to offline pages. It is called in two cases:
>> 1. hot remove a memory device
>> 2. echo offline >/sys/devices/system/memory/memoryXX/state
>>
>> In the 1st case, we should also change memory block's state, and notify
>> the userspace that the memory block's state is changed after offlining
>> pages.
>>
>> So rename remove_memory() to offline_memory()/offline_pages(). And in
>> the 1st case, offline_memory() will be used. The function offline_memory()
>> is not implemented. In the 2nd case, offline_pages() will be used.
>
> But this time there is not a function associated with add_memory.

To associate with add_memory() later, we renamed it.

Thanks,
Yasuaki Ishimatsu

>
>>
>> CC: David Rientjes <rientjes@google.com>
>> CC: Jiang Liu <liuj97@gmail.com>
>> CC: Len Brown <len.brown@intel.com>
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: Paul Mackerras <paulus@samba.org>
>> CC: Christoph Lameter <cl@linux.com>
>> Cc: Minchan Kim <minchan.kim@gmail.com>
>> CC: Andrew Morton <akpm@linux-foundation.org>
>> CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
>> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
>> ---
>>   drivers/acpi/acpi_memhotplug.c |    2 +-
>>   drivers/base/memory.c          |    9 +++------
>>   include/linux/memory_hotplug.h |    3 ++-
>>   mm/memory_hotplug.c            |   22 ++++++++++++++--------
>>   4 files changed, 20 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
>> index 24c807f..2a7beac 100644
>> --- a/drivers/acpi/acpi_memhotplug.c
>> +++ b/drivers/acpi/acpi_memhotplug.c
>> @@ -318,7 +318,7 @@ static int acpi_memory_disable_device(struct acpi_memory_device *mem_device)
>>        */
>>       list_for_each_entry_safe(info, n, &mem_device->res_list, list) {
>>           if (info->enabled) {
>> -            result = remove_memory(info->start_addr, info->length);
>> +            result = offline_memory(info->start_addr, info->length);
>>               if (result)
>>                   return result;
>>           }
>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>> index 7dda4f7..44e7de6 100644
>> --- a/drivers/base/memory.c
>> +++ b/drivers/base/memory.c
>> @@ -248,26 +248,23 @@ static bool pages_correctly_reserved(unsigned long start_pfn,
>>   static int
>>   memory_block_action(unsigned long phys_index, unsigned long action)
>>   {
>> -    unsigned long start_pfn, start_paddr;
>> +    unsigned long start_pfn;
>>       unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
>>       struct page *first_page;
>>       int ret;
>>       first_page = pfn_to_page(phys_index << PFN_SECTION_SHIFT);
>> +    start_pfn = page_to_pfn(first_page);
>>       switch (action) {
>>           case MEM_ONLINE:
>> -            start_pfn = page_to_pfn(first_page);
>> -
>>               if (!pages_correctly_reserved(start_pfn, nr_pages))
>>                   return -EBUSY;
>>               ret = online_pages(start_pfn, nr_pages);
>>               break;
>>           case MEM_OFFLINE:
>> -            start_paddr = page_to_pfn(first_page) << PAGE_SHIFT;
>> -            ret = remove_memory(start_paddr,
>> -                        nr_pages << PAGE_SHIFT);
>> +            ret = offline_pages(start_pfn, nr_pages);
>>               break;
>>           default:
>>               WARN(1, KERN_WARNING "%s(%ld, %ld) unknown action: "
>> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
>> index 910550f..c183f39 100644
>> --- a/include/linux/memory_hotplug.h
>> +++ b/include/linux/memory_hotplug.h
>> @@ -233,7 +233,8 @@ static inline int is_mem_section_removable(unsigned long pfn,
>>   extern int mem_online_node(int nid);
>>   extern int add_memory(int nid, u64 start, u64 size);
>>   extern int arch_add_memory(int nid, u64 start, u64 size);
>> -extern int remove_memory(u64 start, u64 size);
>> +extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
>> +extern int offline_memory(u64 start, u64 size);
>>   extern int sparse_add_one_section(struct zone *zone, unsigned long start_pfn,
>>                                   int nr_pages);
>>   extern void sparse_remove_one_section(struct zone *zone, struct mem_section *ms);
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 3ad25f9..bb42316 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -866,7 +866,7 @@ check_pages_isolated(unsigned long start_pfn, unsigned long end_pfn)
>>       return offlined;
>>   }
>> -static int __ref offline_pages(unsigned long start_pfn,
>> +static int __ref __offline_pages(unsigned long start_pfn,
>>             unsigned long end_pfn, unsigned long timeout)
>>   {
>>       unsigned long pfn, nr_pages, expire;
>> @@ -994,18 +994,24 @@ out:
>>       return ret;
>>   }
>> -int remove_memory(u64 start, u64 size)
>> +int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>>   {
>> -    unsigned long start_pfn, end_pfn;
>> +    return __offline_pages(start_pfn, start_pfn + nr_pages, 120 * HZ);
>> +}
>> -    start_pfn = PFN_DOWN(start);
>> -    end_pfn = start_pfn + PFN_DOWN(size);
>> -    return offline_pages(start_pfn, end_pfn, 120 * HZ);
>> +int offline_memory(u64 start, u64 size)
>> +{
>> +    return -EINVAL;
>>   }
>>   #else
>> -int remove_memory(u64 start, u64 size)
>> +int offline_pages(unsigned long start, unsigned long size)
>> +{
>> +    return -EINVAL;
>> +}
>> +
>> +int offline_memory(u64 start, u64 size)
>>   {
>>       return -EINVAL;
>>   }
>>   #endif /* CONFIG_MEMORY_HOTREMOVE */
>> -EXPORT_SYMBOL_GPL(remove_memory);
>> +EXPORT_SYMBOL_GPL(offline_memory);
>
