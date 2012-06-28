Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 35BB5B6FBC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 17:01:24 +1000 (EST)
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 461A83EE0BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 16:01:23 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 3071D45DE59
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 16:01:23 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 057D845DE5A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 16:01:23 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id ECF231DB804D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 16:01:22 +0900 (JST)
Received: from g01jpexchkw02.g01.fujitsu.local
 (g01jpexchkw02.g01.fujitsu.local [10.0.194.41])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id ABAF31DB8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 16:01:22 +0900 (JST)
Message-ID: <4FEC012E.5030209@jp.fujitsu.com>
Date: Thu, 28 Jun 2012 16:01:02 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH 2/12] memory-hogplug : check memory offline in
 offline_pages
References: <4FEA9C88.1070800@jp.fujitsu.com> <4FEA9DB1.7010303@jp.fujitsu.com>
 <alpine.DEB.2.00.1206262313440.32567@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.00.1206262313440.32567@chino.kir.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
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

Hi David,

2012/06/27 15:16, David Rientjes wrote:
> On Wed, 27 Jun 2012, Yasuaki Ishimatsu wrote:
>
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
>
> Are there additional prerequisites for this patch?  Otherwise it changes
> the return value of offline_memory() which will now call
> acpi_memory_powerdown_device() in the acpi memhotplug case when disabling.
> Is that a problem?

I have understood there is a person who expects "offline_pages()" to fail
in this case by kosaki's comment. So I'll move memory_is_offline to caller
side.

Thanks,
Yasuaki Ishimatsu

>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
>
