Return-Path: <cyrilbur@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLQbT5pRzzDrRm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 13:55:49 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 125so15858859pgi.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 20:55:49 -0700 (PDT)
Message-ID: <1501473342.3751.2.camel@gmail.com>
Subject: Re: [PATCH v4 4/5] powerpc/lib/sstep: Add prty instruction emulation
From: Cyril Bur <cyrilbur@gmail.com>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 31 Jul 2017 13:55:42 +1000
In-Reply-To: <20170731005826.32044-4-matthew.brown.dev@gmail.com>
References: <20170731005826.32044-1-matthew.brown.dev@gmail.com>
 <20170731005826.32044-4-matthew.brown.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-31 at 10:58 +1000, Matt Brown wrote:
> This adds emulation for the prtyw and prtyd instructions.
> Tested for logical correctness against the prtyw and prtyd instructions
> on ppc64le.
> 
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>

Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

> ---
> v4:
> 	- use simpler xor method
> v3:
> 	- optimised using the Giles-Miller method of side-ways addition
> v2:
> 	- fixed opcodes
> 	- fixed bitshifting and typecast errors
> 	- merged do_prtyw and do_prtyd into single function
> ---
>  arch/powerpc/lib/sstep.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index c9fd613..af4eef9 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -657,6 +657,24 @@ static nokprobe_inline void do_bpermd(struct pt_regs *regs, unsigned long v1,
>  	regs->gpr[ra] = perm;
>  }
>  #endif /* CONFIG_PPC64 */
> +/*
> + * The size parameter adjusts the equivalent prty instruction.
> + * prtyw = 32, prtyd = 64
> + */
> +static nokprobe_inline void do_prty(struct pt_regs *regs, unsigned long v,
> +				int size, int ra)
> +{
> +	unsigned long long res = v ^ (v >> 8);
> +
> +	res ^= res >> 16;
> +	if (size == 32) {		/* prtyw */
> +		regs->gpr[ra] = res & 0x0000000100000001;
> +		return;
> +	}
> +
> +	res ^= res >> 32;
> +	regs->gpr[ra] = res & 1;	/*prtyd */
> +}
>  
>  static nokprobe_inline int trap_compare(long v1, long v2)
>  {
> @@ -1247,6 +1265,14 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
>  		case 124:	/* nor */
>  			regs->gpr[ra] = ~(regs->gpr[rd] | regs->gpr[rb]);
>  			goto logical_done;
> +
> +		case 154:	/* prtyw */
> +			do_prty(regs, regs->gpr[rd], 32, ra);
> +			goto logical_done;
> +
> +		case 186:	/* prtyd */
> +			do_prty(regs, regs->gpr[rd], 64, ra);
> +			goto logical_done;
>  #ifdef CONFIG_PPC64
>  		case 252:	/* bpermd */
>  			do_bpermd(regs, regs->gpr[rd], regs->gpr[rb], ra);
