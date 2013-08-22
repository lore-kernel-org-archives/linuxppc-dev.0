Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D88442C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 19:17:35 +1000 (EST)
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 by fgwmail8.fujitsu.co.jp (Postfix) with ESMTP id 5E2581793CCF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 17:21:08 +0900 (JST)
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A85F83EE0C0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 17:21:04 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 908CE45DE56
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 17:21:04 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6F62945DE53
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 17:21:04 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5B491E08001
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 17:21:04 +0900 (JST)
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local
 (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id E1E6EE08002
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 17:21:03 +0900 (JST)
Message-ID: <5215C9B3.4090608@jp.fujitsu.com>
Date: Thu, 22 Aug 2013 17:20:03 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Seth Jennings <sjenning@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/7] drivers: base: refactor add_memory_section() to
 add_memory_block()
References: <1377018783-26756-1-git-send-email-sjenning@linux.vnet.ibm.com>
 <1377018783-26756-7-git-send-email-sjenning@linux.vnet.ibm.com>
In-Reply-To: <1377018783-26756-7-git-send-email-sjenning@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Cc: Dave Hansen <dave@sr71.net>, Lai Jiangshan <laijs@cn.fujitsu.com>,
 linuxppc-dev@lists.ozlabs.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Yinghai Lu <yinghai@kernel.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Cody P Schafer <cody@linux.vnet.ibm.com>,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(2013/08/21 2:13), Seth Jennings wrote:
> Right now memory_dev_init() maintains the memory block pointer
> between iterations of add_memory_section().  This is nasty.
> 
> This patch refactors add_memory_section() to become add_memory_block().
> The refactoring pulls the section scanning out of memory_dev_init()
> and simplifies the signature.
> 
> Signed-off-by: Seth Jennings <sjenning@linux.vnet.ibm.com>
> ---
>   drivers/base/memory.c | 48 +++++++++++++++++++++---------------------------
>   1 file changed, 21 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 7d9d3bc..021283a 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -602,32 +602,31 @@ static int init_memory_block(struct memory_block **memory,
>   	return ret;
>   }
>   
> -static int add_memory_section(struct mem_section *section,
> -			struct memory_block **mem_p)
> +static int add_memory_block(int base_section_nr)
>   {
> -	struct memory_block *mem = NULL;
> -	int scn_nr = __section_nr(section);
> -	int ret = 0;
> -
> -	if (mem_p && *mem_p) {
> -		if (scn_nr >= (*mem_p)->start_section_nr &&
> -		    scn_nr <= (*mem_p)->end_section_nr) {
> -			mem = *mem_p;
> -		}
> -	}
> +	struct memory_block *mem;
> +	int i, ret, section_count = 0, section_nr;
>   
> -	if (mem)
> -		mem->section_count++;
> -	else {
> -		ret = init_memory_block(&mem, section, MEM_ONLINE);
> -		/* store memory_block pointer for next loop */
> -		if (!ret && mem_p)
> -			*mem_p = mem;
> +	for (i = base_section_nr;
> +	     (i < base_section_nr + sections_per_block) && i < NR_MEM_SECTIONS;
> +	     i++) {
> +		if (!present_section_nr(i))
> +			continue;
> +		if (section_count == 0)
> +			section_nr = i;
> +		section_count++;
>   	}
>   
> -	return ret;
> +	if (section_count == 0)
> +		return 0;
> +	ret = init_memory_block(&mem, __nr_to_section(section_nr), MEM_ONLINE);
> +	if (ret)
> +		return ret;
> +	mem->section_count = section_count;
> +	return 0;
>   }
>   
> +
>   /*
>    * need an interface for the VM to add new memory regions,
>    * but without onlining it.
> @@ -733,7 +732,6 @@ int __init memory_dev_init(void)
>   	int ret;
>   	int err;
>   	unsigned long block_sz;
> -	struct memory_block *mem = NULL;
>   
>   	ret = subsys_system_register(&memory_subsys, memory_root_attr_groups);
>   	if (ret)
> @@ -747,12 +745,8 @@ int __init memory_dev_init(void)
>   	 * during boot and have been initialized
>   	 */
>   	mutex_lock(&mem_sysfs_mutex);
> -	for (i = 0; i < NR_MEM_SECTIONS; i++) {
> -		if (!present_section_nr(i))
> -			continue;
> -		/* don't need to reuse memory_block if only one per block */
> -		err = add_memory_section(__nr_to_section(i),
> -				 (sections_per_block == 1) ? NULL : &mem);
> +	for (i = 0; i < NR_MEM_SECTIONS; i += sections_per_block) {

Why do you remove present_setcion_nr() check?

> +		err = add_memory_block(i);
>   		if (!ret)

Thanks,
Yasuaki Ishimatasu

>   			ret = err;
>   	}
> 
