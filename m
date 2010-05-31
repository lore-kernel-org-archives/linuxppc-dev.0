Return-Path: <rpurdie@rpsys.net>
Received: from tim.rpsys.net (93-97-173-237.zone5.bethere.co.uk
	[93.97.173.237])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5F05CB7D2E
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jun 2010 08:06:13 +1000 (EST)
Subject: Re: [PATCH] drivers: remove all i2c_set_clientdata(client, NULL)
From: Richard Purdie <rpurdie@rpsys.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <20100531190911.GC30712@core.coreip.homeip.net>
References: <1275310552-14685-1-git-send-email-w.sang@pengutronix.de>
	<20100531190911.GC30712@core.coreip.homeip.net>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 31 May 2010 22:48:32 +0100
Message-ID: <1275342512.24079.1559.camel@rex>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org,
	Alessandro Rubini <rubini@cvml.unipv.it>,
	Samuel Ortiz <sameo@linux.intel.com>, lm-sensors@lm-sensors.org,
	linux-input@vger.kernel.org, linux-media@vger.kernel.org,
	Paul Gortmaker <p_gortmaker@yahoo.com>,
	devel@driverdev.osuosl.org, rtc-linux@googlegroups.com,
	Riku Voipio <riku.voipio@iki.fi>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	Jean Delvare <khali@linux-fr.org>,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
	Liam Girdwood <lrg@slimlogic.co.uk>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Guillaume Ligneul <guillaume.ligneul@gmail.com>,
	George Joseph <george.joseph@fairview5.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linux-kernel@vger.kernel.org, Colin Leroy <colin@colino.net>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-05-31 at 12:09 -0700, Dmitry Torokhov wrote:
> On Mon, May 31, 2010 at 02:55:48PM +0200, Wolfram Sang wrote:
> > I2C-drivers can use the clientdata-pointer to point to private data. As I2C
> > devices are not really unregistered, but merely detached from their driver, it
> > used to be the drivers obligation to clear this pointer during remove() or a
> > failed probe(). As a couple of drivers forgot to do this, it was agreed that it
> > was cleaner if the i2c-core does this clearance when appropriate, as there is
> > no guarantee for the lifetime of the clientdata-pointer after remove() anyhow.
> > This feature was added to the core with commit
> > e4a7b9b04de15f6b63da5ccdd373ffa3057a3681 to fix the faulty drivers.
> > 
> > As there is no need anymore to clear the clientdata-pointer, remove all current
> > occurrences in the drivers to simplify the code and prevent confusion.
> > 
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > Cc: Jean Delvare <khali@linux-fr.org>
> > ---
> > 
> > Some more notes:
> > 
> > I waited for rc1 as I knew there were some drivers/patches coming along which
> > needed to be processed, too.
> > 
> > I'd suggest that this goes via the i2c-tree, so we get rid of all occurences at
> > once.
> > 
> 
> Frankly I'd prefer taking input stuff through my tree with the goal of
> .36 merge window just to minimize potential merge issues. This is a
> simple cleanup patch that has no dependencies, so there is little gain
> from doing it all in one go.

How about asking Linus to take this one now, then its done and we can
all move on rather than queuing up problems for the next merge window?

Acked-by: Richard Purdie <rpurdie@linux.intel.com>

Cheers,

Richard
