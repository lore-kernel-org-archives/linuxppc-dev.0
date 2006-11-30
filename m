Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D063E67B8F
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Dec 2006 04:03:57 +1100 (EST)
Date: Thu, 30 Nov 2006 17:10:49 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Olaf Hering <olaf@aepfle.de>, linux-ide@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: Re: pata_sl82c105 can not reserve IO region
Message-ID: <20061130171049.7b80a40c@localhost.localdomain>
In-Reply-To: <20061130165202.GA23205@aepfle.de>
References: <20061130165202.GA23205@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 30 Nov 2006 17:52:02 +0100 (MET)
Olaf Hering <olaf@aepfle.de> wrote:

> 
> pata_sl82c105 can be used on the ppc64 POWER4 system p610, p615 and p630
> for the onboard IDE CD drive. It could be also used for ppc32 Motorola
> PowerStack PReP systems.
> 
> Unfortunately, it doesnt work for me on the p630:
> 
> PCI: Enabling device: (0000:00:03.1), cmd 141
> PCI: Unable to reserve I/O region #6:10@0 for device 0000:00:03.1
> pata_sl82c105: probe of 0000:00:03.1 failed with error -16
> 
> Any idea how to fix it properly?

That looks like a compiler bug.

I/O region #6.

pci_request_regions() and pci_request_selcted_regions() end up in a loop
calling pci_request_region with the values 0 to 5. Never 6.

Can you instrument that code a bit and see wtf is going on first of all.

Alan
