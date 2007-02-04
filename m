Return-Path: <proski@gnu.org>
Received: from fencepost.gnu.org (fencepost.gnu.org [199.232.76.164])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 245D2DDE45
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Feb 2007 19:16:14 +1100 (EST)
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>) id 1HDcWe-0002iT-Eq
	for linuxppc-dev@ozlabs.org; Sun, 04 Feb 2007 03:15:04 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>) id 1HDcXg-0007tH-6q
	for linuxppc-dev@ozlabs.org; Sun, 04 Feb 2007 03:16:08 -0500
Subject: [PATCH] Assign all PCI busses on G3 Blue & White
From: Pavel Roskin <proski@gnu.org>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Sun, 04 Feb 2007 03:16:08 -0500
Message-Id: <1170576968.21644.55.camel@dv>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Pavel Roskin <proski@gnu.org>

G3 Blue & White is misconfigured by default so that CardBus controllers
in PCI slots don't work.  The PCI bridge is programmed to only allow
access to bus 1 but not higher busses.

The patch forces the PCI busses to be reassigned if a Grackle controller
is found and the machine identifies itself as "PowerMac1,1"

Signed-off-by: Pavel Roskin <proski@gnu.org>
---
My previous attempt to fix this bug can be found in this thread:
http://ozlabs.org/pipermail/linuxppc-dev/2004-May/thread.html#17056
The new patch relies on the existing common PCI code and doesn't poke
bridge registers itself.  It would even do the right thing if a PCI or
CardBus bridge is inserted into the upper slot reserved for video cards
and connected directly to bus 0.
---

 arch/powerpc/sysdev/grackle.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/grackle.c b/arch/powerpc/sysdev/grackle.c
index b6ec793..4205362 100644
--- a/arch/powerpc/sysdev/grackle.c
+++ b/arch/powerpc/sysdev/grackle.c
@@ -56,6 +56,8 @@ static inline void grackle_set_loop_snoop(struct pci_controller *bp, int enable)
 void __init setup_grackle(struct pci_controller *hose)
 {
 	setup_indirect_pci(hose, 0xfec00000, 0xfee00000);
+	if (machine_is_compatible("PowerMac1,1"))
+		pci_assign_all_buses = 1;
 	if (machine_is_compatible("AAPL,PowerBook1998"))
 		grackle_set_loop_snoop(hose, 1);
 #if 0	/* Disabled for now, HW problems ??? */


-- 
Regards,
Pavel Roskin
