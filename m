Return-Path: <bgat@billgatliff.com>
Received: from mail-iw0-f181.google.com (mail-iw0-f181.google.com
	[209.85.223.181]) by ozlabs.org (Postfix) with ESMTP id 866C8B6EF3
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 02:15:47 +1100 (EST)
Received: by iwn11 with SMTP id 11so12935718iwn.17
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Jan 2010 07:15:46 -0800 (PST)
Message-ID: <4B44A93E.5030805@billgatliff.com>
Date: Wed, 06 Jan 2010 09:16:14 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Ayman El-Khashab <ayman@elkhashab.com>
Subject: Re: How to set GPIO state in the dts or in platform
References: <4B440EDC.3060805@elkhashab.com> <4B4413DA.7010704@billgatliff.com>
	<4B441AD8.4050709@elkhashab.com>
In-Reply-To: <4B441AD8.4050709@elkhashab.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ayman El-Khashab wrote:
> On 1/5/2010 10:38 PM, Bill Gatliff wrote:
>> Ayman El-Khashab wrote:
>>  
>>> I've got a custom board akin to the walnut.  I've successfully got
>>> u-boot,
>>> the kernel, and a working filesystem.  The only thing I lack is a
>>> clear idea
>>> of how to set a GPIO.
>>>     
>>
>> Isn't that the "flags" parameter, e.g.:
>>
>> gpios = <phandle gpioid flags>
>>
>> ?
>>
>> If you are passing a 0 for the flags, try a 1.  I know of at least one
>> driver that interprets that to mean a polarity inversion.  Maybe you'll
>> get lucky.  :)
>>
>>   
> Possibly, I saw that in the documentation directory, but didn't quite
> follow the explanation that
> was given.  Below is what I was using as  a reference, but is it as
> simple as that?  Do the flags encode
> just the state or also, the open drain, hi-z and everything else?  In
> my case, I want the GPIO 3 actively
> driven high.

The flags can encode everything, or nothing.  It all depends on what the
caller of of_get_gpio_flags() does with them.  (Note that I'm not an
authority on this topic, I'm just telling what I've learned about it
recently).

For example, in of_mpc8xxx_spi_get_chipselects(), the flag is tested
against OF_GPIO_ACTIVE_LOW, and the result is passed to
gpio_direction_output() as the initial value.  So it both inverts the
sense of the pin, and sets its initial state.

In of_gpio_leds_probe(), the flag is tested against OF_GPIO_ACTIVE_LOW
as well.

In both of the above examples, the drivers can make assumptions about
things like the pin must be an output, will be actively driven in either
direction, and so on.  The convention is for the flag to be a bitmap of
values from the of_gpio_flags enumeration, but the only value there
is--- you guessed it--- OF_GPIO_ACTIVE_LOW.  :)

If you provide your own xlate() function in a of_gpio_chip driver, you
can make the flags mean anything you want.  As for anywhere you call
of_gpio_get_flags().  For now, the only established interpretation is
the OF_GPIO_ACTIVE_LOW one.


b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat@billgatliff.com
