Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 15893DDE98
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 00:08:44 +1000 (EST)
Message-Id: <F09034D9-1B3C-4087-B6DF-FAB7B3AFA191@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20080625040718.028B470296@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 2/9] powerpc: Add macros to access floating point
	registers in thread_struct.
Date: Wed, 25 Jun 2008 09:08:31 -0500
References: <20080625040718.028B470296@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> Index: linux-2.6-ozlabs/arch/powerpc/kernel/ptrace32.c
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/kernel/ptrace32.c
> +++ linux-2.6-ozlabs/arch/powerpc/kernel/ptrace32.c
> @@ -64,6 +64,11 @@ static long compat_ptrace_old(struct tas
> 	return -EPERM;
> }
>
> +/* Macros to workout the correct index for the FPR in the thread  
> struct */
> +#define FPRNUMBER(i) (((i) - PT_FPR0) >> 1)
> +#define FPRHALF(i) (((i) - PT_FPR0) % 2)

Have you looked at what the compiler spits out here to make sure we  
aren't getting a divide?  Seems like we could use '& 0x1'.

> +#define FPRINDEX(i) TS_FPRWIDTH * FPRNUMBER(i) + FPRHALF(i)



>
> +
> long compat_arch_ptrace(struct task_struct *child, compat_long_t  
> request,
> 			compat_ulong_t caddr, compat_ulong_t cdata)
> {
> @@ -122,7 +127,8 @@ long compat_arch_ptrace(struct task_stru
> 			 * to be an array of unsigned int (32 bits) - the
> 			 * index passed in is based on this assumption.
> 			 */
> -			tmp = ((unsigned int *)child->thread.fpr)[index - PT_FPR0];
> +			tmp = ((unsigned int *)child->thread.fpr)
> +				[FPRINDEX(index)];
> 		}
> 		ret = put_user((unsigned int)tmp, (u32 __user *)data);
> 		break;
> @@ -162,7 +168,8 @@ long compat_arch_ptrace(struct task_stru
> 		CHECK_FULL_REGS(child->thread.regs);
> 		if (numReg >= PT_FPR0) {
> 			flush_fp_to_thread(child);
> -			tmp = ((unsigned long int *)child->thread.fpr)[numReg - PT_FPR0];
> +			tmp = ((unsigned long int *)child->thread.fpr)
> +				[FPRINDEX(numReg)];
> 		} else { /* register within PT_REGS struct */
> 			tmp = ptrace_get_reg(child, numReg);
> 		}
> @@ -217,7 +224,8 @@ long compat_arch_ptrace(struct task_stru
> 			 * to be an array of unsigned int (32 bits) - the
> 			 * index passed in is based on this assumption.
> 			 */
> -			((unsigned int *)child->thread.fpr)[index - PT_FPR0] = data;
> +			((unsigned int *)child->thread.fpr)
> +				[FPRINDEX(index)] = data;
> 			ret = 0;
> 		}
> 		break;

- k
