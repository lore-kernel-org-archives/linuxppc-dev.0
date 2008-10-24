Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 07A55DDDFA
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 10:05:51 +1100 (EST)
Date: Fri, 24 Oct 2008 16:04:57 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: linux-kernel@vger.kernel.org
Subject: OpenFirmware GPIO LED driver
Message-ID: <Pine.LNX.4.64.0810241442240.3790@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series of patches adds support for OpenFirmware bindings for GPIO based
LEDs.

I last posted a version of this in July but discussion of the OF binding
details didn't seem to be going anywhere.

I've since been contacted by some people who are actually using the previous
patches and have been motivated to try again.

All the users of this code are satisfied with the current version and it does
everything they need it to do.

The first patch extends the of_get_gpio() function to provide the gpio flags.

The way this already works (i.e., this is not something I'm adding, it's
what's already there) is that the OF gpio specifier is an opaque sequence of
words.  The GPIO controller driver (of which only one currently exists)
provides an ->xlate() method that turns this into a Linux gpiolib gpio number. 
All current gpio controllers have flags in their gpio specifier, but there is
no way to get them.  So I extend the xlate method to also produce the flags in
a Linux format, the same way it produces a Linux gpio number.

The second patch adds OF bindings to the gpio-leds driver.  The existing code
is refactored so that almost all of the common code is shared between the two
binding methods.  Either or both bindings can be selected via Kconfig.  The
bindings do have one "linux," property, but no one has been able to come up
with something close to workable that avoids this and still satisfies the
*requirement* that the default trigger be settable from the OF bindings.

The second and third patches add some additional capabilities for gpio leds
that some users need.

One is to have a LED start in the on state when it's made known to Linux. 
There is already a "default-on" trigger that does this, but it produces a
glitch where an LED that is already on will turn off then back on.  My (tiny)
patch avoids this problem.

The next lets an LED stay, without glitches, in whatever state it was already
in when it's made known to Linux.  It may have been put into this state by the
BIOS, firmware, bootloader, or the hardware itself.
