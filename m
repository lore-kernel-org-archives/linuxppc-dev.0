Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 35943DDDF8
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 22:18:09 +1100 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: benh@kernel.crashing.org
Subject: Re: Connecting to "PCI command write" interrupt on 4xx platforms
Date: Tue, 4 Nov 2008 12:17:04 +0100
References: <200810301158.46686.matthias.fuchs@esd-electronics.com>
	<200811040619.13820.sr@denx.de> <1225779403.8004.263.camel@pasglop>
In-Reply-To: <1225779403.8004.263.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200811041217.04961.matthias.fuchs@esd-electronics.com>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 04 November 2008 07:16, Benjamin Herrenschmidt wrote:
> > It is device_type for PCIe right now, I'm afraid. This was what we agreed 
> > upon. Here a code sniplet from the patch:
> > 
> > 	/* Check if device_type property is set to "pci" or "pci-endpoint".
> > 	 * Resulting from this setup this PCIe port will be configured
> > 	 * as root-complex or as endpoint.
> > 	 */
> > 	val = of_get_property(port->node, "device_type", NULL);
> > 	if (!strcmp(val, "pci-endpoint")) {
> > 		port->endpoint = 1;
> > 	} else if (!strcmp(val, "pci")) {
> > 		port->endpoint = 0;
> > 	} else {
> > 		printk(KERN_ERR "PCIE: missing or incorrect device_type for %s\n",
> > 		       np->full_name);
> > 		return;
> > 	}
> 
> Allright, that was a bad idea from both of us, David will have my
> skin ...
> 
> We should try to move toward something like an "endpoint" property and a
> "pci-endpoint" name instead.
I must admit that I am not sure what you mean by (pci-endpoint) _name_.
Do you mean something like this:
 
        PCI: pci@abc {
                endpoint = "pci-endpoint";
                ...

To many "endpoint" appearances for my taste:-)

Matthias
