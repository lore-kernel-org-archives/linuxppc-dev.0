Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 50812DE29C
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 03:54:03 +1100 (EST)
Date: Thu, 15 Jan 2009 08:54:00 -0800
From: Ira Snyder <iws@ovro.caltech.edu>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC v5] net: add PCINet driver
Message-ID: <20090115165359.GA2230@ovro.caltech.edu>
References: <20090107195052.GA24981@ovro.caltech.edu>
	<200901131842.54688.arnd@arndb.de>
	<20090115001251.GA10745@ovro.caltech.edu>
	<200901151358.34250.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200901151358.34250.arnd@arndb.de>
Cc: netdev@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	shemminger@vyatta.com, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 15, 2009 at 01:58:33PM +0100, Arnd Bergmann wrote:
> On Thursday 15 January 2009, Ira Snyder wrote:
> 
> > The only problem with that is that you cannot route interrupts from the
> > DMA controller over PCI with the PowerPC core running. Which makes it
> > mostly useless for this case.
> 
> If the host supports MSI, you can simply program the DMA controller to
> write the correct message to the inbound address of the MSI interrupt
> controller!
> 
> All modern host systems should have MSI, as this is required by the
> PCIe specification, but it still somewhat limits the choice of your
> hosts.
> 

These are PCI boards, not PCIe. The host computers are all Pentium3-M
systems. I tried enabling MSI on the Freescale boards in the driver, by
calling pci_enable_msi() during probe(), and it failed. I'm pretty sure
I can't do MSI.

I'll keep thinking about how to manage the DMA. Feel free to toss around
any ideas you have, though.

Ira
