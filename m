Return-Path: <wency@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 8E3CC2C00D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2012 23:09:59 +1100 (EST)
Message-ID: <50DC3C26.6060308@cn.fujitsu.com>
Date: Thu, 27 Dec 2012 20:16:38 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
To: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH v5 14/14] memory-hotplug: free node_data when a node is
 offlined
References: <1356350964-13437-1-git-send-email-tangchen@cn.fujitsu.com>
 <1356350964-13437-15-git-send-email-tangchen@cn.fujitsu.com>
 <50DA7533.6060407@jp.fujitsu.com>
In-Reply-To: <50DA7533.6060407@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Tang Chen <tangchen@cn.fujitsu.com>, linux-mm@kvack.org, paulus@samba.org,
 hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, liuj97@gmail.com,
 len.brown@intel.com, cmetcalf@tilera.com, wujianguo@huawei.com,
 yinghai@kernel.org, laijs@cn.fujitsu.com, linux-kernel@vger.kernel.org,
 minchan.kim@gmail.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At 12/26/2012 11:55 AM, Kamezawa Hiroyuki Wrote:
> (2012/12/24 21:09), Tang Chen wrote:
>> From: Wen Congyang <wency@cn.fujitsu.com>
>>
>> We call hotadd_new_pgdat() to allocate memory to store node_data. So we
>> should free it when removing a node.
>>
>> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
> 
> I'm sorry but is it safe to remove pgdat ? All zone cache and zonelists are
> properly cleared/rebuilded in synchronous way ? and No threads are visinting
> zone in vmscan.c ?

We have rebuilt zonelists when a zone has no memory after offlining some pages.

Thanks
Wen Congyang

> 
> Thanks,
> -Kame
> 
>> ---
>>   mm/memory_hotplug.c |   20 +++++++++++++++++++-
>>   1 files changed, 19 insertions(+), 1 deletions(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index f8a1d2f..447fa24 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1680,9 +1680,12 @@ static int check_cpu_on_node(void *data)
>>   /* offline the node if all memory sections of this node are removed */
>>   static void try_offline_node(int nid)
>>   {
>> +	pg_data_t *pgdat = NODE_DATA(nid);
>>   	unsigned long start_pfn = NODE_DATA(nid)->node_start_pfn;
>> -	unsigned long end_pfn = start_pfn + NODE_DATA(nid)->node_spanned_pages;
>> +	unsigned long end_pfn = start_pfn + pgdat->node_spanned_pages;
>>   	unsigned long pfn;
>> +	struct page *pgdat_page = virt_to_page(pgdat);
>> +	int i;
>>   
>>   	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>>   		unsigned long section_nr = pfn_to_section_nr(pfn);
>> @@ -1709,6 +1712,21 @@ static void try_offline_node(int nid)
>>   	 */
>>   	node_set_offline(nid);
>>   	unregister_one_node(nid);
>> +
>> +	if (!PageSlab(pgdat_page) && !PageCompound(pgdat_page))
>> +		/* node data is allocated from boot memory */
>> +		return;
>> +
>> +	/* free waittable in each zone */
>> +	for (i = 0; i < MAX_NR_ZONES; i++) {
>> +		struct zone *zone = pgdat->node_zones + i;
>> +
>> +		if (zone->wait_table)
>> +			vfree(zone->wait_table);
>> +	}
>> +
>> +	arch_refresh_nodedata(nid, NULL);
>> +	arch_free_nodedata(pgdat);
>>   }
>>   
>>   int __ref remove_memory(int nid, u64 start, u64 size)
>>
> 
> 
> 
