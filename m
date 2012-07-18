Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BEC8E2C0377
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2012 20:25:55 +1000 (EST)
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 8FFF03EE0C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2012 19:25:53 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7351045DE52
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2012 19:25:53 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 4747F45DE4E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2012 19:25:53 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 2EEBCE18004
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2012 19:25:53 +0900 (JST)
Received: from g01jpexchyt07.g01.fujitsu.local
 (g01jpexchyt07.g01.fujitsu.local [10.128.194.46])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id CE24F1DB8038
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2012 19:25:52 +0900 (JST)
Message-ID: <50068F19.1020606@jp.fujitsu.com>
Date: Wed, 18 Jul 2012 19:25:29 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [PATCH v4 3/13] memory-hotplug : check whether memory is present
 or not
References: <50068974.1070409@jp.fujitsu.com>
 <50068AE9.3050804@jp.fujitsu.com> <50068F0A.20100@cn.fujitsu.com>
In-Reply-To: <50068F0A.20100@cn.fujitsu.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 cl@linux.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wen,

2012/07/18 19:25, Wen Congyang wrote:
> At 07/18/2012 06:07 PM, Yasuaki Ishimatsu Wrote:
>> If system supports memory hot-remove, online_pages() may online removed pages.
>> So online_pages() need to check whether onlining pages are present or not.
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
>>
>> ---
>>   include/linux/mmzone.h |   21 +++++++++++++++++++++
>>   mm/memory_hotplug.c    |   13 +++++++++++++
>>   2 files changed, 34 insertions(+)
>>
>> Index: linux-3.5-rc6/include/linux/mmzone.h
>> ===================================================================
>> --- linux-3.5-rc6.orig/include/linux/mmzone.h	2012-07-08 09:23:56.000000000 +0900
>> +++ linux-3.5-rc6/include/linux/mmzone.h	2012-07-17 16:10:21.588186145 +0900
>> @@ -1168,6 +1168,27 @@ void sparse_init(void);
>>   #define sparse_index_init(_sec, _nid)  do {} while (0)
>>   #endif /* CONFIG_SPARSEMEM */
>>   
>> +#ifdef CONFIG_SPARSEMEM
>> +static inline int pfns_present(unsigned long pfn, unsigned long nr_pages)
>> +{
>> +	int i;
>> +	for (i = 0; i < nr_pages; i++) {
>> +		if (pfn_present(pfn + 1))
>> +			continue;
>> +		else {
>> +			unlock_memory_hotplug();
> 
> Why do you unlock memory hotplug here? The caller will do it.

Ah, you are right. In this case, the function should only return -EINVAL.

Thansks,
Yasuaki Ishimatsu
> 
> Thanks
> Wen Congyang
> 
>> +			return -EINVAL;
>> +		}
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
>> Index: linux-3.5-rc6/mm/memory_hotplug.c
>> ===================================================================
>> --- linux-3.5-rc6.orig/mm/memory_hotplug.c	2012-07-17 14:26:40.000000000 +0900
>> +++ linux-3.5-rc6/mm/memory_hotplug.c	2012-07-17 16:09:50.070580170 +0900
>> @@ -467,6 +467,19 @@ int __ref online_pages(unsigned long pfn
>>   	struct memory_notify arg;
>>   
>>   	lock_memory_hotplug();
>> +	/*
>> + 	 * If system supports memory hot-remove, the memory may have been
>> + 	 * removed. So we check whether the memory has been removed or not.
>> + 	 *
>> + 	 * Note: When CONFIG_SPARSEMEM is defined, pfns_present() become
>> + 	 *       effective. If CONFIG_SPARSEMEM is not defined, pfns_present()
>> + 	 *       always returns 0.
>> + 	 */
>> +	ret = pfns_present(pfn, nr_pages);
>> +	if (ret) {
>> +		unlock_memory_hotplug();
>> +		return ret;
>> +	}
>>   	arg.start_pfn = pfn;
>>   	arg.nr_pages = nr_pages;
>>   	arg.status_change_nid = -1;
>>
>>
> 
