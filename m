Return-Path: <cyrilbur@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLMdG3YZKzDrJP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 11:42:10 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id t83so37100pfj.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 18:42:10 -0700 (PDT)
Message-ID: <1501465323.3751.0.camel@gmail.com>
Subject: Re: [PATCH v4 1/5] powerpc/lib/sstep: Add cmpb instruction emulation
From: Cyril Bur <cyrilbur@gmail.com>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 31 Jul 2017 11:42:03 +1000
In-Reply-To: <20170731005826.32044-1-matthew.brown.dev@gmail.com>
References: <20170731005826.32044-1-matthew.brown.dev@gmail.com>
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
> This patch adds emulation of the cmpb instruction, enabling xmon to
> emulate this instruction.
> Tested for correctness against the cmpb asm instruction on ppc64le.
> 
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>

Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

> ---
> v2: 
> 	- fixed opcode
> 	- fixed mask typecasting
> ---
>  arch/powerpc/lib/sstep.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 33117f8..87d277f 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -596,6 +596,22 @@ static nokprobe_inline void do_cmp_unsigned(struct pt_regs *regs, unsigned long
>  	regs->ccr = (regs->ccr & ~(0xf << shift)) | (crval << shift);
>  }
>  
> +static nokprobe_inline void do_cmpb(struct pt_regs *regs, unsigned long v1,
> +				unsigned long v2, int rd)
> +{
> +	unsigned long long out_val, mask;
> +	int i;
> +
> +	out_val = 0;
> +	for (i = 0; i < 8; i++) {
> +		mask = 0xffUL << (i * 8);
> +		if ((v1 & mask) == (v2 & mask))
> +			out_val |= mask;
> +	}
> +
> +	regs->gpr[rd] = out_val;
> +}
> +
>  static nokprobe_inline int trap_compare(long v1, long v2)
>  {
>  	int ret = 0;
> @@ -1049,6 +1065,10 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
>  			do_cmp_unsigned(regs, val, val2, rd >> 2);
>  			goto instr_done;
>  
> +		case 508: /* cmpb */
> +			do_cmpb(regs, regs->gpr[rd], regs->gpr[rb], ra);
> +			goto instr_done;
> +
>  /*
>   * Arithmetic instructions
>   */
