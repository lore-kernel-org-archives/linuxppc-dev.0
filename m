Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4E978DDDE0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Nov 2008 08:54:55 +1100 (EST)
Message-ID: <4919FF29.1080203@freescale.com>
Date: Tue, 11 Nov 2008 15:54:49 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: Using DMA
References: <OFA4A29B19.15508F00-ON882574FE.0075F65A-882574FE.00779C47@selinc.com>
In-Reply-To: <OFA4A29B19.15508F00-ON882574FE.0075F65A-882574FE.00779C47@selinc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bruce_Leonard@selinc.com wrote:

> Yea, that works!  I hit the probe function.  Thanks very much Timur.  I 
> would never have found that.

I'm glad to help.

> Experimentally, I've found that I don't need the "simple-bus" 
> compatibility in the of_device_id array in the Elo DMA driver.  Any idea 
> why?

Not off-hand.

> Thanks again for all the help.  If you've got some time, could you explain 
> why adding the "simple-bus" compatibility to the SOC node of the device 
> tree was needed.  I _still_ (after fighting with them for over a year) 
> don't get device trees.

The 'compatible' field is usually the field used to find a node.  Also, I
believe the OF code only probes nodes one level deep from a node it already
knows about.  So if you don't have a compatible=simple-bus where it belongs,
then the kernel won't automatically probe all nodes under it.

However, certain standard nodes, like I2C and serial ports, are probed
independently of where they are located.  This happens in fsl_soc.c.  I could
have updated fsl_soc.c to automatically probe the DMA nodes as well, but
fsl_soc.c is reserved for devices that have architecture-independent drivers, so
something needs to extract the data from the device tree and put it into
arch-independent platform data structures for the drivers.  Since the DMA driver
is powerpc-only, it doesn't qualify for this service.  The driver has to extract
all the information it needs directly from the device tree.

-- 
Timur Tabi
Linux kernel developer at Freescale
