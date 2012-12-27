Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 4C1D02C023B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2012 14:10:32 +1100 (EST)
Message-ID: <50DBBBEF.70701@cn.fujitsu.com>
Date: Thu, 27 Dec 2012 11:09:35 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH v5 04/14] memory-hotplug: remove /sys/firmware/memmap/X
 sysfs
References: <1356350964-13437-1-git-send-email-tangchen@cn.fujitsu.com>
 <1356350964-13437-5-git-send-email-tangchen@cn.fujitsu.com>
 <50DA6F5A.2070601@jp.fujitsu.com>
In-Reply-To: <50DA6F5A.2070601@jp.fujitsu.com>
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

On 12/26/2012 11:30 AM, Kamezawa Hiroyuki wrote:
>> @@ -41,6 +42,7 @@ struct firmware_map_entry {
>>    	const char		*type;	/* type of the memory range */
>>    	struct list_head	list;	/* entry for the linked list */
>>    	struct kobject		kobj;   /* kobject for each entry */
>> +	unsigned int		bootmem:1; /* allocated from bootmem */
>>    };
> 
> Can't we detect from which the object is allocated from, slab or bootmem ?
> 
> Hm, for example,
> 
>      PageReserved(virt_to_page(address_of_obj)) ?
>      PageSlab(virt_to_page(address_of_obj)) ?
> 

Hi Kamezawa-san,

I think we can detect it without a new member. I think bootmem:1 member
is just for convenience. I think I can remove it. :)

Thanks. :)
