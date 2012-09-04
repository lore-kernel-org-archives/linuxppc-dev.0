Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B76B72C0095
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2012 20:45:59 +1000 (EST)
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 by fgwmail8.fujitsu.co.jp (Postfix) with ESMTP id 1061F1793103
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2012 18:55:33 +0900 (JST)
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 44F163EE0C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2012 18:55:29 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 240D245DE52
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2012 18:55:29 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 0064645DE4D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2012 18:55:29 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id E3B1A1DB8047
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2012 18:55:28 +0900 (JST)
Received: from G01JPEXCHKW08.g01.fujitsu.local
 (G01JPEXCHKW08.g01.fujitsu.local [10.0.194.47])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 973EC1DB803A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2012 18:55:28 +0900 (JST)
Message-ID: <5045CFD6.9040408@jp.fujitsu.com>
Date: Tue, 4 Sep 2012 18:54:30 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [RFC v8 PATCH 13/20] memory-hotplug: check page type in
 get_page_bootmem
References: <1346148027-24468-1-git-send-email-wency@cn.fujitsu.com>	<1346148027-24468-14-git-send-email-wency@cn.fujitsu.com>
 <20120831143032.1343e99a.akpm@linux-foundation.org>
 <50457983.1050304@cn.fujitsu.com>
In-Reply-To: <50457983.1050304@cn.fujitsu.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, len.brown@intel.com,
 linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 paulus@samba.org, minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com,
 rientjes@google.com, sparclinux@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 cl@linux.com, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wen,

2012/09/04 12:46, Wen Congyang wrote:
> Hi, isimatu-san
>
> At 09/01/2012 05:30 AM, Andrew Morton Wrote:
>> On Tue, 28 Aug 2012 18:00:20 +0800
>> wency@cn.fujitsu.com wrote:
>>
>>> From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>>>
>>> There is a possibility that get_page_bootmem() is called to the same page many
>>> times. So when get_page_bootmem is called to the same page, the function only
>>> increments page->_count.
>>
>> I really don't understand this explanation, even after having looked at
>> the code.  Can you please have another attempt at the changelog?
>
> What is the problem that you want to fix? The function get_page_bootmem()
> may be called to the same page more than once, but I don't find any problem
> about current implementation.

The patch is just optimization. The patch does not fix a problems.
As you know, the function may be called many times for the same page.
I think if a page is sets to page_type and Page Private flag and page->private,
the page need not be set the same things again. So we check page_type when
get_page_bootmem() is called. And if the page has been set to them, the page
is only incremented page->_count.

Thanks,
Yasuaki Ishimatsu

>
> Thanks
> Wen Congyang
>
>>
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -95,10 +95,17 @@ static void release_memory_resource(struct resource *res)
>>>   static void get_page_bootmem(unsigned long info,  struct page *page,
>>>   			     unsigned long type)
>>>   {
>>> -	page->lru.next = (struct list_head *) type;
>>> -	SetPagePrivate(page);
>>> -	set_page_private(page, info);
>>> -	atomic_inc(&page->_count);
>>> +	unsigned long page_type;
>>> +
>>> +	page_type = (unsigned long) page->lru.next;
>>> +	if (page_type < MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE ||
>>> +	    page_type > MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE){
>>> +		page->lru.next = (struct list_head *) type;
>>> +		SetPagePrivate(page);
>>> +		set_page_private(page, info);
>>> +		atomic_inc(&page->_count);
>>> +	} else
>>> +		atomic_inc(&page->_count);
>>>   }
>>
>> And a code comment which explains what is going on would be good.  As
>> is always the case ;)
>>
>>
>
