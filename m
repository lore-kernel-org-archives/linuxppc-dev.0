Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id CC2FC2BDA0
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Dec 2004 05:54:18 +1100 (EST)
Date: Mon, 6 Dec 2004 11:54:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Message-ID: <20041206185416.GE7153@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven Hartge <hartge@ds9.gnuu.de>, Meelis Roos <mroos@linux.ee>,
	Christian Kujau <evil@g-house.de>
Subject: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII Utah) PCI
	IRQ map
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PCI IRQ map for the old Motorola PowerStackII (Utah) boards was
incorrect, but this breakage wasn't exposed until 2.5, and finally fixed
until recently by Sebastian Heutling <sheutlin@gmx.de>.

Signed-off-by: Christian Kujau <evil@g-house.de>
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.32/arch/ppc/platforms/prep_pci.c	2004-10-12 14:29:11 -07:00
+++ edited/arch/ppc/platforms/prep_pci.c	2004-12-06 09:20:52 -07:00
@@ -49,10 +49,10 @@
         0,   /* Slot 1  - unused */
         5,   /* Slot 2  - SCSI - NCR825A  */
         0,   /* Slot 3  - unused */
-        1,   /* Slot 4  - Ethernet - DEC2114x */
+        3,   /* Slot 4  - Ethernet - DEC2114x */
         0,   /* Slot 5  - unused */
-        3,   /* Slot 6  - PCI Card slot #1 */
-        4,   /* Slot 7  - PCI Card slot #2 */
+        2,   /* Slot 6  - PCI Card slot #1 */
+        3,   /* Slot 7  - PCI Card slot #2 */
         5,   /* Slot 8  - PCI Card slot #3 */
         5,   /* Slot 9  - PCI Bridge */
              /* added here in case we ever support PCI bridges */

-- 
Tom Rini
http://gate.crashing.org/~trini/
