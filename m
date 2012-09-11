Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2B7942C007B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 12:25:52 +1000 (EST)
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 3B85D3EE0C0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 11:25:48 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 2495D45DE58
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 11:25:48 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 02C6D45DE54
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 11:25:48 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id EA8AA1DB8040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 11:25:47 +0900 (JST)
Received: from g01jpexchyt28.g01.fujitsu.local
 (g01jpexchyt28.g01.fujitsu.local [10.128.193.111])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 99A7E1DB8043
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 11:25:47 +0900 (JST)
Message-ID: <504EA0F7.5090805@jp.fujitsu.com>
Date: Tue, 11 Sep 2012 11:24:55 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [RFC v9 PATCH 05/21] memory-hotplug: check whether memory is
 present or not
References: <1346837155-534-1-git-send-email-wency@cn.fujitsu.com>
 <1346837155-534-6-git-send-email-wency@cn.fujitsu.com>
 <504E9EBE.1040403@cn.fujitsu.com>
In-Reply-To: <504E9EBE.1040403@cn.fujitsu.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, len.brown@intel.com,
 linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 paulus@samba.org, minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com,
 rientjes@google.com, sparclinux@vger.kernel.org, cl@linux.com,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wen,

2012/09/11 11:15, Wen Congyang wrote:
> Hi, ishimatsu
>
> At 09/05/2012 05:25 PM, wency@cn.fujitsu.com Wrote:
>> From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>>
>> If system supports memory hot-remove, online_pages() may online removed pages.
>> So online_pages() need to check whether onlining pages are present or not.
>
> Because we use memory_block_change_state() to hotremoving memory, I think
> this patch can be removed. What do you think?

Pleae teach me detals a little more. If we use memory_block_change_state(),
does the conflict never occur? Why?

Thansk,
Yasuaki Ishimatsu

> Thanks
> Wen Congyang
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
>> CC: Wen Congyang <wency@cn.fujitsu.com>
>> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>> ---
>>   include/linux/mmzone.h |   19 +++++++++++++++++++
>>   mm/memory_hotplug.c    |   13 +++++++++++++
>>   2 files changed, 32 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 2daa54f..ac3ae30 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -1180,6 +1180,25 @@ void sparse_init(void);
>>   #define sparse_index_init(_sec, _nid)  do {} while (0)
>>   #endif /* CONFIG_SPARSEMEM */
>>
>> +#ifdef CONFIG_SPARSEMEM
>> +static inline int pfns_present(unsigned long pfn, unsigned long nr_pages)
>> +{
>> +	int i;
>> +	for (i = 0; i < nr_pages; i++) {
>> +		if (pfn_present(pfn + i))
>> +			continue;
>> +		else
>> +			return -EINVAL;
>> +	}
>> +	return 0;
>> +}
>> +#else
>> +static inline int pfns_present(unsigned long pfn, unsigned long nr_pages)
>> +{
>> +	return 0;
>> +}
>> +#endif /* CONFIG_SPARSEMEM*/
>> +
>>   #ifdef CONFIG_NODES_SPAN_OTHER_NODES
>>   bool early_pfn_in_nid(unsigned long pfn, int nid);
>>   #else
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 49f7747..299747d 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -467,6 +467,19 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages)
>>   	struct memory_notify arg;
>>
>>   	lock_memory_hotplug();
>> +	/*
>> +	 * If system supports memory hot-remove, the memory may have been
>> +	 * removed. So we check whether the memory has been removed or not.
>> +	 *
>> +	 * Note: When CONFIG_SPARSEMEM is defined, pfns_present() become
>> +	 *       effective. If CONFIG_SPARSEMEM is not defined, pfns_present()
>> +	 *       always returns 0.
>> +	 */
>> +	ret = pfns_present(pfn, nr_pages);
>> +	if (ret) {
>> +		unlock_memory_hotplug();
>> +		return ret;
>> +	}
>>   	arg.start_pfn = pfn;
>>   	arg.nr_pages = nr_pages;
>>   	arg.status_change_nid = -1;
>
