Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1CD9F2C011B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 17:50:14 +1000 (EST)
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 3B2EE3EE0C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:50:13 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id DD65D45DE62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:50:12 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C65E045DE59
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:50:12 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id B94E61DB8043
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:50:12 +0900 (JST)
Received: from g01jpexchyt07.g01.fujitsu.local
 (g01jpexchyt07.g01.fujitsu.local [10.128.194.46])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 468B81DB8052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:50:12 +0900 (JST)
Message-ID: <50090DA4.8040908@jp.fujitsu.com>
Date: Fri, 20 Jul 2012 16:49:56 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [RFC PATCH 3/8] memory-hotplug: call remove_memory() to cleanup
 when removing memory device
References: <5009038A.4090001@cn.fujitsu.com> <5009046C.106@cn.fujitsu.com>
In-Reply-To: <5009046C.106@cn.fujitsu.com>
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
> We should remove the following things when removing the memory device:
> 1. memmap and related sysfs files
> 2. iomem_resource
> 3. mem_section and related sysfs files
> 4. node and related sysfs files
>
> The function remove_memory() can do this. So call it after the memory device
> is offlined.
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


>   drivers/acpi/acpi_memhotplug.c |    7 ++++++-
>   1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index 712e767..58e4e63 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -315,7 +315,7 @@ static int acpi_memory_disable_device(struct acpi_memory_device *mem_device)
>   {
>   	int result;
>   	struct acpi_memory_info *info, *n;
> -
> +	int node = mem_device->nid;
>
>   	/*
>   	 * Ask the VM to offline this memory range.
> @@ -330,6 +330,11 @@ static int acpi_memory_disable_device(struct acpi_memory_device *mem_device)
>   				if (result)
>   					return result;
>   			}
> +
> +			result = remove_memory(node, info->start_addr,
> +					       info->length);
> +			if (result)
> +				return result;
>   		}
>   		list_del(&info->list);
>   		kfree(info);
>
