Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4BD08B7004
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 14:50:46 +1000 (EST)
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id DA25D3EE0C0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 13:50:41 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id BD49A45DE53
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 13:50:41 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9AAF645DE50
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 13:50:41 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8CD321DB8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 13:50:41 +0900 (JST)
Received: from g01jpexchyt07.g01.fujitsu.local
 (g01jpexchyt07.g01.fujitsu.local [10.128.194.46])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 35E591DB803C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 13:50:41 +0900 (JST)
Message-ID: <4FEBE280.4060107@jp.fujitsu.com>
Date: Thu, 28 Jun 2012 13:50:08 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [RFC PATCH 1/12] memory-hotplug : rename remove_memory to
 offline_memory
References: <4FEA9C88.1070800@jp.fujitsu.com>
 <4FEA9D5C.1080508@jp.fujitsu.com> <4FEAB2E1.3090200@cn.fujitsu.com>
 <4FEAC891.7030808@cn.fujitsu.com> <4FEBC8EE.7040207@jp.fujitsu.com>
 <4FEBCE9C.7030904@cn.fujitsu.com>
In-Reply-To: <4FEBCE9C.7030904@cn.fujitsu.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 cl@linux.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wen,

2012/06/28 12:25, Wen Congyang wrote:
> At 06/28/2012 11:01 AM, Yasuaki Ishimatsu Wrote:
>> Hi David and Wen,
>>
>> Thank you for reviewing my patch.
>>
>> 2012/06/27 17:47, Wen Congyang wrote:
>>> At 06/27/2012 03:14 PM, Wen Congyang Wrote:
>>>> At 06/27/2012 01:42 PM, Yasuaki Ishimatsu Wrote:
>>>>> remove_memory() does not remove memory but just offlines memory. The patch
>>>>> changes name of it to offline_memory().
>>>>
>>>> There are 3 functions in the kernel:
>>>> 1. add_memory()
>>>> 2. online_pages()
>>>> 3. remove_memory()
>>>>
>>>> So I think offline_pages() is better than offline_memory().
>>>
>>> There is already a function named offline_pages(). So we
>>> should call offline_pages() instead of remove_memory() in
>>> memory_block_action(), and there is no need to rename
>>> remove_memory().
>>
>> As Wen says, Linux has 4 functions for memory hotplug already.
>> In my recognition, these functions are prepared for following purpose.
>>
>> 1. add_memory     : add physical memory
>> 2. online_pages   : online logical memory
>> 3. remove_memory  : offline logical memory
>> 4. offline_pages  : offline logical memory
>>
>> add_memory() is used for adding physical memory. I think remove_memory()
>> would rather be used for removing physical memory than be used for removing
>> logical memory. So I renamed remove_memory() to offline_memory().
>> How do you think?
> 
> Hmm, remove_memory() will revert all things we do in add_memory(), so I think

I think so too.

add_memory() prepares to use physical memory. It prepares some structures
(pgdat, page table, node, etc) for using the physical memory at the system.
But it does not online the meomory. For onlining the memory, we use
online_pages().

So I think that remove_memory() should remove these structures which are
prepared by add_memory() not offline memory. But current remove_memory() code
only calls offline_pages() and offlines memory.

The patch series recreates remove_memory() for removing these structures
after [RFC PATCH 3/12]. The reason to change the name of remove_memory() is a
preparation to recreate it.

Thanks,
Yasuaki Ishimatsu

> there is no need to rename it. If we rename it to offline_memory(), we should
> also rename add_memory() to online_memory().
> 
> Thanks
> Wen Congyang
> 
>>
>> Regards,
>> Yasuaki Ishimatsu
>>
>>>
>>> Thanks
>>> Wen Congyang
>>>
>>>>
>>>> Thanks
>>>> Wen Congyang
>>>>>
