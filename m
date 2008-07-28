Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 34871DDFF8
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 04:02:07 +1000 (EST)
Date: Mon, 28 Jul 2008 22:02:04 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] leds: Support OpenFirmware led bindings
Message-ID: <20080728180204.GA13190@polina.dev.rtsoft.ru>
References: <Pine.LNX.4.64.0807181339500.10116@t2.domain.actdsltmp>
	<1217019705-24244-2-git-send-email-tpiepho@freescale.com>
	<20080727022116.GN12191@secretlab.ca>
	<Pine.LNX.4.64.0807272159500.26456@t2.domain.actdsltmp>
	<20080728170914.GA21265@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080728170914.GA21265@secretlab.ca>
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

On Mon, Jul 28, 2008 at 11:09:14AM -0600, Grant Likely wrote:
[...]
> > >> +- function :  (optional) This parameter, if present, is a string
> > >> +  defining the function of the LED.  It can be used to put the LED
> > >> +  under software control, e.g. Linux LED triggers like "heartbeat",
> > >> +  "ide-disk", and "timer".  Or it could be used to attach a hardware
> > >> +  signal to the LED, e.g. a SoC that can configured to put a SATA
> > >> +  activity signal on a GPIO line.
> > >
> > > This makes me nervous.  It exposes Linux internal implementation details
> > > into the device tree data.  If you want to have a property that
> > > describes the LED usage, then the possible values and meanings should be
> > > documented here.
> > 
> > Should it be a linux specific property then?  I could list all the current
> > linux triggers, but enumerating every possible function someone might want
> > to assign to an LED seems hopeless.
> 
> I don't like adding Linux specific properties to the device tree if at
> all possible, and I really don't like encoding Linux internal details
> (like trigger names).  They can change between kernel versions and
> breaking compatibility with older device trees is strongly avoided.
> That's why so much effort goes into getting bindings correct the first
> time.
> 
> I'd rather see the device tree provide 'hints' toward the expected usage
> and if a platform needs something specific, then the platform specific
> code should setup the trigger.
> 
> Regardless, any hints provided by the binding must be documented.  In
> most cases the gpio-leds driver should be able to figure out which trigger
> to bind without platform code intervention.

Maybe we can encode leds into devices themselves, via phandles?

E.g.

sata@101 {
	compatible = "fsl,sata";
	leds = <&red_led>;
};

And then the OF GPIO LEDs driver could do something like:

char *ide_disk_trigger_compatibles[] = {
	"fsl,sata",
	"ide-generic",
	...
};

for_each_node_with_leds_property(node, led_phandle) {
	if (if_ide_disk_compatible(node)) {
		struct gpio_led *led = phandle_to_led(led_phandle);

		led->default_trigger = "ide-disk";
	}
}

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
