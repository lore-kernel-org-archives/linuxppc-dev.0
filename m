Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F03EBDE0BE
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Dec 2008 08:39:53 +1100 (EST)
Date: Fri, 12 Dec 2008 13:39:45 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [RFC] Dummy GPIO driver for use with SPI
In-Reply-To: <20081212171438.GA9738@oksana.dev.rtsoft.ru>
Message-ID: <Pine.LNX.4.64.0812121322110.28806@t2.domain.actdsltmp>
References: <4942738A.80609@harris.com>
	<20081212150144.GA28147@oksana.dev.rtsoft.ru>
	<49429861.9060305@harris.com>
	<20081212171438.GA9738@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 12 Dec 2008, Anton Vorontsov wrote:
> On Fri, Dec 12, 2008 at 11:59:13AM -0500, Steven A. Falco wrote:
>> What do you think about having a mechanism to specify that some
>> SPI slaves have a chip select, while others don't have to have a
>> chip select managed by the SPI subsystem?
>
> Um.. do you know that you can pass '0' as a GPIO?
>
> For example,
>
> spi-controller {
> 	gpios = <&pio1 1 0	/* cs0 */
> 		 0		/* cs1, no GPIO */
> 		 &pio2 2 0>;	/* cs2 */

It's ok the that middle specifier is only one word instead of three?  Seems
like "0 0 0" would be better, so all the specifiers are the same size.

> 		normal case;
> 	} else if (gpio == -EEXIST) {

Isn't EEXIST (pathname already exists) backward?  Seems like ENOENT would
be the right error code.  Except that's used for reading past the end...

Maybe a reading past the end should be EINVAL or EBADF?

Or return ENODEV for the 'hole' cell?  Or ENOLINK?

EEXIST is for trying to create something that already exists.  The 'hole'
is more like trying to follow a broken link or find something that doesn't
exist.
