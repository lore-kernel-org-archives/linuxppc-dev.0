Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1C2F42C0092
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 20:45:33 +1000 (EST)
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 435F63EE0C2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 19:45:32 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 2177645DE54
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 19:45:32 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 0569E45DE4E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 19:45:32 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id EA3E41DB8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 19:45:31 +0900 (JST)
Received: from g01jpexchkw05.g01.fujitsu.local
 (g01jpexchkw05.g01.fujitsu.local [10.0.194.44])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id A9C511DB803C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 19:45:31 +0900 (JST)
Message-ID: <5012712E.9000005@jp.fujitsu.com>
Date: Fri, 27 Jul 2012 19:45:02 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [RFC PATCH v5 19/19] memory-hotplug: remove sysfs file of node
References: <50126B83.3050201@cn.fujitsu.com> <50126F21.803@cn.fujitsu.com>
In-Reply-To: <50126F21.803@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-acpi@vger.kernel.org, len.brown@intel.com, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 paulus@samba.org, minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com,
 rientjes@google.com, cl@linux.com, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wen,

2012/07/27 19:36, Wen Congyang wrote:
> From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>
> The patch adds node_set_offline() and unregister_one_node() to remove_memory()
> for removing sysfs file of node.
>
> CC: David Rientjes <rientjes@google.com>
> CC: Jiang Liu <liuj97@gmail.com>
> CC: Len Brown <len.brown@intel.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Christoph Lameter <cl@linux.com>
> Cc: Minchan Kim <minchan.kim@gmail.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
> CC: Wen Congyang <wency@cn.fujitsu.com>
> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> ---
>   mm/memory_hotplug.c |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 5ac035f..5681968 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1267,6 +1267,11 @@ int __ref remove_memory(int nid, u64 start, u64 size)
>   	/* remove memmap entry */
>   	firmware_map_remove(start, start + size, "System RAM");
>
> +	if (!node_present_pages(nid)) {

Applying [PATCH v5 17/19], pgdat->node_spanned_pages can become 0 when
all memory of the pgdat is removed. When pgdat->node_spanned_pages is 0,
it means the pgdat has no memory. So I think node_spanned_pages() is
better.

Thanks,
Yasuaki Ishimatsu

> +		node_set_offline(nid);
> +		unregister_one_node(nid);
> +	}
> +
>   	arch_remove_memory(start, size);
>   out:
>   	unlock_memory_hotplug();
>
