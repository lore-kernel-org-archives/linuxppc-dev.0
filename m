Return-Path: <paubert@iram.es>
Received: from marchena.puc.rediris.es (marchena.puc.rediris.es
 [IPv6:2001:720:418:ca00::4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJ8b01jpnzDqPS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 18:16:12 +1000 (AEST)
Date: Mon, 30 May 2016 10:15:52 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Anton Blanchard <anton@ozlabs.org>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, acsawdey@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc: Avoid load hit store in __giveup_fpu() and
 __giveup_altivec()
Message-ID: <20160530081552.GA2547@visitor2.iram.es>
References: <1464523432-12605-1-git-send-email-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464523432-12605-1-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 29, 2016 at 10:03:50PM +1000, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> In both __giveup_fpu() and __giveup_altivec() we make two modifications
> to tsk->thread.regs->msr. gcc decides to do a read/modify/write of
> each change, so we end up with a load hit store:
> 
>         ld      r9,264(r10)
>         rldicl  r9,r9,50,1
>         rotldi  r9,r9,14
>         std     r9,264(r10)
> ...
>         ld      r9,264(r10)
>         rldicl  r9,r9,40,1
>         rotldi  r9,r9,24
>         std     r9,264(r10)
> 
> Fix this by using a temporary.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/kernel/process.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index e2f12cb..7da1f92 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -139,12 +139,16 @@ EXPORT_SYMBOL(__msr_check_and_clear);
>  #ifdef CONFIG_PPC_FPU
>  void __giveup_fpu(struct task_struct *tsk)
>  {
> +	u64 msr;

Huh? Make it an unsigned long please, which is the type of the msr
field in struct pt_regs to work on both 32 and 64 bit processors.

> +
>  	save_fpu(tsk);
> -	tsk->thread.regs->msr &= ~MSR_FP;
> +	msr = tsk->thread.regs->msr;
> +	msr &= ~MSR_FP;
>  #ifdef CONFIG_VSX
>  	if (cpu_has_feature(CPU_FTR_VSX))
> -		tsk->thread.regs->msr &= ~MSR_VSX;
> +		msr &= ~MSR_VSX;
>  #endif
> +	tsk->thread.regs->msr = msr;
>  }
>  
>  void giveup_fpu(struct task_struct *tsk)
> @@ -219,12 +223,16 @@ static int restore_fp(struct task_struct *tsk) { return 0; }
>  
>  static void __giveup_altivec(struct task_struct *tsk)
>  {
> +	u64 msr;
> +

Ditto.

>  	save_altivec(tsk);
> -	tsk->thread.regs->msr &= ~MSR_VEC;
> +	msr = tsk->thread.regs->msr;
> +	msr &= ~MSR_VEC;
>  #ifdef CONFIG_VSX
>  	if (cpu_has_feature(CPU_FTR_VSX))
> -		tsk->thread.regs->msr &= ~MSR_VSX;
> +		msr &= ~MSR_VSX;
>  #endif
> +	tsk->thread.regs->msr = msr;
>  }
>  
>  void giveup_altivec(struct task_struct *tsk)
> -- 
> 2.7.4
> 

    Gabriel
