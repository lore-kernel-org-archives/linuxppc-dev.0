Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C0225DDE23
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 00:05:20 +1000 (EST)
Date: Thu, 17 Jul 2008 18:05:19 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3] leds: implement OpenFirmare GPIO LED driver
Message-ID: <20080717140519.GA32617@polina.dev.rtsoft.ru>
References: <1216133032.5345.73.camel@dax.rpnet.com>
	<20080715151917.GA30607@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0807161546010.12709@t2.domain.actdsltmp>
	<20080717041531.GA27243@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080717041531.GA27243@secretlab.ca>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>,
	Trent Piepho <tpiepho@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 16, 2008 at 10:15:31PM -0600, Grant Likely wrote:
> On Wed, Jul 16, 2008 at 04:18:52PM -0700, Trent Piepho wrote:
> > On Tue, 15 Jul 2008, Anton Vorontsov wrote:
> > > Despite leds-gpio and leds-openfirmware-gpio similar purposes, there
> > > is not much code can be shared between the two drivers (both are mostly
> > > driver bindings anyway).
> > 
> > Why can't this driver use the existing gpio-led driver?  Basically, do
> > something like this:
> > 
> > of_gpio_leds_probe(...)
> > {
> >  	gpio = of_get_gpio(np, 0);
> >  	label = of_get_property(np, "label", NULL);
> > 
> >  	struct gpio_led led = {
> >  		.name = label,
> >  		.gpio = gpio,
> >  	};
> > 
> >  	pdev = platform_device_register_simple("leds-gpio", 0, NULL, 0);
> >  	platform_device_add_data(pdev, &led, sizeof(led));
> > }
> 
> Ugh; that means registering *2* 'struct device' with the kernel instead of
> one.  One as a platform device and one as an of_platform device.
> It's bad enough that the LED scheme we're using for OF bindings has a
> separate registration for every single LED.
> 
> Now that it comes to it, I worry that this driver takes the wrong
> approach.  The number of resources dedicated per LED in this driver
> seems pretty loony to me (one of_platform device per LED).  The fact
> that the binding specifies one node per LED makes of_platform not a very
> efficient solution.
> 
> I think it would be better to have a module that scans the device tree
> for LED nodes and registers a single leds-gpio platform device for the
> whole lot.
> 
> Thoughts?

I like the idea, thanks.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
