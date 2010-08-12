Return-Path: <matt@console-pimps.org>
Received: from arkanian.console-pimps.org (arkanian.console-pimps.org
	[212.110.184.194]) by ozlabs.org (Postfix) with ESMTP id 62369B70D1
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Aug 2010 21:42:43 +1000 (EST)
Date: Thu, 12 Aug 2010 12:34:21 +0100
From: Matt Fleming <matt@console-pimps.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Running out of SDHCI quirk space (Re: [PATCH 1/3 v2] sdhci: Add
	auto CMD12 support for eSDHC driver)
Message-ID: <20100812113421.GB30744@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Dooks <ben@simtec.co.uk>, linux-mmc@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 03, 2010 at 04:43:46PM -0700, Andrew Morton wrote:
> On Tue, 3 Aug 2010 11:11:10 +0800
> Roy Zang <tie-fei.zang@freescale.com> wrote:
> 
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -240,6 +240,8 @@ struct sdhci_host {
> >  #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
> >  /* Controller cannot support End Attribute in NOP ADMA descriptor */
> >  #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
> > +/* Controller uses Auto CMD12 command to stop the transfer */
> > +#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<27)
> 
> This becomes 1<<29 in my tree.
> 
> We're about to run out.  What happens then?

I've been wondering for a while now if many of the quirks should be
hidden behind function pointers. While we could of course extend the
quirk space, I think that's kinda missing the point that quirks are
being used too liberally. Take SDHCI_QUIRK_SINGLE_POWER_WRITE in
drivers/mmc/host/sdhci.c:sdhci_set_power(). Really, that quirk should
probably be hidden inside a set_power() function in the sdhci_ops
structure.

I'm gonna have a go at trying to remove some of the quirks that don't
make sense being quirks. I'll post the series when I'm done.

Does anyone think that this approach is crazy?
