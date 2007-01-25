Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E0E7DDFDE
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 14:46:32 +1100 (EST)
Subject: Re: [PATCH] driver/ata: PATA driver	for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <45B805E1.1030906@garzik.org>
References: <200701170924.l0H9OsdG002754@harpo.it.uu.se>
	<45AE539E.2040600@garzik.org>
	<17838.34747.222649.93821@alkaid.it.uu.se>
	<200701180055.l0I0tl6M021051@toshiba.co.jp>
	<200701180129.l0I1TL48013407@toshiba.co.jp>
	<45B805E1.1030906@garzik.org>
Content-Type: text/plain
Date: Thu, 25 Jan 2007 14:45:23 +1100
Message-Id: <1169696724.24996.45.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Mikael Pettersson <mikpe@it.uu.se>, arnd@arndb.de, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, paulus@samba.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-01-24 at 20:20 -0500, Jeff Garzik wrote:
> Akira Iguchi wrote:
> > This is the patch for PATA controller of Celleb.
> > It depends on the previous "add another IRQ calls" patch.
> > 
> > Because this driver needs special taskfile accesses, there is
> > a copy of ata_std_softreset(). ata_dev_try_classify() is exported
> > so that it can be used in this function.
> > 
> > Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> > Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
> 
> The driver looks OK, the only thing I wonder is:  can you use the iomap 
> interface to eliminate the rest of the duplicated code?
> 
> See Tejun's latest patchset "[PATCHSET] Managed device resources, take 
> #3" which completes the conversion of libata to using the lib/iomap.c 
> interface.

That would be a bit nasty :-) The powerpc kernel can have any number of
platforms compiled into the same kernel. Some of the base things, like
PCI IOs, iomap, etc... are common to all platforms. In this case, what
they want is hook only accesses on one given device, one one given
platform (or rather, on all platforms using that device, which is even
worse, it's not even platform specific, at least not in theory).

While we do now provide a mecanism to add hooks to all PCI MMIO and IO
accessors (to workaround HW bugs on some chipsets), again, it would be a
a serious abuse to have a driver hook on that to change the access
method on a given device :-)

How much copied code remains ? I wonder if the accesses to nsect/lba for
example can be done using the taskfile accessors, possibly with a new
flag indicating to only read/write those 2 registers ?

Ben.
