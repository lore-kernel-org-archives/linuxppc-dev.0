Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99758B6F8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 16:46:31 +1000 (EST)
Date: Wed, 25 May 2011 08:46:19 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 5/7] mmc: sdhci: consolidate sdhci-of-esdhc and
	sdhci-esdhc-imx
Message-ID: <20110525064619.GI9774@pengutronix.de>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
	<20110524194054.GC25727@pengutronix.de>
	<20110525060637.GA30583@S2100-06.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20110525060637.GA30583@S2100-06.ap.freescale.net>
Cc: Chris Ball <cjb@laptop.org>, Anton Vorontsov <avorontsov@ru.mvista.com>,
	sameo@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
	patches@linaro.org, devicetree-discuss@lists.ozlabs.org,
	linux-mmc@vger.kernel.org, Saeed Bishara <saeed@marvell.com>,
	Xiaobo Xie <X.Xie@freescale.com>, kernel@pengutronix.de,
	Mike Rapoport <mike@compulab.co.il>, Olof Johansson <olof@lixom.net>,
	Shawn Guo <shawn.guo@linaro.org>, linuxppc-dev@lists.ozlabs.org,
	Albert Herranz <albert_herranz@yahoo.es>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Shawn,

> > > +#ifndef CONFIG_MMC_SDHCI_ESDHC_IMX
> > > +#define cpu_is_mx25()	(0)
> > > +#define cpu_is_mx35()	(0)
> > > +#define cpu_is_mx51()	(0)
> > > +#define cpu_is_imx()	(0)
> > > +#else
> > > +#define cpu_is_imx()	(1)
> > > +#endif
> > 
> > ... e.g. that looks a bit frightening.
> > 
> Agree.
> 
> The use of cpu_is_mx..() in the driver itself seems a churn to me
> even without this consolidation patch.  Is it possible for us to
> eliminate them by using pdata, and eventually device tree?  When we
> are there, I might want to revisit the consolidation again.
An alternative that allows letting the logic in the driver and still
getting rid of the cpu_is_ stuff is using platform ids. See
drivers/spi/spi_imx.c for an example. Instead of an index into an array
(as it's for the imx-spi driver) driver_data can hold flags, too, which
should be enough most of the time.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
