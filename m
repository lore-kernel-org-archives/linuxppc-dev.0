Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A21DD1A2931
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 10:48:29 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 70E111400A0
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 10:48:29 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 14 Nov 2014 09:48:29 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 40FD43578048
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 10:48:28 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sADNoFXD40239342
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 10:50:23 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sADNltcL025069
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 10:47:55 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpc/eeh: Set EEH_PE_RESET on PE reset
Date: Fri, 14 Nov 2014 10:47:29 +1100
Message-Id: <1415922450-29581-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1415922450-29581-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1415922450-29581-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch introduces additional flag EEH_PE_RESET to indicate the
corresponding PE is under reset. In turn, the PE retrieval bakcend
on PowerNV platform can return unfrozen state for the EEH core to
moving forward. Flag EEH_PE_CFG_BLOCKED isn't the correct one for
the purpose.

In PCI passthrou case, the problem is more worse: Guest doesn't
recover 6th EEH error. The PE is left in isolated (frozen) and
config blocked state on Broadcom adapters. We can't retrieve the
PE's state correctly any more, even from the host side via sysfs
/sys/bus/pci/devices/xxx/eeh_pe_state.

Reported-by: Rajeshkumar Subramanian <rajeshkumars@in.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h            |  1 +
 arch/powerpc/kernel/eeh.c                 |  4 ++++
 arch/powerpc/kernel/eeh_driver.c          | 10 ++--------
 arch/powerpc/platforms/powernv/eeh-ioda.c |  2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index ca07f9c..2e633b4 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -72,6 +72,7 @@ struct device_node;
 #define EEH_PE_ISOLATED		(1 << 0)	/* Isolated PE		*/
 #define EEH_PE_RECOVERING	(1 << 1)	/* Recovering PE	*/
 #define EEH_PE_CFG_BLOCKED	(1 << 2)	/* Block config access	*/
+#define EEH_PE_RESET		(1 << 3)	/* PE reset in progress */
 
 #define EEH_PE_KEEP		(1 << 8)	/* Keep PE on hotplug	*/
 #define EEH_PE_CFG_RESTRICTED	(1 << 9)	/* Block config on error */
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 967e4a0..b372bfd 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -760,6 +760,9 @@ int eeh_reset_pe(struct eeh_pe *pe)
 	int flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
 	int i, state, ret;
 
+	/* Mark as reset and block config space */
+	eeh_pe_state_mark(pe, EEH_PE_RESET | EEH_PE_CFG_BLOCKED);
+
 	/* Take three shots at resetting the bus */
 	for (i = 0; i < 3; i++) {
 		eeh_reset_pe_once(pe);
@@ -788,6 +791,7 @@ int eeh_reset_pe(struct eeh_pe *pe)
 	}
 
 out:
+	eeh_pe_state_clear(pe, EEH_PE_RESET | EEH_PE_CFG_BLOCKED);
 	return ret;
 }
 
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 6535936..b17e793 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -528,13 +528,11 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
 	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
 
 	/* Issue reset */
-	eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
 	ret = eeh_reset_pe(pe);
 	if (ret) {
-		eeh_pe_state_clear(pe, EEH_PE_RECOVERING | EEH_PE_CFG_BLOCKED);
+		eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
 		return ret;
 	}
-	eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
 
 	/* Unfreeze the PE */
 	ret = eeh_clear_pe_frozen_state(pe, true);
@@ -601,19 +599,15 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	 * config accesses. So we prefer to block them. However, controlled
 	 * PCI config accesses initiated from EEH itself are allowed.
 	 */
-	eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
 	rc = eeh_reset_pe(pe);
-	if (rc) {
-		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
+	if (rc)
 		return rc;
-	}
 
 	pci_lock_rescan_remove();
 
 	/* Restore PE */
 	eeh_ops->configure_bridge(pe);
 	eeh_pe_restore_bars(pe);
-	eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
 
 	/* Clear frozen state */
 	rc = eeh_clear_pe_frozen_state(pe, false);
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index eba9cb1..426814a 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -373,7 +373,7 @@ static int ioda_eeh_get_pe_state(struct eeh_pe *pe)
 	 * moving forward, we have to return operational
 	 * state during PE reset.
 	 */
-	if (pe->state & EEH_PE_CFG_BLOCKED) {
+	if (pe->state & EEH_PE_RESET) {
 		result = (EEH_STATE_MMIO_ACTIVE  |
 			  EEH_STATE_DMA_ACTIVE   |
 			  EEH_STATE_MMIO_ENABLED |
-- 
1.8.3.2
