Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtS6r4xxFzDvYq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 13:41:24 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id j186so787939pge.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 20:41:24 -0700 (PDT)
Date: Thu, 22 Jun 2017 13:41:12 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 4/6] powerpc/64s: Un-blacklist system_call() from
 kprobes
Message-ID: <20170622134112.4bd32543@roar.ozlabs.ibm.com>
In-Reply-To: <d13eccaed4be643409abed29565dbdd8c7d5af6a.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <d13eccaed4be643409abed29565dbdd8c7d5af6a.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Thu, 22 Jun 2017 00:08:40 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> It is actually safe to probe system_call() in entry_64.S, but only till
> we unset MSR_RI. To allow this, add a new symbol system_call_exit()
> after the mtmsrd and blacklist that. Though the mtmsrd instruction
> itself is now whitelisted, we won't be allowed to probe on it as we
> don't allow probing on rfi and mtmsr instructions (checked for in
> arch_prepare_kprobe()).

Can you add a little comment to say probes aren't allowed, and it's
located after the mtmsr in order to avoid contaminating traces?

Also I wonder if a slightly different name would be more instructive?
I don't normally care, but the system_call_common code isn't trivial
to follow. system_call_exit might give the impression that it is the
entire exit path (which would pair with system_call for entry).

Perhaps system_call_exit_notrace? No that sucks too :(

Thanks,
Nick


> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/entry_64.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index ef8e6615b8ba..feeeadc9aa71 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -204,6 +204,7 @@ system_call:			/* label this so stack traces look sane */
>  	mtmsrd	r11,1
>  #endif /* CONFIG_PPC_BOOK3E */
>  
> +system_call_exit:
>  	ld	r9,TI_FLAGS(r12)
>  	li	r11,-MAX_ERRNO
>  	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
> @@ -412,7 +413,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>  	b	.	/* prevent speculative execution */
>  #endif
>  _ASM_NOKPROBE_SYMBOL(system_call_common);
> -_ASM_NOKPROBE_SYMBOL(system_call);
> +_ASM_NOKPROBE_SYMBOL(system_call_exit);
>  
>  /* Save non-volatile GPRs, if not already saved. */
>  _GLOBAL(save_nvgprs)
