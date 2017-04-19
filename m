Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7Prj20JVzDqNM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 00:43:49 +1000 (AEST)
Date: Wed, 19 Apr 2017 23:43:38 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] powerpc: kprobes: remove duplicate saving of msr
Message-Id: <20170419234338.24997b39e18506f07e4897bf@kernel.org>
In-Reply-To: <bdf0464c4b7f0d4aa0099d3e60ebeb63ba4b07d1.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <bdf0464c4b7f0d4aa0099d3e60ebeb63ba4b07d1.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Wed, 19 Apr 2017 18:21:06 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> set_current_kprobe() already saves regs->msr into kprobe_saved_msr. Remove
> the redundant save.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/kprobes.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 067e9863bfdf..5c0a1ffcbcf9 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -272,7 +272,6 @@ int __kprobes kprobe_handler(struct pt_regs *regs)
>  			 */
>  			save_previous_kprobe(kcb);
>  			set_current_kprobe(p, regs, kcb);
> -			kcb->kprobe_saved_msr = regs->msr;
>  			kprobes_inc_nmissed_count(p);
>  			prepare_singlestep(p, regs);
>  			kcb->kprobe_status = KPROBE_REENTER;
> -- 
> 2.12.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
