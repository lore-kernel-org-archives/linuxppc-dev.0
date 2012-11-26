Return-Path: <wujianguo106@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C5D742C0085
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2012 01:27:50 +1100 (EST)
Received: by mail-pb0-f51.google.com with SMTP id ro12so5267822pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 06:27:48 -0800 (PST)
Message-ID: <50B37C52.2060301@gmail.com>
Date: Mon, 26 Nov 2012 22:27:30 +0800
From: Jianguo Wu <wujianguo106@gmail.com>
MIME-Version: 1.0
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [PATCH v3 11/12] memory-hotplug: remove sysfs file of node
References: <1351763083-7905-1-git-send-email-wency@cn.fujitsu.com>
 <1351763083-7905-12-git-send-email-wency@cn.fujitsu.com>
In-Reply-To: <1351763083-7905-12-git-send-email-wency@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org,
 linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 cmetcalf@tilera.com, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, paulus@samba.org,
 Minchan Kim <minchan.kim@gmail.com>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 David Rientjes <rientjes@google.com>, sparclinux@vger.kernel.org,
 Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>, Jiang Liu <liuj97@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2012/11/1 17:44, Wen Congyang wrote:
> This patch introduces a new function try_offline_node() to
> remove sysfs file of node when all memory sections of this
> node are removed. If some memory sections of this node are
> not removed, this function does nothing.
> 
> CC: David Rientjes <rientjes@google.com>
> CC: Jiang Liu <liuj97@gmail.com>
> CC: Len Brown <len.brown@intel.com>
> CC: Christoph Lameter <cl@linux.com>
> Cc: Minchan Kim <minchan.kim@gmail.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
> CC: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
> ---
>  drivers/acpi/acpi_memhotplug.c |  8 +++++-
>  include/linux/memory_hotplug.h |  2 +-
>  mm/memory_hotplug.c            | 58 ++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 64 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index 24c807f..0780f99 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -310,7 +310,9 @@ static int acpi_memory_disable_device(struct acpi_memory_device *mem_device)
>  {
>  	int result;
>  	struct acpi_memory_info *info, *n;
> +	int node;
>  
> +	node = acpi_get_node(mem_device->device->handle);
>  
>  	/*
>  	 * Ask the VM to offline this memory range.
> @@ -318,7 +320,11 @@ static int acpi_memory_disable_device(struct acpi_memory_device *mem_device)
>  	 */
>  	list_for_each_entry_safe(info, n, &mem_device->res_list, list) {
>  		if (info->enabled) {
> -			result = remove_memory(info->start_addr, info->length);
> +			if (node < 0)
> +				node = memory_add_physaddr_to_nid(
> +					info->start_addr);
> +			result = remove_memory(node, info->start_addr,
> +				info->length);
>  			if (result)
>  				return result;
>  		}
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index d4c4402..7b4cfe6 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -231,7 +231,7 @@ extern int arch_add_memory(int nid, u64 start, u64 size);
>  extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
>  extern int offline_memory_block(struct memory_block *mem);
>  extern bool is_memblock_offlined(struct memory_block *mem);
> -extern int remove_memory(u64 start, u64 size);
> +extern int remove_memory(int node, u64 start, u64 size);
>  extern int sparse_add_one_section(struct zone *zone, unsigned long start_pfn,
>  								int nr_pages);
>  extern void sparse_remove_one_section(struct zone *zone, struct mem_section *ms);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 7bcced0..d965da3 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -29,6 +29,7 @@
>  #include <linux/suspend.h>
>  #include <linux/mm_inline.h>
>  #include <linux/firmware-map.h>
> +#include <linux/stop_machine.h>
>  
>  #include <asm/tlbflush.h>
>  
> @@ -1299,7 +1300,58 @@ static int is_memblock_offlined_cb(struct memory_block *mem, void *arg)
>  	return ret;
>  }
>  
> -int __ref remove_memory(u64 start, u64 size)
> +static int check_cpu_on_node(void *data)
> +{
> +	struct pglist_data *pgdat = data;
> +	int cpu;
> +
> +	for_each_present_cpu(cpu) {
> +		if (cpu_to_node(cpu) == pgdat->node_id)
> +			/*
> +			 * the cpu on this node isn't removed, and we can't
> +			 * offline this node.
> +			 */
> +			return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +/* offline the node if all memory sections of this node are removed */
> +static void try_offline_node(int nid)
> +{
> +	unsigned long start_pfn = NODE_DATA(nid)->node_start_pfn;
> +	unsigned long end_pfn = start_pfn + NODE_DATA(nid)->node_spanned_pages;
> +	unsigned long pfn;
> +
> +	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
> +		unsigned long section_nr = pfn_to_section_nr(pfn);
> +
> +		if (!present_section_nr(section_nr))
> +			continue;
> +
> +		if (pfn_to_nid(pfn) != nid)
> +			continue;
> +
> +		/*
> +		 * some memory sections of this node are not removed, and we
> +		 * can't offline node now.
> +		 */
> +		return;
> +	}
> +
> +	if (stop_machine(check_cpu_on_node, NODE_DATA(nid), NULL))
> +		return;

how about:
	if (nr_cpus_node(nid))
		return;
> +
> +	/*
> +	 * all memory/cpu of this node are removed, we can offline this
> +	 * node now.
> +	 */
> +	node_set_offline(nid);
> +	unregister_one_node(nid);
> +}
> +
> +int __ref remove_memory(int nid, u64 start, u64 size)
>  {
>  	unsigned long start_pfn, end_pfn;
>  	int ret = 0;
> @@ -1346,6 +1398,8 @@ repeat:
>  
>  	arch_remove_memory(start, size);
>  
> +	try_offline_node(nid);
> +
>  	unlock_memory_hotplug();
>  
>  	return 0;
> @@ -1355,7 +1409,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  {
>  	return -EINVAL;
>  }
> -int remove_memory(u64 start, u64 size)
> +int remove_memory(int nid, u64 start, u64 size)
>  {
>  	return -EINVAL;
>  }
> 
