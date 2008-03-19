Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6C811DDF15
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 09:43:44 +1100 (EST)
Date: Wed, 19 Mar 2008 17:43:45 -0500
From: Scott Wood <scottwood@freescale.com>
To: Mike Hench <mhench@engagenet.com>
Subject: Re: question about of_platform vs 'platform'
Message-ID: <20080319224345.GA5166@loki.buserror.net>
References: <6629C06B144F5C4098DFF95C4FF9DAF702BA1D37@mailsrv.engagenet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6629C06B144F5C4098DFF95C4FF9DAF702BA1D37@mailsrv.engagenet.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 19, 2008 at 04:49:18PM -0500, Mike Hench wrote:
> bus: 'of_platform': driver_probe_device: matching device e0007000.spi
> with drive
> r fsl-elbc
> bus: 'platform': driver_probe_device: matching device fsl-usb2-udc.0
> with driver
>  mpc83xx_spi
> bus: 'platform': driver_probe_device: matching device mpc83xx_wdt.0 with
> driver
> mpc83xx_spi
> bus: 'platform': driver_probe_device: matching device fsl-i2c.0 with
> driver mpc8
> 3xx_spi
> bus: 'platform': driver_probe_device: matching device fsl-i2c.1 with
> driver mpc8
> 3xx_spi
> bus: 'platform': driver_probe_device: matching device Fixed MDIO bus.0
> with driv
> er mpc83xx_spi
> 
> it seems there is some sort of mismatch
> how did the kernel decide that SPI was an 'of_platform' device.

It will try to match all device nodes under probed buses to an of_platform
device.

> The DTS file spi entry look similar to the i2c entries.
> Those are treated as 'platform' devices.

There is glue code in arch/powerpc/sysdev/fsl_soc.c:of_fsl_spi_probe() to
create platform devices from the device nodes.

It doesn't seem to be registered as an initcall, though -- you need to call
it from platform code.  See mpc832x_rdb.c for an example.

-Scott
