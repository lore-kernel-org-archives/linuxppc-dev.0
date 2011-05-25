Return-Path: <r65073@freescale.com>
Date: Wed, 25 May 2011 14:06:37 +0800
From: Shawn Guo <shawn.guo@freescale.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 5/7] mmc: sdhci: consolidate sdhci-of-esdhc and
	sdhci-esdhc-imx
Message-ID: <20110525060637.GA30583@S2100-06.ap.freescale.net>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
	<20110524194054.GC25727@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20110524194054.GC25727@pengutronix.de>
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

On Tue, May 24, 2011 at 09:40:54PM +0200, Wolfram Sang wrote:
> On Thu, May 05, 2011 at 09:22:56PM +0800, Shawn Guo wrote:
> > This patch is to consolidate SDHCI driver for Freescale eSDHC
> > controller found on both MPCxxx and i.MX platforms.  It merges
> > sdhci-of-esdhc.c into sdhci-esdhc.c, so that the same pair of
> > .probe/.remove hook works with eSDHC for two platforms.
> > 
> > As the results, sdhci-of-esdhc.c and sdhci-esdhc.h are removed, and
> > header esdhc.h containing the definition of esdhc_platform_data is
> > put into the public folder.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> I agree with Anton about not merging the two...
> 
> > +#ifndef CONFIG_MMC_SDHCI_ESDHC_IMX
> > +#define cpu_is_mx25()	(0)
> > +#define cpu_is_mx35()	(0)
> > +#define cpu_is_mx51()	(0)
> > +#define cpu_is_imx()	(0)
> > +#else
> > +#define cpu_is_imx()	(1)
> > +#endif
> 
> ... e.g. that looks a bit frightening.
> 
Agree.

The use of cpu_is_mx..() in the driver itself seems a churn to me
even without this consolidation patch.  Is it possible for us to
eliminate them by using pdata, and eventually device tree?  When we
are there, I might want to revisit the consolidation again.

-- 
Regards,
Shawn
