Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 57951DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 04:06:39 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so2251820qwb.15
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 10:06:37 -0700 (PDT)
Message-ID: <4907469B.6030506@genesi-usa.com>
Date: Tue, 28 Oct 2008 12:06:35 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <7b6eafc46f644dea59fbf0af17dbc005@localhost>
	<fa686aa40810280715m3275a302jd43ab517d2d455fc@mail.gmail.com>
In-Reply-To: <fa686aa40810280715m3275a302jd43ab517d2d455fc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Konstantinos Margaritis <markos@codex.gr>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Grant Likely wrote:
> 
> For Matt's purposes, I think he wants to describe which GPIO pins are
> available to be used, but are not yet connected to anything.  In such
> a case I think it does make sense to add a node for available GPIO
> pins and give it a gpios property with a list of the pins wired to the
> header.

Yes, the two problems I saw were there is only an implicit definition
of which gpios are available for use (GPIOLIB will happily give
you an unavailable pin if you ask for it, because there is no
definition except for "gpios" property as hooked up to a device).

I liked Mitch's idea about the available property and re-using already
existing standards and parsing to get it done.

(this allows some syntax/lint checking of a device tree too since if
you put a pin in a gpios property which you marked as unavailable,
you can flag it :)

The other problem was defining pins which most definitely ARE
connected to something (as GPIO) but could well be in an ill-defined
order or for no defined purpose with regards to the peripheral. A
lot of GPIO drivers right now (bitbang SPI, I2C) will just allocate
one pin as one thing and the other as another - if you say pin 15
and 16 for bitbang-i2c, then it may assumes pin 15 is clock and 16
is data. For SPI, you get another pin, which order is it (the
middle one may be correct but the outer ones could be swapped).

Is this even defined? Shouldn't it be? And therein lies the
question :)

Exposing it to userspace is a good idea. While grouping them up
would break the existing sysfs ABI there's no reason you can't
have all of the GPIOs dumped into sysfs as it is now, and then
new directories named after the gpio-group, which symlink back
to the sysfs pins in the parent directory? That would really
rock as it's bringing the abstraction and description of the
device tree back into userspace, where let's be honest, they do
not give a crap about device tree bindings, only what pin does
what action :D

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
