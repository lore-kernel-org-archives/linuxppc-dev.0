Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 46CECDDDA1
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 16:07:02 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so622419ywb.39
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 21:06:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <200902261524.51750.roman.fietze@telemotive.de>
References: <200902261524.51750.roman.fietze@telemotive.de>
Date: Thu, 26 Feb 2009 22:06:59 -0700
Message-ID: <fa686aa40902262106i2176f06ew7ab0f870119a8e04@mail.gmail.com>
Subject: Re: [PATCH] Add MPC52xx simple interrupt GPIO support
From: Grant Likely <grant.likely@secretlab.ca>
To: Roman Fietze <roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Roman,

Thanks for this work.  Comments below.

On Thu, Feb 26, 2009 at 7:24 AM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
> Hello,
>
> I've got a target derived from the Lite5200 that needs to use simple
> interrupt GPIO pins. I created a patch to support this kind of GPIO.
>
> I would need your opinion and like to hear any criticism. Esp. the
> facts that I ad to split up struct mpc52xx_gpio and that the GPIO
> numbering might get mixed up concern me.

While I understand why this patch is written the way it is, I don't
think it is the right approach.

This patch changes the mpc5200 gpio binding to adapt to a Linux
internal implementation detail.  Specifically, the of_mm
infrastructure only allows a 1:1 relationship between a 'struct
of_gpio_chip' and a 'struct gpio_chip'.  When working with device
trees, this is the wrong way around.  The device tree describes the
hardware, not the Linux implementation details.

An argument could be made that the current binding isn't ideal and
that it would be better to split the simple, interrupt and output-only
gpio pins into separate nodes, but that pretty much comes down to a
matter of opinion as the existing binding describes the hardware just
fine.  I'm actually of the opinion that it would be better to fewer
gpio nodes, not more, by merging the simple and wakeup pins into a
single node, but what's done is done and there is no technical reason
for changing the current binding.

So, that leaves the problem working with the of_mm infrastructure.  I
think the correct solution is to modify of_gpio_chip to hold an array
of struct gpio_chip and to change of_gpio_simple_xlate() to handle it.
 Maybe something like:

struct of_gpio_chip {
        int gpio_cells;
        int (*xlate)(struct of_gpio_chip *of_gc, struct device_node *np,
                     const void *gpio_spec, enum of_gpio_flags *flags);
        struct gpio_chip gc[1];
};

and add an allocator function that takes care of allocating the
required size of the gc array.  There are details to work out of
course, but I thing this would be the more robust solution.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
