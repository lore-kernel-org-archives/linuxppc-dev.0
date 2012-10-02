Return-Path: <nizhan.chen@gmail.com>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 483732C0096
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2012 22:24:18 +1000 (EST)
Received: by iebc10 with SMTP id c10so13532101ieb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2012 05:24:15 -0700 (PDT)
Message-ID: <506ADCE0.1020602@gmail.com>
Date: Tue, 02 Oct 2012 20:24:00 +0800
From: Ni zhan Chen <nizhan.chen@gmail.com>
MIME-Version: 1.0
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [RFC v9 PATCH 13/21] memory-hotplug: check page type in
 get_page_bootmem
References: <1346837155-534-1-git-send-email-wency@cn.fujitsu.com>
 <1346837155-534-14-git-send-email-wency@cn.fujitsu.com>
 <506659D7.9080904@gmail.com> <506907E5.2080609@jp.fujitsu.com>
In-Reply-To: <506907E5.2080609@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 Wen Congyang <wency@cn.fujitsu.com>, len.brown@intel.com,
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

On 10/01/2012 11:03 AM, Yasuaki Ishimatsu wrote:
> Hi Chen,
>
> 2012/09/29 11:15, Ni zhan Chen wrote:
>> On 09/05/2012 05:25 PM, wency@cn.fujitsu.com wrote:
>>> From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>>>
>>> The function get_page_bootmem() may be called more than one time to 
>>> the same
>>> page. There is no need to set page's type, private if the function 
>>> is not
>>> the first time called to the page.
>>>
>>> Note: the patch is just optimization and does not fix any problem.
>>
>> Hi Yasuaki,
>>
>> this patch is reasonable to me. I have another question associated to 
>> get_page_bootmem(), the question is from another fujitsu guy's patch 
>> changelog [commit : 04753278769f3], the changelog said  that:
>>
>>   1) When the memmap of removing section is allocated on other
>>       section by bootmem, it should/can be free.
>>   2) When the memmap of removing section is allocated on the
>>       same section, it shouldn't be freed. Because the section has to be
>>       logical memory offlined already and all pages must be isolated 
>> against
>>       page allocater. If it is freed, page allocator may use it which 
>> will
>>       be removed physically soon.
>>
>> but I don't see his patch guarantee 2), it means that his patch 
>> doesn't guarantee the memmap of removing section which is allocated 
>> on other section by bootmem doesn't be freed. Hopefully get your 
>> explaination in details, thanks in advance. :-)
>
> In my understanding, the patch does not guarantee it.
> Please see [commit : 0c0a4a517a31e]. free_map_bootmem() in the commit
> guarantees it.

Thanks Yasuaki, I have already seen the commit you mentioned. But the 
changelog of the commit I point out 2), why it said that "If it is 
freed, page allocator may use it which will be removed physically soon", 
does it mean that use-after-free ? AFAK, the isolated pages will be free 
if no users use it, so why not free the associated memmap?

>
> Thanks,
> Yasuaki Ishimatsu
>
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
>>>   mm/memory_hotplug.c |   15 +++++++++++----
>>>   1 files changed, 11 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index d736df3..26a5012 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -95,10 +95,17 @@ static void release_memory_resource(struct 
>>> resource *res)
>>>   static void get_page_bootmem(unsigned long info,  struct page *page,
>>>                    unsigned long type)
>>>   {
>>> -    page->lru.next = (struct list_head *) type;
>>> -    SetPagePrivate(page);
>>> -    set_page_private(page, info);
>>> -    atomic_inc(&page->_count);
>>> +    unsigned long page_type;
>>> +
>>> +    page_type = (unsigned long)page->lru.next;
>>> +    if (page_type < MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE ||
>>> +        page_type > MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE){
>>> +        page->lru.next = (struct list_head *)type;
>>> +        SetPagePrivate(page);
>>> +        set_page_private(page, info);
>>> +        atomic_inc(&page->_count);
>>> +    } else
>>> +        atomic_inc(&page->_count);
>>>   }
>>>   /* reference to __meminit __free_pages_bootmem is valid
>>
>
>
>
