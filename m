Return-Path: <bgat@billgatliff.com>
Received: from mail-yw0-f198.google.com (mail-yw0-f198.google.com
	[209.85.211.198]) by ozlabs.org (Postfix) with ESMTP id B6765B6EE8
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Dec 2009 17:27:15 +1100 (EST)
Received: by ywh36 with SMTP id 36so11569212ywh.15
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Dec 2009 22:27:13 -0800 (PST)
Message-ID: <4B3AF2C4.7030607@billgatliff.com>
Date: Wed, 30 Dec 2009 00:27:16 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Does gpio_to_irq() work for MPC52xx gpios?
References: <4B312EDA.7030606@billgatliff.com>
	<87fx72wwpd.fsf@macbook.be.48ers.dk>
In-Reply-To: <87fx72wwpd.fsf@macbook.be.48ers.dk>
Content-Type: text/plain; charset=us-ascii
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Korsgaard wrote:
>>>>>> "Bill" == Bill Gatliff <bgat@billgatliff.com> writes:
>>>>>>             
>
>  Bill> Guys:
>  Bill> Is it possible to specify an individual GPIO pin as an interrupt source
>  Bill> with the current MPC52xx code?
>
> No (not yet). In Ben's latest pull request there's a patch from me to
> add basic infrastructure for gpio_to_irq(). I've recently added irq
> support to the mpc8xxx driver, but so far nothing has been written for
> 52xx.
>
> http://patchwork.ozlabs.org/patch/41550/
>   

Ok, after looking at your code for a few days I'm even more lost than
when I started!

On the MPC5200, all the GPIO_WKUP pins are multiplexed into a single
interrupt line, which is Main_Mask8. As currently defined by
mpc52xx_pic.c, that's a virtual interrupt number of 72. So generally
speaking, if I do a request_irq() on 72, I'll get an interrupt any time
an enabled GPIO_WKUP pin changes state.

What I want to be able to do is a request_irq(gpio_to_irq(GPIO_WKUP_7),
...), so that I can have a single interrupt handler for each GPIO_WKUP
pin. To do this, I think the general idea is as follows:

1. create a virtual interrupt number for each GPIO_WKUP line
2. install a chained interrupt handler on interrupt 72
3. inside the chained handler, map each active GPIO_WKUP pin to its
associated virtual interrupt number, and invoke the associated interrupt
handler by passing that virtual interrupt number to generic_handle_irq()
4. provide a gpio_to_irq that can map GPIO offsets to their associated
virtual interrupt numbers

I'm trying to implement the above, but I'm getting lost in all the IRQ
mapping and virtualization. Can someone show me what I'm doing wrong in
my code?

I've put a complete copy of my modified mpc52xx_gpio.c on pastebin, with
my portions highlighted:

http://pastebin.com/f4c074ab8

A kernel message buffer log is here, also with the interesting lines
highlighted:

http://pastebin.com/f378d3c61

I get a mapping from hwirq 72 to a virq of 16. That seems fine. But
that's the extent of the good news. :)

The two GPIO pins I'm interested in are 222 and 223, which are
GPIO_WKUP_6 and GPIO_WKUP_7. In my gpio_to_irq() I'm doing this:

static int mpc52xx_wkup_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
{
struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
struct mpc52xx_gpiochip *c = to_mpc52xx_gpiochip(mm);

pr_err("%s mapping offset %d\n", __func__, offset);

if (c->irqhost && offset < MPC52XX_WKUP_GPIO_PINS)
return irq_create_mapping(c->irqhost, c->irq);
return -ENXIO;
}

That's not giving me what I want, it's just creating another mapping to
virtual irq 16. I know that code is wrong, I just don't know what the
right code should be...

Help, I'm lost! :)



Kindest regards,

b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat@billgatliff.com
