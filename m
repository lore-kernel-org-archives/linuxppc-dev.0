Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3874D2C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Mar 2014 14:26:50 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sun, 2 Mar 2014 22:26:46 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 744CB6E803C
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Mar 2014 22:26:39 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s233Qis76684940
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Mar 2014 03:26:44 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s233Qiia010818
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Mar 2014 22:26:44 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/eeh: More reliability of PCI dev reset
Date: Mon,  3 Mar 2014 11:26:31 +0800
Message-Id: <1393817192-14271-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PCI core has function pci_reset_function() to do reset on the
specified PCI device. Before the reset starts, the sate of the PCI
device is saved and it is restored after reset. The real reset work
could be routed to pcibios_set_pcie_reset_state() by quirks. However,
the PCI bus or PCI device isn't settled down fully for restore (PCI
config and MMIO for MSIx table) after reset and it would introduce
unnecessary frozen PE. One of the observed cases is failure of passing
IPR adapter from host to KVM-based guest because of this.

The patch adds delay in pcibios_set_pcie_reset_state() so that the
PCI bus/device can settle down fully before restoring PCI device
states. The patch also does cleanup on the names of those macros for
PE reset hold and settle time.

CC: <stable@vger.kernel.org>
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index e7b76a6..251e370 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -84,8 +84,10 @@
  */
 #define EEH_MAX_FAILS	2100000
 
-/* Time to wait for a PCI slot to report status, in milliseconds */
-#define PCI_BUS_RESET_WAIT_MSEC (5*60*1000)
+/* All in milliseconds */
+#define EEH_PE_STATUS_WAIT_TIME		(5 * 60 * 1000)
+#define EEH_PE_RESET_HOLD_TIME		250
+#define EEH_PE_RESET_SETTLE_TIME	1800
 
 /* Platform dependent EEH operations */
 struct eeh_ops *eeh_ops = NULL;
@@ -522,7 +524,7 @@ int eeh_pci_enable(struct eeh_pe *pe, int function)
 		pr_warning("%s: Unexpected state change %d on PHB#%d-PE#%x, err=%d\n",
 			__func__, function, pe->phb->global_number, pe->addr, rc);
 
-	rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
+	rc = eeh_ops->wait_state(pe, EEH_PE_STATUS_WAIT_TIME);
 	if (rc > 0 && (rc & EEH_STATE_MMIO_ENABLED) &&
 	   (function == EEH_OPT_THAW_MMIO))
 		return 0;
@@ -552,12 +554,15 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 	switch (state) {
 	case pcie_deassert_reset:
 		eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
+		msleep(EEH_PE_RESET_HOLD_TIME);
 		break;
 	case pcie_hot_reset:
 		eeh_ops->reset(pe, EEH_RESET_HOT);
+		msleep(EEH_PE_RESET_HOLD_TIME);
 		break;
 	case pcie_warm_reset:
 		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
+		msleep(EEH_PE_RESET_SETTLE_TIME);
 		break;
 	default:
 		return -EINVAL;
@@ -615,8 +620,7 @@ static void eeh_reset_pe_once(struct eeh_pe *pe)
 	/* The PCI bus requires that the reset be held high for at least
 	 * a 100 milliseconds. We wait a bit longer 'just in case'.
 	 */
-#define PCI_BUS_RST_HOLD_TIME_MSEC 250
-	msleep(PCI_BUS_RST_HOLD_TIME_MSEC);
+	msleep(EEH_PE_RESET_HOLD_TIME);
 
 	/* We might get hit with another EEH freeze as soon as the
 	 * pci slot reset line is dropped. Make sure we don't miss
@@ -630,8 +634,7 @@ static void eeh_reset_pe_once(struct eeh_pe *pe)
 	 * a 1.5 second idle time for the bus to stabilize, before starting
 	 * up traffic.
 	 */
-#define PCI_BUS_SETTLE_TIME_MSEC 1800
-	msleep(PCI_BUS_SETTLE_TIME_MSEC);
+	msleep(EEH_PE_RESET_SETTLE_TIME);
 }
 
 /**
@@ -651,7 +654,7 @@ int eeh_reset_pe(struct eeh_pe *pe)
 	for (i=0; i<3; i++) {
 		eeh_reset_pe_once(pe);
 
-		rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
+		rc = eeh_ops->wait_state(pe, EEH_PE_STATUS_WAIT_TIME);
 		if ((rc & flags) == flags)
 			return 0;
 
-- 
1.7.10.4
