In-Reply-To: <20040323024726.GA2939@gate.ebshome.net>
References: <20040312014800.GA25455@gate.ebshome.net> <405124A3.3040002@embeddededge.com> <20040312030502.GA25644@gate.ebshome.net> <24019-11838@sneakemail.com> <20040312045451.GA25876@gate.ebshome.net> <1921A482-7431-11D8-AFB6-000393DBC2E8@motorola.com> <1079668852.909.88.camel@gaston> <20040323024726.GA2939@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7BA03F8C-839E-11D8-928B-000393DBC2E8@motorola.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>,
	Matt Porter <mporter@kernel.crashing.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Kumar Gala <kumar.gala@motorola.com>
Subject: Re: [RFC] "indirect" DCR access (40x, BookE)
Date: Wed, 31 Mar 2004 23:36:10 -0600
To: Eugene Surovegin <ebs@ebshome.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Looks good to me.

- kumar

On Mar 22, 2004, at 8:47 PM, Eugene Surovegin wrote:

>
> On Fri, Mar 19, 2004 at 03:00:53PM +1100, Benjamin Herrenschmidt wrote:
>> I much prefer Eugene's idea.
>
> During discussion with Ben on IRC he suggested that having two
> different DCR access wasn't a good idea and better if we use GCC
> __builtin_constant_p extension to decide what version to call.
>
> New patch version can be found http://kernel.ebshome.net/dcr-2.6-2.diff
>
> Here is only _new_ part for review:
>
> ===== include/asm-ppc/reg_booke.h 1.5 vs edited =====
> --- 1.5/include/asm-ppc/reg_booke.h     Fri Feb 13 07:24:55 2004
> +++ edited/include/asm-ppc/reg_booke.h  Mon Mar 22 17:44:02 2004
> @@ -10,20 +10,33 @@
>  #define __ASM_PPC_REG_BOOKE_H__
>
>  #ifndef __ASSEMBLY__
> +#include <linux/compiler.h>
> +
>  /* Device Control Registers */
> +void __mtdcr(int reg, unsigned int val);
> +unsigned int __mfdcr(int reg);
>  #define mfdcr(rn) mfdcr_or_dflt(rn, 0)
>  #define mfdcr_or_dflt(rn,default_rval)
>  \
>         ({unsigned int rval;
>  \
> -       if (rn == 0)
>  \
> +       if (unlikely(rn == 0))
>  \
>                 rval = default_rval;
>  \
>         else
>  \
> -               asm volatile("mfdcr %0," __stringify(rn) : "=r"
> (rval)); \
> +               if (__builtin_constant_p(rn))
>  \
> +                       asm volatile("mfdcr %0," __stringify(rn)
>  \
> +                                     : "=r" (rval));
>  \
> +               else
>  \
> +                       rval = __mfdcr(rn);
>  \
>         rval;})
>
>  #define mtdcr(rn, v)
>  \
>  do {
>  \
> -       if (rn != 0)
>  \
> -               asm volatile("mtdcr " __stringify(rn) ",%0" : : "r"
> (v)); \
> +       if (likely(rn != 0)){
>  \
> +               if (__builtin_constant_p(rn))
>  \
> +                       asm volatile("mtdcr " __stringify(rn) ",%0"
>  \
> +                                     : : "r" (v));
>  \
> +               else
>  \
> +                       __mtdcr(rn, v);
>  \
> +       }
>  \
>  } while (0)
>
>  /* R/W of indirect DCRs make use of standard naming conventions for
> DCRs */
>
> Thanks,
>
> Eugene
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
