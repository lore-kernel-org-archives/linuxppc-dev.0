Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ie0-x22c.google.com (mail-ie0-x22c.google.com
 [IPv6:2607:f8b0:4001:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B5EF91A06CB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 21:39:18 +1000 (EST)
Received: by mail-ie0-f172.google.com with SMTP id tp5so1589679ieb.31
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 04:39:15 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1401449454-30895-2-git-send-email-berthe.ab@gmail.com>
References: <20140530094025.3b78301e@canb.auug.org.au>
 <1401449454-30895-1-git-send-email-berthe.ab@gmail.com>
 <1401449454-30895-2-git-send-email-berthe.ab@gmail.com>
Date: Fri, 30 May 2014 13:39:15 +0200
Message-ID: <CAMuHMdV6AtjD2aqO3buzj8Eo7A7xc_+ROYnxEi2sdjMaqFiAuA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: gpiolib: set gpiochip_remove retval to void
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: abdoulaye berthe <berthe.ab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: driverdevel <devel@driverdev.osuosl.org>,
 Alexandre Courbot <gnurou@gmail.com>, patches@opensource.wolfsonmicro.com,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 spear-devel@list.st.com, linux-samsungsoc@vger.kernel.org,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, m@bues.ch,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 30, 2014 at 1:30 PM, abdoulaye berthe <berthe.ab@gmail.com> wrote:
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1263,10 +1263,9 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gpiochip);
>   *
>   * A gpio_chip with any GPIOs still requested may not be removed.
>   */
> -int gpiochip_remove(struct gpio_chip *chip)
> +void gpiochip_remove(struct gpio_chip *chip)
>  {
>         unsigned long   flags;
> -       int             status = 0;
>         unsigned        id;
>
>         acpi_gpiochip_remove(chip);
> @@ -1278,24 +1277,15 @@ int gpiochip_remove(struct gpio_chip *chip)
>         of_gpiochip_remove(chip);
>
>         for (id = 0; id < chip->ngpio; id++) {
> -               if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags)) {
> -                       status = -EBUSY;
> -                       break;
> -               }
> -       }
> -       if (status == 0) {
> -               for (id = 0; id < chip->ngpio; id++)
> -                       chip->desc[id].chip = NULL;
> -
> -               list_del(&chip->list);
> +               if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags))
> +                       panic("gpio: removing gpiochip with gpios still requested\n");

panic?

Is this likely to happen?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
