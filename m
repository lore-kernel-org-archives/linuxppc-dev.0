Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by ozlabs.org (Postfix) with ESMTP id 963F4DE19B
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 04:54:00 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Ira Snyder <iws@ovro.caltech.edu>
Subject: Re: [PATCH RFC v5] net: add PCINet driver
Date: Thu, 15 Jan 2009 18:53:51 +0100
References: <20090107195052.GA24981@ovro.caltech.edu>
	<200901151358.34250.arnd@arndb.de>
	<20090115165359.GA2230@ovro.caltech.edu>
In-Reply-To: <20090115165359.GA2230@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901151853.52202.arnd@arndb.de>
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

On Thursday 15 January 2009, Ira Snyder wrote:
> 
> These are PCI boards, not PCIe. The host computers are all Pentium3-M
> systems. I tried enabling MSI on the Freescale boards in the driver, by
> calling pci_enable_msi() during probe(), and it failed. 

That doesn't really mean anything, just that the PCI endpoint doesn't
announce its capability to do MSI in the config space, or that it
does not have an interrupt line. Since you basically implement the
device on the FSL board, you should also be able to define the interrupt
capabilities by writing to the config space.

Do you know what kind of chipset the host uses? It should be fairly
simple to find out whether or not it can do MSI.

	Arnd <><
