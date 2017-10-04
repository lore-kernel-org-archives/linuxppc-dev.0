Return-Path: <pmladek@suse.com>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6XVJ5MtFzDqpt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 21:40:22 +1100 (AEDT)
Date: Wed, 4 Oct 2017 12:40:16 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 5/7] parisc64: Add .opd based function descriptor
 dereference
Message-ID: <20171004104016.GG20084@pathway.suse.cz>
References: <20170930025319.987-1-sergey.senozhatsky@gmail.com>
 <20170930025319.987-6-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170930025319.987-6-sergey.senozhatsky@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat 2017-09-30 11:53:17, Sergey Senozhatsky wrote:
> We are moving towards separate kernel and module function descriptor
> dereference callbacks. This patch enables it for parisc64.
> 
> For pointers that belong to the kernel
> -  Added __start_opd and __end_opd pointers, to track the kernel
>    .opd section address range;
> 
> -  Added dereference_kernel_function_descriptor(). Now we
>    will dereference only function pointers that are within
>    [__start_opd, __end_opd];
> 
> For pointers that belong to a module
> -  Added dereference_module_function_descriptor() to handle module
>    function descriptor dereference. Now we will dereference only
>    pointers that are within [module->opd.start, module->opd.end].

> diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
> index f1a76935a314..28f89b3dcc11 100644
> --- a/arch/parisc/kernel/module.c
> +++ b/arch/parisc/kernel/module.c
> @@ -954,3 +955,19 @@ void module_arch_cleanup(struct module *mod)
>  {
>  	deregister_unwind_table(mod);
>  }
> +
> +#ifdef CONFIG_64BIT
> +unsigned long dereference_module_function_descriptor(struct module *mod,
> +						     unsigned long addr)
> +{
> +	unsigned long start_opd = (Elf64_Addr)mod->core_layout.base +
> +				   mod->arch.fdesc_offset;
> +	unsigned long end_opd = start_opd +
> +				mod->arch.fdesc_count * sizeof(Elf64_Fdesc);

I know that this is used in rather slow paths. But it still might
make sense to have these section borders pre-computed and
stored in struct mod_arch_specific. I mean to do similar
thing that we do on powerpc.

Well, we could do this in a followup patch if parisc people
wanted it.


> +	if (addr < start_opd || addr >= end_opd)
> +		return addr;
> +
> +	return dereference_function_descriptor(addr);
> +}
> +#endif

Otherwise the patch looks fine to me.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
