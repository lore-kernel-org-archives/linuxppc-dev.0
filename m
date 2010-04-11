Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 85D0FB7D1F
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Apr 2010 17:27:07 +1000 (EST)
Subject: Re: A better way to sequence driver initialization?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bill Gatliff <bgat@billgatliff.com>
In-Reply-To: <4BC12673.2090602@billgatliff.com>
References: <4BBF7E9C.80604@billgatliff.com>
	<1270889597.6865.107.camel@pasglop> <4BC07EAD.9020307@billgatliff.com>
	<20100410233909.GA16099@linux-sh.org>
	<4BC12673.2090602@billgatliff.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 11 Apr 2010 17:26:57 +1000
Message-ID: <1270970817.6865.127.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mundt <lethal@linux-sh.org>,
	linux-embedded <linux-embedded@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-04-10 at 20:31 -0500, Bill Gatliff wrote:
> Right now I'm thinking mostly about GPIO devices which need to register
> before things like gpio-leds can use them.  Sometimes the GPIO expansion
> chip of interest is on i2c, other times it's spi, and still others it's
> a platform or USB device.  Linking the gpio-led driver late helps that
> specific situation.

What it boils down to is that driver A depends on a service provided by
driver B. At some stage, your dependency -has- to be expressed. Either
using the device-tree, or by hard wiring a GPIO number, maybe by having
the platform code figure out the GPIO number and shoving it into a
platform_data structure, etc... but at -some- point, driver "A" needs
some kind of "identifier" to the service provided by driver "B". In our
case, let's say it's a GPIO number.

That's when you can start kicking in a simple mechanism for exporting
services. Let's say the GPIO layer does

	register_service("gpio", gpio_service_query);

With something like

	int gpio_service_query(const char *query_string);

Which can parse whatever arguments are passed after the service name and
return success or failure (or even return a struct device *, whatever,
this is just a rough sketch).

>From there, you can have for the drivers something like:

	request_service(const char *name, struct device *myself);

Which takes a service name of the form "service:args", for example
"gpio:5" for GPIO #5.

That returns 0 if found, -EAGAIN if not found yet, -EINVAL if rejected
(the service "gpio" can decide that there cannot be a GPIO 5 on the
system, whatever) for example. In addition, it would attach "myself" (if
non-NULL) to an internal list so that later, it's probe() routine can be
called again.

We then add a way for probe() to return -EAGAIN to put the driver "on
hold" silently.

And finally, maybe a way for services to re-run their query (new GPIOs
were added for example) for all "pending" drivers.

I haven't looked at the flip side here which is service -removal- of
course. We may get away without dealing with it... tbd.

> But what about when I want to use a pin on a GPIO expansion device as
> the card-detect for an MMC slot?  Or, as I've just recently noticed in
> one hardware platform I'm working on, using a pin on a SPI GPIO expander
> as a chip-select for another SPI device, but through gpiolib? 
> Eventually, the dependencies don't become circular but changing the link
> order will break some and fix others.  Ugh.

As I said above, at some stage, -somebody- can identify the dependency,
which ends up being translated into a GPIO number, an OF device path, or
something .... That should be enough for the above to be made to fit
no ?

> Definitely, a free-for-all isn't going to work.  But I don't think that
> having every driver do its own kthread_run() is a solution, either. 
> I'll keep tinkering.  :) 

I'd rather keep threads out of the picture for now. IE. Leave the
decision as to do threaded probing or not at a different level.

Cheers,
Ben.
