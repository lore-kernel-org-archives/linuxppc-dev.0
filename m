Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B594ADE235
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 21:07:33 +1000 (EST)
Date: Thu, 17 Jul 2008 15:07:30 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] leds: implement OpenFirmare GPIO LED driver
Message-ID: <20080717110730.GA24775@polina.dev.rtsoft.ru>
References: <20080714164114.GA18784@polina.dev.rtsoft.ru>
	<dc452eaab83710e7d6f86dcc5d77bdda@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <dc452eaab83710e7d6f86dcc5d77bdda@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>,
	linux-kernel@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 17, 2008 at 07:59:03AM +0200, Segher Boessenkool wrote:
>> diff --git a/Documentation/powerpc/dts-bindings/gpio/led.txt  
>> b/Documentation/powerpc/dts-bindings/gpio/led.txt
>> new file mode 100644
>> index 0000000..7e9ce81
>> --- /dev/null
>> +++ b/Documentation/powerpc/dts-bindings/gpio/led.txt
>> @@ -0,0 +1,15 @@
>> +LED connected to GPIO
>> +
>> +Required properties:
>> +- compatible : should be "gpio-led".
>
> This "compatible" name is a bit too generic.  No, I don't know a
> better name :-(
>
>> +- label : (optional) the label for this LED. If omitted, the label is
>> +  taken from the node name (excluding the unit address).
>
> What is a label? 

The label that is written on the board for this particular LED, or
the label that hardware documentation refers to.

> It should be described here.  Also, its encoding
> should be described ("a string" I guess).

Yes.

>> +- gpios : should specify LED GPIO.
>> +
>> +Example:
>> +
>> +led@0 {
>> +	compatible = "gpio-led";
>> +	label = "hdd";
>> +	gpios = <&mcu_pio 0 0>;
>> +};
>
> You show a unit address but have no "reg" value.  This is
> incorrect.

Hm.. how could I enumerate them then? Or should I just give them the
full names, i.e. "led-hdd" or something?

> What would be the parent node of this, btw?

This is tricky question. Personally I place them inside the gpio
controller node that is responsible for the LED. But I think placing the
led nodes at top level would be also fine (maybe with "leds { }" node as
a parent for all board's LEDs. What would you suggest for a "best
practice"?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
