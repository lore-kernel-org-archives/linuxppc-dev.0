Return-Path: <wency@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 879DD2C01FA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 11:48:10 +1000 (EST)
Message-ID: <4FFCDC6A.9070704@cn.fujitsu.com>
Date: Wed, 11 Jul 2012 09:52:42 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [RFC PATCH v3 0/13] memory-hotplug : hot-remove physical memory
References: <4FFAB0A2.8070304@jp.fujitsu.com>
In-Reply-To: <4FFAB0A2.8070304@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
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

At 07/09/2012 06:21 PM, Yasuaki Ishimatsu Wrote:
> This patch series aims to support physical memory hot-remove.
> 
>   [RFC PATCH v3 1/13] memory-hotplug : rename remove_memory to offline_memory
>   [RFC PATCH v3 2/13] memory-hotplug : add physical memory hotplug code to acpi_memory_device_remove
>   [RFC PATCH v3 3/13] memory-hotplug : unify argument of firmware_map_add_early/hotplug
>   [RFC PATCH v3 4/13] memory-hotplug : remove /sys/firmware/memmap/X sysfs
>   [RFC PATCH v3 5/13] memory-hotplug : does not release memory region in PAGES_PER_SECTION chunks
>   [RFC PATCH v3 6/13] memory-hotplug : add memory_block_release
>   [RFC PATCH v3 7/13] memory-hotplug : remove_memory calls __remove_pages
>   [RFC PATCH v3 8/13] memory-hotplug : check page type in get_page_bootmem
>   [RFC PATCH v3 9/13] memory-hotplug : move register_page_bootmem_info_node and put_page_bootmem for
> sparse-vmemmap
>   [RFC PATCH v3 10/13] memory-hotplug : implement register_page_bootmem_info_section of sparse-vmemmap
>   [RFC PATCH v3 11/13] memory-hotplug : free memmap of sparse-vmemmap
>   [RFC PATCH v3 12/13] memory-hotplug : add node_device_release
>   [RFC PATCH v3 13/13] memory-hotplug : remove sysfs file of node
> 
> Even if you apply these patches, you cannot remove the physical memory
> completely since these patches are still under development. I want you to
> cooperate to improve the physical memory hot-remove. So please review these
> patches and give your comment/idea.
> 
> The patches can free/remove following things:
> 
>   - acpi_memory_info                          : [RFC PATCH 2/13]
>   - /sys/firmware/memmap/X/{end, start, type} : [RFC PATCH 4/13]
>   - iomem_resource                            : [RFC PATCH 5/13]
>   - mem_section and related sysfs files       : [RFC PATCH 6-11/13]
>   - node and related sysfs files              : [RFC PATCH 12-13/13]
> 
> The patches cannot do following things yet:
> 
>   - page table of removed memory
> 
> If you find lack of function for physical memory hot-remove, please let me
> know.
> 
> change log of v3:
>  * rebase to 3.5.0-rc6
> 
>  [RFC PATCH v2 2/13]
>    * remove extra kobject_put()
> 
>    * The patch was commented by Wen. Wen's comment is
>      "acpi_memory_device_remove() should ignore a return value of
>      remove_memory() since caller does not care the return value".
>      But I did not change it since I think caller should care the
>      return value. And I am trying to fix it as follow:
> 
>      https://lkml.org/lkml/2012/7/5/624

acpi_memory_device_remove() will be called not only when we write
1 to /sys/bus/acpi/devices/PNP0C80:XX/eject. When we unbind it
from the driver or remove the module acpi_memhotplug, this function
will be called too.

I will check whether your patch can work for these two cases.

Thanks
Wen Congyang

> 
>  [RFC PATCH v2 4/13]
>    * remove a firmware_memmap_entry allocated by kzmalloc()
> 
> change log of v2:
>  [RFC PATCH v2 2/13]
>    * check whether memory block is offline or not before calling offline_memory()
>    * check whether section is valid or not in is_memblk_offline()
>    * call kobject_put() for each memory_block in is_memblk_offline()
> 
>  [RFC PATCH v2 3/13]
>    * unify the end argument of firmware_map_add_early/hotplug
> 
>  [RFC PATCH v2 4/13]
>    * add release_firmware_map_entry() for freeing firmware_map_entry
> 
>  [RFC PATCH v2 6/13]
>   * add release_memory_block() for freeing memory_block
> 
>  [RFC PATCH v2 11/13]
>   * fix wrong arguments of free_pages()
> 
> ---
>  arch/powerpc/platforms/pseries/hotplug-memory.c |   16 +-
>  arch/x86/mm/init_64.c                           |  144 ++++++++++++++++++++++++
>  drivers/acpi/acpi_memhotplug.c                  |   28 ++++
>  drivers/base/memory.c                           |   54 ++++++++-
>  drivers/base/node.c                             |    7 +
>  drivers/firmware/memmap.c                       |   78 ++++++++++++-
>  include/linux/firmware-map.h                    |    6 +
>  include/linux/memory.h                          |    5
>  include/linux/memory_hotplug.h                  |   17 --
>  include/linux/mm.h                              |    5
>  mm/memory_hotplug.c                             |   98 ++++++++++++----
>  mm/sparse.c                                     |    5
>  12 files changed, 414 insertions(+), 49 deletions(-)
> 
> 
