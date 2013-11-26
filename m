Return-Path: <Gang.Liu@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 427FB2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Nov 2013 20:20:52 +1100 (EST)
Message-ID: <1385457644.10928.7.camel@linux>
Subject: Re: [PATCH v2] powerpc/gpio: Fix the wrong GPIO input data on
 MPC8572/MPC8536
From: Liu Gang <Gang.Liu@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Tue, 26 Nov 2013 17:20:44 +0800
In-Reply-To: <D582D1B3-B20B-4860-B1DE-DDCD04B5D0BA@kernel.crashing.org>
References: <1385107960-373-1-git-send-email-Gang.Liu@freescale.com>
 <D582D1B3-B20B-4860-B1DE-DDCD04B5D0BA@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: b07421@freescale.com, linus.walleij@linaro.org, r61911@freescale.com,
 linux-gpio@vger.kernel.org, agust@denx.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-11-22 at 14:51 -0600, Kumar Gala wrote:
> > drivers/gpio/gpio-mpc8xxx.c | 8 ++++++--
> > 1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
> > index 914e859..d7d6d72 100644
> > --- a/drivers/gpio/gpio-mpc8xxx.c
> > +++ b/drivers/gpio/gpio-mpc8xxx.c
> > @@ -70,10 +70,14 @@ static int mpc8572_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> > 	u32 val;
> > 	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
> > 	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
> > +	u32 out_mask, out_shadow;
> > 
> > -	val = in_be32(mm->regs + GPIO_DAT) & ~in_be32(mm->regs + GPIO_DIR);
> > +	out_mask = in_be32(mm->regs + GPIO_DIR);
> > 
> > -	return (val | mpc8xxx_gc->data) & mpc8xxx_gpio2mask(gpio);
> > +	val = in_be32(mm->regs + GPIO_DAT) & ~out_mask;
> > +	out_shadow = mpc8xxx_gc->data & out_mask;
> > +
> > +	return (val | out_shadow) & mpc8xxx_gpio2mask(gpio);
> > }
> 
> I really think a comment is worth adding here about why we do this.
> 
> - k

Hi, Kumar,
Thanks for your comment. In fact, there already had some comments above
the function:

/* Workaround GPIO 1 errata on MPC8572/MPC8536. The status of GPIOs
 * defined as output cannot be determined by reading GPDAT register,
 * so we use shadow data register instead. The status of input pins
 * is determined by reading GPDAT register.
 */

Best Regards,
Liu Gang
