Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNjZx40yKzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 02:17:45 +1100 (AEDT)
Date: Thu, 16 Feb 2017 00:17:33 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc: kprobes: fix handling of function offsets
 on ABIv2
Message-Id: <20170216001733.98d247f7ee293172c238b1f2@kernel.org>
In-Reply-To: <1b7d5ea08a7e11fbf1fb08dd3536219c94b13591.1487060527.git.naveen.n.rao@linux.vnet.ibm.com>
References: <1b7d5ea08a7e11fbf1fb08dd3536219c94b13591.1487060527.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Tue, 14 Feb 2017 14:08:01 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> commit 239aeba76409 ("perf powerpc: Fix kprobe and kretprobe handling
> with kallsyms on ppc64le") changed how we use the offset field in struct
> kprobe on ABIv2. perf now offsets from the GEP (Global entry point) if an
> offset is specified and otherwise chooses the LEP (Local entry point).
> 
> Fix the same in kernel for kprobe API users. We do this by extending
> kprobe_lookup_name() to accept an additional parameter to indicate the
> offset specified with the kprobe registration. If offset is 0, we return
> the local function entry and return the global entry point otherwise.
> 
> With:
> 	# cd /sys/kernel/debug/tracing/
> 	# echo "p _do_fork" >> kprobe_events
> 	# echo "p _do_fork+0x10" >> kprobe_events
> 
> before this patch:
> 	# cat ../kprobes/list
> 	c0000000000d0748  k  _do_fork+0x8    [DISABLED]
> 	c0000000000d0758  k  _do_fork+0x18    [DISABLED]
> 	c0000000000412b0  k  kretprobe_trampoline+0x0    [OPTIMIZED]
> 
> and after:
> 	# cat ../kprobes/list
> 	c0000000000d04c8  k  _do_fork+0x8    [DISABLED]
> 	c0000000000d04d0  k  _do_fork+0x10    [DISABLED]
> 	c0000000000412b0  k  kretprobe_trampoline+0x0    [OPTIMIZED]
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/kprobes.h | 6 +++---
>  arch/powerpc/kernel/optprobes.c    | 4 ++--
>  kernel/kprobes.c                   | 6 +++---
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
> index d821835ade86..e7ada061aa12 100644
> --- a/arch/powerpc/include/asm/kprobes.h
> +++ b/arch/powerpc/include/asm/kprobes.h
> @@ -60,10 +60,10 @@ extern kprobe_opcode_t optprobe_template_end[];
>  
>  #ifdef PPC64_ELF_ABI_v2
>  /* PPC64 ABIv2 needs local entry point */
> -#define kprobe_lookup_name(name, addr)					\
> +#define kprobe_lookup_name(name, addr, offset)				\
>  {									\
>  	addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);		\
> -	if (addr)							\
> +	if (addr && !(offset))						\
>  		addr = (kprobe_opcode_t *)ppc_function_entry(addr);	\
>  }
>  #elif defined(PPC64_ELF_ABI_v1)
> @@ -75,7 +75,7 @@ extern kprobe_opcode_t optprobe_template_end[];
>   * This ensures we always get to the actual symbol and not the descriptor.
>   * Also handle <module:symbol> format.
>   */
> -#define kprobe_lookup_name(name, addr)					\
> +#define kprobe_lookup_name(name, addr, offset)				\
>  {									\
>  	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];		\
>  	const char *modsym;							\
> diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
> index 2282bf4e63cd..e51a045f3d3b 100644
> --- a/arch/powerpc/kernel/optprobes.c
> +++ b/arch/powerpc/kernel/optprobes.c
> @@ -243,8 +243,8 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
>  	/*
>  	 * 2. branch to optimized_callback() and emulate_step()
>  	 */
> -	kprobe_lookup_name("optimized_callback", op_callback_addr);
> -	kprobe_lookup_name("emulate_step", emulate_step_addr);
> +	kprobe_lookup_name("optimized_callback", op_callback_addr, 0);
> +	kprobe_lookup_name("emulate_step", emulate_step_addr, 0);
>  	if (!op_callback_addr || !emulate_step_addr) {
>  		WARN(1, "kprobe_lookup_name() failed\n");
>  		goto error;
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 83ad7e440417..9bc433575d98 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -63,7 +63,7 @@
>   * so this must be overridable.
>   */
>  #ifndef kprobe_lookup_name
> -#define kprobe_lookup_name(name, addr) \
> +#define kprobe_lookup_name(name, addr, offset) \
>  	addr = ((kprobe_opcode_t *)(kallsyms_lookup_name(name)))
>  #endif

Hmm, it smells no good coding... I would like to use __weak function
instead of this "#ifndef" trick.

Thank you,

>  
> @@ -1365,7 +1365,7 @@ static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
>  		goto invalid;
>  
>  	if (p->symbol_name) {
> -		kprobe_lookup_name(p->symbol_name, addr);
> +		kprobe_lookup_name(p->symbol_name, addr, p->offset);
>  		if (!addr)
>  			return ERR_PTR(-ENOENT);
>  	}
> @@ -2161,7 +2161,7 @@ static int __init init_kprobes(void)
>  		/* lookup the function address from its name */
>  		for (i = 0; kretprobe_blacklist[i].name != NULL; i++) {
>  			kprobe_lookup_name(kretprobe_blacklist[i].name,
> -					   kretprobe_blacklist[i].addr);
> +					   kretprobe_blacklist[i].addr, 0);
>  			if (!kretprobe_blacklist[i].addr)
>  				printk("kretprobe: lookup failed: %s\n",
>  				       kretprobe_blacklist[i].name);
> -- 
> 2.11.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
