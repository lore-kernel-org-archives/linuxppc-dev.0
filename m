Return-Path: <wency@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id D95372C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2012 13:59:22 +1100 (EST)
Message-ID: <50AC4505.1000007@cn.fujitsu.com>
Date: Wed, 21 Nov 2012 11:05:41 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
To: Jaegeuk Hanse <jaegeuk.hanse@gmail.com>
Subject: Re: [PATCH v3 06/12] memory-hotplug: unregister memory section on
 SPARSEMEM_VMEMMAP
References: <1351763083-7905-1-git-send-email-wency@cn.fujitsu.com>
 <1351763083-7905-7-git-send-email-wency@cn.fujitsu.com>
 <50AB669D.3060007@gmail.com>
In-Reply-To: <50AB669D.3060007@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org,
 linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 cmetcalf@tilera.com, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, paulus@samba.org,
 Minchan Kim <minchan.kim@gmail.com>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 David Rientjes <rientjes@google.com>, sparclinux@vger.kernel.org,
 Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>, Jiang Liu <liuj97@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At 11/20/2012 07:16 PM, Jaegeuk Hanse Wrote:
> On 11/01/2012 05:44 PM, Wen Congyang wrote:
>> From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>>
>> Currently __remove_section for SPARSEMEM_VMEMMAP does nothing. But
>> even if
>> we use SPARSEMEM_VMEMMAP, we can unregister the memory_section.
>>
>> So the patch add unregister_memory_section() into __remove_section().
> 
> Hi Yasuaki,
> 
> I have a question about these sparse vmemmap memory related patches. Hot
> add memory need allocated vmemmap pages, but this time is allocated by
> buddy system. How can gurantee virtual address is continuous to the
> address allocated before? If not continuous, page_to_pfn and pfn_to_page
> can't work correctly.

vmemmap has its virtual address range:
ffffea0000000000 - ffffeaffffffffff (=40 bits) virtual memory map (1TB)

We allocate memory from buddy system to store struct page, and its virtual
address isn't in this range. So we should update the page table:

kmalloc_section_memmap()
    sparse_mem_map_populate()
        pfn_to_page() // get the virtual address in the vmemmap range
        vmemmap_populate() // we update page table here

When we use vmemmap, page_to_pfn() always returns address in the vmemmap
range, not the address that kmalloc() returns. So the virtual address
is continuous.

Thanks
Wen Congyang
> 
> Regards,
> Jaegeuk
> 
>>
>> CC: David Rientjes <rientjes@google.com>
>> CC: Jiang Liu <liuj97@gmail.com>
>> CC: Len Brown <len.brown@intel.com>
>> CC: Christoph Lameter <cl@linux.com>
>> Cc: Minchan Kim <minchan.kim@gmail.com>
>> CC: Andrew Morton <akpm@linux-foundation.org>
>> CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
>> CC: Wen Congyang <wency@cn.fujitsu.com>
>> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>> ---
>>   mm/memory_hotplug.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index ca07433..66a79a7 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -286,11 +286,14 @@ static int __meminit __add_section(int nid,
>> struct zone *zone,
>>   #ifdef CONFIG_SPARSEMEM_VMEMMAP
>>   static int __remove_section(struct zone *zone, struct mem_section *ms)
>>   {
>> -    /*
>> -     * XXX: Freeing memmap with vmemmap is not implement yet.
>> -     *      This should be removed later.
>> -     */
>> -    return -EBUSY;
>> +    int ret = -EINVAL;
>> +
>> +    if (!valid_section(ms))
>> +        return ret;
>> +
>> +    ret = unregister_memory_section(ms);
>> +
>> +    return ret;
>>   }
>>   #else
>>   static int __remove_section(struct zone *zone, struct mem_section *ms)
> 
> 
