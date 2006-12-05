Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 908CC67B6F
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 08:21:37 +1100 (EST)
Subject: Re: What is the correct way to indicate an unassigned PCI resource ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20061205081557.GA8483@aepfle.de>
References: <20061130165202.GA23205@aepfle.de>
	<20061204123854.GA28159@aepfle.de>
	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
	<4574197A.2020204@ru.mvista.com>
	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
	<45741DDE.4080509@ru.mvista.com>
	<20061204132124.4f7c50a9@localhost.localdomain>
	<45742253.1000807@ru.mvista.com>
	<20061204142201.68d9621f@localhost.localdomain>
	<1165293679.29784.39.camel@localhost.localdomain>
	<20061205081557.GA8483@aepfle.de>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 07:19:01 +1100
Message-Id: <1165349941.5469.1.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, greg@kroah.com, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-12-05 at 09:15 +0100, Olaf Hering wrote:
> On Tue, Dec 05, Benjamin Herrenschmidt wrote:
> 
> > Olaf, can you give me a dump of /proc/ioports ? What is sitting at 0 on
> > that PCI bus ?
> 
> with IDE=y
> 
> ==> /proc/ioports <==
> 00000000-0000001f : dma1

So it's indeed colliding with the cruft above.

I reckon it's a bug in the firmware of this machine.

Add to pseries/pci.c a quirk for that chipset (don't forget to test for
machine_is(pseries) in the quirk as they get called for all platforms in
a combo kernel. The quirk shall check if resource 6 has a 0 base and
clear the size as Alan suggested (possibly setting the UNSET flag as
well).

Ben.
