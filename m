Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id EEFAEDDF70
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 03:34:29 +1100 (EST)
Date: Tue, 16 Dec 2008 19:34:28 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [RFC] Dummy GPIO driver for use with SPI
Message-ID: <20081216163428.GA22756@oksana.dev.rtsoft.ru>
References: <4942738A.80609@harris.com>
	<20081212150144.GA28147@oksana.dev.rtsoft.ru>
	<49429861.9060305@harris.com>
	<20081212171438.GA9738@oksana.dev.rtsoft.ru>
	<Pine.LNX.4.64.0812121322110.28806@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <Pine.LNX.4.64.0812121322110.28806@t2.domain.actdsltmp>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 12, 2008 at 01:39:45PM -0800, Trent Piepho wrote:
> On Fri, 12 Dec 2008, Anton Vorontsov wrote:
> > On Fri, Dec 12, 2008 at 11:59:13AM -0500, Steven A. Falco wrote:
> >> What do you think about having a mechanism to specify that some
> >> SPI slaves have a chip select, while others don't have to have a
> >> chip select managed by the SPI subsystem?
> >
> > Um.. do you know that you can pass '0' as a GPIO?
> >
> > For example,
> >
> > spi-controller {
> > 	gpios = <&pio1 1 0	/* cs0 */
> > 		 0		/* cs1, no GPIO */
> > 		 &pio2 2 0>;	/* cs2 */
> 
> It's ok the that middle specifier is only one word instead of three?  Seems
> like "0 0 0" would be better, so all the specifiers are the same size.
> 
> > 		normal case;
> > 	} else if (gpio == -EEXIST) {
> 
> Isn't EEXIST (pathname already exists) backward?

In my thinking it's "the GPIO is specified (exists in the list), but
it's would be an error if you try to use it". So EEXIST.

> Seems like ENOENT would
> be the right error code.  Except that's used for reading past the end...
> Maybe a reading past the end should be EINVAL or EBADF?
> 
> Or return ENODEV for the 'hole' cell?  Or ENOLINK?

I'd say it's a matter of taste, none of the errors are actually
appropriate. An appropriate errno value would be EHOLEINALIST,
but we don't have it.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
