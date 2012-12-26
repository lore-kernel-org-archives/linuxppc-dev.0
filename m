Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E894C2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 14:31:49 +1100 (EST)
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 049963EE0CD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:31:48 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id E09F245DE95
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:31:47 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id B865D45DEAE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:31:47 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id A783AE08005
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:31:47 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 54FF81DB803B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:31:47 +0900 (JST)
Message-ID: <50DA6F5A.2070601@jp.fujitsu.com>
Date: Wed, 26 Dec 2012 12:30:34 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
To: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v5 04/14] memory-hotplug: remove /sys/firmware/memmap/X
 sysfs
References: <1356350964-13437-1-git-send-email-tangchen@cn.fujitsu.com>
 <1356350964-13437-5-git-send-email-tangchen@cn.fujitsu.com>
In-Reply-To: <1356350964-13437-5-git-send-email-tangchen@cn.fujitsu.com>
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
> From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> 
> When (hot)adding memory into system, /sys/firmware/memmap/X/{end, start, type}
> sysfs files are created. But there is no code to remove these files. The patch
> implements the function to remove them.
> 
> Note: The code does not free firmware_map_entry which is allocated by bootmem.
>        So the patch makes memory leak. But I think the memory leak size is
>        very samll. And it does not affect the system.
> 
> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> ---
>   drivers/firmware/memmap.c    |   98 +++++++++++++++++++++++++++++++++++++++++-
>   include/linux/firmware-map.h |    6 +++
>   mm/memory_hotplug.c          |    5 ++-
>   3 files changed, 106 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/memmap.c b/drivers/firmware/memmap.c
> index 90723e6..49be12a 100644
> --- a/drivers/firmware/memmap.c
> +++ b/drivers/firmware/memmap.c
> @@ -21,6 +21,7 @@
>   #include <linux/types.h>
>   #include <linux/bootmem.h>
>   #include <linux/slab.h>
> +#include <linux/mm.h>
>   
>   /*
>    * Data types ------------------------------------------------------------------
> @@ -41,6 +42,7 @@ struct firmware_map_entry {
>   	const char		*type;	/* type of the memory range */
>   	struct list_head	list;	/* entry for the linked list */
>   	struct kobject		kobj;   /* kobject for each entry */
> +	unsigned int		bootmem:1; /* allocated from bootmem */
>   };

Can't we detect from which the object is allocated from, slab or bootmem ?

Hm, for example,

    PageReserved(virt_to_page(address_of_obj)) ?
    PageSlab(virt_to_page(address_of_obj)) ?

Thanks,
-Kame
