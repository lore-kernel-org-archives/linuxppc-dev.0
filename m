Return-Path: <wujianguo106@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B4E192C008A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 17:07:02 +1000 (EST)
Received: by dajt11 with SMTP id t11so860967daj.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Sep 2012 00:07:00 -0700 (PDT)
Message-ID: <50484B8A.4090009@gmail.com>
Date: Thu, 06 Sep 2012 15:06:50 +0800
From: wujianguo <wujianguo106@gmail.com>
MIME-Version: 1.0
To: wency@cn.fujitsu.com
Subject: Re: [RFC PATCH V6 10/19] memory-hotplug: add memory_block_release
References: <1343980161-14254-1-git-send-email-wency@cn.fujitsu.com>
 <1343980161-14254-11-git-send-email-wency@cn.fujitsu.com>
In-Reply-To: <1343980161-14254-11-git-send-email-wency@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-acpi@vger.kernel.org, len.brown@intel.com, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 isimatu.yasuaki@jp.fujitsu.com, paulus@samba.org, minchan.kim@gmail.com,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, cl@linux.com,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2012-8-3 15:49, wency@cn.fujitsu.com wrote:
> From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> 
> When calling remove_memory_block(), the function shows following message at
> device_release().
> 
> Device 'memory528' does not have a release() function, it is broken and must
> be fixed.
> 

I found this warning too when doing memory-hotplug,
why not send as a bug fix patch?
The same as [RFC PATCH V6 18/19] memory-hotplug: add node_device_release

> remove_memory_block() calls kfree(mem). I think it shouled be called from
> device_release(). So the patch implements memory_block_release()
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
>  drivers/base/memory.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 038be73..1cd3ef3 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -109,6 +109,15 @@ bool is_memblk_offline(unsigned long start, unsigned long size)
>  }
>  EXPORT_SYMBOL(is_memblk_offline);
>  
> +#define to_memory_block(device) container_of(device, struct memory_block, dev)
> +
> +static void release_memory_block(struct device *dev)
> +{
> +	struct memory_block *mem = to_memory_block(dev);
> +
> +	kfree(mem);
> +}
> +
>  /*
>   * register_memory - Setup a sysfs device for a memory block
>   */
> @@ -119,6 +128,7 @@ int register_memory(struct memory_block *memory)
>  
>  	memory->dev.bus = &memory_subsys;
>  	memory->dev.id = memory->start_section_nr / sections_per_block;
> +	memory->dev.release = release_memory_block;
>  
>  	error = device_register(&memory->dev);
>  	return error;
> @@ -674,7 +684,6 @@ int remove_memory_block(unsigned long node_id, struct mem_section *section,
>  		mem_remove_simple_file(mem, phys_device);
>  		mem_remove_simple_file(mem, removable);
>  		unregister_memory(mem);
> -		kfree(mem);
>  	} else
>  		kobject_put(&mem->dev.kobj);
>  
> 
