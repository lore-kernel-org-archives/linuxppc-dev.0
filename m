Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D10AADE130
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 04:17:16 +1000 (EST)
Date: Thu, 22 May 2008 22:17:13 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [PATCH 3/4] [MMC] mmc_spi: add polling support for the card
	detect line
Message-ID: <20080522181713.GA26918@polina.dev.rtsoft.ru>
References: <20080516165057.GC24196@polina.dev.rtsoft.ru>
	<20080517133633.5aa26938@mjolnir.drzeus.cx>
	<20080521184713.GA30284@polina.dev.rtsoft.ru>
	<20080521212831.523f344b@mjolnir.drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080521212831.523f344b@mjolnir.drzeus.cx>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 21, 2008 at 09:28:31PM +0200, Pierre Ossman wrote:
> On Wed, 21 May 2008 22:47:13 +0400
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > 
> > Calling get_cd() for every request smells like overhead, especially given
> > that that get_cd() could ask for GPIO status via relatively slow bus (like
> > I2C GPIO expanders). So, polling seems most reasonable solution here, no
> > need to call it very often.
> > 
> 
> Fair enough. You should probably add a comment about this somewhere so
> that people do not call get_cd() in the core request function and
> similar places. Place it so that both get_cd() and get_ro() are covered
> though, as it should be relevant for both.

I think this is applicable to the .set_ios() too.

[...]
> > +	if (host->ops->get_cd) {
> > +		int old_cd_status = host->cd_status;
> > +
> > +		host->cd_status = !!host->ops->get_cd(host);
> > +		if (!(old_cd_status ^ host->cd_status)) {
> > +			mmc_bus_put(host);
> > +			goto out;
> > +		}
> > +	}
> > +
> 
> This should only be done when there is no bus handler. Since we are
> polling, we might actually miss the user removing and reinserting the
> card. The only way to check for that is to poke the card and see if it
> is still alive. This also means you won't need that state variable.

Yeah, this makes sense. Indeed pretty easy to trigger [if poll interval
increased to 3 seconds, for example].

> Also, that second if clause seems fit for an obfuscation contest. ;)

cd_status was a bitfield, so I thought that bit operations would be
appropriate. :-)

> > p.s. Since mmc_host_ops no longer the same for every instance of
> > mmc_spi, struct mmc_host_ops can't be const and should be allocated
> > dynamically.
> 
> This can be solved by allowing get_cd() to return an error that will be
> treated as if get_cd() wasn't defined. -ENODEV seems suitable.

-ENOSYS (not implemented) sounds better for this purpose...

> (get_ro() needs the same treatment, but I haven't gotten around to
> that)

Ok. How about this version?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
