Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdJtW240rzF0mN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 02:30:58 +1100 (AEDT)
Received: by mail-qk0-x244.google.com with SMTP id c82so10422313qka.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Feb 2018 07:30:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180209120732.17863-3-j.neuschaefer@gmx.net>
References: <20180209120732.17863-1-j.neuschaefer@gmx.net>
 <20180209120732.17863-3-j.neuschaefer@gmx.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Feb 2018 17:30:55 +0200
Message-ID: <CAHp75Vf=Z7DTMvbacLN+E-hScBD3ZNpnf6Ch+5xm=JNbX2cbVg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] gpio: Add GPIO driver for Nintendo Wii
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Joel Stanley <joel@jms.id.au>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 Albert Herranz <albert_herranz@yahoo.es>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 9, 2018 at 2:07 PM, Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
> The Nintendo Wii's chipset (called "Hollywood") has a GPIO controller
> that supports a configurable number of pins (up to 32), interrupts, and
> some special mechanisms to share the controller between the system's
> security processor (an ARM926) and the PowerPC CPU. Pin multiplexing is
> not supported.
>
> This patch adds a basic driver for this GPIO controller. Interrupt
> support will come in a later patch.
>
> This patch is based on code developed by Albert Herranz and the GameCube
> Linux Team, file arch/powerpc/platforms/embedded6xx/hlwd-gpio.c,
> available at https://github.com/DeltaResero/GC-Wii-Linux-Kernels, but
> has grown quite dissimilar.
>

Fine to me, though one comment below.
In any case,

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Cc: Albert Herranz <albert_herranz@yahoo.es>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> <---
>
> v3:
> - Do some style cleanups, as suggest by Andy Shevchenko
>
> v2:
> - Change hlwd_gpio_driver.driver.name to "gpio-hlwd" to match the
>   filename (was "hlwd_gpio")
> - Remove unnecessary include of linux/of_gpio.h, as suggested by Linus
>   Walleij.
> - Add struct device pointer to context struct to make it possible to use
>   dev_info(hlwd->dev, "..."), as suggested by Linus Walleij
> - Use the GPIO_GENERIC library to reduce code size, as suggested by
>   Linus Walleij
> - Use iowrite32be instead of __raw_writel for big-endian MMIO access, as
>   suggested by Linus Walleij
> - Remove commit message paragraph suggesting to diff against the
>   original driver, because it's so different now
> ---
>  drivers/gpio/Kconfig     |   9 ++++
>  drivers/gpio/Makefile    |   1 +
>  drivers/gpio/gpio-hlwd.c | 115 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 125 insertions(+)
>  create mode 100644 drivers/gpio/gpio-hlwd.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index d6a8e851ad13..47606dfe06cc 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -229,6 +229,15 @@ config GPIO_GRGPIO
>           Select this to support Aeroflex Gaisler GRGPIO cores from the G=
RLIB
>           VHDL IP core library.
>
> +config GPIO_HLWD
> +       tristate "Nintendo Wii (Hollywood) GPIO"

> +       depends on OF_GPIO

You may get rid of it if...

> +       select GPIO_GENERIC
> +       help
> +         Select this to support the GPIO controller of the Nintendo Wii.
> +
> +         If unsure, say N.
> +
>  config GPIO_ICH
>         tristate "Intel ICH GPIO"
>         depends on PCI && X86
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 4bc24febb889..492f62d0eb59 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -54,6 +54,7 @@ obj-$(CONFIG_GPIO_FTGPIO010)  +=3D gpio-ftgpio010.o
>  obj-$(CONFIG_GPIO_GE_FPGA)     +=3D gpio-ge.o
>  obj-$(CONFIG_GPIO_GPIO_MM)     +=3D gpio-gpio-mm.o
>  obj-$(CONFIG_GPIO_GRGPIO)      +=3D gpio-grgpio.o
> +obj-$(CONFIG_GPIO_HLWD)                +=3D gpio-hlwd.o
>  obj-$(CONFIG_HTC_EGPIO)                +=3D gpio-htc-egpio.o
>  obj-$(CONFIG_GPIO_ICH)         +=3D gpio-ich.o
>  obj-$(CONFIG_GPIO_INGENIC)     +=3D gpio-ingenic.o
> diff --git a/drivers/gpio/gpio-hlwd.c b/drivers/gpio/gpio-hlwd.c
> new file mode 100644
> index 000000000000..a63136a68ba3
> --- /dev/null
> +++ b/drivers/gpio/gpio-hlwd.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (C) 2008-2009 The GameCube Linux Team
> +// Copyright (C) 2008,2009 Albert Herranz
> +// Copyright (C) 2017-2018 Jonathan Neusch=C3=A4fer
> +//
> +// Nintendo Wii (Hollywood) GPIO driver
> +
> +#include <linux/gpio/driver.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

