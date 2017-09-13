Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsyJr5TMMzDqYP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 09:18:36 +1000 (AEST)
Date: Wed, 13 Sep 2017 16:18:32 -0700
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/5] powerpc/kprobes: Some cosmetic updates to
 try_to_emulate()
Message-Id: <20170913161832.fb471e2aff5c4ceb0cfa396f@kernel.org>
In-Reply-To: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
References: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Thu, 14 Sep 2017 02:50:32 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> 1. This is only used in kprobes.c, so make it static.
> 2. Remove the un-necessary (ret == 0) comparison in the else clause.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> ---
>  arch/powerpc/kernel/kprobes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 367494dc67d9..c2a6ab38a67f 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -239,7 +239,7 @@ void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
>  }
>  NOKPROBE_SYMBOL(arch_prepare_kretprobe);
>  
> -int try_to_emulate(struct kprobe *p, struct pt_regs *regs)
> +static int try_to_emulate(struct kprobe *p, struct pt_regs *regs)
>  {
>  	int ret;
>  	unsigned int insn = *p->ainsn.insn;
> @@ -261,7 +261,7 @@ int try_to_emulate(struct kprobe *p, struct pt_regs *regs)
>  		 */
>  		printk("Can't step on instruction %x\n", insn);
>  		BUG();
> -	} else if (ret == 0)
> +	} else
>  		/* This instruction can't be boosted */
>  		p->ainsn.boostable = -1;
>  
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
