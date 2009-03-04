Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id E3823DE134
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Mar 2009 04:47:45 +1100 (EST)
Date: Wed, 4 Mar 2009 20:47:44 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: [PATCH 12/13] sdhci: Add quirk for controllers with max. block
	size up to 4096 bytes
Message-ID: <20090304174744.GB7477@oksana.dev.rtsoft.ru>
References: <20090213144630.GA13436@oksana.dev.rtsoft.ru>
	<20090213144739.GL23889@oksana.dev.rtsoft.ru>
	<20090221165844.4f494043@mjolnir.ossman.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090221165844.4f494043@mjolnir.ossman.eu>
Cc: Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx,
	Pierre Ossman <drzeus-sdhci@drzeus.cx>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Feb 21, 2009 at 04:58:44PM +0100, Pierre Ossman wrote:
> On Fri, 13 Feb 2009 17:47:39 +0300
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > @@ -831,7 +832,12 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
> >  	sdhci_set_transfer_irqs(host);
> >  
> >  	/* We do not handle DMA boundaries, so set it to max (512 KiB) */
> > -	sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, data->blksz), SDHCI_BLOCK_SIZE);
> > +	if (host->quirks & SDHCI_QUIRK_MAX_BLK_SZ_4096)
> > +		blksz = data->blksz;
> > +	else
> > +		blksz = SDHCI_MAKE_BLKSZ(7, data->blksz);
> > +
> > +	sdhci_writew(host, blksz, SDHCI_BLOCK_SIZE);
> >  	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
> >  }
> >  
> 
> Hmm.. I seem to have overlooked this part previously. I guess they've
> basically stripped out the DMA boundary stuff and used the bits for
> other things?

Yes, the last two "DMA boundary" bits are reserved, and the first
one is re-used for blksz of 4096 bytes.

> At this point I'm leaning more towards simply not supporting their
> extended block size.

Eh. But well, OK. We can always persuade you later. :-)

I'll get rid of this particular patch, and put some BLOCK_SIZE
magic into the writew accessor (to clean the DMA bits) instead.

Though, I'll prepare another patch to force blksz to 2048, since
eSDHC specifies "3" in the blksz capability bitfield, and that
causes SDHCI core to fall back to the 512 byte blocks.

> After all, is it ever used?

Not sure, maybe `dd bs=' can use it? A bit lazy to check this
right now, but from the quick tests, enabling/disabling "blksz
of 4096 bytes" doesn't cause any performance change. At least
with the ordinary SD cards.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
