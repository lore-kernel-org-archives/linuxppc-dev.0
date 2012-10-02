Return-Path: <nizhan.chen@gmail.com>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B662D2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2012 10:34:53 +1000 (EST)
Received: by pabkq12 with SMTP id kq12so4708392pab.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2012 17:34:51 -0700 (PDT)
Message-ID: <506A36A1.6030709@gmail.com>
Date: Tue, 02 Oct 2012 08:34:41 +0800
From: Ni zhan Chen <nizhan.chen@gmail.com>
MIME-Version: 1.0
To: wency@cn.fujitsu.com
Subject: Re: [RFC v9 PATCH 06/21] memory-hotplug: export the function
 acpi_bus_remove()
References: <1346837155-534-1-git-send-email-wency@cn.fujitsu.com>
 <1346837155-534-7-git-send-email-wency@cn.fujitsu.com>
In-Reply-To: <1346837155-534-7-git-send-email-wency@cn.fujitsu.com>
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
> The function acpi_bus_remove() can remove a acpi device from acpi device.

IIUC, s/acpi device/acpi bus

>   
> When a acpi device is removed, we need to call this function to remove
> the acpi device from acpi bus. So export this function.
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
>   drivers/acpi/scan.c     |    3 ++-
>   include/acpi/acpi_bus.h |    1 +
>   2 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index d1ecca2..1cefc34 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1224,7 +1224,7 @@ static int acpi_device_set_context(struct acpi_device *device)
>   	return -ENODEV;
>   }
>   
> -static int acpi_bus_remove(struct acpi_device *dev, int rmdevice)
> +int acpi_bus_remove(struct acpi_device *dev, int rmdevice)
>   {
>   	if (!dev)
>   		return -EINVAL;
> @@ -1246,6 +1246,7 @@ static int acpi_bus_remove(struct acpi_device *dev, int rmdevice)
>   
>   	return 0;
>   }
> +EXPORT_SYMBOL(acpi_bus_remove);
>   
>   static int acpi_add_single_object(struct acpi_device **child,
>   				  acpi_handle handle, int type,
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index bde976e..2ccf109 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -360,6 +360,7 @@ bool acpi_bus_power_manageable(acpi_handle handle);
>   bool acpi_bus_can_wakeup(acpi_handle handle);
>   int acpi_power_resource_register_device(struct device *dev, acpi_handle handle);
>   void acpi_power_resource_unregister_device(struct device *dev, acpi_handle handle);
> +int acpi_bus_remove(struct acpi_device *dev, int rmdevice);
>   #ifdef CONFIG_ACPI_PROC_EVENT
>   int acpi_bus_generate_proc_event(struct acpi_device *device, u8 type, int data);
>   int acpi_bus_generate_proc_event4(const char *class, const char *bid, u8 type, int data);
