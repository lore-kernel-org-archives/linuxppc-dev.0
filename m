Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B5FEC2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 14:21:44 +1100 (EST)
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id F3E803EE0BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:21:42 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id CE88A45DE74
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:21:42 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id B04C045DE84
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:21:42 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9F80A1DB8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:21:42 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3B32C1DB8044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:21:42 +0900 (JST)
Message-ID: <50DA6D04.8020906@jp.fujitsu.com>
Date: Wed, 26 Dec 2012 12:20:36 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
To: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v5 03/14] memory-hotplug: remove redundant codes
References: <1356350964-13437-1-git-send-email-tangchen@cn.fujitsu.com>
 <1356350964-13437-4-git-send-email-tangchen@cn.fujitsu.com>
In-Reply-To: <1356350964-13437-4-git-send-email-tangchen@cn.fujitsu.com>
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
> offlining memory blocks and checking whether memory blocks are offlined
> are very similar. This patch introduces a new function to remove
> redundant codes.
> 
> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
> ---
>   mm/memory_hotplug.c |  101 ++++++++++++++++++++++++++++-----------------------
>   1 files changed, 55 insertions(+), 46 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index d43d97b..dbb04d8 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1381,20 +1381,14 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>   	return __offline_pages(start_pfn, start_pfn + nr_pages, 120 * HZ);
>   }
>   
> -int remove_memory(u64 start, u64 size)

please add explanation of this function here. If (*func) returns val other than 0,
this function will fail and returns callback's return value...right ?


> +static int walk_memory_range(unsigned long start_pfn, unsigned long end_pfn,
> +		void *arg, int (*func)(struct memory_block *, void *))
>   {
>   	struct memory_block *mem = NULL;
>   	struct mem_section *section;
> -	unsigned long start_pfn, end_pfn;
>   	unsigned long pfn, section_nr;
>   	int ret;
> -	int return_on_error = 0;
> -	int retry = 0;
> -
> -	start_pfn = PFN_DOWN(start);
> -	end_pfn = start_pfn + PFN_DOWN(size);
>   
> -repeat:

Shouldn't we check lock is held here ? (VM_BUG_ON(!mutex_is_locked(&mem_hotplug_mutex);


>   	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>   		section_nr = pfn_to_section_nr(pfn);
>   		if (!present_section_nr(section_nr))
> @@ -1411,22 +1405,61 @@ repeat:
>   		if (!mem)
>   			continue;
>   
> -		ret = offline_memory_block(mem);
> +		ret = func(mem, arg);
>   		if (ret) {
> -			if (return_on_error) {
> -				kobject_put(&mem->dev.kobj);
> -				return ret;
> -			} else {
> -				retry = 1;
> -			}
> +			kobject_put(&mem->dev.kobj);
> +			return ret;
>   		}
>   	}
>   
>   	if (mem)
>   		kobject_put(&mem->dev.kobj);
>   
> -	if (retry) {
> -		return_on_error = 1;
> +	return 0;
> +}
> +
> +static int offline_memory_block_cb(struct memory_block *mem, void *arg)
> +{
> +	int *ret = arg;
> +	int error = offline_memory_block(mem);
> +
> +	if (error != 0 && *ret == 0)
> +		*ret = error;
> +
> +	return 0;

Always returns 0 and run through all mem blocks for scan-and-retry, right ?
You need explanation here !


> +}
> +
> +static int is_memblock_offlined_cb(struct memory_block *mem, void *arg)
> +{
> +	int ret = !is_memblock_offlined(mem);
> +
> +	if (unlikely(ret))
> +		pr_warn("removing memory fails, because memory "
> +			"[%#010llx-%#010llx] is onlined\n",
> +			PFN_PHYS(section_nr_to_pfn(mem->start_section_nr)),
> +			PFN_PHYS(section_nr_to_pfn(mem->end_section_nr + 1))-1);
> +
> +	return ret;
> +}
> +
> +int remove_memory(u64 start, u64 size)
> +{
> +	unsigned long start_pfn, end_pfn;
> +	int ret = 0;
> +	int retry = 1;
> +
> +	start_pfn = PFN_DOWN(start);
> +	end_pfn = start_pfn + PFN_DOWN(size);
> +
> +repeat:

please explan why you repeat here .

> +	walk_memory_range(start_pfn, end_pfn, &ret,
> +			  offline_memory_block_cb);
> +	if (ret) {
> +		if (!retry)
> +			return ret;
> +
> +		retry = 0;
> +		ret = 0;
>   		goto repeat;
>   	}
>   
> @@ -1444,37 +1477,13 @@ repeat:
>   	 * memory blocks are offlined.
>   	 */
>   
> -	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
> -		section_nr = pfn_to_section_nr(pfn);
> -		if (!present_section_nr(section_nr))
> -			continue;
> -
> -		section = __nr_to_section(section_nr);
> -		/* same memblock? */
> -		if (mem)
> -			if ((section_nr >= mem->start_section_nr) &&
> -			    (section_nr <= mem->end_section_nr))
> -				continue;
> -
> -		mem = find_memory_block_hinted(section, mem);
> -		if (!mem)
> -			continue;
> -
> -		ret = is_memblock_offlined(mem);
> -		if (!ret) {
> -			pr_warn("removing memory fails, because memory "
> -				"[%#010llx-%#010llx] is onlined\n",
> -				PFN_PHYS(section_nr_to_pfn(mem->start_section_nr)),
> -				PFN_PHYS(section_nr_to_pfn(mem->end_section_nr + 1)) - 1);
> -
> -			kobject_put(&mem->dev.kobj);
> -			unlock_memory_hotplug();
> -			return ret;
> -		}

please explain what you do here. confirming all memory blocks are offlined
before returning 0 ....right ? 

> +	ret = walk_memory_range(start_pfn, end_pfn, NULL,
> +				is_memblock_offlined_cb);
> +	if (ret) {
> +		unlock_memory_hotplug();
> +		return ret;
>   	}
>   
> -	if (mem)
> -		kobject_put(&mem->dev.kobj);
>   	unlock_memory_hotplug();
>   
>   	return 0;
> 

Thanks,
-Kame
