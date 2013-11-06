Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:2:6])
 by ozlabs.org (Postfix) with ESMTP id C79192C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 14:49:57 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/7] IBM Akebono: Add support to the EHCI platform driver
 for Akebono
Date: Wed, 06 Nov 2013 14:50:28 +1100
Message-ID: <2440701.siW6M1PPWz@mexican>
In-Reply-To: <1383681133.4776.95.camel@pasglop>
References: <Pine.LNX.4.44L0.1311051004080.1360-100000@iolanthe.rowland.org>
 <1383681133.4776.95.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 6 Nov 2013 06:52:13 Benjamin Herrenschmidt wrote:

[snip]

> 
> Why ? Do we need to add an entry for every platform in there ? Besides,
> it probably should be the SoC name not the platform here....
> 
> Why not simply a generic compatible "usb-ehci" ? It's a standard
> programming interface, there are no specific quirks, we shouldn't
> need to have to add new entries to the driver like that for every
> new SoC/platform.
> 

Actually a grep of "usb-ehci" turns up the ehci-ppc-of driver which I somehow 
missed. This driver works and uses .compatible = "usb-ehci" so I can use that 
instead if that is preferable?

However it is basically the same as the ehci-platform driver so I guess at 
some point the two should be merged...

> > > @@ -229,7 +230,7 @@ static struct platform_driver ehci_platform_driver =
> > > {
> > > 
> > >  		.owner	= THIS_MODULE,
> > >  		.name	= "ehci-platform",
> > >  		.pm	= &ehci_platform_pm_ops,
> > > 
> > > -		.of_match_table = vt8500_ehci_ids,
> > > +		.of_match_table = ehci_platform_ids,
> > > 
> > >  	}
> > >  
> > >  };
> > 
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
