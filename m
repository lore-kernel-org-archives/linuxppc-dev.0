Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3SZ83cvjzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 14:32:32 +1000 (AEST)
Date: Thu, 13 Apr 2017 13:32:21 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Ingo
 Molnar <mingo@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] powerpc: introduce a new helper to obtain
 function entry points
Message-Id: <20170413133221.a11fafe3f1f776517cce9663@kernel.org>
In-Reply-To: <0f8685ca8b0d0b467a0d5ae60e666558d85062ed.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <0f8685ca8b0d0b467a0d5ae60e666558d85062ed.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 12 Apr 2017 16:28:26 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> kprobe_lookup_name() is specific to the kprobe subsystem and may not
> always return the function entry point (in a subsequent patch for
> KPROBES_ON_FTRACE).

If so, please move this patch into that series. It is hard to review
patches which requires for other series.

Thank you,

> For looking up function entry points, introduce a
> separate helper and use the same in optprobes.c
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/code-patching.h | 37 ++++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/optprobes.c          |  6 +++---
>  2 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
> index 8ab937771068..3e994f404434 100644
> --- a/arch/powerpc/include/asm/code-patching.h
> +++ b/arch/powerpc/include/asm/code-patching.h
> @@ -12,6 +12,8 @@
>  
>  #include <asm/types.h>
>  #include <asm/ppc-opcode.h>
> +#include <linux/string.h>
> +#include <linux/kallsyms.h>
>  
>  /* Flags for create_branch:
>   * "b"   == create_branch(addr, target, 0);
> @@ -99,6 +101,41 @@ static inline unsigned long ppc_global_function_entry(void *func)
>  #endif
>  }
>  
> +/*
> + * Wrapper around kallsyms_lookup() to return function entry address:
> + * - For ABIv1, we lookup the dot variant.
> + * - For ABIv2, we return the local entry point.
> + */
> +static inline unsigned long ppc_kallsyms_lookup_name(const char *name)
> +{
> +	unsigned long addr;
> +#ifdef PPC64_ELF_ABI_v1
> +	/* check for dot variant */
> +	char dot_name[1 + KSYM_NAME_LEN];
> +	bool dot_appended = false;
> +	if (name[0] != '.') {
> +		dot_name[0] = '.';
> +		dot_name[1] = '\0';
> +		strncat(dot_name, name, KSYM_NAME_LEN - 2);
> +		dot_appended = true;
> +	} else {
> +		dot_name[0] = '\0';
> +		strncat(dot_name, name, KSYM_NAME_LEN - 1);
> +	}
> +	addr = kallsyms_lookup_name(dot_name);
> +	if (!addr && dot_appended)
> +		/* Let's try the original non-dot symbol lookup	*/
> +		addr = kallsyms_lookup_name(name);
> +#elif defined(PPC64_ELF_ABI_v2)
> +	addr = kallsyms_lookup_name(name);
> +	if (addr)
> +		addr = ppc_function_entry((void *)addr);
> +#else
> +	addr = kallsyms_lookup_name(name);
> +#endif
> +	return addr;
> +}
> +
>  #ifdef CONFIG_PPC64
>  /*
>   * Some instruction encodings commonly used in dynamic ftracing
> diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
> index ce81a322251c..ec60ed0d4aad 100644
> --- a/arch/powerpc/kernel/optprobes.c
> +++ b/arch/powerpc/kernel/optprobes.c
> @@ -243,10 +243,10 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
>  	/*
>  	 * 2. branch to optimized_callback() and emulate_step()
>  	 */
> -	op_callback_addr = kprobe_lookup_name("optimized_callback", 0);
> -	emulate_step_addr = kprobe_lookup_name("emulate_step", 0);
> +	op_callback_addr = (kprobe_opcode_t *)ppc_kallsyms_lookup_name("optimized_callback");
> +	emulate_step_addr = (kprobe_opcode_t *)ppc_kallsyms_lookup_name("emulate_step");
>  	if (!op_callback_addr || !emulate_step_addr) {
> -		WARN(1, "kprobe_lookup_name() failed\n");
> +		WARN(1, "Unable to lookup optimized_callback()/emulate_step()\n");
>  		goto error;
>  	}
>  
> -- 
> 2.12.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
