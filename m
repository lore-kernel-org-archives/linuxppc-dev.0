Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by ozlabs.org (Postfix) with ESMTP id 8B06FDDDF7
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 03:09:18 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so5892841wfg.15
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 10:09:17 -0700 (PDT)
Date: Mon, 28 Jul 2008 11:09:14 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [PATCH 2/2] leds: Support OpenFirmware led bindings
Message-ID: <20080728170914.GA21265@secretlab.ca>
References: <Pine.LNX.4.64.0807181339500.10116@t2.domain.actdsltmp>
	<1217019705-24244-2-git-send-email-tpiepho@freescale.com>
	<20080727022116.GN12191@secretlab.ca>
	<Pine.LNX.4.64.0807272159500.26456@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0807272159500.26456@t2.domain.actdsltmp>
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

On Mon, Jul 28, 2008 at 01:31:47AM -0700, Trent Piepho wrote:
> On Sat, 26 Jul 2008, Grant Likely wrote:
> > On Fri, Jul 25, 2008 at 02:01:45PM -0700, Trent Piepho wrote:
> >> Add bindings to support LEDs defined as of_platform devices in addition to
> >> the existing bindings for platform devices.
> >
> >> +- gpios :  Should specify the LED GPIO.
> >
> > Question: it is possible/desirable for a single LED to be assigned
> > multiple GPIO pins?  Say, for a tri-color LED?  (I'm fishing for
> > opinions; I really don't know if it would be a good idea or not)
> 
> Good question.  The Linux LED layer has no concept of multi-color LEDs, so
> it's more difficult that just adding support to the gpio led driver.  I have
> a device with a tri-color red/green/orange LED and this posed some
> difficulty.  It's defined as independent red and greed LEDs, which is mostly
> fine, except I wanted it to flash orange.  I can make both the red LED and
> green LED flash, but there is nothing to insure their flashing remains in
> sync.
> 
> Other OF bindings allow multiple GPIOs to be listed in a gpios property, so
> that's not a problem if someone wants to do that.  There would need to be a
> way to define what the gpios mean.  I don't think it's worthwhile to come up
> with a binding for that until there is a real user.

True.  The binding can be extended at a later date anyway.  It might be
as simple as adding an array of strings that define what each gpio value
means.  ie.  if 2 gpio lines are used for a led, then that maps to
numbers in the range [0, 1, 2, 3].  It could be encoded thus:

        led-states = "off", "green", "red", "orange";

The driver would then need to interpret/adapt these strings to something
useful in the LED driver.  Just a thought.

> >> +- function :  (optional) This parameter, if present, is a string
> >> +  defining the function of the LED.  It can be used to put the LED
> >> +  under software control, e.g. Linux LED triggers like "heartbeat",
> >> +  "ide-disk", and "timer".  Or it could be used to attach a hardware
> >> +  signal to the LED, e.g. a SoC that can configured to put a SATA
> >> +  activity signal on a GPIO line.
> >
> > This makes me nervous.  It exposes Linux internal implementation details
> > into the device tree data.  If you want to have a property that
> > describes the LED usage, then the possible values and meanings should be
> > documented here.
> 
> Should it be a linux specific property then?  I could list all the current
> linux triggers, but enumerating every possible function someone might want
> to assign to an LED seems hopeless.

I don't like adding Linux specific properties to the device tree if at
all possible, and I really don't like encoding Linux internal details
(like trigger names).  They can change between kernel versions and
breaking compatibility with older device trees is strongly avoided.
That's why so much effort goes into getting bindings correct the first
time.

I'd rather see the device tree provide 'hints' toward the expected usage
and if a platform needs something specific, then the platform specific
code should setup the trigger.

Regardless, any hints provided by the binding must be documented.  In
most cases the gpio-leds driver should be able to figure out which trigger
to bind without platform code intervention.

g.
