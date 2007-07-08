Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0C24EDE205
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 10:54:18 +1000 (EST)
Subject: Re: [PATCH 1/2] [ide] mmio ide support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20070707210234.6aed88bb@the-village.bc.nu>
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
	<200707071419.52650.arnd@arndb.de>
	<20070707210234.6aed88bb@the-village.bc.nu>
Content-Type: text/plain
Date: Sun, 08 Jul 2007 10:54:08 +1000
Message-Id: <1183856048.3388.246.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-07-07 at 21:02 +0100, Alan Cox wrote:
> > You could also make it an of_platform_driver at the same time
> > instead of adding more cruft to fsl_soc.c. Since we're already
> > about to add the electra_ide.c driver in 2.6.23, I guess there
> > should really be _one_ driver that is able to handle all
> > of_device based ATA hosts.
> 
> and do so using libata. Preferably ata_platform but it does look like
> ata_of would make sense as a companion.

I wouldn't push for it too much tho. It's perfectly fine to have
"helpers" generate xx_platform from the device-tree. Since I added the
generic dev_archdata to struct device, it's easy for the arch to keep
track of OF devices for anything, it doesn't have to be an of_platform
device or anything like that anymore.

One of the things I have in mind is to provide a way to register
"constructors" that are based on an OF match set. Those would then be
called by the arch code for every OF node that matches, and would then
"construct" the appropriate linux device. Could be some kind of platform
device, could even be PCI devs.

Ben.
