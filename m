Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C687F1A0688
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2015 03:24:48 +1100 (AEDT)
Date: Thu, 3 Dec 2015 17:24:45 +0100
From: Petr Mladek <pmladek@suse.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v4 8/9] Implement kernel live patching for ppc64le (ABIv2)
Message-ID: <20151203162445.GG8047@pathway.suse.cz>
References: <20151125172608.9588569260@newverein.lst.de>
 <20151125172937.9425E69260@newverein.lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151125172937.9425E69260@newverein.lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 2015-11-25 17:48:36, Torsten Duwe wrote:
>   * create the appropriate files+functions
>     arch/powerpc/include/asm/livepatch.h
>         klp_check_compiler_support,
>         klp_arch_set_pc
>     arch/powerpc/kernel/livepatch.c with a stub for
>         klp_write_module_reloc
>     This is architecture-independent work in progress.
>   * introduce a fixup in arch/powerpc/kernel/entry_64.S
>     for local calls that are becoming global due to live patching.
>     And of course do the main KLP thing: return to a maybe different
>     address, possibly altered by the live patching ftrace op.
> 
> --- /dev/null
> +++ b/arch/powerpc/include/asm/livepatch.h
> @@ -0,0 +1,45 @@
[...]
> +#include <linux/module.h>
> +#include <linux/ftrace.h>
> +
> +#ifdef CONFIG_LIVEPATCH
> +static inline int klp_check_compiler_support(void)
> +{
> +#if !defined(_CALL_ELF) || _CALL_ELF != 2

I am just curious why we do not check CC_USING_MPROFILE_KERNEL
like in the other similar locations. It would look less cryptic.
But I am not sure if it is precise enough.

Best Regards,
Petr

> +	return 1;
> +#endif
> +	return 0;
> +}
> +
