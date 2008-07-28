Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id 9BA2CDDED1
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 04:49:59 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so5951478wfg.15
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 11:49:58 -0700 (PDT)
Date: Mon, 28 Jul 2008 12:49:55 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [PATCH 2/2] leds: Support OpenFirmware led bindings
Message-ID: <20080728184955.GB21874@secretlab.ca>
References: <Pine.LNX.4.64.0807181339500.10116@t2.domain.actdsltmp>
	<1217019705-24244-2-git-send-email-tpiepho@freescale.com>
	<20080727022116.GN12191@secretlab.ca>
	<Pine.LNX.4.64.0807272159500.26456@t2.domain.actdsltmp>
	<20080728170914.GA21265@secretlab.ca>
	<20080728180204.GA13190@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0807281120150.26456@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0807281120150.26456@t2.domain.actdsltmp>
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

On Mon, Jul 28, 2008 at 11:26:28AM -0700, Trent Piepho wrote:
> On Mon, 28 Jul 2008, Anton Vorontsov wrote:
> > On Mon, Jul 28, 2008 at 11:09:14AM -0600, Grant Likely wrote:
> > [...]
> >>>>> +- function :  (optional) This parameter, if present, is a string
> >>>>> +  defining the function of the LED.  It can be used to put the LED
> >>>>> +  under software control, e.g. Linux LED triggers like "heartbeat",
> >>>>> +  "ide-disk", and "timer".  Or it could be used to attach a hardware
> >>>>> +  signal to the LED, e.g. a SoC that can configured to put a SATA
> >>>>> +  activity signal on a GPIO line.
> >>>>
> >>>> This makes me nervous.  It exposes Linux internal implementation details
> >>>> into the device tree data.  If you want to have a property that
> >>>> describes the LED usage, then the possible values and meanings should be
> >>>> documented here.
> >>>
> >>> Should it be a linux specific property then?  I could list all the current
> >>> linux triggers, but enumerating every possible function someone might want
> >>> to assign to an LED seems hopeless.
> >>
> >> I'd rather see the device tree provide 'hints' toward the expected usage
> >> and if a platform needs something specific, then the platform specific
> >> code should setup the trigger.
> >>
> > Maybe we can encode leds into devices themselves, via phandles?
> 
> How will this work for anything besides ide activity?  For example, flashing,
> heartbeat, default on, overheat, fan failed, kernel panic, etc.

It certainly doesn't work for everything; but where it does work it
makes a lot of sense because the property position provides a lot of
context.

> 
> > And then the OF GPIO LEDs driver could do something like:
> >
> > char *ide_disk_trigger_compatibles[] = {
> > 	"fsl,sata",
> > 	"ide-generic",
> > 	...
> > };
> 
> Everytime someone added a new ide driver, this table would have to be updated.

Yes, the implementation needs thought.

g.
