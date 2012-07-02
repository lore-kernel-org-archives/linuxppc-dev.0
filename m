Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 98A0C2C0315
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2012 12:57:27 +1000 (EST)
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id C8ABE3EE0BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2012 11:57:25 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id AEF7F45DE5F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2012 11:57:25 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 8976045DE5D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2012 11:57:25 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 706AE1DB8048
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2012 11:57:25 +0900 (JST)
Received: from g01jpexchyt11.g01.fujitsu.local
 (g01jpexchyt11.g01.fujitsu.local [10.128.194.50])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1FE12E08001
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2012 11:57:25 +0900 (JST)
Message-ID: <4FF10DF0.7000508@jp.fujitsu.com>
Date: Mon, 2 Jul 2012 11:56:48 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Jiang Liu <liuj97@gmail.com>
Subject: Re: [RFC PATCH 2/12] memory-hogplug : check memory offline in
 offline_pages
References: <4FEA9C88.1070800@jp.fujitsu.com>
 <4FEA9DB1.7010303@jp.fujitsu.com> <4FEF2075.2050603@gmail.com>
In-Reply-To: <4FEF2075.2050603@gmail.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Cc: len.brown@intel.com, wency@cn.fujitsu.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, cl@linux.com,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jiang,

2012/07/01 0:51, Jiang Liu wrote:
> On 06/27/2012 01:44 PM, Yasuaki Ishimatsu wrote:
>> When offline_pages() is called to offlined memory, the function fails since
>> all memory has been offlined. In this case, the function should succeed.
>> The patch adds the check function into offline_pages().
>>
>> CC: Len Brown <len.brown@intel.com>
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: Paul Mackerras <paulus@samba.org>
>> CC: Christoph Lameter <cl@linux.com>
>> Cc: Minchan Kim <minchan.kim@gmail.com>
>> CC: Andrew Morton <akpm@linux-foundation.org>
>> CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
>> CC: Wen Congyang <wency@cn.fujitsu.com>
>> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>>
>> ---
>>   drivers/base/memory.c  |   20 ++++++++++++++++++++
>>   include/linux/memory.h |    1 +
>>   mm/memory_hotplug.c    |    5 +++++
>>   3 files changed, 26 insertions(+)
>>
>> Index: linux-3.5-rc4/drivers/base/memory.c
>> ===================================================================
>> --- linux-3.5-rc4.orig/drivers/base/memory.c	2012-06-26 13:28:16.726211752 +0900
>> +++ linux-3.5-rc4/drivers/base/memory.c	2012-06-26 13:34:22.423639904 +0900
>> @@ -70,6 +70,26 @@ void unregister_memory_isolate_notifier(
>>   }
>>   EXPORT_SYMBOL(unregister_memory_isolate_notifier);
>>
>> +bool memory_is_offline(unsigned long start_pfn, unsigned long end_pfn)
>> +{
>> +	struct memory_block *mem;
>> +	struct mem_section *section;
>> +	unsigned long pfn, section_nr;
>> +
>> +	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>> +		section_nr = pfn_to_section_nr(pfn);
>> +		section = __nr_to_section(section_nr);
>> +		mem = find_memory_block(section);
> Seems find_memory_block_hinted() is more efficient than find_memory_block() here.

Thanks. I'll update it.

Thanks,
Yasuaki Ishimatsu

> 
>> +		if (!mem)
>> +			continue;
>> +		if (mem->state == MEM_OFFLINE)
>> +			continue;
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>>   /*
>>    * register_memory - Setup a sysfs device for a memory block
>>    */
>> Index: linux-3.5-rc4/include/linux/memory.h
>> ===================================================================
>> --- linux-3.5-rc4.orig/include/linux/memory.h	2012-06-25 04:53:04.000000000 +0900
>> +++ linux-3.5-rc4/include/linux/memory.h	2012-06-26 13:34:22.424639891 +0900
>> @@ -120,6 +120,7 @@ extern int memory_isolate_notify(unsigne
>>   extern struct memory_block *find_memory_block_hinted(struct mem_section *,
>>   							struct memory_block *);
>>   extern struct memory_block *find_memory_block(struct mem_section *);
>> +extern bool memory_is_offline(unsigned long start_pfn, unsigned long end_pfn);
>>   #define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
>>   enum mem_add_context { BOOT, HOTPLUG };
>>   #endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
>> Index: linux-3.5-rc4/mm/memory_hotplug.c
>> ===================================================================
>> --- linux-3.5-rc4.orig/mm/memory_hotplug.c	2012-06-26 13:28:16.743211538 +0900
>> +++ linux-3.5-rc4/mm/memory_hotplug.c	2012-06-26 13:48:38.264940468 +0900
>> @@ -887,6 +887,11 @@ static int __ref offline_pages(unsigned
>>
>>   	lock_memory_hotplug();
>>
>> +	if (memory_is_offline(start_pfn, end_pfn)) {
>> +		ret = 0;
>> +		goto out;
>> +	}
>> +
>>   	zone = page_zone(pfn_to_page(start_pfn));
>>   	node = zone_to_nid(zone);
>>   	nr_pages = end_pfn - start_pfn;
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
> 
