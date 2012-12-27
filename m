Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 534CB2C00DB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2012 14:11:54 +1100 (EST)
Message-ID: <50DBBC40.6040700@cn.fujitsu.com>
Date: Thu, 27 Dec 2012 11:10:56 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH v5 02/14] memory-hotplug: check whether all memory blocks
 are offlined or not when removing memory
References: <1356350964-13437-1-git-send-email-tangchen@cn.fujitsu.com>
 <1356350964-13437-3-git-send-email-tangchen@cn.fujitsu.com>
 <50DA6AB3.2030608@jp.fujitsu.com>
In-Reply-To: <50DA6AB3.2030608@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, liuj97@gmail.com,
 len.brown@intel.com, wency@cn.fujitsu.com, cmetcalf@tilera.com,
 wujianguo@huawei.com, yinghai@kernel.org, laijs@cn.fujitsu.com,
 linux-kernel@vger.kernel.org, minchan.kim@gmail.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/26/2012 11:10 AM, Kamezawa Hiroyuki wrote:
> (2012/12/24 21:09), Tang Chen wrote:
>> From: Yasuaki Ishimatsu<isimatu.yasuaki@jp.fujitsu.com>
>>
>> We remove the memory like this:
>> 1. lock memory hotplug
>> 2. offline a memory block
>> 3. unlock memory hotplug
>> 4. repeat 1-3 to offline all memory blocks
>> 5. lock memory hotplug
>> 6. remove memory(TODO)
>> 7. unlock memory hotplug
>>
>> All memory blocks must be offlined before removing memory. But we don't hold
>> the lock in the whole operation. So we should check whether all memory blocks
>> are offlined before step6. Otherwise, kernel maybe panicked.
>>
>> Signed-off-by: Wen Congyang<wency@cn.fujitsu.com>
>> Signed-off-by: Yasuaki Ishimatsu<isimatu.yasuaki@jp.fujitsu.com>
> 
> Acked-by: KAMEZAWA Hiroyuki<kamezawa.hiroyu@jp.fujitsu.com>
> 
> a nitpick below.
> 
>> +
>> +	for (pfn = start_pfn; pfn<  end_pfn; pfn += PAGES_PER_SECTION) {
> 
> I prefer adding mem = NULL at the start of this for().

Hi Kamezawa-san,

Added, thanks. :)

> 
>> +		section_nr = pfn_to_section_nr(pfn);
>> +		if (!present_section_nr(section_nr))
>> +			continue;
>> +
>> +		section = __nr_to_section(section_nr);
>> +		/* same memblock? */
>> +		if (mem)
>> +			if ((section_nr>= mem->start_section_nr)&&
>> +			    (section_nr<= mem->end_section_nr))
>> +				continue;
>> +
> 
> Thanks,
> -Kame
> 
> 
> 
