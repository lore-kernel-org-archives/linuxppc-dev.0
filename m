Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 674B62C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 17:47:03 +1000 (EST)
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 109153EE0C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:47:01 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id ECA9B45DD78
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:47:00 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id D321945DE54
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:47:00 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id C69C1E18004
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:47:00 +0900 (JST)
Received: from g01jpexchyt03.g01.fujitsu.local
 (g01jpexchyt03.g01.fujitsu.local [10.128.194.42])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5560F1DB803E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:47:00 +0900 (JST)
Message-ID: <50090CE0.3040409@jp.fujitsu.com>
Date: Fri, 20 Jul 2012 16:46:40 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [RFC PATCH 2/8] memory-hotplug: offline memory only when it is
 onlined
References: <5009038A.4090001@cn.fujitsu.com> <5009044B.7050203@cn.fujitsu.com>
In-Reply-To: <5009044B.7050203@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 cl@linux.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wen,

2012/07/20 16:10, Wen Congyang wrote:
> offline_memory() will fail if the memory is not onlined. So check
> whether the memory is onlined before calling offline_memory().
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

I have no comment.
Reviewed-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Thanks,
Yasuaki Ishimatsu

>   drivers/acpi/acpi_memhotplug.c |   10 +++++++---
>   1 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index db8de39..712e767 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -323,9 +323,13 @@ static int acpi_memory_disable_device(struct acpi_memory_device *mem_device)
>   	 */
>   	list_for_each_entry_safe(info, n, &mem_device->res_list, list) {
>   		if (info->enabled) {
> -			result = offline_memory(info->start_addr, info->length);
> -			if (result)
> -				return result;
> +			if (!is_memblk_offline(info->start_addr,
> +					       info->length)) {
> +				result = offline_memory(info->start_addr,
> +							info->length);
> +				if (result)
> +					return result;
> +			}
>   		}
>   		list_del(&info->list);
>   		kfree(info);
>
