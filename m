Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 44A77B6F92
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 00:55:38 +1100 (EST)
Date: Thu, 27 Oct 2011 14:53:53 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] asm-generic/gpio.h: merge basic gpiolib wrappers
Message-ID: <20111027135353.GM19187@n2100.arm.linux.org.uk>
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
> diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
> index 11ad0bf..741efb2 100644
> --- a/arch/arm/include/asm/gpio.h
> +++ b/arch/arm/include/asm/gpio.h
> @@ -5,14 +5,15 @@
>  #include <mach/gpio.h>
>  
>  #ifndef __ARM_GPIOLIB_COMPLEX
> +/* assume the mach has defined this */
> +#ifndef irq_to_gpio
> +#define irq_to_gpio irq_to_gpio
> +#endif

Oh, this isn't a valid assumption either - it's far from valid.  Those
sub-architectures which don't define __ARM_GPIOLIB_COMPLEX probably don't
define any kind of irq_to_gpio function by any means.  Some of our
mach/gpio.h header files for sub-architectures using entirely gpiolib
are entirely empty - and we want them to stay that way.
