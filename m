Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id B0E86DDF0E
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 14:15:36 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so2583890ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 21:15:34 -0700 (PDT)
Date: Wed, 16 Jul 2008 22:15:31 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [PATCH v3] leds: implement OpenFirmare GPIO LED driver
Message-ID: <20080717041531.GA27243@secretlab.ca>
References: <1216133032.5345.73.camel@dax.rpnet.com>
	<20080715151917.GA30607@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0807161546010.12709@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0807161546010.12709@t2.domain.actdsltmp>
Sender: Grant Likely <glikely@secretlab.ca>
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

On Wed, Jul 16, 2008 at 04:18:52PM -0700, Trent Piepho wrote:
> On Tue, 15 Jul 2008, Anton Vorontsov wrote:
> > Despite leds-gpio and leds-openfirmware-gpio similar purposes, there
> > is not much code can be shared between the two drivers (both are mostly
> > driver bindings anyway).
> 
> Why can't this driver use the existing gpio-led driver?  Basically, do
> something like this:
> 
> of_gpio_leds_probe(...)
> {
>  	gpio = of_get_gpio(np, 0);
>  	label = of_get_property(np, "label", NULL);
> 
>  	struct gpio_led led = {
>  		.name = label,
>  		.gpio = gpio,
>  	};
> 
>  	pdev = platform_device_register_simple("leds-gpio", 0, NULL, 0);
>  	platform_device_add_data(pdev, &led, sizeof(led));
> }

Ugh; that means registering *2* 'struct device' with the kernel instead of
one.  One as a platform device and one as an of_platform device.
It's bad enough that the LED scheme we're using for OF bindings has a
separate registration for every single LED.

Now that it comes to it, I worry that this driver takes the wrong
approach.  The number of resources dedicated per LED in this driver
seems pretty loony to me (one of_platform device per LED).  The fact
that the binding specifies one node per LED makes of_platform not a very
efficient solution.

I think it would be better to have a module that scans the device tree
for LED nodes and registers a single leds-gpio platform device for the
whole lot.

Thoughts?

g.
