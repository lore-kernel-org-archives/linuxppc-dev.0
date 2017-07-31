Return-Path: <cyrilbur@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLQJ71sctzDr3x
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 13:42:31 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id y129so29299644pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 20:42:31 -0700 (PDT)
Message-ID: <1501472544.3751.1.camel@gmail.com>
Subject: Re: [PATCH v4 3/5] powerpc/lib/sstep: Add bpermd instruction emulation
From: Cyril Bur <cyrilbur@gmail.com>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 31 Jul 2017 13:42:24 +1000
In-Reply-To: <20170731005826.32044-3-matthew.brown.dev@gmail.com>
References: <20170731005826.32044-1-matthew.brown.dev@gmail.com>
 <20170731005826.32044-3-matthew.brown.dev@gmail.com>
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
> This adds emulation for the bpermd instruction.
> Tested for correctness against the bpermd instruction on ppc64le.
> 
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>

Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

> ---
> v4:
> 	- change ifdef macro from __powerpc64__ to CONFIG_PPC64
> v2:
> 	- fixed opcode
> 	- added ifdef tags to do_bpermd func
> 	- fixed bitshifting errors
> ---
>  arch/powerpc/lib/sstep.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 2fd7377..c9fd613 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -640,6 +640,24 @@ static nokprobe_inline void do_popcnt(struct pt_regs *regs, unsigned long v1,
>  	regs->gpr[ra] = out;	/* popcntd */
>  }
>  
> +#ifdef CONFIG_PPC64
> +static nokprobe_inline void do_bpermd(struct pt_regs *regs, unsigned long v1,
> +				unsigned long v2, int ra)
> +{
> +	unsigned char perm, idx;
> +	unsigned int i;
> +
> +	perm = 0;
> +	for (i = 0; i < 8; i++) {
> +		idx = (v1 >> (i * 8)) & 0xff;
> +		if (idx < 64)
> +			if (v2 & PPC_BIT(idx))
> +				perm |= 1 << i;
> +	}
> +	regs->gpr[ra] = perm;
> +}
> +#endif /* CONFIG_PPC64 */
> +
>  static nokprobe_inline int trap_compare(long v1, long v2)
>  {
>  	int ret = 0;
> @@ -1229,7 +1247,11 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
>  		case 124:	/* nor */
>  			regs->gpr[ra] = ~(regs->gpr[rd] | regs->gpr[rb]);
>  			goto logical_done;
> -
> +#ifdef CONFIG_PPC64
> +		case 252:	/* bpermd */
> +			do_bpermd(regs, regs->gpr[rd], regs->gpr[rb], ra);
> +			goto logical_done;
> +#endif
>  		case 284:	/* xor */
>  			regs->gpr[ra] = ~(regs->gpr[rd] ^ regs->gpr[rb]);
>  			goto logical_done;
