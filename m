Return-Path: <linus.walleij@linaro.org>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLQJ201N8zF0Z7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 20:42:56 +1100 (AEDT)
Received: by mail-io0-x242.google.com with SMTP id k18so16141797ioc.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 01:42:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180115031401.19577-4-j.neuschaefer@gmx.net>
References: <20180115031401.19577-1-j.neuschaefer@gmx.net>
 <20180115031401.19577-4-j.neuschaefer@gmx.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 16 Jan 2018 10:42:54 +0100
Message-ID: <CACRpkdb11jn4HFdoKLuNVmXeTBntpTAjkVctvH1=R-p6989eTg@mail.gmail.com>
Subject: Re: [PATCH 3/6] gpio: Add GPIO driver for Nintendo Wii
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 linux-gpio@vger.kernel.org,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Albert Herranz <albert_herranz@yahoo.es>,
 Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 15, 2018 at 4:13 AM, Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> This patch is based on code developed by Albert Herranz and the GameCube
> Linux Team, file arch/powerpc/platforms/embedded6xx/hlwd-gpio.c,
> available at https://github.com/DeltaResero/GC-Wii-Linux-Kernels, but
> has grown quite dissimilar.

I'm impressed by this effort. As with all reverse engineering.

> This driver currently uses __raw_readl and __raw_writel to access the
> GPIO controller's MMIO registers. I wonder if readl/writel plus explicit
> byte-swapping would be more correct, because it could be independent of
> the CPU's endianness. That said, this hardware only exists in two
> big-endian machines (Wii and Wii U).

I don't know about PPC but I think you're supposed to use
ioread32be() and iowrite32be() to do explicit BE access.

But when I look at it, I think you can just use the gpio-mmio library
for this driver and cut down code cosiderably.

> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Can't you just save a pointer to struct device *dev in the
state container and use dev_info(state->dev, ...) etc instead
of this?

> +#include <linux/of_gpio.h>

This include should not be needed.

> +/*
> + * Update the bit with the given bit offset in the given register to a g=
iven
> + * value
> + */
> +static void hlwd_gpio_update_bit(struct gpio_chip *gc, unsigned int reg,
> +               int offset, int value)
> +{
> +       struct hlwd_gpio *hlwd =3D gpiochip_get_data(gc);
> +       unsigned long flags;
> +       u32 bit =3D 1UL << offset;

#include <linux/bitops.h>

u32 bit =3D BIT(offset);

> +       u32 tmp;
> +
> +       spin_lock_irqsave(&hlwd->lock, flags);
> +       tmp =3D __raw_readl(hlwd->regs + reg);
> +       if (value)
> +               __raw_writel(tmp | bit, hlwd->regs + reg);
> +       else
> +               __raw_writel(tmp & ~bit, hlwd->regs + reg);
> +       spin_unlock_irqrestore(&hlwd->lock, flags);
> +}

This looks very much like it is reimplementing the stuff we already
have in drivers/gpio/gpio-mmio.h.

There is even a big endian access flag for the library.
And you get so much for free with gpio-mmio.

select GPIO_GENERIC
in Kconfig

the helpers come in from <linux/gpio/driver.h>

Look at other drivers for inspiration:
git grep bgpio_init

If you need IRQ support you should probably have your own file
for this driver, but it will be just a few lines of wrapper using
bgpio_init() and BGPIOF_BIG_ENDIAN and/or possibly
BGPIOF_BIG_ENDIAN_BYTE_ORDER.

See the other drivers.

Yours,
Linus Walleij
