Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f203.google.com (mail-iw0-f203.google.com
	[209.85.223.203]) by ozlabs.org (Postfix) with ESMTP id 8FBD2B7D29
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 04:17:05 +1100 (EST)
Received: by iwn41 with SMTP id 41so2844899iwn.9
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 09:17:04 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100205203232.GA1475@oksana.dev.rtsoft.ru>
References: <20100205203201.GA32281@oksana.dev.rtsoft.ru>
	<20100205203232.GA1475@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 10:16:44 -0700
Message-ID: <fa686aa41002090916w613efcb9te15e4969a880f724@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpiolib: Introduce chip addition/removal notifier
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bill Gatliff <bgat@billgatliff.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 5, 2010 at 1:32 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> Some platforms (e.g. OpenFirmware) want to know when a particular chip
> added or removed, so that the platforms could add their specifics for
> non-platform devices, like I2C or SPI GPIO chips.
>
> This patch implements the notifier for chip addition and removal events.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> =A0drivers/gpio/gpiolib.c =A0 =A0 | =A0 14 ++++++++++++++
> =A0include/asm-generic/gpio.h | =A0 =A08 ++++++++
> =A02 files changed, 22 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 350842a..375c03a 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -9,6 +9,7 @@
> =A0#include <linux/seq_file.h>
> =A0#include <linux/gpio.h>
> =A0#include <linux/idr.h>
> +#include <linux/notifier.h>
>
>
> =A0/* Optional implementation infrastructure for GPIO interfaces.
> @@ -1029,6 +1030,9 @@ static inline void gpiochip_unexport(struct gpio_ch=
ip *chip)
>
> =A0#endif /* CONFIG_GPIO_SYSFS */
>
> +BLOCKING_NOTIFIER_HEAD(gpio_notifier);
> +EXPORT_SYMBOL_GPL(gpio_notifier);
> +
> =A0/**
> =A0* gpiochip_add() - register a gpio_chip
> =A0* @chip: the chip to register, with chip->base initialized
> @@ -1103,6 +1107,9 @@ fail:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("gpiochip_add: gpios %d..%d (%s) no=
t registered\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip->base, chip->base + c=
hip->ngpio - 1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip->label ? : "generic")=
;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 blocking_notifier_call_chain(&gpio_notifier=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0GPIO_NOTIFY_CHIP_ADDED, chip);

Rather than doing an else block which will need to be reworked if/when
any additional code is added to the bottom of this routine, please
rework the if() block to bail on failure instead of implicitly falling
through to the return statement.

Otherwise, this patch looks okay to me, so you can go ahead and add my:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

*however* (and don't kill me for saying this because I know I
suggested the notifier approach in the first place).  Looking at the
whole patch series, the notifier call adds a lot of code for very
little gain.  If you dropped just the notifier bits (but left the rest
of the series the same), then the the of gpio bits would be
considerably simpler, and the only impact on the core gpiolib would be
the addition of an of_gpiochip_register_simple() and
of_gpiochip_unregister() hooks that will be conditionally compiled.

And to address one of my previous concerns, I've got no problem with
the automatic registration of GPIO devices for OF usage, as long as
of-aware drivers have the option of overriding the simple defaults
when needed.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
