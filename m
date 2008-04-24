Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BE86DDEC40
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 02:25:56 +1000 (EST)
Date: Thu, 24 Apr 2008 18:28:13 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: mpc5200b custom board upstreamable?
Message-ID: <20080424162813.GL6692@pengutronix.de>
References: <20080424151237.GI6692@pengutronix.de>
	<fa686aa40804240813p66889769y3bee6eb0111741f7@mail.gmail.com>
	<20080424155303.GK6692@pengutronix.de>
	<fa686aa40804240907w7e36b579y4d2c63f00dd30848@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40804240907w7e36b579y4d2c63f00dd30848@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 24, 2008 at 10:07:20AM -0600, Grant Likely wrote:
> On Thu, Apr 24, 2008 at 9:53 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Thu, Apr 24, 2008 at 09:13:45AM -0600, Grant Likely wrote:
> >  > On Thu, Apr 24, 2008 at 9:12 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >  > >
> >  > >  Hi all,
> >  > >
> >  > >  I had the intention to push the code for a custom mpc5200b board (freely
> >  > >  available, no internal project) upstream. After cleaning up the code I
> >  > >  realized that actually no board specific code is left and our board is
> >  > >  well handled by the mpc5200_simple_platform machine.
> >  > >
> >  > >  The only issue is that the machine only matches things like
> >  > >  "schindler,cm5200", there's no generic entry. Would it be possible to
> >  > >  add a "generic-mpc52xx" entry to this list?
> >  >
> >  > I'm being cautious about this for the time being.  I'd like to have a
> >  > generic match mechanism, but I don't want to do something that isn't
> >  > easy to recover from if it turns out to be brain dead.  For now, just
> >  > add your board name to the explicit match list.
> >
> >  The board is called "generic". No, just kidding ;)
> 
> /me slaps Sascha
> 
> Seriously though; I do intend to fix this, but I don't think adding a
> generic entry to the compatible list is the right way to do it.  For
> example, what would "mpc5200-generic" really mean anyway?  Convention
> for usage of 'compatible' would indicate that it means the *entire
> board* is compatible (obviously not true).  The use-case you're
> talking about is simply "the board uses a 5200 and firmware is sane".
> On the other hand, I may just be overthinking things and compatible is
> the most appropriate place to specify that the board is a mpc5200
> based board.  (please feel free to argue with my; my opinion can
> probably be swayed... attaching promises of beer to your argument is
> probably an effective strategy)

At the moment my compatible entry looks like this:

compatible = "phytec,pcm030","generic-mpc52xx";

What I think would be nice is that "phytec,pcm030" support is used
when available and "generic-mpc52xx" as a fallback. We do not have any
platform specific hacks at the moment, but we may have later. Having
"phytec,pcm030" in the simple machine would prevent us from doing so.

> 
> This is an issue that probably affects the other embedded platforms
> too, so it would be nice to agree on a common method of handling it.
> 
> Regardless, whatever method is chosen, it is also important that it is
> always possible for board specific fixups to override the generic
> behavior.

agreed

Sascha


-- 
Pengutronix e.K. - Linux Solutions for Science and Industry
-----------------------------------------------------------
Kontakt-Informationen finden Sie im Header dieser Mail oder
auf der Webseite -> http://www.pengutronix.de/impressum/ <-
