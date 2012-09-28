Return-Path: <nizhan.chen@gmail.com>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 193912C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 13:37:40 +1000 (EST)
Received: by oagn12 with SMTP id n12so2537456oag.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2012 20:37:37 -0700 (PDT)
Message-ID: <50651B77.1070809@gmail.com>
Date: Fri, 28 Sep 2012 11:37:27 +0800
From: Ni zhan Chen <nizhan.chen@gmail.com>
MIME-Version: 1.0
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [RFC v9 PATCH 05/21] memory-hotplug: check whether memory is
 present or not
References: <1346837155-534-1-git-send-email-wency@cn.fujitsu.com>
 <1346837155-534-6-git-send-email-wency@cn.fujitsu.com>
 <504E9EBE.1040403@cn.fujitsu.com> <504EA0F7.5090805@jp.fujitsu.com>
In-Reply-To: <504EA0F7.5090805@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 Wen Congyang <wency@cn.fujitsu.com>, linux-acpi@vger.kernel.org,
 linux-sh@vger.kernel.org, len.brown@intel.com, x86@kernel.org,
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

On 09/11/2012 10:24 AM, Yasuaki Ishimatsu wrote:
> Hi Wen,
>
> 2012/09/11 11:15, Wen Congyang wrote:
>> Hi, ishimatsu
>>
>> At 09/05/2012 05:25 PM, wency@cn.fujitsu.com Wrote:
>>> From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>>>
>>> If system supports memory hot-remove, online_pages() may online 
>>> removed pages.
>>> So online_pages() need to check whether onlining pages are present 
>>> or not.
>>
>> Because we use memory_block_change_state() to hotremoving memory, I 
>> think
>> this patch can be removed. What do you think?
>
> Pleae teach me detals a little more. If we use 
> memory_block_change_state(),
> does the conflict never occur? Why?

since memory hot-add or hot-remove is based on memblock, if check in 
memory_block_change_state()
can guarantee conflict never occur?

>
> Thansk,
> Yasuaki Ishimatsu
>
>> Thanks
>> Wen Congyang
>>
>>>
>>> CC: David Rientjes <rientjes@google.com>
>>> CC: Jiang Liu <liuj97@gmail.com>
>>> CC: Len Brown <len.brown@intel.com>
>>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> CC: Paul Mackerras <paulus@samba.org>
>>> CC: Christoph Lameter <cl@linux.com>
>>> Cc: Minchan Kim <minchan.kim@gmail.com>
>>> CC: Andrew Morton <akpm@linux-foundation.org>
>>> CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
>>> CC: Wen Congyang <wency@cn.fujitsu.com>
>>> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>>> ---
>>>   include/linux/mmzone.h |   19 +++++++++++++++++++
>>>   mm/memory_hotplug.c    |   13 +++++++++++++
>>>   2 files changed, 32 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>> index 2daa54f..ac3ae30 100644
>>> --- a/include/linux/mmzone.h
>>> +++ b/include/linux/mmzone.h
>>> @@ -1180,6 +1180,25 @@ void sparse_init(void);
>>>   #define sparse_index_init(_sec, _nid)  do {} while (0)
>>>   #endif /* CONFIG_SPARSEMEM */
>>>
>>> +#ifdef CONFIG_SPARSEMEM
>>> +static inline int pfns_present(unsigned long pfn, unsigned long 
>>> nr_pages)
>>> +{
>>> +    int i;
>>> +    for (i = 0; i < nr_pages; i++) {
>>> +        if (pfn_present(pfn + i))
>>> +            continue;
>>> +        else
>>> +            return -EINVAL;
>>> +    }
>>> +    return 0;
>>> +}
>>> +#else
>>> +static inline int pfns_present(unsigned long pfn, unsigned long 
>>> nr_pages)
>>> +{
>>> +    return 0;
>>> +}
>>> +#endif /* CONFIG_SPARSEMEM*/
>>> +
>>>   #ifdef CONFIG_NODES_SPAN_OTHER_NODES
>>>   bool early_pfn_in_nid(unsigned long pfn, int nid);
>>>   #else
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index 49f7747..299747d 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -467,6 +467,19 @@ int __ref online_pages(unsigned long pfn, 
>>> unsigned long nr_pages)
>>>       struct memory_notify arg;
>>>
>>>       lock_memory_hotplug();
>>> +    /*
>>> +     * If system supports memory hot-remove, the memory may have been
>>> +     * removed. So we check whether the memory has been removed or 
>>> not.
>>> +     *
>>> +     * Note: When CONFIG_SPARSEMEM is defined, pfns_present() become
>>> +     *       effective. If CONFIG_SPARSEMEM is not defined, 
>>> pfns_present()
>>> +     *       always returns 0.
>>> +     */
>>> +    ret = pfns_present(pfn, nr_pages);
>>> +    if (ret) {
>>> +        unlock_memory_hotplug();
>>> +        return ret;
>>> +    }
>>>       arg.start_pfn = pfn;
>>>       arg.nr_pages = nr_pages;
>>>       arg.status_change_nid = -1;
>>
>
>
> -- 
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
>
