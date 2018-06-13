Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4159S250lbzF0dd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 12:19:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 2/5] powerpc: Flush checkpointed gpr state for 32-bit
 processes in ptrace
In-Reply-To: <20180607152534.29427-3-pedromfc@linux.vnet.ibm.com>
References: <20180607152534.29427-1-pedromfc@linux.vnet.ibm.com>
 <20180607152534.29427-3-pedromfc@linux.vnet.ibm.com>
Date: Wed, 13 Jun 2018 12:19:30 +1000
Message-ID: <87d0wvtolp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com> writes:

> Currently ptrace doesn't flush the register state when the
> checkpointed GPRs of a 32-bit thread are accessed. This can cause core
> dumps to have stale data in the checkpointed GPR note.
> ---
>  arch/powerpc/kernel/ptrace.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 6618570c6d56..be8ca03a0bd5 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -2124,6 +2124,16 @@ static int tm_cgpr32_get(struct task_struct *target,
>  		     unsigned int pos, unsigned int count,
>  		     void *kbuf, void __user *ubuf)
>  {
> +	if (!cpu_has_feature(CPU_FTR_TM))
> +		return -ENODEV;
> +
> +	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
> +		return -ENODATA;
> +
> +	flush_tmregs_to_thread(target);
> +	flush_fp_to_thread(target);
> +	flush_altivec_to_thread(target);

I think we already have 8 (!) copies of this logic in ptrace.c.

And you add two more, seems like it should be in a helper function.

Can you add a helper that does it and use that helper in these two
functions. Then if you can send me another patch that converts all the
other uses to use the new helper.

cheers

> @@ -2133,6 +2143,16 @@ static int tm_cgpr32_set(struct task_struct *target,
>  		     unsigned int pos, unsigned int count,
>  		     const void *kbuf, const void __user *ubuf)
>  {
> +	if (!cpu_has_feature(CPU_FTR_TM))
> +		return -ENODEV;
> +
> +	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
> +		return -ENODATA;
> +
> +	flush_tmregs_to_thread(target);
> +	flush_fp_to_thread(target);
> +	flush_altivec_to_thread(target);
> +
>  	return gpr32_set_common(target, regset, pos, count, kbuf, ubuf,
>  			&target->thread.ckpt_regs.gpr[0]);
>  }
> -- 
> 2.13.6
