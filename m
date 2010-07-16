Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id 44499B7083
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 10:13:42 +1000 (EST)
Received: from m2.gw.fujitsu.co.jp ([10.0.50.72])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o6G0Ddht003763 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Fri, 16 Jul 2010 09:13:40 +0900
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 424D845DE61
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 09:13:39 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id F3D7A45DE4F
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 09:13:38 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id A3FF41DB8040
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 09:13:38 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.249.87.103])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 0C0911DB803C
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 09:13:38 +0900 (JST)
Date: Fri, 16 Jul 2010 09:08:57 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 2/5] v2 Create new 'end_phys_index' file
Message-Id: <20100716090857.5e5c91a3.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4C3F55BC.4020600@austin.ibm.com>
References: <4C3F53D1.3090001@austin.ibm.com> <4C3F55BC.4020600@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 15 Jul 2010 13:38:52 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> Add a new 'end_phys_index' file to each memory sysfs directory to
> report the physical index of the last memory section
> covered by the sysfs directory.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

Does memory_block have to be contiguous between [phys_index, end_phys_index] ?
Should we provide "# of sections" or "amount of memory under a block" ?

No objections to end_phys_index...buf plz fix diff style.

Thanks,
-Kame


> ---
>  drivers/base/memory.c  |   14 +++++++++++++-
>  include/linux/memory.h |    3 +++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/base/memory.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/memory.c	2010-07-15 09:55:54.000000000 -0500
> +++ linux-2.6/drivers/base/memory.c	2010-07-15 09:56:05.000000000 -0500
> @@ -121,7 +121,15 @@
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
> @@ -321,6 +329,7 @@
>  }
>  
>  static SYSDEV_ATTR(phys_index, 0444, show_mem_phys_index, NULL);
> +static SYSDEV_ATTR(end_phys_index, 0444, show_mem_end_phys_index, NULL);
>  static SYSDEV_ATTR(state, 0644, show_mem_state, store_mem_state);
>  static SYSDEV_ATTR(phys_device, 0444, show_phys_device, NULL);
>  static SYSDEV_ATTR(removable, 0444, show_mem_removable, NULL);
> @@ -533,6 +542,8 @@
>  		if (!ret)
>  			ret = mem_create_simple_file(mem, phys_index);
>  		if (!ret)
> +			ret = mem_create_simple_file(mem, end_phys_index);
> +		if (!ret)
>  			ret = mem_create_simple_file(mem, state);
>  		if (!ret)
>  			ret = mem_create_simple_file(mem, phys_device);
> @@ -577,6 +588,7 @@
>  	if (list_empty(&mem->sections)) {
>  		unregister_mem_sect_under_nodes(mem);
>  		mem_remove_simple_file(mem, phys_index);
> +		mem_remove_simple_file(mem, end_phys_index);
>  		mem_remove_simple_file(mem, state);
>  		mem_remove_simple_file(mem, phys_device);
>  		mem_remove_simple_file(mem, removable);
> Index: linux-2.6/include/linux/memory.h
> ===================================================================
> --- linux-2.6.orig/include/linux/memory.h	2010-07-15 09:54:06.000000000 -0500
> +++ linux-2.6/include/linux/memory.h	2010-07-15 09:56:05.000000000 -0500
> @@ -29,6 +29,9 @@
>  
>  struct memory_block {
>  	unsigned long state;
> +	unsigned long start_phys_index;
> +	unsigned long end_phys_index;
> +
>  	/*
>  	 * This serializes all state change requests.  It isn't
>  	 * held during creation because the control files are
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
