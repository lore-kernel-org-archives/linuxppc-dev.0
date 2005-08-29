Return-Path: <stelian@popies.net>
Received: from placid.alcove-fr (gw.alcove.fr [81.80.245.157])
	by ozlabs.org (Postfix) with ESMTP id 877BD680F7
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Aug 2005 20:58:08 +1000 (EST)
From: Stelian Pop <stelian@popies.net>
To: Alex Williamson <alex.williamson@hp.com>
In-Reply-To: <1125288175.5595.3.camel@localhost.localdomain>
References: <jehdda2tqt.fsf@sykes.suse.de>
	<1125288175.5595.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Mon, 29 Aug 2005 12:39:11 +0200
Message-Id: <1125311951.4662.3.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: Re: 2.6.13-rc7-git2 crashes on iBook
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Le dimanche 28 août 2005 à 22:02 -0600, Alex Williamson a écrit :
> On Sun, 2005-08-28 at 13:20 +0200, Andreas Schwab wrote:
> > The last change to drivers/pci/setup-res.c (Ignore disabled ROM resources
> > at setup) is breaking radeonfb on iBook G3 (with Radeon Mobility M6 LY).
> > It crashes in pci_map_rom when called from radeonfb_map_ROM.  This is
> > probably a dormant bug that was just uncovered by the change.
> 
>    Same thing on Mac Mini.  2.6.13 doesn't boot.  Revert the
> drivers/pci/setup-res.c change from rc7-git2 and it seems ok.

Confirmed on an Apple Powerbook too.

For reference, the (already reverted) patch which needs to be applied is
below.

Signed-off-by: Stelian Pop <stelian@popies.net>

Index: linux-2.6.git/drivers/pci/setup-res.c
===================================================================
--- linux-2.6.git.orig/drivers/pci/setup-res.c	2005-08-29 10:03:00.000000000 +0200
+++ linux-2.6.git/drivers/pci/setup-res.c	2005-08-29 12:23:20.980716336 +0200
@@ -53,9 +53,7 @@
 	if (resno < 6) {
 		reg = PCI_BASE_ADDRESS_0 + 4 * resno;
 	} else if (resno == PCI_ROM_RESOURCE) {
-		if (!(res->flags & IORESOURCE_ROM_ENABLE))
-			return;
-		new |= PCI_ROM_ADDRESS_ENABLE;
+		new |= res->flags & IORESOURCE_ROM_ENABLE;
 		reg = dev->rom_base_reg;
 	} else {
 		/* Hmm, non-standard resource. */

Stelian.
-- 
Stelian Pop <stelian@popies.net>
