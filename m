Return-Path: <tpiepho@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 47F5DDDF26
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 06:02:49 +1000 (EST)
Date: Thu, 17 Jul 2008 13:01:21 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v3] leds: implement OpenFirmare GPIO LED driver
In-Reply-To: <20080717135542.GA15503@polina.dev.rtsoft.ru>
Message-ID: <Pine.LNX.4.64.0807171216420.27902@t2.domain.actdsltmp>
References: <1216133032.5345.73.camel@dax.rpnet.com>
	<20080715151917.GA30607@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0807161546010.12709@t2.domain.actdsltmp>
	<20080717041531.GA27243@secretlab.ca>
	<Pine.LNX.4.64.0807162143460.26314@t2.domain.actdsltmp>
	<20080717135542.GA15503@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 Jul 2008, Anton Vorontsov wrote:
> On Wed, Jul 16, 2008 at 10:13:06PM -0700, Trent Piepho wrote:
>> Ok, how about adding code the existing leds-gpio driver so that it can creates
>> LEDs from of_platform devices too?
>
> Few comments below.
>
>> I've made a patch to do this and it works ok.  The code added to leds-gpio is
>> about half what was involved in Anton's new driver.
>
> This isn't true.

Your new driver was 194 lines, not counting docs or Kconfig.  My patch
added about 104 lines to the existing leds-gpio driver.  So yes, about half
the code.

>> There is still one of_platform device per led because of how the bindings work
>> (but that could be changed with new bindings), but there are zero extra
>> platform devices created.
>
> You didn't count extra platform driver. You can't #ifdef it. The only way
> you can avoid this is creating leds-gpio-base.c or something, and place the
> helper functions there.

I guess, in terms of compiled size, the combined platform + of_platform
driver is bigger than the of_platform only driver.  Though it's much
smaller than having both the platform only and of_platform only drivers. 
In terms of source code, there's less with the combined driver.

I don't see why the combined leds-gpio driver can't have an ifdef for the
platform part.  All the platform driver specific code is already in one
contiguous block.  In fact, I just did it and it works fine.  My LEDs from
the dts were created and the LED I have as a platform device wasn't, as
expected.  Here's the patch, pretty simple:

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -108,2 +108,3 @@ static int create_gpio_led(struct gpio_led *cur_led,

+#ifdef CONFIG_LEDS_GPIO_PLATFORM
  static int gpio_led_probe(struct platform_device *pdev)
@@ -222,2 +223,3 @@ module_init(gpio_led_init);
  module_exit(gpio_led_exit);
+#endif /* CONFIG_LEDS_GPIO_PLATFORM */


>> +static int create_gpio_led(struct gpio_led *cur_led,
>
> The create_gpio_led() interface is also quite weird, since it implies that
> we have to pass two GPIO LED "handles": struct gpio_led_data (that we
> allocated) and temporary struct gpio_led. And this helper function will
> just assign things from one struct to another, and then will register the
> led.

It creates a "thing" from a template passed a pointer to a struct.  This is
very common, there must be hundreds of functions in the kernel that work
this way.  The difference is instead of allocating and returning the
created thing, you pass it a blank pre-allocated thing to fill in and
register.  I know there is other code that works this way too.  It's
usually used, like it is here, so you can allocate a bunch of things at
once and then register them one at a time.

> With OF driver I don't need "struct gpio_led". Only the platform driver
> need this so platforms could pass gpio led info through it, while with OF
> we're getting all information from the device tree.

The struct gpio_led is just used to pass the stats to the led creation
function.  It doesn't stick around.  You could use local variables for the
gpio and name and pass them to the create led function.  Bundling them into
a struct is an tiny change that lets more code be shared.

>> +/* #ifdef CONFIG_LEDS_GPIO_OF */
>
> Heh.

Obviously the OF binding code should be conditional, selectable from
kconfig if the platform has OF support.  It's all in one contiguous block
and that shows where the ifdef would go.  I didn't think it was necessary
to include the obvious kconfig patch.
