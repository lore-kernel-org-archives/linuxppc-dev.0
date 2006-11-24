Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0A1567BD3
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Nov 2006 08:19:16 +1100 (EST)
Subject: Re: [PATCH 1/2] Fixed compiled issue tu to new of_platform.h header
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <Pine.LNX.4.44L0.0611241557080.16422-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0611241557080.16422-100000@netrider.rowland.org>
Content-Type: text/plain
Date: Sat, 25 Nov 2006 08:19:05 +1100
Message-Id: <1164403145.5653.93.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>, sl@bplan-gmbh.de,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I haven't been following this very closely.  The problem is that you have 
> a system with two different kinds of OHCI controllers, thus requiring two 
> different and incompatible versions of the driver?

Sort-of. Basically, PowerPC can (and must in some case) build a single
kernel image that can be booted on a variety of platforms. There are at
least 3 platforms coming in now (this Efika is one of them) where that
includes a non-PCI OHCI or EHCI (big endian even) while the same kernel
must also contain the normal PCI OHCI/EHCI driver.

It's generally not a problem as the endian thingy is a runtime bit, and
in general, the whole code allows for this just fine, with, afaik, the
exception of the multiple module_init() bits...

> If the only source of incompatibility is the module_init() and 
> module_exit() routines, then your suggestion would be a simple fix.  
> Ugly, yes, but I don't think anyone will really mind.
> 
> Is there anything else to prevent you from combining multiple HCIs into a
> single driver?

Not that I know. But we could have a cleaner approach. The #include one
dates a bit... we could have for example an ohci-core.ko with the core
bits, and ochi-pci.ko, ohci-patform.ko etc... be separate modules linked
on the first and instanciating it.

I'll have a look and will come up with either solution.

Ben.
