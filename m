Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id E8AA9DDF26
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 04:16:12 +1100 (EST)
Date: Mon, 2 Mar 2009 20:16:10 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Add MPC52xx simple interrupt GPIO support
Message-ID: <20090302171610.GA19984@oksana.dev.rtsoft.ru>
References: <200902261524.51750.roman.fietze@telemotive.de>
	<fa686aa40902262106i2176f06ew7ab0f870119a8e04@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <fa686aa40902262106i2176f06ew7ab0f870119a8e04@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Roman Fietze <roman.fietze@telemotive.de>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 26, 2009 at 10:06:59PM -0700, Grant Likely wrote:
> Hi Roman,
> 
> Thanks for this work.  Comments below.
> 
> On Thu, Feb 26, 2009 at 7:24 AM, Roman Fietze
> <roman.fietze@telemotive.de> wrote:
> > Hello,
> >
> > I've got a target derived from the Lite5200 that needs to use simple
> > interrupt GPIO pins. I created a patch to support this kind of GPIO.
> >
> > I would need your opinion and like to hear any criticism. Esp. the
> > facts that I ad to split up struct mpc52xx_gpio and that the GPIO
> > numbering might get mixed up concern me.
> 
> While I understand why this patch is written the way it is, I don't
> think it is the right approach.
> 
> This patch changes the mpc5200 gpio binding to adapt to a Linux
> internal implementation detail.  Specifically, the of_mm
> infrastructure only allows a 1:1 relationship between a 'struct
> of_gpio_chip' and a 'struct gpio_chip'.  When working with device
> trees, this is the wrong way around.  The device tree describes the
> hardware, not the Linux implementation details.
> 
> An argument could be made that the current binding isn't ideal and
> that it would be better to split the simple, interrupt and output-only
> gpio pins into separate nodes, but that pretty much comes down to a
> matter of opinion as the existing binding describes the hardware just
> fine.  I'm actually of the opinion that it would be better to fewer
> gpio nodes, not more, by merging the simple and wakeup pins into a
> single node, but what's done is done and there is no technical reason
> for changing the current binding.
> 
> So, that leaves the problem working with the of_mm infrastructure.  I
> think the correct solution is to modify of_gpio_chip to hold an array
> of struct gpio_chip and to change of_gpio_simple_xlate() to handle it.
>  Maybe something like:
> 
> struct of_gpio_chip {
>         int gpio_cells;
>         int (*xlate)(struct of_gpio_chip *of_gc, struct device_node *np,
>                      const void *gpio_spec, enum of_gpio_flags *flags);
>         struct gpio_chip gc[1];
> };

I'd suggest to not touch of_gpio_chip structure, I'd like to keep
of_gpio_chip struct 1:1 bound to a pure gpio_chip structure. This keeps
things simple and understandable on the low level.

And when you need several gpio controllers bound to some Linux struct,
I would rather suggest this:

struct mpc5200_gpio_controller {
	void __iomem *regs;
	void (*save_regs)(struct of_mm_gpio_chip *mm_gc);
	struct of_gpio_chip of_gc[1];
};

In the of_gc->xlate callback you'll always get &of_gc[0], but since you
know that this is mpc5200 controller, you can add needed offset depending
on gpio_spec.

(s/mpc5200/of_multi_mm/ or something like this, if you'll manage to
do this for the general case.)


OTOH, there is even more straightforward solution, all you actually need
is to define "HW GPIO" bindings (which are wkup, which are interrupt, etc.),
and then:

void mpc5200_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
{
	if (mpc5200_is_wkup(gpio))
		write to the wkup registers block;
	else if (mpc5200_is_int(gpio))
		write to the int registers block;
	else
		...
}

That is, the same thing we do for the interrupt controllers.

(Note that these "if"s can be replaced by a table, as in
arch/powerpc/sysdev/qe_lib/qe_ic.c).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
