Return-Path: <ben@trinity.fluff.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3EAD31A012B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jun 2014 09:58:14 +1000 (EST)
Date: Mon, 9 Jun 2014 00:18:23 +0100
From: Ben Dooks <ben@trinity.fluff.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] gpio: gpiolib: set gpiochip_remove retval to void
Message-ID: <20140608231823.GB10112@trinity.fluff.org>
References: <20140530094025.3b78301e@canb.auug.org.au>
 <1401449454-30895-1-git-send-email-berthe.ab@gmail.com>
 <1401449454-30895-2-git-send-email-berthe.ab@gmail.com>
 <CAMuHMdV6AtjD2aqO3buzj8Eo7A7xc_+ROYnxEi2sdjMaqFiAuA@mail.gmail.com>
 <5388C0F1.90503@gmail.com> <5388CB1B.3090802@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5388CB1B.3090802@metafoo.de>
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>, m@bues.ch,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, platform-driver-x86@vger.kernel.org,
 "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
 driverdevel <devel@driverdev.osuosl.org>, Alexandre Courbot <gnurou@gmail.com>,
 patches@opensource.wolfsonmicro.com, linux-samsungsoc@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 spear-devel@list.st.com,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 David Daney <ddaney.cavm@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 abdoulaye berthe <berthe.ab@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 30, 2014 at 08:16:59PM +0200, Lars-Peter Clausen wrote:
> On 05/30/2014 07:33 PM, David Daney wrote:
> >On 05/30/2014 04:39 AM, Geert Uytterhoeven wrote:
> >>On Fri, May 30, 2014 at 1:30 PM, abdoulaye berthe <berthe.ab@gmail.com>
> >>wrote:
> >>>--- a/drivers/gpio/gpiolib.c
> >>>+++ b/drivers/gpio/gpiolib.c
> >>>@@ -1263,10 +1263,9 @@ static void gpiochip_irqchip_remove(struct
> >>>gpio_chip *gpiochip);
> >>>   *
> >>>   * A gpio_chip with any GPIOs still requested may not be removed.
> >>>   */
> >>>-int gpiochip_remove(struct gpio_chip *chip)
> >>>+void gpiochip_remove(struct gpio_chip *chip)
> >>>  {
> >>>         unsigned long   flags;
> >>>-       int             status = 0;
> >>>         unsigned        id;
> >>>
> >>>         acpi_gpiochip_remove(chip);
> >>>@@ -1278,24 +1277,15 @@ int gpiochip_remove(struct gpio_chip *chip)
> >>>         of_gpiochip_remove(chip);
> >>>
> >>>         for (id = 0; id < chip->ngpio; id++) {
> >>>-               if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags)) {
> >>>-                       status = -EBUSY;
> >>>-                       break;
> >>>-               }
> >>>-       }
> >>>-       if (status == 0) {
> >>>-               for (id = 0; id < chip->ngpio; id++)
> >>>-                       chip->desc[id].chip = NULL;
> >>>-
> >>>-               list_del(&chip->list);
> >>>+               if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags))
> >>>+                       panic("gpio: removing gpiochip with gpios still
> >>>requested\n");
> >>
> >>panic?
> >
> >NACK to the patch for this reason.  The strongest thing you should do here
> >is WARN.
> >
> >That said, I am not sure why we need this whole patch set in the first place.
> 
> Well, what currently happens when you remove a device that is a
> provider of a gpio_chip which is still in use, is that the kernel
> crashes. Probably with a rather cryptic error message. So this patch
> doesn't really change the behavior, but makes it more explicit what
> is actually wrong. And even if you replace the panic() by a WARN()
> it will again just crash slightly later.
> 
> This is a design flaw in the GPIO subsystem that needs to be fixed.

Surely then the best way is to error out to the module unload and
stop the driver being unloaded?

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
