Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by ozlabs.org (Postfix) with ESMTP id B1828B70AE
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 17:20:21 +1000 (EST)
Received: from m2.gw.fujitsu.co.jp ([10.0.50.72])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o6K7KJK7010868 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Tue, 20 Jul 2010 16:20:19 +0900
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id EC65245DE51
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:20:18 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id B74D145DE4E
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:20:18 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id A396A1DB803B
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:20:18 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.249.87.103])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 625111DB803A
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 16:20:15 +0900 (JST)
Date: Tue, 20 Jul 2010 16:15:32 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 4/8] v3 Allow memory_block to span multiple memory sections
Message-Id: <20100720161532.31952577.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4C451E1C.8070907@austin.ibm.com>
References: <4C451BF5.50304@austin.ibm.com> <4C451E1C.8070907@austin.ibm.com>
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

On Mon, 19 Jul 2010 22:55:08 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> Update the memory sysfs code that each sysfs memory directory is now
> considered a memory block that can contain multiple memory sections per
> memory block.  The default size of each memory block is SECTION_SIZE_BITS
> to maintain the current behavior of having a single memory section per
> memory block (i.e. one sysfs directory per memory section).
> 
> For architectures that want to have memory blocks span multiple
> memory sections they need only define their own memory_block_size_bytes()
> routine.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
> ---
>  drivers/base/memory.c |  141 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 98 insertions(+), 43 deletions(-)
> 
> Index: linux-2.6/drivers/base/memory.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/memory.c	2010-07-19 20:44:01.000000000 -0500
> +++ linux-2.6/drivers/base/memory.c	2010-07-19 21:12:22.000000000 -0500
> @@ -28,6 +28,14 @@
>  #include <asm/uaccess.h>
>  
>  #define MEMORY_CLASS_NAME	"memory"
> +#define MIN_MEMORY_BLOCK_SIZE	(1 << SECTION_SIZE_BITS)
> +
> +static int sections_per_block;
> +
> +static inline int base_memory_block_id(int section_nr)
> +{
> +	return (section_nr / sections_per_block) * sections_per_block;
> +}
>  
>  static struct sysdev_class memory_sysdev_class = {
>  	.name = MEMORY_CLASS_NAME,
> @@ -82,22 +90,21 @@ EXPORT_SYMBOL(unregister_memory_isolate_
>   * register_memory - Setup a sysfs device for a memory block
>   */
>  static
> -int register_memory(struct memory_block *memory, struct mem_section *section)
> +int register_memory(struct memory_block *memory)
>  {
>  	int error;
>  
>  	memory->sysdev.cls = &memory_sysdev_class;
> -	memory->sysdev.id = __section_nr(section);
> +	memory->sysdev.id = memory->start_phys_index;

I'm curious that this memory->start_phys_index can't overflow ?
sysdev.id is 32bit.


Thanks,
-Kame
