Return-Path: <sven.luther@wanadoo.fr>
Received: from LAubervilliers-151-12-84-108.w193-252.abo.wanadoo.fr.
	(LNeuilly-152-23-83-57.w217-128.abo.wanadoo.fr [217.128.214.57])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D90E567B22
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Dec 2006 19:58:36 +1100 (EST)
Date: Sun, 3 Dec 2006 09:23:03 +0100
From: Sven Luther <sven@genesi-usa.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Fixed compiled issue tu to new of_platform.h header
Message-ID: <20061203082303.GA9129@powerlinux.fr>
References: <Pine.LNX.4.44L0.0611241557080.16422-100000@netrider.rowland.org>
	<1164403145.5653.93.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1164403145.5653.93.camel@localhost.localdomain>
Cc: linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>,
	sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>, sven@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Nov 25, 2006 at 08:19:05AM +1100, Benjamin Herrenschmidt wrote:
> 
> > I haven't been following this very closely.  The problem is that you have 
> > a system with two different kinds of OHCI controllers, thus requiring two 
> > different and incompatible versions of the driver?
> 
> Sort-of. Basically, PowerPC can (and must in some case) build a single
> kernel image that can be booted on a variety of platforms. There are at
> least 3 platforms coming in now (this Efika is one of them) where that
> includes a non-PCI OHCI or EHCI (big endian even) while the same kernel
> must also contain the normal PCI OHCI/EHCI driver.
> 
> It's generally not a problem as the endian thingy is a runtime bit, and
> in general, the whole code allows for this just fine, with, afaik, the
> exception of the multiple module_init() bits...
> 
> > If the only source of incompatibility is the module_init() and 
> > module_exit() routines, then your suggestion would be a simple fix.  
> > Ugly, yes, but I don't think anyone will really mind.
> > 
> > Is there anything else to prevent you from combining multiple HCIs into a
> > single driver?
> 
> Not that I know. But we could have a cleaner approach. The #include one
> dates a bit... we could have for example an ohci-core.ko with the core
> bits, and ochi-pci.ko, ohci-patform.ko etc... be separate modules linked
> on the first and instanciating it.
> 
> I'll have a look and will come up with either solution.

Hi, ...

I am just wondering if i got dropped from the CCs or if there was no further
discussion on this.

The 2.6.19 kernel doesn't build when the efika patches are applied and the
ohci modules are built. We need a solution for this. Even disabling the patch
for ohci fails to build the ohci driver, but this could be a bad manipulation.

Is there any hint on the right way to go for this ? 

Friendly,

Sven Luther
