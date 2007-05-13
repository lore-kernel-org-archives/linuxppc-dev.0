Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5CD45DDEC6
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 12:20:24 +1000 (EST)
Subject: Re: [PATCH] pasemi: electra IDE/pata_platform glue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200705130248.22844.arnd@arndb.de>
References: <20070512145041.GA13025@lixom.net>
	<200705130111.03153.arnd@arndb.de>
	<20070513005830.38ba8e3b@the-village.bc.nu>
	<200705130248.22844.arnd@arndb.de>
Content-Type: text/plain
Date: Sun, 13 May 2007 12:20:10 +1000
Message-Id: <1179022810.32247.54.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-05-13 at 02:48 +0200, Arnd Bergmann wrote:
> On Sunday 13 May 2007, Alan Cox wrote:
> > > Why not provide a proper pata_of.c driver based on ata_generic? That
> > > will help the next person that has a builtin ata controller and wants
> > > to get it running as an of_device.
> > 
> > Easier to use pata_platform I would think ? Just create the OF device and
> > bind it to pata_platform.
> 
> Not sure I understand what you mean. pata_platform expects a platform_device,
> which cannot be cast from an of_device.

Note that in the long run, we might have less problem with that sort of
thing.

First, every device now has an OF node optionally attached to it (since
I introduced dev_sysdata). This of_device doesn't really bring much more
than OF type/name/compatible properties based probing.

Then, the plans I have in mind for the future of that stuff are around
the idea of registering "constructors" based on bus matches and device
matches respectively.

The kernel will then walk the whole OF device-tree at boot, and will
instanciate devices using those constructors, passing them the struct
device of whatever was the parent.

Thus we could easily have platforms registers constructors for specific
devices that build a platform device off an OF node. We can have a
generic constructor that builds the PCI devices, etc... and we can have
bus constructors to generate of_device's for things where they are
useful, like plb4/5 on 4xx etc...

On top of that, I want to add some resource management to of_device and
maybe kill things like ebus, vio, etc... device if possible (that is if
the only difference to the base OF device can be resolved at
construction time).

Anyway, still only thoughts but that gives you an idea to where I'm
heading.

Ben.
 
