Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id BE305B7D6A
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 06:16:22 +1100 (EST)
Date: Tue, 9 Feb 2010 22:16:20 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] of/gpio: Implement GPIOLIB notifier hooks
Message-ID: <20100209191620.GA24539@oksana.dev.rtsoft.ru>
References: <20100205203201.GA32281@oksana.dev.rtsoft.ru>
	<20100205203236.GC1475@oksana.dev.rtsoft.ru>
	<fa686aa41002090913t4c72a3b8o5fda68723bc8d089@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <fa686aa41002090913t4c72a3b8o5fda68723bc8d089@mail.gmail.com>
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

On Tue, Feb 09, 2010 at 10:13:11AM -0700, Grant Likely wrote:
[...]
> > +static int __init of_gpio_notifier_init(void)
> > +{
> > +       return blocking_notifier_chain_register(&gpio_notifier, &of_gpio_nb);
> > +}
> > +arch_initcall(of_gpio_notifier_init);
> 
> Another concern;  if any gpio chips get registered before this
> arch_initcall (not sure if it is possible or not), then those chips
> won't get registered with the of gpio infrastructure.

Technically, it is possible, but registering usual GPIO controllers
in arch_initcall feels not quite right approach in the first place
(and, btw, it won't work most of the time, because even early drivers
do not register itself earlier than subsys_initcall).

And arch gpio controllers (like QE GPIO) are usually device-less,
and they use of_mm_gpiochip_add(), so we fully control them.

Plus I don't see any reason why we couldn't move
of_gpio_notifier_init() into, say, postcore_initcall, if we ever
need it.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
