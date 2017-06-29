Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyxQn1BX2zDqjJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 20:55:45 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id u62so11514824pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 03:55:45 -0700 (PDT)
Date: Thu, 29 Jun 2017 20:55:25 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Anton
 Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 5/7] powerpc/64s: Un-blacklist system_call() from
 kprobes
Message-ID: <20170629205525.47a7e21f@roar.ozlabs.ibm.com>
In-Reply-To: <2832438c5f54ec9bef25ffacedff52c145a53d61.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
 <2832438c5f54ec9bef25ffacedff52c145a53d61.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 29 Jun 2017 16:11:08 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> It is actually safe to probe system_call() in entry_64.S, but only till
> we unset MSR_RI. To allow this, add a new symbol system_call_exit()
> after the mtmsrd and blacklist that. Though the mtmsrd instruction
> itself is now whitelisted, we won't be allowed to probe on it as we
> don't allow probing on rfi and mtmsr instructions (checked for in
> arch_prepare_kprobe()).

Can you perhaps add a small comment to explain the label
(and why it's safe to have after the mtmsrd). It could be
a bit confusing to read if you don't have that detail of
the tracer in your mind.

Other than that

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>


> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/entry_64.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index c39436706555..7a87427a67cd 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -205,6 +205,7 @@ system_call:			/* label this so stack traces look sane */
>  	mtmsrd	r11,1
>  #endif /* CONFIG_PPC_BOOK3E */
>  
> +system_call_exit:
>  	ld	r9,TI_FLAGS(r12)
>  	li	r11,-MAX_ERRNO
>  	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
> @@ -413,7 +414,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>  	b	.	/* prevent speculative execution */
>  #endif
>  _ASM_NOKPROBE_SYMBOL(system_call_common);
> -_ASM_NOKPROBE_SYMBOL(system_call);
> +_ASM_NOKPROBE_SYMBOL(system_call_exit);
>  
>  /* Save non-volatile GPRs, if not already saved. */
>  _GLOBAL(save_nvgprs)
