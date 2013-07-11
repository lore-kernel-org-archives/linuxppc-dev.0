Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2C5892C02F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 22:45:30 +1000 (EST)
Message-ID: <1373546721.19894.90.camel@pasglop>
Subject: Re: [PATCH 2/2] powerpc/math-emu: keep track of the instructions
 unimplemented by FPU
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Hao <haokexin@gmail.com>
Date: Thu, 11 Jul 2013 22:45:21 +1000
In-Reply-To: <1373545315-9219-3-git-send-email-haokexin@gmail.com>
References: <1373545315-9219-1-git-send-email-haokexin@gmail.com>
 <1373545315-9219-3-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-07-11 at 20:21 +0800, Kevin Hao wrote:
> Some cores (such as Freescale BookE) don't implement all floating
> point instructions in ISA. But some gcc versions do use these
> instructions. So we would have to enable the math emulation in this
> case. Add this to emulated instructions tracking statistics so that
> the user has a way to know that its toolcahin emit these unimplemented
> floating point instructions.

That patch is gross, it makes the function even more nasty than it
already is. Besides, CONFIG_PPC_FPU doesn't mean you have a HW FPU,
you need to check the CPU feature bits.

Also the caller already does PPC_WARN_EMULATED, so this patch makes
you call it twice or am I missing something ?

Cheers,
Ben.

> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  arch/powerpc/math-emu/math.c | 50 +++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/math-emu/math.c b/arch/powerpc/math-emu/math.c
> index 18ce6a7..9a98b6c 100644
> --- a/arch/powerpc/math-emu/math.c
> +++ b/arch/powerpc/math-emu/math.c
> @@ -10,6 +10,7 @@
>  
>  #include <asm/sfp-machine.h>
>  #include <math-emu/double.h>
> +#include <asm/emulated_ops.h>
>  
>  #define FLOATFUNC(x)	extern int x(void *, void *, void *, void *)
>  
> @@ -222,10 +223,17 @@ do_mathemu(struct pt_regs *regs)
>  	int idx = 0;
>  	int (*func)(void *, void *, void *, void *);
>  	int type = 0;
> -	int eflag, trap;
> +	int eflag, trap, ret = -ENOSYS;
> +	int has_hw_fpu = 0;
>  
> -	if (get_user(insn, (u32 *)pc))
> -		return -EFAULT;
> +#ifdef CONFIG_PPC_FPU
> +	has_hw_fpu = 1;
> +#endif
> +
> +	if (get_user(insn, (u32 *)pc)) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
>  
>  	switch (insn >> 26) {
>  	case LFS:	func = lfs;	type = D;	break;
> @@ -249,7 +257,7 @@ do_mathemu(struct pt_regs *regs)
>  		case STFDUX:	func = stfd;	type = XEU;	break;
>  		case STFIWX:	func = stfiwx;	type = XE;	break;
>  		default:
> -			goto illegal;
> +			goto out;
>  		}
>  		break;
>  
> @@ -267,7 +275,7 @@ do_mathemu(struct pt_regs *regs)
>  		case FNMSUBS:	func = fnmsubs;	type = ABC;	break;
>  		case FNMADDS:	func = fnmadds;	type = ABC;	break;
>  		default:
> -			goto illegal;
> +			goto out;
>  		}
>  		break;
>  
> @@ -287,7 +295,7 @@ do_mathemu(struct pt_regs *regs)
>  			case FNMSUB:	func = fnmsub;	type = ABC;	break;
>  			case FNMADD:	func = fnmadd;	type = ABC;	break;
>  			default:
> -				goto illegal;
> +				goto out;
>  			}
>  			break;
>  		}
> @@ -309,12 +317,12 @@ do_mathemu(struct pt_regs *regs)
>  		case MFFS:	func = mffs;	type = X;	break;
>  		case MTFSF:	func = mtfsf;	type = XFLB;	break;
>  		default:
> -			goto illegal;
> +			goto out;
>  		}
>  		break;
>  
>  	default:
> -		goto illegal;
> +		goto out;
>  	}
>  
>  	switch (type) {
> @@ -347,7 +355,7 @@ do_mathemu(struct pt_regs *regs)
>  	case DU:
>  		idx = (insn >> 16) & 0x1f;
>  		if (!idx)
> -			goto illegal;
> +			goto out;
>  
>  		sdisp = (insn & 0xffff);
>  		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
> @@ -375,7 +383,7 @@ do_mathemu(struct pt_regs *regs)
>  			if (((insn >> 1) & 0x3ff) == STFIWX)
>  				op1 = (void *)(regs->gpr[(insn >> 11) & 0x1f]);
>  			else
> -				goto illegal;
> +				goto out;
>  		} else {
>  			op1 = (void *)(regs->gpr[idx] + regs->gpr[(insn >> 11) & 0x1f]);
>  		}
> @@ -417,7 +425,7 @@ do_mathemu(struct pt_regs *regs)
>  		break;
>  
>  	default:
> -		goto illegal;
> +		goto out;
>  	}
>  
>  	/*
> @@ -425,9 +433,8 @@ do_mathemu(struct pt_regs *regs)
>  	 * if flushed into the thread_struct before attempting
>  	 * emulation
>  	 */
> -#ifdef CONFIG_PPC_FPU
> -	flush_fp_to_thread(current);
> -#endif
> +	if (has_hw_fpu)
> +		flush_fp_to_thread(current);
>  
>  	eflag = func(op0, op1, op2, op3);
>  
> @@ -437,8 +444,10 @@ do_mathemu(struct pt_regs *regs)
>  	}
>  
>  	trap = record_exception(regs, eflag);
> -	if (trap)
> -		return 1;
> +	if (trap) {
> +		ret = 1;
> +		goto out;
> +	}
>  
>  	switch (type) {
>  	case DU:
> @@ -451,8 +460,11 @@ do_mathemu(struct pt_regs *regs)
>  	}
>  
>  	regs->nip += 4;
> -	return 0;
> +	ret = 0;
> +
> +out:
> +	if (has_hw_fpu && ret >= 0)
> +		PPC_WARN_EMULATED(math, regs);
>  
> -illegal:
> -	return -ENOSYS;
> +	return ret;
>  }
