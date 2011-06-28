Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 02FC2B6EDF
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2011 09:15:52 +1000 (EST)
Subject: Re: [PATCH v4]PPC4xx: Adding PCI(E) MSI support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <ayman@elkhashab.com>
In-Reply-To: <20110628223131.GA10267@crust.elkhashab.com>
References: <201103300910.p2U9AO8t024353@amcc.com>
	<1306387484.7481.453.camel@pasglop>
	<20110628223131.GA10267@crust.elkhashab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Jun 2011 09:15:28 +1000
Message-ID: <1309302928.32158.470.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Rupjyoti Sarmah <rsarmah@amcc.com>,
	rsarmah@apm.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-06-28 at 17:31 -0500, Ayman El-Khashab wrote:
> > > +static int ppc4xx_setup_pcieh_hw(struct platform_device *dev,
> > > +                            struct resource res, struct
> ppc4xx_msi *msi)
> > > +{
> > > +
> 
> <snip>
> 
> > > +
> > > +   msi->msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
> > > +   if (msi->msi_dev)
> > > +           return -ENODEV;
> 
> This does not look correct. I guess it should probably read 
> 
> if (!msi->msi_dev) .....

Indeed, that looks bogus. Rupjyoti, please test and send fixes if
necessary, obviously this code has not been tested.

This is not part of the bits I fixed up so I looks to me like the
original patch was wrong (and thus obviously untested !!!)

Cheers,
Ben.
