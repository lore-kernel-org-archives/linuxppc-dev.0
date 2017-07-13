Return-Path: <paubert@iram.es>
Received: from cica-lavadora-l1mail3.puc.rediris.es
 (ci-l1mail3-out05a.puc.rediris.es [IPv6:2001:720:418:ca02::31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7S8X5rvbzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 17:27:56 +1000 (AEST)
Date: Thu, 13 Jul 2017 09:16:18 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Matt Brown <matthew.brown.dev@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org
Subject: Re: [PATCH 3/5] powerpc/lib/sstep: Add bpermd instruction emulation
Message-ID: <20170713071618.ibiqvzkc4dusc6ub@lt-gp.iram.es>
References: <20170713032548.451-1-matthew.brown.dev@gmail.com>
 <20170713032548.451-3-matthew.brown.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170713032548.451-3-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 13, 2017 at 01:25:46PM +1000, Matt Brown wrote:
> This adds emulation for the bpermd instruction.
> 
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
> ---
>  arch/powerpc/lib/sstep.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index cf69987..603654d 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -637,6 +637,21 @@ static nokprobe_inline void do_popcnt(struct pt_regs *regs, unsigned long v1,
>  	regs->gpr[ra] = out_val;
>  }
>  
> +static nokprobe_inline void do_bpermd(struct pt_regs *regs, unsigned long v1,
> +				unsigned long v2, int ra)
> +{
> +	unsigned int idx, i;
> +	unsigned char perm;
> +
> +	perm = 0x0;
> +	for (i = 0; i < 8; i++) {
> +		idx = (v1 >> (i * 8)) & 0xff;
> +		if (idx < 64)
> +			perm |= (v2 & (1 << idx)) >> (idx - i);
> +	}
> +	regs->gpr[ra] = 0 | perm;

Huh? What's the point of doing an or with 0?

The compiler will eliminate it, but it just confuses the reader.

	Gabriel
> +}
> +
>  static nokprobe_inline int trap_compare(long v1, long v2)
>  {
>  	int ret = 0;
> @@ -1274,6 +1289,14 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
>  			goto logical_done;
>  #endif
>  
> +#ifdef __powerpc64__
> +		case 2396736:	/* bpermd */
> +			val = regs->gpr[rd];
> +			val2 = regs->gpr[rb];
> +			do_bpermd(regs, val, val2, ra);
> +			goto logical_done;
> +#endif
> +
>  /*
>   * Shift instructions
>   */
> -- 
> 2.9.3
