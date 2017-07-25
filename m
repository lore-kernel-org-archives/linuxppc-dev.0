Return-Path: <bsingharora@gmail.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGqFL3mf7zDqm5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 17:12:38 +1000 (AEST)
Received: by mail-it0-x244.google.com with SMTP id r9so8189964ita.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 00:12:38 -0700 (PDT)
Message-ID: <1500966751.2611.1.camel@gmail.com>
Subject: Re: [PATCH v3 2/5] powerpc/lib/sstep: Add popcnt instruction emulation
From: Balbir Singh <bsingharora@gmail.com>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 25 Jul 2017 17:12:31 +1000
In-Reply-To: <20170725033320.17893-2-matthew.brown.dev@gmail.com>
References: <20170725033320.17893-1-matthew.brown.dev@gmail.com>
 <20170725033320.17893-2-matthew.brown.dev@gmail.com>
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
> +	out = (0x3333333333333333 & out) + (0x3333333333333333 & (out >> 2));
> +	out = (0x0f0f0f0f0f0f0f0f & out) + (0x0f0f0f0f0f0f0f0f & (out >> 4));
> +	if (size == 8) {	/* popcntb */
> +		regs->gpr[ra] = out;
> +		return;
> +	}
> +	out = (0x001f001f001f001f & out) + (0x001f001f001f001f & (out >> 8));

Why are we using 0x001f001f here? Now that we've got things in the
bytes with 0's prefixing, we can directly use

out = out + out >> 8

> +	out = (0x0000003f0000003f & out) + (0x0000003f0000003f & (out >> 16));

Same as above

> +	if (size == 32) {	/* popcntw */
> +		regs->gpr[ra] = out;
> +		return;
> +	}
> +	out = (0x000000000000007f & out) + (0x000000000000007f & (out >> 32));
> +	regs->gpr[ra] = out;	/* popcntd */

Ditto

Otherwise looks good!

Balbir Singh.
