Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zV07j6mXHzDqmy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 04:32:01 +1100 (AEDT)
Received: by mail-qk0-x242.google.com with SMTP id b76so2873080qkc.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jan 2018 09:32:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180122050411.32460-4-j.neuschaefer@gmx.net>
References: <20180122050411.32460-1-j.neuschaefer@gmx.net>
 <20180122050411.32460-4-j.neuschaefer@gmx.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 28 Jan 2018 19:31:58 +0200
Message-ID: <CAHp75VcWshngZFuUp4hzYdD43HF7TZ1sRE3Dh+HckB5do1=gGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] gpio: Add GPIO driver for Nintendo Wii
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Mon, Jan 22, 2018 at 7:04 AM, Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

Style issues below.

> +#define HW_GPIO_OWNER          0x3c
> +
> +
> +struct hlwd_gpio {

No need extra empty line in between.

> +       struct gpio_chip gpioc;
> +       void __iomem *regs;
> +       struct device *dev;
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

> +       /* Save the struct device pointer so dev_info, etc. can be used. =
*/

Useless.

> +       hlwd->dev =3D &pdev->dev;
> +

> +       regs_resource =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);

> +       if (IS_ERR(regs_resource))
> +               return PTR_ERR(regs_resource);
> +

This is redundant. Below does it for ya.

> +       hlwd->regs =3D devm_ioremap_resource(&pdev->dev, regs_resource);
> +       if (IS_ERR(hlwd->regs))
> +               return PTR_ERR(hlwd->regs);


> +       res =3D bgpio_init(&hlwd->gpioc, &pdev->dev, 4,
> +                       hlwd->regs + HW_GPIOB_IN, hlwd->regs + HW_GPIOB_O=
UT,
> +                       NULL, hlwd->regs + HW_GPIOB_DIR, NULL,
> +                       BGPIOF_BIG_ENDIAN_BYTE_ORDER);

> +

Remove this extra line.

> +       if (res < 0) {
> +               dev_warn(hlwd->dev, "bgpio_init failed: %d\n", res);
> +               return res;
> +       }

> +       if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios))
> +               ngpios =3D 32;

A nit: I would rather go with
res =3D of_property_read(...);
if (res)
  ngpios =3D 32;

--=20
With Best Regards,
Andy Shevchenko
