Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LV9m2MCmzDqwG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 13:38:04 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>, ruscur@russell.cc,
 sam.bobroff@au1.ibm.com
Subject: [PATCH] powerpc/eeh: Fix enabling bridge MMIO windows
Date: Wed, 11 Apr 2018 13:37:58 +1000
Message-Id: <20180411033758.20794-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On boot we save the configuration space of PCIe bridges. We do this so
when we get an EEH event and everything gets reset that we can restore
them.

Unfortunately we save this state before we've enabled the MMIO space
on the bridges. Hence if we have to reset the bridge when we come back
MMIO is not enabled and we end up taking an PE freeze when the driver
starts accessing again.

This patch forces the memory/MMIO and bus mastering on when restoring
bridges on EEH. Ideally we'd do this correctly by saving the
configuration space writes later, but that will have to come later in
a larger EEH rewrite. For now we have this simple fix.

The original bug can be triggered on a boston machine by doing:
  echo 0x8000000000000000 > /sys/kernel/debug/powerpc/PCI0001/err_injct_outbound
On boston, this PHB has a PCIe switch on it.  Without this patch,
you'll see two EEH events, 1 expected and 1 the failure we are fixing
here. The second EEH event causes the anything under the PHB to
disappear (i.e. the i40e eth).

With this patch, only 1 EEH event occurs and devices properly recover.

Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: stable@vger.kernel.org
---
 arch/powerpc/kernel/eeh_pe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 2d4956e97a..ee5a67d57a 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -807,7 +807,8 @@ static void eeh_restore_bridge_bars(struct eeh_dev *edev)
 	eeh_ops->write_config(pdn, 15*4, 4, edev->config_space[15]);
 
 	/* PCI Command: 0x4 */
-	eeh_ops->write_config(pdn, PCI_COMMAND, 4, edev->config_space[1]);
+	eeh_ops->write_config(pdn, PCI_COMMAND, 4, edev->config_space[1] |
+			      PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
 
 	/* Check the PCIe link is ready */
 	eeh_bridge_check_link(edev);
-- 
2.14.1
