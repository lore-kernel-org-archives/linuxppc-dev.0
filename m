Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id F21C4DDE9F
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Nov 2008 00:55:02 +1100 (EST)
Date: Fri, 7 Nov 2008 16:55:00 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Martyn Welch <martyn.welch@gefanuc.com>
Subject: Re: [PATCH v3] powerpc: Basic GPIO support for GE Fanuc SBC610
Message-ID: <20081107135459.GA15326@oksana.dev.rtsoft.ru>
References: <20081107122856.6236.61346.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081107122856.6236.61346.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 07, 2008 at 01:00:15PM +0000, Martyn Welch wrote:
> Basic support for the GPIO available on the SBC610 VPX Single Board Computer
> from GE Fanuc (PowerPC MPC8641D).
> 
> This patch adds basic support for the GPIO in the devices I/O FPGA, the GPIO
> functionality is exposed through the AFIX pins on the backplane, unless used
> by an AFIX card.
> 
> This code currently does not support switching between totem-pole and
> open-drain outputs (when used as outputs, GPIOs default to totem-pole).
> The interrupt capabilites of the GPIO lines is also not currently supported.
> 
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>

Looks great.

Reviewed-by: Anton Vorontsov <avorontsov@ru.mvista.com>

[...]
> +static void gef_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
> +{
> +	struct of_mm_gpio_chip *mmchip;
> +
> +	/* Find memory mapped gpio chip structure from gpio_chip, this contains
> +	 * the mapped location of the GPIO controller
> +	 */

Just nitpicking, you might want to remove this repetitive
comment, it is quite obvious anyway. Will save 5 lines of code per
function, 20 lines in sum.

struct of_mm_gpio_chip *mmchip = to_of_mm_gpio_chip(chip);

> +	mmchip = to_of_mm_gpio_chip(chip);
> +
> +	_gef_gpio_set(mmchip->regs + GEF_GPIO_OUT, offset, value);
> +

Stray empty line here.

> +}
> +

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
