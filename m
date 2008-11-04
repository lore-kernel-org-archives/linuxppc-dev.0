Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 387B8DDDE3
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 16:19:25 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
 benh@kernel.crashing.org
Subject: Re: Connecting to "PCI command write" interrupt on 4xx platforms
Date: Tue, 4 Nov 2008 06:19:13 +0100
References: <200810301158.46686.matthias.fuchs@esd-electronics.com>
	<200811031445.00963.matthias.fuchs@esd-electronics.com>
	<1225743554.8004.257.camel@pasglop>
In-Reply-To: <1225743554.8004.257.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811040619.13820.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 03 November 2008, Benjamin Herrenschmidt wrote:
> > I will try to add endpoint support for PCI as well. I would like to have
> > a single PCI node and let the device_type attribute decide if we are
> > running in hostbridge or endpoint mode.
>
> Don't use device_type. Do the same we do for PCI-E (whatever it is, I
> don't have the source code at hand right now).

It is device_type for PCIe right now, I'm afraid. This was what we agreed 
upon. Here a code sniplet from the patch:

	/* Check if device_type property is set to "pci" or "pci-endpoint".
	 * Resulting from this setup this PCIe port will be configured
	 * as root-complex or as endpoint.
	 */
	val = of_get_property(port->node, "device_type", NULL);
	if (!strcmp(val, "pci-endpoint")) {
		port->endpoint = 1;
	} else if (!strcmp(val, "pci")) {
		port->endpoint = 0;
	} else {
		printk(KERN_ERR "PCIE: missing or incorrect device_type for %s\n",
		       np->full_name);
		return;
	}

Best regards,
Stefan
