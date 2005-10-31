Return-Path: <mgreer@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 8ED276864F
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Nov 2005 06:05:19 +1100 (EST)
Date: Mon, 31 Oct 2005 12:05:24 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051031190524.GE5055@mag.az.mvista.com>
References: <20051025075159.GA10316@localhost.localdomain>
	<17251.265.196352.234376@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17251.265.196352.234376@cargo.ozlabs.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Sven Luther <sl@bplan-gmbh.de>
Subject: Re: [PATCH 2.6.14-rc5 1/1] : mv643xx_eth_pcidev - implements
	hotplug for the marvell gige functionality by probing the
	northbridge pci id.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Oct 29, 2005 at 02:56:41PM +1000, Paul Mackerras wrote:
> Sven Luther writes:
> 
> > +static struct pci_device_id pci_marvell_mv64360[] = {
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_MV64360) },
> 
> Are there other devices in this northbridge whose drivers might also
> want to bind to this PCI id?
> 
> What other devices does this northbridge contain?

It does have a PIC, DMA engine, and SRAM that Sven mentioned but there
are also a serial controller (MPSC), an i2c controller, and a watchdog
timer.  I would guess that the MPSC and i2c drivers, at least, should
use MODULE_DEVICE_TABLE.  If you agree, I'll add it to the list.

Mark
