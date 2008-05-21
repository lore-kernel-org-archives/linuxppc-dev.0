Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7E232DE6BB
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 02:10:40 +1000 (EST)
Date: Wed, 21 May 2008 20:10:39 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/4] [OF] spi_of: add support for dedicated SPI
	constructors
Message-ID: <20080521161039.GA9050@polina.dev.rtsoft.ru>
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
	<20080521154139.GB4566@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0805211754300.5386@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <Pine.LNX.4.64.0805211754300.5386@axis700.grange>
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 21, 2008 at 05:56:33PM +0200, Guennadi Liakhovetski wrote:
> On Wed, 21 May 2008, Anton Vorontsov wrote:
> 
> > Dedicated (usually the ones that need to fill platform data) constructors
> > will create board info, so SPI core will probe them as normal SPI devices.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> >  drivers/spi/spi_of.c       |   67 ++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/spi/spi_of.h |    5 +++
> >  2 files changed, 72 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/spi/spi_of.c b/drivers/spi/spi_of.c
> > index b5ae434..2e1a11f 100644
> > --- a/drivers/spi/spi_of.c
> > +++ b/drivers/spi/spi_of.c
> > @@ -11,6 +11,66 @@
> >  #include <linux/spi/spi.h>
> >  #include <linux/spi/spi_of.h>
> >  
> > +/*
> > + * Caller have no idea who is master, i.e. this function does not
> > + * accept pointer to the master, instead we use board infos.
> > + */
> > +int of_spi_device_probe_common(struct device_node *np,
> > +			       struct spi_board_info *spi_binfo,
> > +			       const char *modalias)
> > +{
> 
> Hm, I might well misunderstand something here, but it looks to me like you 
> are again trying to use both OF _and_ platform (spi_board_info) bindings 
> for your SPI setup?

Yes, you didn't misunderstand. ;-)

> And this is exactly what we are trying to avoid in 
> Grant's series of patches...

I didn't find other way... The show stopper is "master" argument,
drivers don't know about masters (and should not, since if they should,
then this implies that masters should be registered prior to devices,
and that complicates everything).

What is the problem with board infos, btw? I missed that part. Board
infos are good because:

1. This is how things work in real life: SPI isn't probe-able bus, so
   platform code (or board code, or OF helpers) should explicitly probe
   and create devices.
2. With platform infos we're probing in a Linux usual way (e.g.
   master's .bus_id + chip_select matching).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
