Return-Path: <wujianguo106@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 950E02C009D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 17:27:58 +1000 (EST)
Received: by iage36 with SMTP id e36so1595828iag.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Sep 2012 00:27:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1346837155-534-21-git-send-email-wency@cn.fujitsu.com>
References: <1346837155-534-1-git-send-email-wency@cn.fujitsu.com>
 <1346837155-534-21-git-send-email-wency@cn.fujitsu.com>
Date: Thu, 6 Sep 2012 15:27:55 +0800
Message-ID: <CA+quRcZtQCmFa4=1fq1iainQROy3NgtAXjLFF9cixs6KVXoMDA@mail.gmail.com>
Subject: Re: [RFC v9 PATCH 20/21] memory-hotplug: clear hwpoisoned flag when
 onlining pages
From: =?GB2312?B?YW5keXd1MTA2vai5+g==?= <wujianguo106@gmail.com>
To: wency@cn.fujitsu.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, len.brown@intel.com,
 linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 isimatu.yasuaki@jp.fujitsu.com, paulus@samba.org, minchan.kim@gmail.com,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 sparclinux@vger.kernel.org, cl@linux.com, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2012/9/5 <wency@cn.fujitsu.com>
>
> From: Wen Congyang <wency@cn.fujitsu.com>
>
> hwpoisoned may set when we offline a page by the sysfs interface
> /sys/devices/system/memory/soft_offline_page or
> /sys/devices/system/memory/hard_offline_page. If we don't clear
> this flag when onlining pages, this page can't be freed, and will
> not in free list. So we can't offline these pages again. So we
> should clear this flag when onlining pages.
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
> CC: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
> ---
>  mm/memory_hotplug.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 270c249..140c080 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -661,6 +661,11 @@ EXPORT_SYMBOL_GPL(__online_page_increment_counters);
>
>  void __online_page_free(struct page *page)
>  {
> +#ifdef CONFIG_MEMORY_FAILURE
> +       /* The page may be marked HWPoisoned by soft/hard offline page */
> +       ClearPageHWPoison(page);

Hi Congyang,
I think you should decrease mce_bad_pages counter her
atomic_long_sub(1, &mce_bad_pages);

>
> +#endif
> +
>         ClearPageReserved(page);
>         init_page_count(page);
>         __free_page(page);
> --
> 1.7.1
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
