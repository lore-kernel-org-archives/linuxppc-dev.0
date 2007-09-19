Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A8514DDEC6
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 06:28:20 +1000 (EST)
In-Reply-To: <11901785761816-git-send-email-Ed.Swarthout@freescale.com>
References: <11901785761816-git-send-email-Ed.Swarthout@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AE49FC96-0FEF-4EEA-BCAA-C5C4585F4491@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc mm init_32 gdb regions
Date: Wed, 19 Sep 2007 15:31:23 -0500
To: Ed Swarthout <Ed.Swarthout@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 19, 2007, at 12:09 AM, Ed Swarthout wrote:

> Add memory regions to the kcore list for 32-bit machines.
> Since the entries are only 32-bit, keep under 4G.
>
> Signed-off-by: Ed Swarthout <Ed.Swarthout@freescale.com>
> ---
>
> Adapted from init_64.c
>
>  arch/powerpc/mm/init_32.c |   34 ++++++++++++++++++++++++++++++++++
>  1 files changed, 34 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
> index d65995a..d804c65 100644
> --- a/arch/powerpc/mm/init_32.c
> +++ b/arch/powerpc/mm/init_32.c
> @@ -255,3 +255,37 @@ void free_initrd_mem(unsigned long start,  
> unsigned long end)
>  	}
>  }
>  #endif
> +

should this be #ifdef CONFIG_PROC_KCORE protected?

> +static struct kcore_list kcore_vmem;
> +
> +static int __init setup_kcore(void)
> +{
> +	int i;
> +
> +	for (i=0; i < lmb.memory.cnt; i++) {
> +		unsigned long base, size;
> +		struct kcore_list *kcore_mem;
> +
> +		base = lmb.memory.region[i].base;
> +		size = lmb.memory.region[i].size;
> +
> +		kcore_mem = kmalloc(sizeof(struct kcore_list), GFP_ATOMIC);
> +		if (!kcore_mem)
> +			panic("%s: kmalloc failed\n", __FUNCTION__);
> +
> +		/* must stay under 32 bits */
> +		if ( 0xfffffffful - (unsigned long)__va(base) < size) {
> +			size = 0xfffffffful - (unsigned long)(__va(base));
> +			printk(KERN_DEBUG "setup_kcore: restrict size=%lx\n",
> +						size);
> +		}
> +
> +		kclist_add(kcore_mem, __va(base), size);
> +	}
> +
> +	kclist_add(&kcore_vmem, (void *)VMALLOC_START,
> +		VMALLOC_END-VMALLOC_START);
> +
> +	return 0;
> +}
> +module_init(setup_kcore);
> -- 
> 1.5.3.rc6.63.gf7c18
