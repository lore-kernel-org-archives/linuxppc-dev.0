Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id 450CAB70A7
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 14:54:38 +1000 (EST)
Received: from m3.gw.fujitsu.co.jp ([10.0.50.73])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o754sakr001744 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Thu, 5 Aug 2010 13:54:37 +0900
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 52C3045DE4E
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 13:54:36 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 33EF945DD77
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 13:54:36 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 1E7D61DB803F
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 13:54:36 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.249.87.104])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id C83AE1DB803E
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 13:54:35 +0900 (JST)
Date: Thu, 5 Aug 2010 13:49:43 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 2/9] v4  Add new phys_index properties
Message-Id: <20100805134943.9841a2e0.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4C581B9B.8050106@austin.ibm.com>
References: <4C581A6D.9030908@austin.ibm.com> <4C581B9B.8050106@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mm@kvack.org, Dave Hansen <dave@linux.vnet.ibm.com>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 03 Aug 2010 08:37:31 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> Update the 'phys_index' properties of a memory block to include a
> 'start_phys_index' which is the same as the current 'phys_index' property.
> The property still appears as 'phys_index' in sysfs but the memory_block
> struct name is updated to indicate the start and end values.
> This also adds an 'end_phys_index' property to indicate the id of the
> last section in th memory block.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

Acked-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

nitpick. After this patch, end_phys_index is added but contains 0.
It's better to contain the same value with phys_index..

But, ok. Following patch will fix it.

Thanks,
-Kame

> ---
>  drivers/base/memory.c  |   28 ++++++++++++++++++++--------
>  include/linux/memory.h |    3 ++-
>  2 files changed, 22 insertions(+), 9 deletions(-)
> 
> Index: linux-2.6/drivers/base/memory.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/memory.c	2010-08-02 13:32:21.000000000 -0500
> +++ linux-2.6/drivers/base/memory.c	2010-08-02 13:33:27.000000000 -0500
> @@ -109,12 +109,20 @@ unregister_memory(struct memory_block *m
>   * uses.
>   */
>  
> -static ssize_t show_mem_phys_index(struct sys_device *dev,
> +static ssize_t show_mem_start_phys_index(struct sys_device *dev,
>  			struct sysdev_attribute *attr, char *buf)
>  {
>  	struct memory_block *mem =
>  		container_of(dev, struct memory_block, sysdev);
> -	return sprintf(buf, "%08lx\n", mem->phys_index);
> +	return sprintf(buf, "%08lx\n", mem->start_phys_index);
> +}
> +
> +static ssize_t show_mem_end_phys_index(struct sys_device *dev,
> +			struct sysdev_attribute *attr, char *buf)
> +{
> +	struct memory_block *mem =
> +		container_of(dev, struct memory_block, sysdev);
> +	return sprintf(buf, "%08lx\n", mem->end_phys_index);
>  }
>  
>  /*
> @@ -128,7 +136,7 @@ static ssize_t show_mem_removable(struct
>  	struct memory_block *mem =
>  		container_of(dev, struct memory_block, sysdev);
>  
> -	start_pfn = section_nr_to_pfn(mem->phys_index);
> +	start_pfn = section_nr_to_pfn(mem->start_phys_index);
>  	ret = is_mem_section_removable(start_pfn, PAGES_PER_SECTION);
>  	return sprintf(buf, "%d\n", ret);
>  }
> @@ -191,7 +199,7 @@ memory_block_action(struct memory_block
>  	int ret;
>  	int old_state = mem->state;
>  
> -	psection = mem->phys_index;
> +	psection = mem->start_phys_index;
>  	first_page = pfn_to_page(psection << PFN_SECTION_SHIFT);
>  
>  	/*
> @@ -264,7 +272,7 @@ store_mem_state(struct sys_device *dev,
>  	int ret = -EINVAL;
>  
>  	mem = container_of(dev, struct memory_block, sysdev);
> -	phys_section_nr = mem->phys_index;
> +	phys_section_nr = mem->start_phys_index;
>  
>  	if (!present_section_nr(phys_section_nr))
>  		goto out;
> @@ -296,7 +304,8 @@ static ssize_t show_phys_device(struct s
>  	return sprintf(buf, "%d\n", mem->phys_device);
>  }
>  
> -static SYSDEV_ATTR(phys_index, 0444, show_mem_phys_index, NULL);
> +static SYSDEV_ATTR(phys_index, 0444, show_mem_start_phys_index, NULL);
> +static SYSDEV_ATTR(end_phys_index, 0444, show_mem_end_phys_index, NULL);
>  static SYSDEV_ATTR(state, 0644, show_mem_state, store_mem_state);
>  static SYSDEV_ATTR(phys_device, 0444, show_phys_device, NULL);
>  static SYSDEV_ATTR(removable, 0444, show_mem_removable, NULL);
> @@ -476,16 +485,18 @@ static int add_memory_block(int nid, str
>  	if (!mem)
>  		return -ENOMEM;
>  
> -	mem->phys_index = __section_nr(section);
> +	mem->start_phys_index = __section_nr(section);
>  	mem->state = state;
>  	mutex_init(&mem->state_mutex);
> -	start_pfn = section_nr_to_pfn(mem->phys_index);
> +	start_pfn = section_nr_to_pfn(mem->start_phys_index);
>  	mem->phys_device = arch_get_memory_phys_device(start_pfn);
>  
>  	ret = register_memory(mem, section);
>  	if (!ret)
>  		ret = mem_create_simple_file(mem, phys_index);
>  	if (!ret)
> +		ret = mem_create_simple_file(mem, end_phys_index);
> +	if (!ret)
>  		ret = mem_create_simple_file(mem, state);
>  	if (!ret)
>  		ret = mem_create_simple_file(mem, phys_device);
> @@ -507,6 +518,7 @@ int remove_memory_block(unsigned long no
>  	mem = find_memory_block(section);
>  	unregister_mem_sect_under_nodes(mem);
>  	mem_remove_simple_file(mem, phys_index);
> +	mem_remove_simple_file(mem, end_phys_index);
>  	mem_remove_simple_file(mem, state);
>  	mem_remove_simple_file(mem, phys_device);
>  	mem_remove_simple_file(mem, removable);
> Index: linux-2.6/include/linux/memory.h
> ===================================================================
> --- linux-2.6.orig/include/linux/memory.h	2010-08-02 13:23:49.000000000 -0500
> +++ linux-2.6/include/linux/memory.h	2010-08-02 13:33:27.000000000 -0500
> @@ -21,7 +21,8 @@
>  #include <linux/mutex.h>
>  
>  struct memory_block {
> -	unsigned long phys_index;
> +	unsigned long start_phys_index;
> +	unsigned long end_phys_index;
>  	unsigned long state;
>  	/*
>  	 * This serializes all state change requests.  It isn't
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
> 
