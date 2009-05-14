Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 471E8DE010
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 01:49:52 +1000 (EST)
Date: Thu, 14 May 2009 11:49:50 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/ftrace: Use pr_devel() in ftrace.c
In-Reply-To: <e805665453162bf2eb90b402e41fc7b672fcf639.1242282612.git.michael@ellerman.id.au>
Message-ID: <alpine.DEB.2.00.0905141149130.30591@gandalf.stny.rr.com>
References: <e805665453162bf2eb90b402e41fc7b672fcf639.1242282612.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I'm fine with this patch, but it should go via the PPC tree.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve


On Thu, 14 May 2009, Michael Ellerman wrote:

> pr_debug() can now result in code being generated even when #DEBUG
> is not defined. That's not really desirable in the ftrace code
> which we want to be snappy.
> 
> With CONFIG_DYNAMIC_DEBUG=y:
> 
> size before:
>    text	   data	    bss	    dec	    hex	filename
>    3334	    672	      4	   4010	    faa	arch/powerpc/kernel/ftrace.o
> 
> size after:
>    text	   data	    bss	    dec	    hex	filename
>    2616	    360	      4	   2980	    ba4	arch/powerpc/kernel/ftrace.o
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/powerpc/kernel/ftrace.c |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
> index 70e2a73..5b078ee 100644
> --- a/arch/powerpc/kernel/ftrace.c
> +++ b/arch/powerpc/kernel/ftrace.c
> @@ -157,7 +157,7 @@ __ftrace_make_nop(struct module *mod,
>  	 * 0xe8, 0x4c, 0x00, 0x28,    ld      r2,40(r12)
>  	 */
>  
> -	pr_debug("ip:%lx jumps to %lx r2: %lx", ip, tramp, mod->arch.toc);
> +	pr_devel("ip:%lx jumps to %lx r2: %lx", ip, tramp, mod->arch.toc);
>  
>  	/* Find where the trampoline jumps to */
>  	if (probe_kernel_read(jmp, (void *)tramp, sizeof(jmp))) {
> @@ -165,7 +165,7 @@ __ftrace_make_nop(struct module *mod,
>  		return -EFAULT;
>  	}
>  
> -	pr_debug(" %08x %08x", jmp[0], jmp[1]);
> +	pr_devel(" %08x %08x", jmp[0], jmp[1]);
>  
>  	/* verify that this is what we expect it to be */
>  	if (((jmp[0] & 0xffff0000) != 0x3d820000) ||
> @@ -181,18 +181,18 @@ __ftrace_make_nop(struct module *mod,
>  	offset = ((unsigned)((unsigned short)jmp[0]) << 16) +
>  		(int)((short)jmp[1]);
>  
> -	pr_debug(" %x ", offset);
> +	pr_devel(" %x ", offset);
>  
>  	/* get the address this jumps too */
>  	tramp = mod->arch.toc + offset + 32;
> -	pr_debug("toc: %lx", tramp);
> +	pr_devel("toc: %lx", tramp);
>  
>  	if (probe_kernel_read(jmp, (void *)tramp, 8)) {
>  		printk(KERN_ERR "Failed to read %lx\n", tramp);
>  		return -EFAULT;
>  	}
>  
> -	pr_debug(" %08x %08x\n", jmp[0], jmp[1]);
> +	pr_devel(" %08x %08x\n", jmp[0], jmp[1]);
>  
>  	ptr = ((unsigned long)jmp[0] << 32) + jmp[1];
>  
> @@ -269,7 +269,7 @@ __ftrace_make_nop(struct module *mod,
>  	 *  0x4e, 0x80, 0x04, 0x20  bctr
>  	 */
>  
> -	pr_debug("ip:%lx jumps to %lx", ip, tramp);
> +	pr_devel("ip:%lx jumps to %lx", ip, tramp);
>  
>  	/* Find where the trampoline jumps to */
>  	if (probe_kernel_read(jmp, (void *)tramp, sizeof(jmp))) {
> @@ -277,7 +277,7 @@ __ftrace_make_nop(struct module *mod,
>  		return -EFAULT;
>  	}
>  
> -	pr_debug(" %08x %08x ", jmp[0], jmp[1]);
> +	pr_devel(" %08x %08x ", jmp[0], jmp[1]);
>  
>  	/* verify that this is what we expect it to be */
>  	if (((jmp[0] & 0xffff0000) != 0x3d600000) ||
> @@ -293,7 +293,7 @@ __ftrace_make_nop(struct module *mod,
>  	if (tramp & 0x8000)
>  		tramp -= 0x10000;
>  
> -	pr_debug(" %lx ", tramp);
> +	pr_devel(" %lx ", tramp);
>  
>  	if (tramp != addr) {
>  		printk(KERN_ERR
> @@ -402,7 +402,7 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>  	/* ld r2,40(r1) */
>  	op[1] = 0xe8410028;
>  
> -	pr_debug("write to %lx\n", rec->ip);
> +	pr_devel("write to %lx\n", rec->ip);
>  
>  	if (probe_kernel_write((void *)ip, op, MCOUNT_INSN_SIZE * 2))
>  		return -EPERM;
> @@ -442,7 +442,7 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>  		return -EINVAL;
>  	}
>  
> -	pr_debug("write to %lx\n", rec->ip);
> +	pr_devel("write to %lx\n", rec->ip);
>  
>  	if (probe_kernel_write((void *)ip, &op, MCOUNT_INSN_SIZE))
>  		return -EPERM;
> -- 
> 1.6.2.1
> 
> 
