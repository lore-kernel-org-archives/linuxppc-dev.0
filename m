Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id 12799B6F17
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 10:17:19 +1000 (EST)
Received: from m2.gw.fujitsu.co.jp ([10.0.50.72])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o6G0HIEs005427 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Fri, 16 Jul 2010 09:17:18 +0900
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 702AB45DE57
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 09:17:18 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 4B57D45DE51
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 09:17:18 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 2D6071DB8041
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 09:17:18 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.249.87.105])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id CA48D1DB803E
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 09:17:17 +0900 (JST)
Date: Fri, 16 Jul 2010 09:12:39 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 4/5] v2 Update sysfs node routines for new sysfs memory
	directories
Message-Id: <20100716091239.69f40e47.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4C3F5628.6030809@austin.ibm.com>
References: <4C3F53D1.3090001@austin.ibm.com> <4C3F5628.6030809@austin.ibm.com>
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

On Thu, 15 Jul 2010 13:40:40 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> Update the node sysfs directory routines that create
> links to the memory sysfs directories under each node.
> This update makes the node code aware that a memory sysfs
> directory can cover multiple memory sections.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

Shouldn't "static int link_mem_sections(int nid)" be update ?
It does
 for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
        register..

Thanks,
-Kame


> ---
>  drivers/base/node.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6/drivers/base/node.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/node.c	2010-07-15 09:54:06.000000000 -0500
> +++ linux-2.6/drivers/base/node.c	2010-07-15 09:56:16.000000000 -0500
> @@ -346,8 +346,10 @@
>  		return -EFAULT;
>  	if (!node_online(nid))
>  		return 0;
> -	sect_start_pfn = section_nr_to_pfn(mem_blk->phys_index);
> -	sect_end_pfn = sect_start_pfn + PAGES_PER_SECTION - 1;
> +
> +	sect_start_pfn = section_nr_to_pfn(mem_blk->start_phys_index);
> +	sect_end_pfn = section_nr_to_pfn(mem_blk->end_phys_index);
> +	sect_end_pfn += PAGES_PER_SECTION - 1;
>  	for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
>  		int page_nid;
>  
> @@ -383,8 +385,10 @@
>  	if (!unlinked_nodes)
>  		return -ENOMEM;
>  	nodes_clear(*unlinked_nodes);
> -	sect_start_pfn = section_nr_to_pfn(mem_blk->phys_index);
> -	sect_end_pfn = sect_start_pfn + PAGES_PER_SECTION - 1;
> +
> +	sect_start_pfn = section_nr_to_pfn(mem_blk->start_phys_index);
> +	sect_end_pfn = section_nr_to_pfn(mem_blk->end_phys_index);
> +	sect_end_pfn += PAGES_PER_SECTION - 1;
>  	for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
>  		int nid;
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
