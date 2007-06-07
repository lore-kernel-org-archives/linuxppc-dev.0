Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 63527DDEE8
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 08:28:17 +1000 (EST)
Date: Thu, 7 Jun 2007 15:29:12 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Randy Vinson <rvinson@mvista.com>
Subject: Re: [PATCH] 85xxCDS: Make sure restart resets the PCI bus.
Message-ID: <20070607222912.GB12076@mag.az.mvista.com>
References: <46686CAF.4030407@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46686CAF.4030407@mvista.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 07, 2007 at 01:38:07PM -0700, Randy Vinson wrote:
> --- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c

> +	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686,
> +					NULL))) {
> +
> +		/* Use the VIA Super Southbridge to force a PCI reset */
> +		pci_read_config_byte(dev, 0x47, &tmp);
> +		pci_write_config_byte(dev, 0x47, tmp | 1);

How about adding another "pci_read_config_byte(dev, 0x47, &tmp);" to
flush the write out of any fifo's and adding a comment that explains
that once that write hits the hardware, the reset is essentially
instantaneous.  IOW, there isn't a race between this reset and the reset
you'd call if/when it falls out of this 'if'.

> +
> +		pci_dev_put(dev);
> +	}
> +
> +	/*
> +	 *  We should only get here if the P2P bridge is disabled. In that
> +	 *  case, just use the default reset.
> +	 */
> +	mpc85xx_restart(NULL);

Mark
