Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8LFZ1d3LzDvNS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 08:04:34 +1100 (AEDT)
Date: Thu, 3 Nov 2016 08:04:12 +1100
From: Anton Blanchard <anton@samba.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au, duwe@lst.de, ast@kernel.org, viro@zeniv.linux.org.uk,
 chris@distroguy.com, oss@buserror.net, paul.gortmaker@windriver.com,
 oohall@gmail.com, aneesh.kumar@linux.vnet.ibm.com,
 lsorense@csclub.uwaterloo.ca, bauerman@linux.vnet.ibm.com,
 paulus@samba.org, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH 1/3] powerpc: Emulation support for load/store
 instructions on LE
Message-ID: <20161103080412.68240cda@kryten>
In-Reply-To: <1478076783-2872-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1478076783-2872-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1478076783-2872-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
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

Hi Ravi,

> emulate_step() uses a number of underlying kernel functions that were
> initially not enabled for LE. This has been rectified since. So, fix
> emulate_step() for LE for the corresponding instructions.

Thanks. Should this be queued up for stable?

Anton

> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
>  arch/powerpc/lib/sstep.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 3362299..6ca3b90 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -1807,8 +1807,6 @@ int __kprobes emulate_step(struct pt_regs
> *regs, unsigned int instr) goto instr_done;
>  
>  	case LARX:
> -		if (regs->msr & MSR_LE)
> -			return 0;
>  		if (op.ea & (size - 1))
>  			break;		/* can't handle
> misaligned */ err = -EFAULT;
> @@ -1832,8 +1830,6 @@ int __kprobes emulate_step(struct pt_regs
> *regs, unsigned int instr) goto ldst_done;
>  
>  	case STCX:
> -		if (regs->msr & MSR_LE)
> -			return 0;
>  		if (op.ea & (size - 1))
>  			break;		/* can't handle
> misaligned */ err = -EFAULT;
> @@ -1859,8 +1855,6 @@ int __kprobes emulate_step(struct pt_regs
> *regs, unsigned int instr) goto ldst_done;
>  
>  	case LOAD:
> -		if (regs->msr & MSR_LE)
> -			return 0;
>  		err = read_mem(&regs->gpr[op.reg], op.ea, size,
> regs); if (!err) {
>  			if (op.type & SIGNEXT)
> @@ -1872,8 +1866,6 @@ int __kprobes emulate_step(struct pt_regs
> *regs, unsigned int instr) 
>  #ifdef CONFIG_PPC_FPU
>  	case LOAD_FP:
> -		if (regs->msr & MSR_LE)
> -			return 0;
>  		if (size == 4)
>  			err = do_fp_load(op.reg, do_lfs, op.ea,
> size, regs); else
> @@ -1882,15 +1874,11 @@ int __kprobes emulate_step(struct pt_regs
> *regs, unsigned int instr) #endif
>  #ifdef CONFIG_ALTIVEC
>  	case LOAD_VMX:
> -		if (regs->msr & MSR_LE)
> -			return 0;
>  		err = do_vec_load(op.reg, do_lvx, op.ea & ~0xfUL,
> regs); goto ldst_done;
>  #endif
>  #ifdef CONFIG_VSX
>  	case LOAD_VSX:
> -		if (regs->msr & MSR_LE)
> -			return 0;
>  		err = do_vsx_load(op.reg, do_lxvd2x, op.ea, regs);
>  		goto ldst_done;
>  #endif
> @@ -1913,8 +1901,6 @@ int __kprobes emulate_step(struct pt_regs
> *regs, unsigned int instr) goto instr_done;
>  
>  	case STORE:
> -		if (regs->msr & MSR_LE)
> -			return 0;
>  		if ((op.type & UPDATE) && size == sizeof(long) &&
>  		    op.reg == 1 && op.update_reg == 1 &&
>  		    !(regs->msr & MSR_PR) &&
> @@ -1927,8 +1913,6 @@ int __kprobes emulate_step(struct pt_regs
> *regs, unsigned int instr) 
>  #ifdef CONFIG_PPC_FPU
>  	case STORE_FP:
> -		if (regs->msr & MSR_LE)
> -			return 0;
>  		if (size == 4)
>  			err = do_fp_store(op.reg, do_stfs, op.ea,
> size, regs); else
> @@ -1937,15 +1921,11 @@ int __kprobes emulate_step(struct pt_regs
> *regs, unsigned int instr) #endif
>  #ifdef CONFIG_ALTIVEC
>  	case STORE_VMX:
> -		if (regs->msr & MSR_LE)
> -			return 0;
>  		err = do_vec_store(op.reg, do_stvx, op.ea & ~0xfUL,
> regs); goto ldst_done;
>  #endif
>  #ifdef CONFIG_VSX
>  	case STORE_VSX:
> -		if (regs->msr & MSR_LE)
> -			return 0;
>  		err = do_vsx_store(op.reg, do_stxvd2x, op.ea, regs);
>  		goto ldst_done;
>  #endif
