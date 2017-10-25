Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMbPc4qf8zDqvG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 03:36:36 +1100 (AEDT)
Date: Thu, 26 Oct 2017 01:36:31 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] powerpc/kprobes: Blacklist emulate_update_regs()
 from kprobes
Message-Id: <20171026013631.aad0fc7b0d77ef02616b806e@kernel.org>
In-Reply-To: <df974488791e93054bce0bea032ef1b1ec8ad873.1508776485.git.naveen.n.rao@linux.vnet.ibm.com>
References: <2a4b854c7fc11db576e3b7ff6dcfda94c64d2842.1508776485.git.naveen.n.rao@linux.vnet.ibm.com>
 <df974488791e93054bce0bea032ef1b1ec8ad873.1508776485.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Mon, 23 Oct 2017 22:07:40 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Commit 3cdfcbfd32b9d ("powerpc: Change analyse_instr so it doesn't
> modify *regs") introduced emulate_update_regs() to perform part of what
> emulate_step() was doing earlier. However, this function was not added
> to the kprobes blacklist. Add it so as to prevent it from being probed.
> 

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/lib/sstep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 8c3955e183d4..70274b7b4773 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -2717,6 +2717,7 @@ void emulate_update_regs(struct pt_regs *regs, struct instruction_op *op)
>  	}
>  	regs->nip = next_pc;
>  }
> +NOKPROBE_SYMBOL(emulate_update_regs);
>  
>  /*
>   * Emulate a previously-analysed load or store instruction.
> -- 
> 2.14.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
