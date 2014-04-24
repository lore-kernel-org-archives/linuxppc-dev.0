Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B7F9B140181
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:33 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:33 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 94ACD2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:31 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7dSNP6226290
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:39:28 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80UOB004263
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:30 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 17/25] powerpc/eeh: Make the delay for PE reset unified
Date: Thu, 24 Apr 2014 18:00:23 +1000
Message-Id: <1398326431-24305-18-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Basically, we have 3 types of resets to fulfil PE reset: fundamental,
hot and PHB reset. For the later 2 cases, we need PCI bus reset hold
and settlement delay as specified by PCI spec. PowerNV and pSeries
platforms are running on top of different firmware and some of the
delays have been covered by underly firmware (PowerNV).

The patch makes the delays unified to be done in backend, instead of
EEH core.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               | 10 ++++++++++
 arch/powerpc/kernel/eeh.c                    | 13 -------------
 arch/powerpc/platforms/powernv/eeh-ioda.c    | 12 +++++++++++-
 arch/powerpc/platforms/pseries/eeh_pseries.c | 10 +++++++++-
 4 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 2841eca..b76f58c 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -39,6 +39,16 @@ struct device_node;
 #define EEH_PROBE_MODE_DEVTREE	0x8	/* From device tree	*/
 
 /*
+ * Delay for PE reset, all in ms
+ *
+ * PCI specification has reset hold time of 100 milliseconds.
+ * We have 250 milliseconds here. The PCI bus settlement time
+ * is specified as 1.5 seconds and we have 1.8 seconds.
+ */
+#define EEH_PE_RST_HOLD_TIME		250
+#define EEH_PE_RST_SETTLE_TIME		1800
+
+/*
  * The struct is used to trace PE related EEH functionality.
  * In theory, there will have one instance of the struct to
  * be created against particular PE. In nature, PEs corelate
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 1e409a2..3764fb7 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -639,20 +639,7 @@ static void eeh_reset_pe_once(struct eeh_pe *pe)
 	else
 		eeh_ops->reset(pe, EEH_RESET_HOT);
 
-	/* The PCI bus requires that the reset be held high for at least
-	 * a 100 milliseconds. We wait a bit longer 'just in case'.
-	 */
-#define PCI_BUS_RST_HOLD_TIME_MSEC 250
-	msleep(PCI_BUS_RST_HOLD_TIME_MSEC);
-
 	eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
-
-	/* After a PCI slot has been reset, the PCI Express spec requires
-	 * a 1.5 second idle time for the bus to stabilize, before starting
-	 * up traffic.
-	 */
-#define PCI_BUS_SETTLE_TIME_MSEC 1800
-	msleep(PCI_BUS_SETTLE_TIME_MSEC);
 }
 
 /**
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 0844e00..268cd46 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -417,9 +417,13 @@ static int ioda_eeh_phb_reset(struct pci_controller *hose, int option)
 
 	/*
 	 * Poll state of the PHB until the request is done
-	 * successfully.
+	 * successfully. The PHB reset is usually PHB complete
+	 * reset followed by hot reset on root bus. So we also
+	 * need the PCI bus settlement delay.
 	 */
 	rc = ioda_eeh_phb_poll(phb);
+	if (option == EEH_RESET_DEACTIVATE)
+		msleep(EEH_PE_RST_SETTLE_TIME);
 out:
 	if (rc != OPAL_SUCCESS)
 		return -EIO;
@@ -457,6 +461,8 @@ static int ioda_eeh_root_reset(struct pci_controller *hose, int option)
 
 	/* Poll state of the PHB until the request is done */
 	rc = ioda_eeh_phb_poll(phb);
+	if (option == EEH_RESET_DEACTIVATE)
+		msleep(EEH_PE_RST_SETTLE_TIME);
 out:
 	if (rc != OPAL_SUCCESS)
 		return -EIO;
@@ -480,11 +486,15 @@ static int ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
 		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &ctrl);
 		ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
 		eeh_ops->write_config(dn, PCI_BRIDGE_CONTROL, 2, ctrl);
+
+		msleep(EEH_PE_RST_HOLD_TIME);
 		break;
 	case EEH_RESET_DEACTIVATE:
 		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &ctrl);
 		ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
 		eeh_ops->write_config(dn, PCI_BRIDGE_CONTROL, 2, ctrl);
+
+		msleep(EEH_PE_RST_SETTLE_TIME);
 		break;
 	}
 
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 2f1ba64..0bec0c0 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -532,11 +532,19 @@ static int pseries_eeh_reset(struct eeh_pe *pe, int option)
 	/* If fundamental-reset not supported, try hot-reset */
 	if (option == EEH_RESET_FUNDAMENTAL &&
 	    ret == -8) {
+		option = EEH_RESET_HOT;
 		ret = rtas_call(ibm_set_slot_reset, 4, 1, NULL,
 				config_addr, BUID_HI(pe->phb->buid),
-				BUID_LO(pe->phb->buid), EEH_RESET_HOT);
+				BUID_LO(pe->phb->buid), option);
 	}
 
+	/* We need reset hold or settlement delay */
+	if (option == EEH_RESET_FUNDAMENTAL ||
+	    option == EEH_RESET_HOT)
+		msleep(EEH_PE_RST_HOLD_TIME);
+	else
+		msleep(EEH_PE_RST_SETTLE_TIME);
+
 	return ret;
 }
 
-- 
1.8.3.2
