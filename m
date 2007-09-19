Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C652DDDFE6
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 06:09:12 +1000 (EST)
In-Reply-To: <1190229304592-git-send-email-timur@freescale.com>
References: <1190229304592-git-send-email-timur@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7307F27A-9C96-464A-9285-55DAB9A9A89D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: rheap-managed bootmem allocator
Date: Wed, 19 Sep 2007 15:12:19 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 19, 2007, at 2:15 PM, Timur Tabi wrote:

> Add the ability to allocate a block of memory via alloc_bootmem()  
> and manage
> that memory with a remote heap (rheap).
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> This patch will conflict with Sylvain's "powerpc: Changes the  
> config mechanism
> for rheap" patch, but that patch hasn't been accepted yet, so I'm  
> posting this
> for review and comment.
>
>  arch/powerpc/lib/rheap.c    |   79 ++++++++++++++++++++++++++++++++ 
> +++++++++++
>  include/asm-powerpc/rheap.h |    4 ++
>  2 files changed, 83 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
> index ada5b42..d2c8913 100644
> --- a/arch/powerpc/lib/rheap.c
> +++ b/arch/powerpc/lib/rheap.c
> @@ -18,6 +18,8 @@
>  #include <linux/mm.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> +#include <linux/bootmem.h>
> +#include <linux/module.h>
>
>  #include <asm/rheap.h>
>
> @@ -729,3 +731,80 @@ void rh_dump_blk(rh_info_t * info, rh_block_t  
> * blk)
>  	       "blk @0x%p: 0x%lx-0x%lx (%u)\n",
>  	       blk, blk->start, blk->start + blk->size, blk->size);
>  }
> +
> +/* Bootmem-allocated rheap
> + *
> + * If the "rhbootmem=X" command-line parameter is specified, then  
> the RHEAP
> + * code will allocate a chunk of memory using alloc_bootmem() and  
> create an
> + * rheap for it.
> +*/
> +
> +static rh_info_t bootmem_rh_info;
> +static rh_block_t bootmem_rh_block[16];
> +
> +static void *bootmem_ptr;
> +static unsigned long bootmem_size;
> +
> +static int __init early_parse_rhbootmem(char *p)
> +{
> +	if (!p)
> +		return 1;
> +
> +	bootmem_size = _ALIGN_UP(memparse(p, &p), 32);
> +
> +	return 0;

seems like we should have a way to set bootmem_size via board/ 
platform code and not require a cmdline arg.

> +}
> +early_param("rhbootmem", early_parse_rhbootmem);
> +
