Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by ozlabs.org (Postfix) with ESMTP id 3BCDAB6EE9
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 16:25:24 +1000 (EST)
Received: from m4.gw.fujitsu.co.jp ([10.0.50.74])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o6D6PMOm032723 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Tue, 13 Jul 2010 15:25:22 +0900
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 33D3F45DE6F
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 15:25:22 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 0857345DE70
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 15:25:22 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id BC9001DB803B
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 15:25:21 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.249.87.106])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id EE529E38006
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 15:25:20 +0900 (JST)
Date: Tue, 13 Jul 2010 15:20:44 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 3/7] Update the [register,unregister]_memory routines
Message-Id: <20100713152044.7ec8c9ae.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4C3B384A.4000902@austin.ibm.com>
References: <4C3B3446.5090302@austin.ibm.com> <4C3B384A.4000902@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 12 Jul 2010 10:44:10 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> This patch moves the register/unregister_memory routines to
> avoid a forward declaration.  It also moves the sysfs file
> creation and deletion for each directory into the register/
> unregister routines to avoid duplicating it with these updates.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
> ---
>  drivers/base/memory.c |   93 +++++++++++++++++++++++++-------------------------
>  1 file changed, 48 insertions(+), 45 deletions(-)
> 
> Index: linux-2.6/drivers/base/memory.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/memory.c	2010-07-09 14:23:17.000000000 -0500
> +++ linux-2.6/drivers/base/memory.c	2010-07-09 14:23:20.000000000 -0500
> @@ -87,31 +87,6 @@
>  EXPORT_SYMBOL(unregister_memory_isolate_notifier);
>  
>  /*
> - * register_memory - Setup a sysfs device for a memory block
> - */
> -static
> -int register_memory(struct memory_block *memory, struct mem_section *section)
> -{
> -	int error;
> -
> -	memory->sysdev.cls = &memory_sysdev_class;
> -	memory->sysdev.id = __section_nr(section);
> -
> -	error = sysdev_register(&memory->sysdev);
> -	return error;
> -}
> -
> -static void
> -unregister_memory(struct memory_block *memory)
> -{
> -	BUG_ON(memory->sysdev.cls != &memory_sysdev_class);
> -
> -	/* drop the ref. we got in remove_memory_block() */
> -	kobject_put(&memory->sysdev.kobj);
> -	sysdev_unregister(&memory->sysdev);
> -}
> -
> -/*
>   * use this as the physical section index that this memsection
>   * uses.
>   */
> @@ -346,6 +321,53 @@
>  	sysdev_remove_file(&mem->sysdev, &attr_##attr_name)
>  
>  /*
> + * register_memory - Setup a sysfs device for a memory block
> + */
> +static
> +int register_memory(struct memory_block *memory, struct mem_section *section,
> +		    int nid, enum mem_add_context context)
> +{
> +	int ret;
> +
> +	memory->sysdev.cls = &memory_sysdev_class;
> +	memory->sysdev.id = __section_nr(section);
> +
Why not block-ID  but section-ID ?

-Kame
