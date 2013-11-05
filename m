Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8A90B2C0246
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 06:52:29 +1100 (EST)
Message-ID: <1383681133.4776.95.camel@pasglop>
Subject: Re: [PATCH 5/7] IBM Akebono: Add support to the EHCI platform
 driver for Akebono
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Stern <stern@rowland.harvard.edu>
Date: Wed, 06 Nov 2013 06:52:13 +1100
In-Reply-To: <Pine.LNX.4.44L0.1311051004080.1360-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1311051004080.1360-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alistair Popple <alistair@popple.id.au>, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-11-05 at 10:04 -0500, Alan Stern wrote:
> On Tue, 5 Nov 2013, Alistair Popple wrote:
> 
> > The IBM Akebono board has an EHCI compliant USB host interface. This
> > patch adds support for it to the EHCI platform driver.
> > 
> > Signed-off-by: Alistair Popple <alistair@popple.id.au>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: linux-usb@vger.kernel.org
> > ---
> >  drivers/usb/host/ehci-platform.c |    5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> > index f6b790c..0a67616 100644
> > --- a/drivers/usb/host/ehci-platform.c
> > +++ b/drivers/usb/host/ehci-platform.c
> > @@ -203,9 +203,10 @@ static int ehci_platform_resume(struct device *dev)
> >  #define ehci_platform_resume	NULL
> >  #endif /* CONFIG_PM */
> >  
> > -static const struct of_device_id vt8500_ehci_ids[] = {
> > +static const struct of_device_id ehci_platform_ids[] = {
> >  	{ .compatible = "via,vt8500-ehci", },
> >  	{ .compatible = "wm,prizm-ehci", },
> > +	{ .compatible = "ibm,akebono-ehci", },
> >  	{}
> >  };

Why ? Do we need to add an entry for every platform in there ? Besides,
it probably should be the SoC name not the platform here....

Why not simply a generic compatible "usb-ehci" ? It's a standard
programming interface, there are no specific quirks, we shouldn't
need to have to add new entries to the driver like that for every
new SoC/platform.

> > @@ -229,7 +230,7 @@ static struct platform_driver ehci_platform_driver = {
> >  		.owner	= THIS_MODULE,
> >  		.name	= "ehci-platform",
> >  		.pm	= &ehci_platform_pm_ops,
> > -		.of_match_table = vt8500_ehci_ids,
> > +		.of_match_table = ehci_platform_ids,
> >  	}
> >  };
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
