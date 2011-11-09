Return-Path: <gong.chen@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by ozlabs.org (Postfix) with ESMTP id 888301007D7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 18:38:40 +1100 (EST)
Message-ID: <4EBA2B90.5040901@linux.intel.com>
Date: Wed, 09 Nov 2011 15:28:16 +0800
From: Chen Gong <gong.chen@linux.intel.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] memory hotplug: Refuse to add unaligned memory regions
References: <20110915062615.782bc4df@kryten>
In-Reply-To: <20110915062615.782bc4df@kryten>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: gregkh@suse.de, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

于 2011/9/15 4:26, Anton Blanchard 写道:
>
> The sysfs memory probe interface allows unaligned regions
> to be added:
>
> # echo 0xffffff>  /sys/devices/system/memory/probe
>
> # cat /proc/iomem
> 00ffffff-01fffffe : System RAM
> 01ffffff-02fffffe : System RAM
> 02ffffff-03fffffe : System RAM
> 03ffffff-04fffffe : System RAM
> 04ffffff-05fffffe : System RAM
>
> Return -EINVAL instead of creating these bad regions.
>
> Signed-off-by: Anton Blanchard<anton@samba.org>
> ---
>
> Index: linux-build/drivers/base/memory.c
> ===================================================================
> --- linux-build.orig/drivers/base/memory.c	2011-08-11 08:25:55.005941391 +1000
> +++ linux-build/drivers/base/memory.c	2011-08-11 08:28:27.938580440 +1000
> @@ -380,9 +380,13 @@ memory_probe_store(struct class *class,
>   	u64 phys_addr;
>   	int nid;
>   	int i, ret;
> +	unsigned long pages_per_block = PAGES_PER_SECTION * sections_per_block;
>
>   	phys_addr = simple_strtoull(buf, NULL, 0);
>
> +	if (phys_addr&  ((pages_per_block<<  PAGE_SHIFT) - 1))
> +		return -EINVAL;
> +
>   	for (i = 0; i<  sections_per_block; i++) {
>   		nid = memory_add_physaddr_to_nid(phys_addr);
>   		ret = add_memory(nid, phys_addr,
> --

what platform doese it affect? PowerPC or else?

As I know, on x86 platform it should not use this interface: *probe*,
instead of acpi_hotplug_xxx. But PowerPC is RISC so how can you add
such weird address for it? Maybe it is because PowerPC uses 16M as
one section size and you assign a wrong address to it intentionally.
The final result is as you show, isn't it?
