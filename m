Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 605C8DE273
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 06:21:32 +1100 (EST)
Date: Thu, 15 Jan 2009 11:21:29 -0800
From: Ira Snyder <iws@ovro.caltech.edu>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC v5] net: add PCINet driver
Message-ID: <20090115192129.GB9091@ovro.caltech.edu>
References: <20090107195052.GA24981@ovro.caltech.edu>
	<200901151358.34250.arnd@arndb.de>
	<20090115165359.GA2230@ovro.caltech.edu>
	<200901151853.52202.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200901151853.52202.arnd@arndb.de>
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

On Thu, Jan 15, 2009 at 06:53:51PM +0100, Arnd Bergmann wrote:
> On Thursday 15 January 2009, Ira Snyder wrote:
> > 
> > These are PCI boards, not PCIe. The host computers are all Pentium3-M
> > systems. I tried enabling MSI on the Freescale boards in the driver, by
> > calling pci_enable_msi() during probe(), and it failed. 
> 
> That doesn't really mean anything, just that the PCI endpoint doesn't
> announce its capability to do MSI in the config space, or that it
> does not have an interrupt line. Since you basically implement the
> device on the FSL board, you should also be able to define the interrupt
> capabilities by writing to the config space.
> 
> Do you know what kind of chipset the host uses? It should be fairly
> simple to find out whether or not it can do MSI.
> 

I have another question for you Arnd.

What did you use as the host and guest drivers when you ran virtio over
PCI? Did you use two unmodified instances of virtio_net (one on host,
one on guest) for networking, or did you write new virtio drivers for
those? How about for virtio_console (if you ran it at all).

Thanks again,
Ira
