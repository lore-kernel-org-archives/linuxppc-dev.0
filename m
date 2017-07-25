Return-Path: <bsingharora@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGrTR67vzzDqm0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 18:08:11 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id f1so8810217ioj.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 01:08:11 -0700 (PDT)
Message-ID: <1500970085.2611.3.camel@gmail.com>
Subject: Re: [PATCH v3 4/5] powerpc/lib/sstep: Add prty instruction emulation
From: Balbir Singh <bsingharora@gmail.com>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 25 Jul 2017 18:08:05 +1000
In-Reply-To: <20170725033320.17893-4-matthew.brown.dev@gmail.com>
References: <20170725033320.17893-1-matthew.brown.dev@gmail.com>
 <20170725033320.17893-4-matthew.brown.dev@gmail.com>
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

On Tue, 2017-07-25 at 13:33 +1000, Matt Brown wrote:
> This adds emulation for the prtyw and prtyd instructions.
> Tested for logical correctness against the prtyw and prtyd instructions
> on ppc64le.
> 
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
> ---
> v3:
> 	- optimised using the Giles-Miller method of side-ways addition
> v2:
> 	- fixed opcodes
> 	- fixed bitshifting and typecast errors
> 	- merged do_prtyw and do_prtyd into single function
> ---
>  arch/powerpc/lib/sstep.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 6a79618..0bcf631 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -655,6 +655,25 @@ static nokprobe_inline void do_bpermd(struct pt_regs *regs, unsigned long v1,
>  	regs->gpr[ra] = perm;
>  }
>  #endif /* __powerpc64__ */
> +/*
> + * The size parameter adjusts the equivalent prty instruction.
> + * prtyw = 32, prtyd = 64
> + */
> +static nokprobe_inline void do_prty(struct pt_regs *regs, unsigned long v,
> +				int size, int ra)
> +{
> +	unsigned long long res = v;
> +
> +	res = (0x0001000100010001 & res) + (0x0001000100010001 & (res >> 8));
> +	res = (0x0000000700000007 & res) + (0x0000000700000007 & (res >> 16));
> +	if (size == 32) {		/* prtyw */
> +		regs->gpr[ra] = (0x0000000100000001 & res);
> +		return;
> +	}
> +
> +	res = (0x000000000000000f & res) + (0x000000000000000f & (res >> 32));
> +	regs->gpr[ra] = res & 1;	/*prtyd */

Looks good, you can also xor instead of adding, but the masks would need
to change in that case.

Balbir Singh.
