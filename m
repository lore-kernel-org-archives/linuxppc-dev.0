Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C11C62C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 14:56:36 +1100 (EST)
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 8B3303EE0C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:56:34 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5B55445DE6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:56:34 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id E1CED45DE72
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:56:33 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id D144AE3800B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:56:33 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 88C33E38007
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:56:33 +0900 (JST)
Message-ID: <50DA7533.6060407@jp.fujitsu.com>
Date: Wed, 26 Dec 2012 12:55:31 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
To: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v5 14/14] memory-hotplug: free node_data when a node is
 offlined
References: <1356350964-13437-1-git-send-email-tangchen@cn.fujitsu.com>
 <1356350964-13437-15-git-send-email-tangchen@cn.fujitsu.com>
In-Reply-To: <1356350964-13437-15-git-send-email-tangchen@cn.fujitsu.com>
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
> We call hotadd_new_pgdat() to allocate memory to store node_data. So we
> should free it when removing a node.
> 
> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>

I'm sorry but is it safe to remove pgdat ? All zone cache and zonelists are
properly cleared/rebuilded in synchronous way ? and No threads are visinting
zone in vmscan.c ?

Thanks,
-Kame

> ---
>   mm/memory_hotplug.c |   20 +++++++++++++++++++-
>   1 files changed, 19 insertions(+), 1 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index f8a1d2f..447fa24 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1680,9 +1680,12 @@ static int check_cpu_on_node(void *data)
>   /* offline the node if all memory sections of this node are removed */
>   static void try_offline_node(int nid)
>   {
> +	pg_data_t *pgdat = NODE_DATA(nid);
>   	unsigned long start_pfn = NODE_DATA(nid)->node_start_pfn;
> -	unsigned long end_pfn = start_pfn + NODE_DATA(nid)->node_spanned_pages;
> +	unsigned long end_pfn = start_pfn + pgdat->node_spanned_pages;
>   	unsigned long pfn;
> +	struct page *pgdat_page = virt_to_page(pgdat);
> +	int i;
>   
>   	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>   		unsigned long section_nr = pfn_to_section_nr(pfn);
> @@ -1709,6 +1712,21 @@ static void try_offline_node(int nid)
>   	 */
>   	node_set_offline(nid);
>   	unregister_one_node(nid);
> +
> +	if (!PageSlab(pgdat_page) && !PageCompound(pgdat_page))
> +		/* node data is allocated from boot memory */
> +		return;
> +
> +	/* free waittable in each zone */
> +	for (i = 0; i < MAX_NR_ZONES; i++) {
> +		struct zone *zone = pgdat->node_zones + i;
> +
> +		if (zone->wait_table)
> +			vfree(zone->wait_table);
> +	}
> +
> +	arch_refresh_nodedata(nid, NULL);
> +	arch_free_nodedata(pgdat);
>   }
>   
>   int __ref remove_memory(int nid, u64 start, u64 size)
> 
