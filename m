Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 31EA1DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 21:07:50 +1100 (EST)
Date: Fri, 28 Nov 2008 13:07:47 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [PATCH] of/gpio: Implement of_get_gpio_flags()
Message-ID: <20081128100747.GA16515@oksana.dev.rtsoft.ru>
References: <20081127204453.GA21901@oksana.dev.rtsoft.ru>
	<Pine.LNX.4.64.0811280107380.5161@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <Pine.LNX.4.64.0811280107380.5161@t2.domain.actdsltmp>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 28, 2008 at 01:11:38AM -0800, Trent Piepho wrote:
> On Thu, 27 Nov 2008, Anton Vorontsov wrote:
> > This function is alike to the simple of_get_gpio(), but accepts new
> > argument: flags. This new function will be used by the drivers that
> > need to retrieve additional GPIO information, such as active-low flag.
> >
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> So you want to do the clean up patch later?

Yup, some day in 2.6.30, I think.

> > +	/*
> > +	 * We're discouraging gpio_cells < 2, since that way you'll have to
> > +	 * write your own xlate function (that will have to retrive the GPIO
> > +	 * number and the flags from a single gpio cell -- this is possible,
> > +	 * but not recommended).
> > +	 */
> > +	if (of_gc->gpio_cells < 2) {
> > +		WARN_ON(1);
> > +		return -EINVAL;
> > +	}
> 
> If you're not going to allow 1 cell anymore (which should perhaps be
> mentioned in the changelog),

It wasn't allowed from the start, I just had to catch the bogus users
on the mailing list.

> you could just check that when the of_gpio
> chip is registered. There's no need to see if of_gc->gpio_cells has
> changed each time a driver maps a GPIO.

There is no single OF GPIO registration function, yet. So the only
way we can check for correct gpio_cells for all "simple" gpio chips
is .xlate(). Soon there will be of_gpio_{,un}register_simple() thus
we can move that check there.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
