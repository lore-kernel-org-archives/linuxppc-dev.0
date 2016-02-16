Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D3801A0502
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 20:09:58 +1100 (AEDT)
Received: from mail-yw0-x233.google.com (mail-yw0-x233.google.com
 [IPv6:2607:f8b0:4002:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EF6F61401E7
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:09:56 +1100 (AEDT)
Received: by mail-yw0-x233.google.com with SMTP id e63so39320049ywc.3
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 01:09:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1455613198-5113-4-git-send-email-khandual@linux.vnet.ibm.com>
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1455613198-5113-4-git-send-email-khandual@linux.vnet.ibm.com>
Date: Tue, 16 Feb 2016 12:09:54 +0300
Message-ID: <CAOJe8K11GOHeMdy-LMyhUn-s5=R6xaPvtLP__+qCNH4R=NavGQ@mail.gmail.com>
Subject: Re: [PATCH V10 03/28] powerpc, ptrace: Enable in transaction
 NT_PRFPREG ptrace requests
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 shuahkh@osg.samsung.com, mikey@neuling.org, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, emachado@linux.vnet.ibm.com, oleg@redhat.com,
 davem@davemloft.net, dhowells@redhat.com, Ulrich.Weigand@de.ibm.com,
 kirjanov@gmail.com, davej@redhat.com, akpm@linux-foundation.org,
 sukadev@linux.vnet.ibm.com, tglx@linutronix.de, sam.bobroff@au1.ibm.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/16/16, Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
> This patch enables in transaction NT_PRFPREG ptrace requests.
> The function fpr_get which gets the running value of all FPR
> registers and the function fpr_set which sets the running
> value of of all FPR registers work on the running set of FPR
> registers whose location will be different if transaction is
> active. This patch makes these functions adapt to situations
> when the transaction is active.
>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/ptrace.c | 93
> ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 89 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 30a03c0..547a979 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -358,6 +358,29 @@ static int gpr_set(struct task_struct *target, const
> struct user_regset *regset,
>  	return ret;
>  }
>
> +/*
> + * When the transaction is active, 'transact_fp' holds the current running
> + * value of all FPR registers and 'fp_state' holds the last checkpointed
> + * value of all FPR registers for the current transaction. When transaction
> + * is not active 'fp_state' holds the current running state of all the FPR
> + * registers. So this function which returns the current running values of
> + * all the FPR registers, needs to know whether any transaction is active
> + * or not.
> + *
> + * Userspace interface buffer layout:
> + *
> + * struct data {
> + *	u64	fpr[32];
> + *	u64	fpscr;
> + * };
> + *
> + * There are two config options CONFIG_VSX and CONFIG_PPC_TRANSACTIONAL_MEM
> + * which determines the final code in this function. All the combinations
> of
> + * these two config options are possible except the one below as
> transactional
> + * memory config pulls in CONFIG_VSX automatically.
> + *
> + *	!defined(CONFIG_VSX) && defined(CONFIG_PPC_TRANSACTIONAL_MEM)
> + */
>  static int fpr_get(struct task_struct *target, const struct user_regset
> *regset,
>  		   unsigned int pos, unsigned int count,
>  		   void *kbuf, void __user *ubuf)
> @@ -368,14 +391,31 @@ static int fpr_get(struct task_struct *target, const
> struct user_regset *regset,
>  #endif
>  	flush_fp_to_thread(target);
>
> -#ifdef CONFIG_VSX
> +#if defined(CONFIG_VSX) && defined(CONFIG_PPC_TRANSACTIONAL_MEM)
> +	/* copy to local buffer then write that out */
> +	if (MSR_TM_ACTIVE(target->thread.regs->msr)) {
> +		flush_altivec_to_thread(target);
> +		flush_tmregs_to_thread(target);
> +		for (i = 0; i < 32 ; i++)
use ELF_NFPREG

> +			buf[i] = target->thread.TS_TRANS_FPR(i);
> +		buf[32] = target->thread.transact_fp.fpscr;
> +	} else {
> +		for (i = 0; i < 32 ; i++)
> +			buf[i] = target->thread.TS_FPR(i);
> +		buf[32] = target->thread.fp_state.fpscr;
> +	}
> +	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
> +#endif
> +
> +#if defined(CONFIG_VSX) && !defined(CONFIG_PPC_TRANSACTIONAL_MEM)
>  	/* copy to local buffer then write that out */
>  	for (i = 0; i < 32 ; i++)
>  		buf[i] = target->thread.TS_FPR(i);
>  	buf[32] = target->thread.fp_state.fpscr;
>  	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
> +#endif
>
> -#else
> +#if !defined(CONFIG_VSX) && !defined(CONFIG_PPC_TRANSACTIONAL_MEM)
>  	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
>  		     offsetof(struct thread_fp_state, fpr[32][0]));
>
> @@ -384,6 +424,29 @@ static int fpr_get(struct task_struct *target, const
> struct user_regset *regset,
>  #endif
>  }
>
> +/*
> + * When the transaction is active, 'transact_fp' holds the current running
> + * value of all FPR registers and 'fp_state' holds the last checkpointed
> + * value of all FPR registers for the current transaction. When transaction
> + * is not active 'fp_state' holds the current running state of all the FPR
> + * registers. So this function which setss the current running values of
> + * all the FPR registers, needs to know whether any transaction is active
> + * or not.
> + *
> + * Userspace interface buffer layout:
> + *
> + * struct data {
> + *	u64	fpr[32];
> + *	u64	fpscr;
> + * };
> + *
> + * There are two config options CONFIG_VSX and CONFIG_PPC_TRANSACTIONAL_MEM
> + * which determines the final code in this function. All the combinations
> of
> + * these two config options are possible except the one below as
> transactional
> + * memory config pulls in CONFIG_VSX automatically.
> + *
> + *	!defined(CONFIG_VSX) && defined(CONFIG_PPC_TRANSACTIONAL_MEM)
> + */
>  static int fpr_set(struct task_struct *target, const struct user_regset
> *regset,
>  		   unsigned int pos, unsigned int count,
>  		   const void *kbuf, const void __user *ubuf)
> @@ -394,7 +457,27 @@ static int fpr_set(struct task_struct *target, const
> struct user_regset *regset,
>  #endif
>  	flush_fp_to_thread(target);
>
> -#ifdef CONFIG_VSX
> +#if defined(CONFIG_VSX) && defined(CONFIG_PPC_TRANSACTIONAL_MEM)
> +	/* copy to local buffer then write that out */
> +	i = user_regset_copyin(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
> +	if (i)
> +		return i;
> +
> +	if (MSR_TM_ACTIVE(target->thread.regs->msr)) {
> +		flush_altivec_to_thread(target);
> +		flush_tmregs_to_thread(target);
> +		for (i = 0; i < 32 ; i++)
> +			target->thread.TS_TRANS_FPR(i) = buf[i];
> +		target->thread.transact_fp.fpscr = buf[32];
> +	} else {
> +		for (i = 0; i < 32 ; i++)
> +			target->thread.TS_FPR(i) = buf[i];
> +		target->thread.fp_state.fpscr = buf[32];
> +	}
> +	return 0;
> +#endif
> +
> +#if defined(CONFIG_VSX) && !defined(CONFIG_PPC_TRANSACTIONAL_MEM)
>  	/* copy to local buffer then write that out */
>  	i = user_regset_copyin(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
>  	if (i)
> @@ -403,7 +486,9 @@ static int fpr_set(struct task_struct *target, const
> struct user_regset *regset,
>  		target->thread.TS_FPR(i) = buf[i];
>  	target->thread.fp_state.fpscr = buf[32];
>  	return 0;
> -#else
> +#endif
> +
> +#if !defined(CONFIG_VSX) && !defined(CONFIG_PPC_TRANSACTIONAL_MEM)
>  	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
>  		     offsetof(struct thread_fp_state, fpr[32][0]));
>
> --
> 2.1.0
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
