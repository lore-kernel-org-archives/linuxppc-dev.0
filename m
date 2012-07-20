Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 864B22C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 17:36:05 +1000 (EST)
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 9B3543EE0BD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:36:03 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7F79C45DEB3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:36:03 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6832A45DEB2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:36:03 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 552471DB803C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:36:03 +0900 (JST)
Received: from g01jpexchyt03.g01.fujitsu.local
 (g01jpexchyt03.g01.fujitsu.local [10.128.194.42])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 017F01DB8038
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:36:03 +0900 (JST)
Message-ID: <50090A4F.3050504@jp.fujitsu.com>
Date: Fri, 20 Jul 2012 16:35:43 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [RFC PATCH 1/8] memory-hotplug: store the node id in
 acpi_memory_device
References: <5009038A.4090001@cn.fujitsu.com> <5009041D.3060909@cn.fujitsu.com>
In-Reply-To: <5009041D.3060909@cn.fujitsu.com>
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

2012/07/20 16:09, Wen Congyang wrote:
> The memory device has only one node id. Store the node id when
> enabling the memory device, and we can reuse it when removing the
> memory device.
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

It looks to me.
Reviewed-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Thanks,
Yasuaki Ishimatsu

>   drivers/acpi/acpi_memhotplug.c |    8 +++++---
>   1 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index 5cafd6b..db8de39 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -84,6 +84,7 @@ struct acpi_memory_info {
>   struct acpi_memory_device {
>   	struct acpi_device * device;
>   	unsigned int state;	/* State of the memory device */
> +	int nid;
>   	struct list_head res_list;
>   };
>
> @@ -257,6 +258,9 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>   		info->enabled = 1;
>   		num_enabled++;
>   	}
> +
> +	mem_device->nid = node;
> +
>   	if (!num_enabled) {
>   		printk(KERN_ERR PREFIX "add_memory failed\n");
>   		mem_device->state = MEMORY_INVALID_STATE;
> @@ -463,7 +467,7 @@ static int acpi_memory_device_remove(struct acpi_device *device, int type)
>
>   	mem_device = acpi_driver_data(device);
>
> -	node = acpi_get_node(mem_device->device->handle);
> +	node = mem_device->nid;
>   	list_for_each_entry_safe(info, tmp, &mem_device->res_list, list) {
>   		if (!info->enabled)
>   			continue;
> @@ -473,8 +477,6 @@ static int acpi_memory_device_remove(struct acpi_device *device, int type)
>   			if (result)
>   				return result;
>   		}
> -		if (node < 0)
> -			node = memory_add_physaddr_to_nid(info->start_addr);
>
>   		result = remove_memory(node, info->start_addr, info->length);
>   		if (result)
>
