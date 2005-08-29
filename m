Return-Path: <sneakums@zork.net>
Received: from frotz.zork.net (frotz.zork.net [70.85.129.199])
	by ozlabs.org (Postfix) with ESMTP id 697AB68135
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Aug 2005 21:13:49 +1000 (EST)
From: Sean Neakums <sneakums@zork.net>
To: Andreas Schwab <schwab@suse.de>
References: <jehdda2tqt.fsf@sykes.suse.de>
Date: Mon, 29 Aug 2005 11:56:15 +0100
In-Reply-To: <jehdda2tqt.fsf@sykes.suse.de> (Andreas Schwab's message of "Sun,
	28 Aug 2005 13:20:10 +0200")
Message-ID: <7wr7cdt3jk.fsf@frotz.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Subject: 2.6.13 PowerBook boot hang (was Re: 2.6.13-rc7-git2 crashes on
	iBook)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab <schwab@suse.de> writes:

> The last change to drivers/pci/setup-res.c (Ignore disabled ROM resources
> at setup) is breaking radeonfb on iBook G3 (with Radeon Mobility M6 LY).
> It crashes in pci_map_rom when called from radeonfb_map_ROM.  This is
> probably a dormant bug that was just uncovered by the change.

2.6.13 hangs on boot on my PowerBook 5.4, reverting the disabled ROM
patch (appended for confirmation) fixes it.  2.6.13-rc7 was fine.


diff-tree 755528c860b05fcecda1c88a2bdaffcb50760a7f (from 26aad69e3dd854abe9028ca873fb40b410a39dd7)
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Fri Aug 26 10:49:22 2005 -0700

    Ignore disabled ROM resources at setup
    
    Writing even a disabled value seems to mess up some matrox graphics
    cards.  It may be a card-related issue, but we may also be writing
    reserved low bits in the result.
    
    This was a fall-out of switching x86 over to the generic PCI resource
    allocation code, and needs more debugging.  In particular, the old x86
    code defaulted to not doing any resource allocations at all for ROM
    resources.
    
    In the meantime, this has been reported to make X happier by Helge
    Hafting <helgehaf@aitel.hist.no>.
    
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -53,7 +53,9 @@ pci_update_resource(struct pci_dev *dev,
 	if (resno < 6) {
 		reg = PCI_BASE_ADDRESS_0 + 4 * resno;
 	} else if (resno == PCI_ROM_RESOURCE) {
-		new |= res->flags & IORESOURCE_ROM_ENABLE;
+		if (!(res->flags & IORESOURCE_ROM_ENABLE))
+			return;
+		new |= PCI_ROM_ADDRESS_ENABLE;
 		reg = dev->rom_base_reg;
 	} else {
 		/* Hmm, non-standard resource. */
