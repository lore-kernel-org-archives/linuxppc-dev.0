Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 129B1DE01D
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 19:53:12 +1000 (EST)
Date: Mon, 28 Jul 2008 13:53:09 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [PATCH 1/2] leds: make the default trigger name const
Message-ID: <20080728095309.GA31809@polina.dev.rtsoft.ru>
References: <Pine.LNX.4.64.0807181339500.10116@t2.domain.actdsltmp>
	<1217019705-24244-1-git-send-email-tpiepho@freescale.com>
	<20080727020857.GM12191@secretlab.ca>
	<20080727231149.1b2508da.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0807271304350.26456@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <Pine.LNX.4.64.0807271304350.26456@t2.domain.actdsltmp>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jul 27, 2008 at 06:56:49PM -0700, Trent Piepho wrote:
> On Sun, 27 Jul 2008, Stephen Rothwell wrote:
> > On Sat, 26 Jul 2008 20:08:57 -0600 Grant Likely <grant.likely@secretlab.ca> wrote:
> >> On Fri, Jul 25, 2008 at 02:01:44PM -0700, Trent Piepho wrote:
> >>> The default_trigger fields of struct gpio_led and thus struct led_classdev
> >>> are pretty much always assigned from a string literal, which means the
> >>> string can't be modified.  Which is fine, since there is no reason to
> >>> modify the string and in fact it never is.
> >>>
> >>> But they should be marked const to prevent such code from being added, to
> >>> prevent warnings if -Wwrite-strings is used and when assigned from a
> >>> constant string other than a string literal (which produces a warning under
> >>> current kernel compiler flags), and for general good coding practices.
> >>>
> >>> Signed-off-by: Trent Piepho <tpiepho@freescale.com>
> >> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> >
> > I would ack this as well, except I am not sure what tree this patch is
> > against.  In the current powerpc next tree,
> 
> It was against powerpc next from Jul 22nd, current at the time I made the
> patch.  It looks like that file has changed in the last few days.  There is a
> patch from Anton Vorontsov, "leds:  mark led_classdev.default_trigger as
> const", which adds const to one of the structs I modified, but doesn't get the
> other one (struct gpio_led).

Yes, I posted the patch for my version of OF GPIO LEDs, which didn't use
struct gpio_led's default_trigger.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
