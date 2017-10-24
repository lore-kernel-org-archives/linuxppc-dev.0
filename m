Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLyLg2JGnzDqfh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 02:46:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: Re: [PATCH 23/25] powerpc: Deliver SEGV signal on pkey violation
In-Reply-To: <1504910713-7094-32-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-32-git-send-email-linuxram@us.ibm.com>
Date: Tue, 24 Oct 2017 17:46:38 +0200
Message-ID: <877evk4kgx.fsf@concordia.ellerman.id.au>
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

Ram Pai <linuxram@us.ibm.com> writes:

> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index ec74e20..f2a310d 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -265,6 +266,15 @@ void user_single_step_siginfo(struct task_struct *tsk,
>  	info->si_addr = (void __user *)regs->nip;
>  }
>  
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +static void fill_sig_info_pkey(int si_code, siginfo_t *info, unsigned long addr)
> +{
> +	if (info->si_signo != SIGSEGV || si_code != SEGV_PKUERR)

Just checking si_code is sufficient there I think.

> +		return;
> +	info->si_pkey = get_paca()->paca_pkey;
> +}
> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */

This should define an empty version in the #else case, so we don't need
the ifdef below.

> @@ -292,6 +302,18 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
>  	info.si_signo = signr;
>  	info.si_code = code;
>  	info.si_addr = (void __user *) addr;
> +
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +	/*
> +	 * update the thread's pkey related fields.
> +	 * core-dump handlers and other sub-systems
> +	 * depend on those values.
> +	 */
> +	thread_pkey_regs_save(&current->thread);

You shouldn't need to do this.

We're not putting any of the pkey regs in the signal frame, so you don't
need to save before we do that. [And if you did the right place to do it
would be in setup_sigcontext() (or the TM version).]

For ptrace and coredumps it should happen in pkey_get(), see eg.
fpr_get() which does flush_fp_to_thread() as an example.

> +	/* update the violated-key value */
> +	fill_sig_info_pkey(code, &info, addr);
> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */

> +
>  	force_sig_info(signr, &info, current);
>  }

cheers
