Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id B92A1B6F59
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2011 01:22:59 +1000 (EST)
Date: Wed, 29 Jun 2011 10:22:54 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4]PPC4xx: Adding PCI(E) MSI support
Message-ID: <20110629152254.GB29257@crust.elkhashab.com>
References: <201103300910.p2U9AO8t024353@amcc.com>
	<1306387484.7481.453.camel@pasglop>
	<20110628223131.GA10267@crust.elkhashab.com>
	<1309302928.32158.470.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309302928.32158.470.camel@pasglop>
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

On Wed, Jun 29, 2011 at 09:15:28AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2011-06-28 at 17:31 -0500, Ayman El-Khashab wrote:
> > > > +static int ppc4xx_setup_pcieh_hw(struct platform_device *dev,
> > > > +                            struct resource res, struct
> > ppc4xx_msi *msi)
> > > > +{
> > > > +
> > 
> > <snip>
> > 
> > > > +
> > > > +   msi->msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
> > > > +   if (msi->msi_dev)
> > > > +           return -ENODEV;
> > 
> > This does not look correct. I guess it should probably read 
> > 
> > if (!msi->msi_dev) .....
> 
> Indeed, that looks bogus. Rupjyoti, please test and send fixes if
> necessary, obviously this code has not been tested.
> 
> This is not part of the bits I fixed up so I looks to me like the
> original patch was wrong (and thus obviously untested !!!)
> 

Looking back through the mailing list, there have been
various incarnations of this patch to add MSI support to the
44x.  Every one that I looked at had this same line of code
in it so I am not sure they worked.  In any case I am trying
to make it work on my system (which is how I found the bug).
When I enable the "sdr-base" line in the MSI section of my
dts, it just reboots continuosly right after "Loading Device
Tree ....".  I tried renaming it to "msi-sdr-base" just in
case there was a conflict (since it is reading through the
entire tree) but that did not help.  If I understand
correctly, the ppc4xx_msi_probe function must be executing
very early since I suspect something in setup_pcieh_hw is 
what causes it to fail.  

ayman
