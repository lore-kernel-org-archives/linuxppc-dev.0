Return-Path: <wency@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id C198B2C008B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2012 15:26:51 +1000 (EST)
Message-ID: <5020A849.4050209@cn.fujitsu.com>
Date: Tue, 07 Aug 2012 13:31:53 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
To: isimatu.yasuaki@jp.fujitsu.com
Subject: Re: [RFC PATCH V6 13/19] memory-hotplug: check page type in
 get_page_bootmem
References: <1343980161-14254-1-git-send-email-wency@cn.fujitsu.com>
 <1343980161-14254-14-git-send-email-wency@cn.fujitsu.com>
In-Reply-To: <1343980161-14254-14-git-send-email-wency@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
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

At 08/03/2012 03:49 PM, wency@cn.fujitsu.com Wrote:
> From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> 
> There is a possibility that get_page_bootmem() is called to the same page many
> times. So when get_page_bootmem is called to the same page, the function only
> increments page->_count.
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
>  mm/memory_hotplug.c |   15 +++++++++++----
>  1 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 5f9f8c7..710e593 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -95,10 +95,17 @@ static void release_memory_resource(struct resource *res)
>  static void get_page_bootmem(unsigned long info,  struct page *page,
>  			     unsigned long type)
>  {
> -	page->lru.next = (struct list_head *) type;
> -	SetPagePrivate(page);
> -	set_page_private(page, info);
> -	atomic_inc(&page->_count);
> +	unsigned long page_type;
> +
> +	page_type = (unsigned long) page->lru.next;
> +	if (type < MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE ||
> +	    type > MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE){

I think it should be page_type not type here.

Thanks
Wen Congyang

> +		page->lru.next = (struct list_head *) type;
> +		SetPagePrivate(page);
> +		set_page_private(page, info);
> +		atomic_inc(&page->_count);
> +	} else
> +		atomic_inc(&page->_count);
>  }
>  
>  /* reference to __meminit __free_pages_bootmem is valid
