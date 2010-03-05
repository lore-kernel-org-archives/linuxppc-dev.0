Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id F1FFEB7CA6
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Mar 2010 07:30:27 +1100 (EST)
Date: Fri, 5 Mar 2010 23:30:24 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] gpiolib: Introduce chip addition/removal notifier
Message-ID: <20100305203024.GA28132@oksana.dev.rtsoft.ru>
References: <20100205203201.GA32281@oksana.dev.rtsoft.ru>
	<20100205203232.GA1475@oksana.dev.rtsoft.ru>
	<fa686aa41002090916w613efcb9te15e4969a880f724@mail.gmail.com>
	<20100305115918.f6c75b12.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100305115918.f6c75b12.akpm@linux-foundation.org>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bill Gatliff <bgat@billgatliff.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 05, 2010 at 11:59:18AM -0800, Andrew Morton wrote:
[...]
> > > /**
> > > * gpiochip_add() - register a gpio_chip
> > > * @chip: the chip to register, with chip->base initialized
> > > @@ -1103,6 +1107,9 @@ fail:
> > >        pr_err("gpiochip_add: gpios %d..%d (%s) not registered\n",
> > >            chip->base, chip->base + chip->ngpio - 1,
> > >            chip->label ? : "generic");
> > > +    else
> > > +        blocking_notifier_call_chain(&gpio_notifier,
> > > +                      GPIO_NOTIFY_CHIP_ADDED, chip);
> > 
> > Rather than doing an else block which will need to be reworked if/when
> > any additional code is added to the bottom of this routine, please
> > rework the if() block to bail on failure instead of implicitly falling
> > through to the return statement.
> 
> This still hasn't happened.

It's in your tree already :-)

gpiolib-cosmetic-improvements-for-error-handling-in-gpiochip_add.patch

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
