Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id EF820DDF77
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 08:05:44 +1100 (EST)
Date: Tue, 17 Mar 2009 00:05:42 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: [PATCH 05/13] sdhci: Add support for card-detection polling
Message-ID: <20090316210542.GA1991@oksana.dev.rtsoft.ru>
References: <20090213144630.GA13436@oksana.dev.rtsoft.ru>
	<20090213144718.GE23889@oksana.dev.rtsoft.ru>
	<20090221165821.1239aa5a@mjolnir.ossman.eu>
	<20090304174917.GD7477@oksana.dev.rtsoft.ru>
	<20090308151121.291f1abb@mjolnir.ossman.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20090308151121.291f1abb@mjolnir.ossman.eu>
Cc: Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Mar 08, 2009 at 03:11:21PM +0100, Pierre Ossman wrote:
> On Wed, 4 Mar 2009 20:49:17 +0300
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > On Sat, Feb 21, 2009 at 04:58:21PM +0100, Pierre Ossman wrote:
> > > Just modify the if-clause and
> > > things will work.
> > 
> > That would look horrid...
> > 
> >         if ((!(host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
> >                         !(sdhci_readl(host, SDHCI_PRESENT_STATE) &
> >                                 SDHCI_CARD_PRESENT)) ||
> >                         (host->flags & SDHCI_DEVICE_DEAD)) {
> > 
> 
> There are worse ones in that code, but I see your point. :)
> 
> > > Might want to add a comment also to make it more obvious what the
> > > if-clause does.
> > 
> > Let's try to avoid the if-clause above? How about this:
> > 
> 
> Looks ok.
> 
> > @@ -1096,6 +1099,7 @@ out:
> >  static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >  {
> >  	struct sdhci_host *host;
> > +	bool present;
> >  	unsigned long flags;
> >  
> >  	host = mmc_priv(mmc);
> 
> Can we use bool in the kernel?

Sure, it's widely used in the kernel, even in such places as
mm/ or kernel/.


Thanks for the review!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
