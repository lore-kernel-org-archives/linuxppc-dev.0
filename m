Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97A9EDDDCA
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 09:43:39 +1000 (EST)
Date: Wed, 23 Jul 2008 16:42:24 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: PIXIS gpio controller and gpio flags
In-Reply-To: <20080723145650.GA13792@polina.dev.rtsoft.ru>
Message-ID: <Pine.LNX.4.64.0807231551230.26456@t2.domain.actdsltmp>
References: <20080717150422.GC31932@secretlab.ca>
	<20080717152006.GA26120@polina.dev.rtsoft.ru>
	<fa686aa40807171105m22dda41dqb334dd5f7b2634d8@mail.gmail.com>
	<Pine.LNX.4.64.0807171302190.27902@t2.domain.actdsltmp>
	<20080717234201.GA15745@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0807171807420.29856@t2.domain.actdsltmp>
	<20080718100549.GA28741@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0807191352040.27586@t2.domain.actdsltmp>
	<20080721175357.GA1773@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0807211340460.26456@t2.domain.actdsltmp>
	<20080723145650.GA13792@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 23 Jul 2008, Anton Vorontsov wrote:
> On Mon, Jul 21, 2008 at 02:12:20PM -0700, Trent Piepho wrote:
>> On Mon, 21 Jul 2008, Anton Vorontsov wrote:
>>> On Sat, Jul 19, 2008 at 02:08:01PM -0700, Trent Piepho wrote:
>>>> It doesn't look like you have any way to unset the active low flag.  What if
>>>> I unload the leds-gpio driver (or another gpio user) and then try to use the
>>>> gpio with something else?  The active low flag is stuck on!
>>>
>>> Why would you want to unset the flags? It is specified in the device
>>> tree, and can't be changed. Specifying different flags for the same GPIO
>>> would be an error (plus, Linux forbids shared gpios, so you simply can't
>>> specify one gpio for several devices).
>>
>> You can't use the same gpio for two different things at the same time, but you
>> can load a driver, unload it, and then load another.
>
> Hm.. yeah, this might happen. Now I tend to think that transparent
> active-low handling wasn't that good idea after all. So, something like
> of_gpio_is_active_low(device_node, gpioidx) should be implemented
> instead. This function will parse the gpio's = <> flags. Please speak up
> if you have any better ideas though.

The flags could be provided via of_get_gpio.  E.g., something like
of_get_gpio(...., u32 *flags), and if flags is non-NULL the gpio flags are
left there.  of_get_gpio already has the flags and some other of_get_*
functions return multiple things like this.

Or just have an active low property for the led:
 	led.active_low = !!of_get_property(np, "active-low", NULL);

Pretty simple, just one line of code.  At least if one looks just at
leds-gpio, that's obviously the simplest way.  Is active low a property of
the led or a property of the gpio?  I guess one could argue either way.

It seems like putting one line of code leds-gpio driver is better than
putting much more complex code into the gpio controller driver.  And each
gpio controller has to have that code too.

Now you could say that each gpio user needing to support inverting gpios is
a lot of code too, but I don't think it's necessary.  Active low LEDs are
common since gpios can usually sink more current than they can source.  But
other gpio users, like the I2C, SPI, MDIO drivers etc., haven't had a need
to support inverting each signal.

I'm also loathe to add software gpio inverting to my mpc8572 gpio driver. 
In addition to some LEDs there is also a bit-banged JTAG bus on the CPU
GPIOs.  I had to go to great lengths to get it fast enough and each
instruction added to a gpio operation is going to cost me MHz.
