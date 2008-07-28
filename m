Return-Path: <tpiepho@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0670DDDFAA
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 12:01:09 +1000 (EST)
Date: Sun, 27 Jul 2008 18:56:49 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/2] leds: make the default trigger name const
In-Reply-To: <20080727231149.1b2508da.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0807271304350.26456@t2.domain.actdsltmp>
References: <Pine.LNX.4.64.0807181339500.10116@t2.domain.actdsltmp>
	<1217019705-24244-1-git-send-email-tpiepho@freescale.com>
	<20080727020857.GM12191@secretlab.ca>
	<20080727231149.1b2508da.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Richard Purdie <rpurdie@rpsys.net>, Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 27 Jul 2008, Stephen Rothwell wrote:
> On Sat, 26 Jul 2008 20:08:57 -0600 Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Fri, Jul 25, 2008 at 02:01:44PM -0700, Trent Piepho wrote:
>>> The default_trigger fields of struct gpio_led and thus struct led_classdev
>>> are pretty much always assigned from a string literal, which means the
>>> string can't be modified.  Which is fine, since there is no reason to
>>> modify the string and in fact it never is.
>>>
>>> But they should be marked const to prevent such code from being added, to
>>> prevent warnings if -Wwrite-strings is used and when assigned from a
>>> constant string other than a string literal (which produces a warning under
>>> current kernel compiler flags), and for general good coding practices.
>>>
>>> Signed-off-by: Trent Piepho <tpiepho@freescale.com>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>
> I would ack this as well, except I am not sure what tree this patch is
> against.  In the current powerpc next tree,

It was against powerpc next from Jul 22nd, current at the time I made the
patch.  It looks like that file has changed in the last few days.  There is a
patch from Anton Vorontsov, "leds:  mark led_classdev.default_trigger as
const", which adds const to one of the structs I modified, but doesn't get the
other one (struct gpio_led).

Then another patch from Nate Case added a new LED chip driver, and the
platform data for this driver was added as "generic led platform data", which
I don't entirely agree with.  And this new struct didn't make default_trigger
const, probably because it was just copied from the gpio led platform data
with some fields removed (so it's not really that generic then, is it?).

I'll send an updated patch for current powerpc next.
