Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id AAA69DEA1E
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 04:47:15 +1000 (EST)
Date: Wed, 21 May 2008 22:47:13 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [PATCH 3/4] [MMC] mmc_spi: add polling support for the card
	detect line
Message-ID: <20080521184713.GA30284@polina.dev.rtsoft.ru>
References: <20080516165057.GC24196@polina.dev.rtsoft.ru>
	<20080517133633.5aa26938@mjolnir.drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080517133633.5aa26938@mjolnir.drzeus.cx>
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

On Sat, May 17, 2008 at 01:36:33PM +0200, Pierre Ossman wrote:
> On Fri, 16 May 2008 20:50:57 +0400
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > Some boards do not use interrupts on the CD line, so we want to poll
> > the CD and see if there was a change. 1 second poll interval seems
> > resonable.
> > 
> 
> The idea isn't bad, but I'm not sure about the mechanism.
> 
> To poll a MMC slot, you do not really need a card detect at all. The
> MMC layer can just shoot off some requests and see if anything
> responds.  The PXA driver (if my memory serves me right) already does
> this. So the best idea there would be to add this feature to the MMC
> core and let the host indicate that it needs it via MMC_CAP_NEEDS_POLL
> or something like that.
> 
> The card detection pin then becomes an optimisation, something that is
> also useful in other ways. Have the host driver check the card detection
> pin at the start of every request, and quickly fail it if there is no
> card present.

Calling get_cd() for every request smells like overhead, especially given
that that get_cd() could ask for GPIO status via relatively slow bus (like
I2C GPIO expanders). So, polling seems most reasonable solution here, no
need to call it very often.

How about these patches? Tested with and without get_cd() optimization.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
