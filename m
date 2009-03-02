Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id D52A8DDF3D
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 04:45:11 +1100 (EST)
Received: by gxk1 with SMTP id 1so8006717gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Mar 2009 09:45:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090302171610.GA19984@oksana.dev.rtsoft.ru>
References: <200902261524.51750.roman.fietze@telemotive.de>
	<fa686aa40902262106i2176f06ew7ab0f870119a8e04@mail.gmail.com>
	<20090302171610.GA19984@oksana.dev.rtsoft.ru>
Date: Mon, 2 Mar 2009 10:45:09 -0700
Message-ID: <fa686aa40903020945o5684710dq75c71705e42d46a1@mail.gmail.com>
Subject: Re: [PATCH] Add MPC52xx simple interrupt GPIO support
From: Grant Likely <grant.likely@secretlab.ca>
To: avorontsov@ru.mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Roman Fietze <roman.fietze@telemotive.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 2, 2009 at 10:16 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Thu, Feb 26, 2009 at 10:06:59PM -0700, Grant Likely wrote:
>> =A0Maybe something like:
>>
>> struct of_gpio_chip {
>> =A0 =A0 =A0 =A0 int gpio_cells;
>> =A0 =A0 =A0 =A0 int (*xlate)(struct of_gpio_chip *of_gc, struct device_n=
ode *np,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const void *gpio_spec, enum o=
f_gpio_flags *flags);
>> =A0 =A0 =A0 =A0 struct gpio_chip gc[1];
>> };
>
> I'd suggest to not touch of_gpio_chip structure, I'd like to keep
> of_gpio_chip struct 1:1 bound to a pure gpio_chip structure. This keeps
> things simple and understandable on the low level.
>
> And when you need several gpio controllers bound to some Linux struct,
> I would rather suggest this:
>
> struct mpc5200_gpio_controller {
> =A0 =A0 =A0 =A0void __iomem *regs;
> =A0 =A0 =A0 =A0void (*save_regs)(struct of_mm_gpio_chip *mm_gc);
> =A0 =A0 =A0 =A0struct of_gpio_chip of_gc[1];
> };
>
> In the of_gc->xlate callback you'll always get &of_gc[0], but since you
> know that this is mpc5200 controller, you can add needed offset depending
> on gpio_spec.

Fair enough.  That works too.

> OTOH, there is even more straightforward solution, all you actually need
> is to define "HW GPIO" bindings (which are wkup, which are interrupt, etc=
.),
> and then:
>
> void mpc5200_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
> {
> =A0 =A0 =A0 =A0if (mpc5200_is_wkup(gpio))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write to the wkup registers block;
> =A0 =A0 =A0 =A0else if (mpc5200_is_int(gpio))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write to the int registers block;
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> }
>
> That is, the same thing we do for the interrupt controllers.

Ugh, I'd really do not want to use this approach.  The GPIOs path is
too long as is.  When GPIOs are used for things like JTAG or other bus
emulation, every cycle counts.  As much as possible the long path,
such as figuring out which chip, should be preprocessed so that it is
already known by the time the set/get/direction hooks are called.

IRQ controllers typically need to deal with far lower frequencies on
the IRQ line.

>
> (Note that these "if"s can be replaced by a table, as in
> arch/powerpc/sysdev/qe_lib/qe_ic.c).

Even with the table it is a cost I don't want in the GPIO handler.  If
it were possible to do so, I'd even like to remove the spinlocks from
the hooks, but that isn't an option at the moment.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
