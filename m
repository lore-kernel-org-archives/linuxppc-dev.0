Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 44D692C036C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Sep 2012 07:30:35 +1000 (EST)
Date: Fri, 31 Aug 2012 14:30:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: wency@cn.fujitsu.com
Subject: Re: [RFC v8 PATCH 13/20] memory-hotplug: check page type in
 get_page_bootmem
Message-Id: <20120831143032.1343e99a.akpm@linux-foundation.org>
In-Reply-To: <1346148027-24468-14-git-send-email-wency@cn.fujitsu.com>
References: <1346148027-24468-1-git-send-email-wency@cn.fujitsu.com>
 <1346148027-24468-14-git-send-email-wency@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, len.brown@intel.com,
 linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 isimatu.yasuaki@jp.fujitsu.com, paulus@samba.org, minchan.kim@gmail.com,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 sparclinux@vger.kernel.org, cl@linux.com, linuxppc-dev@lists.ozlabs.org,
 liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 28 Aug 2012 18:00:20 +0800
wency@cn.fujitsu.com wrote:

> From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> 
> There is a possibility that get_page_bootmem() is called to the same page many
> times. So when get_page_bootmem is called to the same page, the function only
> increments page->_count.

I really don't understand this explanation, even after having looked at
the code.  Can you please have another attempt at the changelog?

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
> +	if (page_type < MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE ||
> +	    page_type > MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE){
> +		page->lru.next = (struct list_head *) type;
> +		SetPagePrivate(page);
> +		set_page_private(page, info);
> +		atomic_inc(&page->_count);
> +	} else
> +		atomic_inc(&page->_count);
>  }

And a code comment which explains what is going on would be good.  As
is always the case ;)
