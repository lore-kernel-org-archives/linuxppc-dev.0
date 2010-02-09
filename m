Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 79763B7D75
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 06:06:40 +1100 (EST)
Date: Tue, 9 Feb 2010 22:06:38 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] of/gpio: Implement GPIOLIB notifier hooks
Message-ID: <20100209190638.GA16013@oksana.dev.rtsoft.ru>
References: <20100205203201.GA32281@oksana.dev.rtsoft.ru>
	<20100205203236.GC1475@oksana.dev.rtsoft.ru>
	<fa686aa41002090908tbeed469k417af2a59757f8a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <fa686aa41002090908tbeed469k417af2a59757f8a@mail.gmail.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bill Gatliff <bgat@billgatliff.com>,
	Andrew Morton <akpm@linux-foundation.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 09, 2010 at 10:08:00AM -0700, Grant Likely wrote:
> On Fri, Feb 5, 2010 at 1:32 PM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
> > This patch implements GPIOLIB notifier hooks, and thus makes device-enabled
> > GPIO chips (i.e. the ones that have gpio_chip->dev specified) automatically
> > attached to the OpenFirmware subsystem. Which means that now we can handle
> > I2C and SPI GPIO chips almost* transparently.
[...]
> One concern.
> 
> How does an OF-aware GPIO driver override these settings?  What is to
> be done when a GPIO chip requires a different xlate hook?  Or a
> different number of gpio_cells?

A lot of options...

1. They can hook up onto a notifier chain, ensure that their callback
   will be called after OF GPIO subsystem (using notifiers' priority
   mechanism), and fixup needed stuff.

2. They can write their own full fledged OF bindings, i.e. they will
   need to allocate of_gc struct and save it into np->data.
   of_gpiochip_register_simple() won't touch np->data if it's already
   used.

   If/when needed, we can write some helper function, i.e.
   of_gpiochip_register(gpiochip, node, xlate_callback).

3. Or of/gpio.c code will handle this by itself, iff the xlate and
   gpio-cells scheme seems generic enough.

4. May be more...

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
