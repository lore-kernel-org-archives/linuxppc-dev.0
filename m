Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 755DEDE5C7
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 00:43:13 +1000 (EST)
Date: Thu, 5 Jun 2008 18:43:10 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Marc Pignat <marc.pignat@hevs.ch>
Subject: Re: [PATCH 3/3] mmc: change .get_ro() callback semantics
Message-ID: <20080605144310.GA31596@polina.dev.rtsoft.ru>
References: <20080523154204.GA19803@polina.dev.rtsoft.ru>
	<20080523154347.GC24862@polina.dev.rtsoft.ru>
	<200806031207.49843.marc.pignat@hevs.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200806031207.49843.marc.pignat@hevs.ch>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net, Timur Tabi <timur@freescale.com>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 03, 2008 at 12:07:49PM +0200, Marc Pignat wrote:
> Hi all!
> 
> On Friday 23 May 2008, Anton Vorontsov wrote:
> > get_ro() callback must return values >= 0 for its logical state, and
> ...
> >  static void pxamci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index f2e9885..ef3b773 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -55,6 +55,9 @@ struct mmc_host_ops {
> >  	 * Avoid calling these three functions too often or in a "fast path",
> >  	 * since underlaying controller might implement them in an expensive
> >  	 * and/or slow way.
> > +	 *
> > +	 * .get_ro and .get_cd should return >= 0 for their logical values,
> > +	 * or negative errno value in case of error.
> >  	 */
> 
> I would suggest to use something more strict (bulletproof), something like:
> 
> /*
>  * get_ro will return:
>  *   0 for a read/write card
>  *   1 for a read-only card 

This isn't always practical. For example, host is using u8 register for
the status, so it might safely return u8 & mask, that will always fit
into int. Or very smart/adventurous authors might be aware that, for the
particular host, mask's bit isn't last, and safely do uXX & mask. :-)

The above is weak argument of course, since it is about optimization.

As an counter-evidence, the strict scheme that you described probably
less error prone. But is it? To implement it we'll need something like
WARN_ON(ret > 0 && ret != 1) to catch erroneous users. Take a closer
look though, will it catch uXX & lastbit case? Nope. :-)

We can catch bogus users though... via hack (_assuming_ that there
are no errno values of 1 << (sizeof(int) * 8 - 1)), i.e.
WARN_ON(ret == (1 << (sizeof(int) * 8 - 1)). Though, to do so, we don't
need the strict scheme, this debugging hack will work in the current
scheme too.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
