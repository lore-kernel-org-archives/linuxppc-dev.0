Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tgByF6WT9zDw9T
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Dec 2016 01:09:25 +1100 (AEDT)
Date: Fri, 16 Dec 2016 23:09:14 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ananth@in.ibm.com, naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
 mahesh@linux.vnet.ibm.com, mhiramat@kernel.org
Subject: Re: [PATCH V2 4/4] arch/powerpc: Optimize kprobe in
 kretprobe_trampoline
Message-Id: <20161216230914.1d5817b0e7f2813b108ac8ee@kernel.org>
In-Reply-To: <1481732310-7779-3-git-send-email-anju@linux.vnet.ibm.com>
References: <1481732310-7779-1-git-send-email-anju@linux.vnet.ibm.com>
 <1481732310-7779-3-git-send-email-anju@linux.vnet.ibm.com>
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

On Wed, 14 Dec 2016 21:48:28 +0530
Anju T Sudhakar <anju@linux.vnet.ibm.com> wrote:

> Kprobe placed on the  kretprobe_trampoline during boot time can be 
> optimized, since the instruction at probe point is a 'nop'.
> 

How simple & clever way! ;)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/kprobes.c   | 8 ++++++++
>  arch/powerpc/kernel/optprobes.c | 7 +++----
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index e785cc9..5b0fd07 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -282,6 +282,7 @@ asm(".global kretprobe_trampoline\n"
>  	".type kretprobe_trampoline, @function\n"
>  	"kretprobe_trampoline:\n"
>  	"nop\n"
> +	"blr\n"
>  	".size kretprobe_trampoline, .-kretprobe_trampoline\n");
>  
>  /*
> @@ -334,6 +335,13 @@ static int __kprobes trampoline_probe_handler(struct kprobe *p,
>  
>  	kretprobe_assert(ri, orig_ret_address, trampoline_address);
>  	regs->nip = orig_ret_address;
> +	/*
> +	 * Make LR point to the orig_ret_address.
> +	 * When the 'nop' inside the kretprobe_trampoline
> +	 * is optimized, we can do a 'blr' after executing the
> +	 * detour buffer code.
> +	 */
> +	regs->link = orig_ret_address;
>  
>  	reset_current_kprobe();
>  	kretprobe_hash_unlock(current, &flags);
> diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
> index ecba221..5e4c254 100644
> --- a/arch/powerpc/kernel/optprobes.c
> +++ b/arch/powerpc/kernel/optprobes.c
> @@ -72,12 +72,11 @@ static unsigned long can_optimize(struct kprobe *p)
>  
>  	/*
>  	 * kprobe placed for kretprobe during boot time
> -	 * is not optimizing now.
> -	 *
> -	 * TODO: Optimize kprobe in kretprobe_trampoline
> +	 * has a 'nop' instruction, which can be emulated.
> +	 * So further checks can be skipped.
>  	 */
>  	if (p->addr == (kprobe_opcode_t *)&kretprobe_trampoline)
> -		return 0;
> +		return (unsigned long)p->addr + sizeof(kprobe_opcode_t);
>  
>  	/*
>  	 * We only support optimizing kernel addresses, but not
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
