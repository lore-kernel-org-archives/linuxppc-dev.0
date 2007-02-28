Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B6FBCDDE47
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Mar 2007 09:03:31 +1100 (EST)
In-Reply-To: <45E5ED35.7090207@gmail.com>
References: <45E5ED35.7090207@gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0a1927a91e52d34352e8a545b7dc57d0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: problems with pci bus on a pm520 board
Date: Wed, 28 Feb 2007 23:03:24 +0100
To: Luotao Fu <devtty0@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 11.* is the usb controller

Three OHCIs or is one an EHCI?

> However, if I compile the usb driver in and try to
> boot. The system stucks somewhere at ohci_init or ohci_run without 
> doing
> anything till I switch the power off. I attached a bdi to the system 
> and
> found out that the system always stucks at the instruction lwbrx, which
> is called by ohci_readl().

32-bit PCI read I suppose.  Use the BDI to figure out what
address is accessed, and what source code corresponds to
this access.

> Seemed that the usb driver failed to acces
> some mapped io memory address somehow.

Yeah.

> The funny thing is that the e100
> driver also does some reading calls on iomem in the initialisation, 
> such
> as readb() in e100_eeprom_read(). It however doesn't cause system
> freezing and the driver quits with an error message that the eeprom is
> corrupted. I suppose the problem is somehow still on the pci
> configuration in the device tree.

Linux normally is perfectly happy if you leave out all of
the PCI devices from your device tree (except the root
bridges of course).

> Hence I suppose the file is still not OK. Anybody could help me with an
> idea where I still could look for or give me some detailed information
> on the format of device tree?

Sure, post it.

> Along with this mail I attached my dts file.

No you didn't.


Segher
