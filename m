Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3BBF2DDE25
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 17:17:12 +1100 (EST)
Subject: Re: Connecting to "PCI command write" interrupt on 4xx platforms
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200811040619.13820.sr@denx.de>
References: <200810301158.46686.matthias.fuchs@esd-electronics.com>
	<200811031445.00963.matthias.fuchs@esd-electronics.com>
	<1225743554.8004.257.camel@pasglop>  <200811040619.13820.sr@denx.de>
Content-Type: text/plain
Date: Tue, 04 Nov 2008 17:16:43 +1100
Message-Id: <1225779403.8004.263.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-11-04 at 06:19 +0100, Stefan Roese wrote:
> On Monday 03 November 2008, Benjamin Herrenschmidt wrote:
> > > I will try to add endpoint support for PCI as well. I would like to have
> > > a single PCI node and let the device_type attribute decide if we are
> > > running in hostbridge or endpoint mode.
> >
> > Don't use device_type. Do the same we do for PCI-E (whatever it is, I
> > don't have the source code at hand right now).
> 
> It is device_type for PCIe right now, I'm afraid. This was what we agreed 
> upon. Here a code sniplet from the patch:
> 
> 	/* Check if device_type property is set to "pci" or "pci-endpoint".
> 	 * Resulting from this setup this PCIe port will be configured
> 	 * as root-complex or as endpoint.
> 	 */
> 	val = of_get_property(port->node, "device_type", NULL);
> 	if (!strcmp(val, "pci-endpoint")) {
> 		port->endpoint = 1;
> 	} else if (!strcmp(val, "pci")) {
> 		port->endpoint = 0;
> 	} else {
> 		printk(KERN_ERR "PCIE: missing or incorrect device_type for %s\n",
> 		       np->full_name);
> 		return;
> 	}

Allright, that was a bad idea from both of us, David will have my
skin ...

We should try to move toward something like an "endpoint" property and a
"pci-endpoint" name instead.

Ben.
