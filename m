Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 97C7D2C0094
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 14:44:32 +1100 (EST)
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 by fgwmail8.fujitsu.co.jp (Postfix) with ESMTP id 83A8A179762B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:04:16 +0900 (JST)
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id C8CBF3EE0BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:04:11 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 74A9C45DE73
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:04:11 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id F04C745DE81
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:03:57 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id CE1B6E3804A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:02:57 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 702FAE38041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:02:57 +0900 (JST)
Message-ID: <50DA68A8.4060001@jp.fujitsu.com>
Date: Wed, 26 Dec 2012 12:02:00 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
To: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v5 01/14] memory-hotplug: try to offline the memory twice
 to avoid dependence
References: <1356350964-13437-1-git-send-email-tangchen@cn.fujitsu.com>
 <1356350964-13437-2-git-send-email-tangchen@cn.fujitsu.com>
In-Reply-To: <1356350964-13437-2-git-send-email-tangchen@cn.fujitsu.com>
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

(2012/12/24 21:09), Tang Chen wrote:
> From: Wen Congyang <wency@cn.fujitsu.com>
> 
> memory can't be offlined when CONFIG_MEMCG is selected.
> For example: there is a memory device on node 1. The address range
> is [1G, 1.5G). You will find 4 new directories memory8, memory9, memory10,
> and memory11 under the directory /sys/devices/system/memory/.
> 
> If CONFIG_MEMCG is selected, we will allocate memory to store page cgroup
> when we online pages. When we online memory8, the memory stored page cgroup
> is not provided by this memory device. But when we online memory9, the memory
> stored page cgroup may be provided by memory8. So we can't offline memory8
> now. We should offline the memory in the reversed order.
> 

If memory8 is onlined as NORMAL memory ...right ?

IIUC, vmalloc() uses __GFP_HIGHMEM but doesn't use __GFP_MOVABLE.

> When the memory device is hotremoved, we will auto offline memory provided
> by this memory device. But we don't know which memory is onlined first, so
> offlining memory may fail. In such case, iterate twice to offline the memory.
> 1st iterate: offline every non primary memory block.
> 2nd iterate: offline primary (i.e. first added) memory block.
> 
> This idea is suggested by KOSAKI Motohiro.
> 
> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>

I'm not sure but the whole DIMM should be onlined as MOVABLE mem ?

Anyway, I agree this kind of retry is required if memory is onlined as NORMAL mem.
But retry-once is ok ?

Thanks,
-Kame

> ---
>   mm/memory_hotplug.c |   16 ++++++++++++++--
>   1 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index d04ed87..62e04c9 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1388,10 +1388,13 @@ int remove_memory(u64 start, u64 size)
>   	unsigned long start_pfn, end_pfn;
>   	unsigned long pfn, section_nr;
>   	int ret;
> +	int return_on_error = 0;
> +	int retry = 0;
>   
>   	start_pfn = PFN_DOWN(start);
>   	end_pfn = start_pfn + PFN_DOWN(size);
>   
> +repeat:
>   	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>   		section_nr = pfn_to_section_nr(pfn);
>   		if (!present_section_nr(section_nr))
> @@ -1410,14 +1413,23 @@ int remove_memory(u64 start, u64 size)
>   
>   		ret = offline_memory_block(mem);
>   		if (ret) {
> -			kobject_put(&mem->dev.kobj);
> -			return ret;
> +			if (return_on_error) {
> +				kobject_put(&mem->dev.kobj);
> +				return ret;
> +			} else {
> +				retry = 1;
> +			}
>   		}
>   	}
>   
>   	if (mem)
>   		kobject_put(&mem->dev.kobj);
>   
> +	if (retry) {
> +		return_on_error = 1;
> +		goto repeat;
> +	}
> +
>   	return 0;
>   }
>   #else
> 
