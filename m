Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3123E1A06BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 23:00:15 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C2F8C140773
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2016 23:00:14 +1100 (AEDT)
Date: Tue, 1 Mar 2016 13:00:11 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH v2 2/8] powerpc/module: Only try to generate the
 ftrace_caller() stub once
Message-ID: <20160301120011.GB10342@lst.de>
References: <1456737989-8755-1-git-send-email-mpe@ellerman.id.au>
 <1456737989-8755-2-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456737989-8755-2-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 29, 2016 at 08:26:23PM +1100, Michael Ellerman wrote:
[...]
> diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
> index 2c01665eb410..dd095496d225 100644
> --- a/arch/powerpc/kernel/module_32.c
> +++ b/arch/powerpc/kernel/module_32.c
> @@ -294,11 +294,19 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
>  			return -ENOEXEC;
>  		}
>  	}
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_DYNAMIC_FTRACE
> -	module->arch.tramp =
> -		do_plt_call(module->core_layout.base,
> -			    (unsigned long)ftrace_caller,
> -			    sechdrs, module);
> -#endif
> +int module_finalize_ftrace(struct module *module, const Elf_Shdr *sechdrs)
> +{
> +	module->arch.tramp = do_plt_call(module->core_layout.base,
> +					 (unsigned long)ftrace_caller,
> +					 sechdrs, module);
> +	if (!mod->arch.tramp)

That should probably read (!module->arch.tramp).

> +		return -ENOENT;
> +
>  	return 0;
>  }
> +#endif
