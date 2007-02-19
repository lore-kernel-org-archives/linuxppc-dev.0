Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8AE54DDF25
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 08:26:32 +1100 (EST)
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20070219215659.15539fb3@localhost.localdomain>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<200702151141.49708.jens@de.ibm.com>
	<20070215171414.GU923@austin.ibm.com>
	<200702151909.26082.arnd@arndb.de>
	<20070219215659.15539fb3@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 08:21:21 +1100
Message-Id: <1171920081.18571.77.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>,
	James K Lewis <jim@jklewis.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-19 at 21:56 +0000, Alan wrote:
> > I fear that the hardest part is yet to come, when we integrate the
> > driver for the the PS3 (currently called gelic_net) into spidernet.
> > The trouble is that the hardware is sufficiently similar to share
> > all the high-level mechanisms like the DMA data structures and
> > descriptor chains, but the low-level mechanisms are hidden in the
> > hypervisor on the PS3. Someone will have to invest a significant
> > amount of time coordinating this so we don't break celleb and qs20
> > in the process.
> 
> That to me implies they should be different drivers using a common
> libata-something file. The PPC mac drivers likewise are currently mashed
> into one in drivers/ide but really want splitting for libata with some
> kind of libata-pmac owning the shared stuff

You meand driver/ide/ppc/pmac.c ?

This driver is really for one family of IP blocks, the apple ones. They
have the same DMA engine and same taskfile register layout, they only
differ in the timning register format & timing abilities.

However, they also differ in probing mecanism because Apple has been
moving them out of the macio_asic to a PCI device at one point, so yes,
maybe you are right, I should move the DMA bits to some "common" file
and split the various implementations.

Ben.