> +#include <linux/of.h>
> +#include <linux/of_platform.h>

...(and using platform device header I suppose)...

> +#include <linux/slab.h>
> +
> +/*
> + * Register names and offsets courtesy of WiiBrew:
> + * https://wiibrew.org/wiki/Hardware/Hollywood_GPIOs
> + *
> + * Note that for most registers, there are two versions:
> + * - HW_GPIOB_* Is always accessible by the Broadway PowerPC core, but d=
oes
> + *   always give access to all GPIO lines
> + * - HW_GPIO_* Is only accessible by the Broadway PowerPC code if the me=
mory
> + *   firewall (AHBPROT) in the Hollywood chipset has been configured to =
allow
> + *   such access.
> + *
> + * The ownership of each GPIO line can be configured in the HW_GPIO_OWNE=
R
> + * register: A one bit configures the line for access via the HW_GPIOB_*
> + * registers, a zero bit indicates access via HW_GPIO_*. This driver use=
s
> + * HW_GPIOB_*.
> + */
> +#define HW_GPIOB_OUT           0x00
> +#define HW_GPIOB_DIR           0x04
> +#define HW_GPIOB_IN            0x08
> +#define HW_GPIOB_INTLVL                0x0c
> +#define HW_GPIOB_INTFLAG       0x10
> +#define HW_GPIOB_INTMASK       0x14
> +#define HW_GPIOB_INMIR         0x18
> +#define HW_GPIO_ENABLE         0x1c
> +#define HW_GPIO_OUT            0x20
> +#define HW_GPIO_DIR            0x24
> +#define HW_GPIO_IN             0x28
> +#define HW_GPIO_INTLVL         0x2c
> +#define HW_GPIO_INTFLAG                0x30
> +#define HW_GPIO_INTMASK                0x34
> +#define HW_GPIO_INMIR          0x38
> +#define HW_GPIO_OWNER          0x3c
> +
> +struct hlwd_gpio {
> +       struct gpio_chip gpioc;
> +       void __iomem *regs;
> +};
> +
> +static int hlwd_gpio_probe(struct platform_device *pdev)
> +{
> +       struct hlwd_gpio *hlwd;
> +       struct resource *regs_resource;
> +       u32 ngpios;
> +       int res;
> +
> +       hlwd =3D devm_kzalloc(&pdev->dev, sizeof(*hlwd), GFP_KERNEL);
> +       if (!hlwd)
> +               return -ENOMEM;
> +
> +       regs_resource =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       hlwd->regs =3D devm_ioremap_resource(&pdev->dev, regs_resource);
> +       if (IS_ERR(hlwd->regs))
> +               return PTR_ERR(hlwd->regs);
> +
> +       /*
> +        * Claim all GPIOs using the OWNER register. This will not work o=
n
> +        * systems where the AHBPROT memory firewall hasn't been configur=
ed to
> +        * permit PPC access to HW_GPIO_*.
> +        *
> +        * Note that this has to happen before bgpio_init reads the
> +        * HW_GPIOB_OUT and HW_GPIOB_DIR, because otherwise it reads the =
wrong
> +        * values.
> +        */
> +       iowrite32be(0xffffffff, hlwd->regs + HW_GPIO_OWNER);
> +
> +       res =3D bgpio_init(&hlwd->gpioc, &pdev->dev, 4,
> +                       hlwd->regs + HW_GPIOB_IN, hlwd->regs + HW_GPIOB_O=
UT,
> +                       NULL, hlwd->regs + HW_GPIOB_DIR, NULL,
> +                       BGPIOF_BIG_ENDIAN_BYTE_ORDER);
> +       if (res < 0) {
> +               dev_warn(&pdev->dev, "bgpio_init failed: %d\n", res);
> +               return res;
> +       }
> +

> +       res =3D of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios=
);

...if you switch to unified device property API.

> +       if (res)
> +               ngpios =3D 32;
> +       hlwd->gpioc.ngpio =3D ngpios;
> +
> +       return devm_gpiochip_add_data(&pdev->dev, &hlwd->gpioc, hlwd);
> +}
> +
> +static const struct of_device_id hlwd_gpio_match[] =3D {
> +       { .compatible =3D "nintendo,hollywood-gpio", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, hlwd_gpio_match);
> +
> +static struct platform_driver hlwd_gpio_driver =3D {
> +       .driver =3D {
> +               .name           =3D "gpio-hlwd",
> +               .of_match_table =3D hlwd_gpio_match,
> +       },
> +       .probe  =3D hlwd_gpio_probe,
> +};
> +module_platform_driver(hlwd_gpio_driver);
> +
> +MODULE_AUTHOR("Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>");
> +MODULE_DESCRIPTION("Nintendo Wii GPIO driver");
> +MODULE_LICENSE("GPL");
> --
> 2.15.1
>



--=20
With Best Regards,
Andy Shevchenko
