Return-Path: <ebiederm@xmission.com>
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xZWVp2XqMzDqsF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 06:18:41 +1000 (AEST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de,
 akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-36-git-send-email-linuxram@us.ibm.com>
Date: Sat, 19 Aug 2017 14:09:58 -0500
In-Reply-To: <1500177424-13695-36-git-send-email-linuxram@us.ibm.com> (Ram
 Pai's message of "Sat, 15 Jul 2017 20:56:37 -0700")
Message-ID: <87d17rnzll.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [RFC v6 35/62] powerpc: Deliver SEGV signal on pkey violation
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
> index d4e545d..fe1e7c7 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -20,6 +20,7 @@
>  #include <linux/sched/debug.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
> +#include <linux/pkeys.h>
>  #include <linux/stddef.h>
>  #include <linux/unistd.h>
>  #include <linux/ptrace.h>
> @@ -247,6 +248,15 @@ void user_single_step_siginfo(struct task_struct *tsk,
>  	info->si_addr = (void __user *)regs->nip;
>  }
>  
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +static void fill_sig_info_pkey(int si_code, siginfo_t *info, unsigned long addr)
> +{
> +	if (si_code != SEGV_PKUERR)
> +		return;

Given that SEGV_PKUERR is a signal specific si_code this test is
insufficient to detect an pkey error.  You also need to check
that signr == SIGSEGV

> +	info->si_pkey = get_paca()->paca_pkey;
> +}
> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> +
>  void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
>  {
>  	siginfo_t info;
> @@ -274,6 +284,11 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
>  	info.si_signo = signr;
>  	info.si_code = code;
>  	info.si_addr = (void __user *) addr;
> +
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +	fill_sig_info_pkey(code, &info, addr);
> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> +
>  	force_sig_info(signr, &info, current);
>  }

Eric
