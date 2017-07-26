Return-Path: <paubert@iram.es>
Received: from cica-lavadora-l1mail3.puc.rediris.es
 (ci-l1mail3-out05a.puc.rediris.es [IPv6:2001:720:418:ca02::31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHRZ82XwvzDqmV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 17:29:16 +1000 (AEST)
Date: Wed, 26 Jul 2017 09:29:00 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Matt Brown <matthew.brown.dev@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/5] powerpc/lib/sstep: Add popcnt instruction emulation
Message-ID: <20170726072850.vtmqtrgzyhzh6okl@lt-gp.iram.es>
References: <20170725033320.17893-1-matthew.brown.dev@gmail.com>
 <20170725033320.17893-2-matthew.brown.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170725033320.17893-2-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 25, 2017 at 01:33:17PM +1000, Matt Brown wrote:
> This adds emulations for the popcntb, popcntw, and popcntd instructions.
> Tested for correctness against the popcnt{b,w,d} instructions on ppc64le.
> 
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
> ---
> v3:
> 	- optimised using the Giles-Miller method of side-ways addition
> v2:
> 	- fixed opcodes
> 	- fixed typecasting
> 	- fixed bitshifting error for both 32 and 64bit arch
> ---
>  arch/powerpc/lib/sstep.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 87d277f..c1f9cdb 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -612,6 +612,32 @@ static nokprobe_inline void do_cmpb(struct pt_regs *regs, unsigned long v1,
>  	regs->gpr[rd] = out_val;
>  }
>  
> +/*
> + * The size parameter is used to adjust the equivalent popcnt instruction.
> + * popcntb = 8, popcntw = 32, popcntd = 64
> + */
> +static nokprobe_inline void do_popcnt(struct pt_regs *regs, unsigned long v1,
> +				int size, int ra)
> +{
> +	unsigned long long out = v1;
> +
> +	out = (0x5555555555555555 & out) + (0x5555555555555555 & (out >> 1));

This can be simplified in a less obvious way as:
	out -= (out >> 1) & 0x5555555555555555;

which maps each pair of bits according to the following:
00 -> 00
01 -> 01
10 -> 01
11 -> 10

This should save one instruction.

> +	out = (0x3333333333333333 & out) + (0x3333333333333333 & (out >> 2));

Ok, but now each nibble is between 0 and 4, so the addition of two
nibbles can't overflow or generate carry into the higher one.

> +	out = (0x0f0f0f0f0f0f0f0f & out) + (0x0f0f0f0f0f0f0f0f & (out >> 4));

	out += out >> 4;
	out &= 0x0f0f0f0f0f0f0f0f;

which should also save one instruction

> +	if (size == 8) {	/* popcntb */
> +		regs->gpr[ra] = out;
> +		return;
> +	}

At this point each count occupies at least one byte and can no more
overflow, so masking is only needed before returning.

> +	out = (0x001f001f001f001f & out) + (0x001f001f001f001f & (out >> 8));
	out += out >> 8;

> +	out = (0x0000003f0000003f & out) + (0x0000003f0000003f & (out >> 16));

	out += out >> 16;

> +	if (size == 32) {	/* popcntw */
> +		regs->gpr[ra] = out;
		regs->gpr[ra] = out & 0x0000003f0000003f;

> +		return;
> +	}
> +	out = (0x000000000000007f & out) + (0x000000000000007f & (out >> 32));
	out = (out + (out >> 32)) & 0x7f;


	Gabriel

> +	regs->gpr[ra] = out;	/* popcntd */
> +}
> +
>  static nokprobe_inline int trap_compare(long v1, long v2)
>  {
>  	int ret = 0;
> @@ -1194,6 +1220,10 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
>  			regs->gpr[ra] = regs->gpr[rd] & ~regs->gpr[rb];
>  			goto logical_done;
>  
> +		case 122:	/* popcntb */
> +			do_popcnt(regs, regs->gpr[rd], 8, ra);
> +			goto logical_done;
> +
>  		case 124:	/* nor */
>  			regs->gpr[ra] = ~(regs->gpr[rd] | regs->gpr[rb]);
>  			goto logical_done;
> @@ -1206,6 +1236,10 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
>  			regs->gpr[ra] = regs->gpr[rd] ^ regs->gpr[rb];
>  			goto logical_done;
>  
> +		case 378:	/* popcntw */
> +			do_popcnt(regs, regs->gpr[rd], 32, ra);
> +			goto logical_done;
> +
>  		case 412:	/* orc */
>  			regs->gpr[ra] = regs->gpr[rd] | ~regs->gpr[rb];
>  			goto logical_done;
> @@ -1217,7 +1251,11 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
>  		case 476:	/* nand */
>  			regs->gpr[ra] = ~(regs->gpr[rd] & regs->gpr[rb]);
>  			goto logical_done;
> -
> +#ifdef __powerpc64__
> +		case 506:	/* popcntd */
> +			do_popcnt(regs, regs->gpr[rd], 64, ra);
> +			goto logical_done;
> +#endif
>  		case 922:	/* extsh */
>  			regs->gpr[ra] = (signed short) regs->gpr[rd];
>  			goto logical_done;
> -- 
> 2.9.3
