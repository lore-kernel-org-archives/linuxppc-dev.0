Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AFB24B71A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Nov 2010 14:37:22 +1100 (EST)
Subject: Re: arch/powerpc/*/div64.S
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <acahalan@gmail.com>
In-Reply-To: <AANLkTinC-DiZNZ4GsWM2+xk+mp=AN1Q82uLAekNB=_FT@mail.gmail.com>
References: <AANLkTinC-DiZNZ4GsWM2+xk+mp=AN1Q82uLAekNB=_FT@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Nov 2010 14:37:14 +1100
Message-ID: <1290051434.32570.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-10-02 at 14:16 -0400, Albert Cahalan wrote:
> This looks like duplicated code getting out of sync.

Right, tho your patch actually reverts the fix :-)

I don't know if it's worth considering using common files for some /lib
stuff there tho.. .the runtime env. is quite different...

Ben.

> $ diff -Naurd arch/powerpc/lib/div64.S arch/powerpc/boot/div64.S
> --- arch/powerpc/lib/div64.S    2009-09-09 18:13:59.000000000 -0400
> +++ arch/powerpc/boot/div64.S   2009-09-09 18:13:59.000000000 -0400
> @@ -13,10 +13,10 @@
>   * as published by the Free Software Foundation; either version
>   * 2 of the License, or (at your option) any later version.
>   */
> -#include <asm/ppc_asm.h>
> -#include <asm/processor.h>
> +#include "ppc_asm.h"
> 
> -_GLOBAL(__div64_32)
> +       .globl __div64_32
> +__div64_32:
>         lwz     r5,0(r3)        # get the dividend into r5/r6
>         lwz     r6,4(r3)
>         cmplw   r5,r4
> @@ -33,10 +33,9 @@
>         cntlzw  r0,r5           # we are shifting the dividend right
>         li      r10,-1          # to make it < 2^32, and shifting
>         srw     r10,r10,r0      # the divisor right the same amount,
> -       addc    r9,r4,r10       # rounding up (so the estimate cannot
> +       add     r9,r4,r10       # rounding up (so the estimate cannot
>         andc    r11,r6,r10      # ever be too large, only too small)
>         andc    r9,r9,r10
> -       addze   r9,r9
>         or      r11,r5,r11
>         rotlw   r9,r9,r0
>         rotlw   r11,r11,r0
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
