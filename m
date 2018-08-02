Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gzDg5dyVzF1Qn
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 15:26:27 +1000 (AEST)
Subject: Re: [PATCH v4 5/6] powerpc: Add show_user_instructions()
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Cc: Alastair D'Silva <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Cyril Bur <cyrilbur@gmail.com>, "Eric W . Biederman"
 <ebiederm@xmission.com>, Joe Perches <joe@perches.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org,
 Segher Boessenkool <segher@kernel.crashing.org>
References: <20180801213320.11203-1-muriloo@linux.ibm.com>
 <20180801213320.11203-6-muriloo@linux.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7209fa95-8d40-14ca-f27a-ce3edb64191e@c-s.fr>
Date: Thu, 2 Aug 2018 07:26:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180801213320.11203-6-muriloo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 01/08/2018 à 23:33, Murilo Opsfelder Araujo a écrit :
> show_user_instructions() is a slightly modified version of
> show_instructions() that allows userspace instruction dump.
> 
> This will be useful within show_signal_msg() to dump userspace
> instructions of the faulty location.
> 
> Here is a sample of what show_user_instructions() outputs:
> 
>    pandafault[10850]: code: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
>    pandafault[10850]: code: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040
> 
> The current->comm and current->pid printed can serve as a glue that
> links the instructions dump to its originator, allowing messages to be
> interleaved in the logs.
> 
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/stacktrace.h | 13 +++++++++
>   arch/powerpc/kernel/process.c         | 40 +++++++++++++++++++++++++++
>   2 files changed, 53 insertions(+)
>   create mode 100644 arch/powerpc/include/asm/stacktrace.h
> 
> diff --git a/arch/powerpc/include/asm/stacktrace.h b/arch/powerpc/include/asm/stacktrace.h
> new file mode 100644
> index 000000000000..6149b53b3bc8
> --- /dev/null
> +++ b/arch/powerpc/include/asm/stacktrace.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Stack trace functions.
> + *
> + * Copyright 2018, Murilo Opsfelder Araujo, IBM Corporation.
> + */
> +
> +#ifndef _ASM_POWERPC_STACKTRACE_H
> +#define _ASM_POWERPC_STACKTRACE_H
> +
> +void show_user_instructions(struct pt_regs *regs);
> +
> +#endif /* _ASM_POWERPC_STACKTRACE_H */
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index e9533b4d2f08..364645ac732c 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1299,6 +1299,46 @@ static void show_instructions(struct pt_regs *regs)
>   	pr_cont("\n");
>   }
>   
> +void show_user_instructions(struct pt_regs *regs)
> +{
> +	int i;
> +	const char *prefix = KERN_INFO "%s[%d]: code: ";
> +	unsigned long pc = regs->nip - (instructions_to_print * 3 / 4 *
> +					sizeof(int));
> +
> +	printk(prefix, current->comm, current->pid);

Why not use pr_info() and remove KERN_INFO from *prefix ?

> +
> +	for (i = 0; i < instructions_to_print; i++) {
> +		int instr;
> +
> +		if (!(i % 8) && (i > 0)) {
> +			pr_cont("\n");
> +			printk(prefix, current->comm, current->pid);
> +		}
> +
> +#if !defined(CONFIG_BOOKE)
> +		/* If executing with the IMMU off, adjust pc rather
> +		 * than print XXXXXXXX.
> +		 */
> +		if (!(regs->msr & MSR_IR))
> +			pc = (unsigned long)phys_to_virt(pc);

Shouldn't this be done outside of the loop, only once ?

Christophe

> +#endif
> +
> +		if (probe_kernel_address((unsigned int __user *)pc, instr)) {
> +			pr_cont("XXXXXXXX ");
> +		} else {
> +			if (regs->nip == pc)
> +				pr_cont("<%08x> ", instr);
> +			else
> +				pr_cont("%08x ", instr);
> +		}
> +
> +		pc += sizeof(int);
> +	}
> +
> +	pr_cont("\n");
> +}
> +
>   struct regbit {
>   	unsigned long bit;
>   	const char *name;
> 
