Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by ozlabs.org (Postfix) with ESMTP id B0D46B6EE9
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 17:06:17 +1000 (EST)
Received: from m4.gw.fujitsu.co.jp ([10.0.50.74])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o6K76FwT016127 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Tue, 20 Jul 2010 16:06:15 +0900
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 0985545DE70
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:06:15 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id DCA0845DE60
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:06:14 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id C1E3A1DB8037
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:06:14 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.249.87.104])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6AACFE38005
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:06:11 +0900 (JST)
Date: Tue, 20 Jul 2010 16:01:31 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 3/8] v3 Add section count to memory_block
Message-Id: <20100720160131.7cc8c0a2.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4C451DD6.3080005@austin.ibm.com>
References: <4C451BF5.50304@austin.ibm.com> <4C451DD6.3080005@austin.ibm.com>
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

On Mon, 19 Jul 2010 22:53:58 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> Add a section count property to the memory_block struct to track the number
> of memory sections that have been added/removed from a emory block.
> 
> Signed-off-by: Nathan Fontenot <nfont@asutin.ibm.com>
> ---
>  drivers/base/memory.c  |   19 ++++++++++++-------
>  include/linux/memory.h |    2 ++
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> Index: linux-2.6/drivers/base/memory.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/memory.c	2010-07-19 20:43:49.000000000 -0500
> +++ linux-2.6/drivers/base/memory.c	2010-07-19 20:44:01.000000000 -0500
> @@ -487,6 +487,7 @@ static int add_memory_block(int nid, str
>  
>  	mem->start_phys_index = __section_nr(section);
>  	mem->state = state;
> +	atomic_inc(&mem->section_count);
>  	mutex_init(&mem->state_mutex);
>  	start_pfn = section_nr_to_pfn(mem->start_phys_index);
>  	mem->phys_device = arch_get_memory_phys_device(start_pfn);
> @@ -516,13 +517,17 @@ int remove_memory_block(unsigned long no
>  	struct memory_block *mem;
>  
>  	mem = find_memory_block(section);
> -	unregister_mem_sect_under_nodes(mem);
> -	mem_remove_simple_file(mem, start_phys_index);
> -	mem_remove_simple_file(mem, end_phys_index);
> -	mem_remove_simple_file(mem, state);
> -	mem_remove_simple_file(mem, phys_device);
> -	mem_remove_simple_file(mem, removable);
> -	unregister_memory(mem, section);
> +	atomic_dec(&mem->section_count);
> +
> +	if (atomic_read(&mem->section_count) == 0) {

We use atomic_dec_and_test() in usual.

Otherwise, I don't see other problems in other part. Please fix this nitpick.

Regards,
-Kame
