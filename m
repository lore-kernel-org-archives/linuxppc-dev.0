Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by ozlabs.org (Postfix) with ESMTP id 6D9231007D1
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 17:00:18 +1000 (EST)
Received: from m6.gw.fujitsu.co.jp ([10.0.50.76])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o6K70G4K013314 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Tue, 20 Jul 2010 16:00:17 +0900
Received: from smail (m6 [127.0.0.1])
	by outgoing.m6.gw.fujitsu.co.jp (Postfix) with ESMTP id A6D8145DE54
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:00:16 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (s6.gw.fujitsu.co.jp [10.0.50.96])
	by m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 7F53A45DE52
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:00:16 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 6401D1DB8013
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:00:16 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.249.87.107])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 0E3251DB8015
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:00:16 +0900 (JST)
Date: Tue, 20 Jul 2010 15:55:02 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 1/8] v3 Move the find_memory_block() routine up
Message-Id: <20100720155502.17242173.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4C451D4E.8040600@austin.ibm.com>
References: <4C451BF5.50304@austin.ibm.com> <4C451D4E.8040600@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mm@kvack.org, greg@kroah.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 19 Jul 2010 22:51:42 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> Move the find_me mory_block() routine up to avoid needing a forward
> declaration in subsequent patches.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

Acked-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

> ---
>  drivers/base/memory.c |   62 +++++++++++++++++++++++++-------------------------
>  1 file changed, 31 insertions(+), 31 deletions(-)
> 
> Index: linux-2.6/drivers/base/memory.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/memory.c	2010-07-16 12:41:30.000000000 -0500
> +++ linux-2.6/drivers/base/memory.c	2010-07-19 20:42:11.000000000 -0500
> @@ -435,6 +435,37 @@ int __weak arch_get_memory_phys_device(u
>  	return 0;
>  }
>  
> +/*
> + * For now, we have a linear search to go find the appropriate
> + * memory_block corresponding to a particular phys_index. If
> + * this gets to be a real problem, we can always use a radix
> + * tree or something here.
> + *
> + * This could be made generic for all sysdev classes.
> + */
> +struct memory_block *find_memory_block(struct mem_section *section)
> +{
> +	struct kobject *kobj;
> +	struct sys_device *sysdev;
> +	struct memory_block *mem;
> +	char name[sizeof(MEMORY_CLASS_NAME) + 9 + 1];
> +
> +	/*
> +	 * This only works because we know that section == sysdev->id
> +	 * slightly redundant with sysdev_register()
> +	 */
> +	sprintf(&name[0], "%s%d", MEMORY_CLASS_NAME, __section_nr(section));
> +
> +	kobj = kset_find_obj(&memory_sysdev_class.kset, name);
> +	if (!kobj)
> +		return NULL;
> +
> +	sysdev = container_of(kobj, struct sys_device, kobj);
> +	mem = container_of(sysdev, struct memory_block, sysdev);
> +
> +	return mem;
> +}
> +
>  static int add_memory_block(int nid, struct mem_section *section,
>  			unsigned long state, enum mem_add_context context)
>  {
> @@ -468,37 +499,6 @@ static int add_memory_block(int nid, str
>  	return ret;
>  }
>  
> -/*
> - * For now, we have a linear search to go find the appropriate
> - * memory_block corresponding to a particular phys_index. If
> - * this gets to be a real problem, we can always use a radix
> - * tree or something here.
> - *
> - * This could be made generic for all sysdev classes.
> - */
> -struct memory_block *find_memory_block(struct mem_section *section)
> -{
> -	struct kobject *kobj;
> -	struct sys_device *sysdev;
> -	struct memory_block *mem;
> -	char name[sizeof(MEMORY_CLASS_NAME) + 9 + 1];
> -
> -	/*
> -	 * This only works because we know that section == sysdev->id
> -	 * slightly redundant with sysdev_register()
> -	 */
> -	sprintf(&name[0], "%s%d", MEMORY_CLASS_NAME, __section_nr(section));
> -
> -	kobj = kset_find_obj(&memory_sysdev_class.kset, name);
> -	if (!kobj)
> -		return NULL;
> -
> -	sysdev = container_of(kobj, struct sys_device, kobj);
> -	mem = container_of(sysdev, struct memory_block, sysdev);
> -
> -	return mem;
> -}
> -
>  int remove_memory_block(unsigned long node_id, struct mem_section *section,
>  		int phys_device)
>  {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
