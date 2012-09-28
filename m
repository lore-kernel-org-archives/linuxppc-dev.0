Return-Path: <nizhan.chen@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 12E562C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 13:21:51 +1000 (EST)
Received: by obblz20 with SMTP id lz20so2500926obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2012 20:21:48 -0700 (PDT)
Message-ID: <506517C1.7050909@gmail.com>
Date: Fri, 28 Sep 2012 11:21:37 +0800
From: Ni zhan Chen <nizhan.chen@gmail.com>
MIME-Version: 1.0
To: wency@cn.fujitsu.com
Subject: Re: [RFC v9 PATCH 03/21] memory-hotplug: store the node id in
 acpi_memory_device
References: <1346837155-534-1-git-send-email-wency@cn.fujitsu.com>
 <1346837155-534-4-git-send-email-wency@cn.fujitsu.com>
In-Reply-To: <1346837155-534-4-git-send-email-wency@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 09/05/2012 05:25 PM, wency@cn.fujitsu.com wrote:
> From: Wen Congyang <wency@cn.fujitsu.com>
>
> The memory device has only one node id. Store the node id when
> enable the memory device, and we can reuse it when removing the
> memory device.

one question:
if use numa emulation, memory device will associated to one node or ...?

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
> Reviewed-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> ---
>   drivers/acpi/acpi_memhotplug.c |    4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index 2a7beac..7873832 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -83,6 +83,7 @@ struct acpi_memory_info {
>   struct acpi_memory_device {
>   	struct acpi_device * device;
>   	unsigned int state;	/* State of the memory device */
> +	int nid;
>   	struct list_head res_list;
>   };
>   
> @@ -256,6 +257,9 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>   		info->enabled = 1;
>   		num_enabled++;
>   	}
> +
> +	mem_device->nid = node;
> +
>   	if (!num_enabled) {
>   		printk(KERN_ERR PREFIX "add_memory failed\n");
>   		mem_device->state = MEMORY_INVALID_STATE;
