Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4AAB51007D8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 00:44:18 +1100 (EST)
Date: Thu, 27 Oct 2011 14:11:24 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] asm-generic/gpio.h: merge basic gpiolib wrappers
Message-ID: <20111027131124.GK19187@n2100.arm.linux.org.uk>
References: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1319720503-3183-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319720503-3183-1-git-send-email-vapier@gentoo.org>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, linux@lists.openrisc.net,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>, linux-arch@vger.kernel.org,
 Matt Turner <mattst88@gmail.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, microblaze-uclinux@itee.uq.edu.au,
 linux-m68k@lists.linux-m68k.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>,
 linux-alpha@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 27, 2011 at 09:01:43AM -0400, Mike Frysinger wrote:
> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> index d494001..622851c 100644
> --- a/include/asm-generic/gpio.h
> +++ b/include/asm-generic/gpio.h
> @@ -170,6 +170,29 @@ extern int __gpio_cansleep(unsigned gpio);
>  
>  extern int __gpio_to_irq(unsigned gpio);
>  
> +#ifndef gpio_get_value
> +#define gpio_get_value(gpio) __gpio_get_value(gpio)
> +#endif
> +
> +#ifndef gpio_set_value
> +#define gpio_set_value(gpio, value) __gpio_set_value(gpio, value)
> +#endif
> +
> +#ifndef gpio_cansleep
> +#define gpio_cansleep(gpio) __gpio_cansleep(gpio)
> +#endif
> +
> +#ifndef gpio_to_irq
> +#define gpio_to_irq(gpio) __gpio_to_irq(gpio)
> +#endif
> +
> +#ifndef irq_to_gpio
> +static inline int irq_to_gpio(unsigned int irq)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +

This is extremely dangerous.  Consider for example this code
(see ARM mach-davinci's gpio.h):

#include <asm-generic/gpio.h>

static inline int gpio_get_value(unsigned gpio)
{
        struct davinci_gpio_controller *ctlr;

        if (!__builtin_constant_p(gpio) || gpio >= davinci_soc_info.gpio_num)
                return __gpio_get_value(gpio);

        ctlr = __gpio_to_controller(gpio);
        return __gpio_mask(gpio) & __raw_readl(ctlr->in_data);
}

The result with your changes above will be:

static inline int __gpio_get_value(unsigned gpio)
{
        struct davinci_gpio_controller *ctlr;

        if (!__builtin_constant_p(gpio) || gpio >= davinci_soc_info.gpio_num)
                return __gpio_get_value(gpio);

        ctlr = __gpio_to_controller(gpio);
        return __gpio_mask(gpio) & __raw_readl(ctlr->in_data);
}

and notice the recursive call there.

This is why I didn't solve this using the preprocessor method in ARM, but
instead used __ARM_GPIOLIB_COMPLEX to control whether these definitions
are required.
