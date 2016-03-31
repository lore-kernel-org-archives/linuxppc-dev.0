Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbKxm5bNgzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 21:09:48 +1100 (AEDT)
Message-ID: <1459418980.24848.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: ppc4xx: drop unused variable
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 Alexandre Courbot <acourbot@nvidia.com>
Cc: Anatolij Gustschin <agust@denx.de>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Date: Thu, 31 Mar 2016 21:09:40 +1100
In-Reply-To: <1459408452-3483-1-git-send-email-linus.walleij@linaro.org>
References: <1459408452-3483-1-git-send-email-linus.walleij@linaro.org>
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

On Thu, 2016-03-31 at 09:14 +0200, Linus Walleij wrote:

> commit 0d36fe65f58391712e11a6621075f373216e5f00
> "powerpc: ppc4xx: use gpiochip data pointer"
> made the mm_gc local variable in ppc4xx_gpio_set()
> redundant, and when GCC treats warnings as errors this
> happens:
> 
> arch/powerpc/sysdev/ppc4xx_gpio.c: In function 'ppc4xx_gpio_set':
> arch/powerpc/sysdev/ppc4xx_gpio.c:93:26: error:
>   unused variable 'mm_gc' [-Werror=unused-variable]
>      struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
>                              ^
>    cc1: all warnings being treated as errors
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I've applied this to the GPIO tree where the offending
> commit is now merged.

Thanks.

If you feel like cross building powerpc in future it should be as simple as:

 $ dnf install gcc-powerpc64-linux-gnu || apt-get install gcc-powerpc-linux-gnu
 $ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- ...

:)

cheers
