Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D1D91A17F5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:08:01 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 17:08:00 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F1B91357804C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:07:57 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9179jEY30146662
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 17:09:46 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9177ui5004755
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 17:07:57 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/6] powerpc/eeh: Block PCI config access upon frozen PE
Date: Wed,  1 Oct 2014 17:07:53 +1000
Message-Id: <1412147274-28770-6-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1412147274-28770-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1412147274-28770-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The problem was found when I tried to inject PCI config error by
PHB3 PAPR error injection registers into Broadcom Austin 4-ports
NIC adapter. The frozen PE was reported successfully and EEH core
started to recover it. However, I run into fenced PHB when dumping
PCI config space as EEH logs. I was told that PCI config requests
should not be progagated to the adapter until PE reset is done
successfully. Otherise, we would run out of PHB internal credits
and trigger PCT (PCIE Completion Timeout), which leads to the
fenced PHB.

The patch introduces another PE flag EEH_PE_CFG_RESTRICTED, which
is set during PE initialization time if the PE includes the specific
PCI devices that need block PCI config access until PE reset is done.
When the PE becomes frozen for the first time, EEH_PE_CFG_BLOCKED is
set if the PE has flag EEH_PE_CFG_RESTRICTED. Then the PCI config
access to the PE will be dropped by platform PCI accessors until
PE reset is done successfully. The mechanism is shared by PowerNV
platform owned PE or userland owned ones. It's not used on pSeries
platform yet.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  1 +
 arch/powerpc/kernel/eeh_pe.c                 |  8 ++++++++
 arch/powerpc/platforms/powernv/eeh-powernv.c | 19 +++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index e925a8e..9d7654c 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -74,6 +74,7 @@ struct device_node;
 #define EEH_PE_CFG_BLOCKED	(1 << 2)	/* Block config access	*/
 
 #define EEH_PE_KEEP		(1 << 8)	/* Keep PE on hotplug	*/
+#define EEH_PE_CFG_RESTRICTED	(1 << 9)	/* Block config on error */
 
 struct eeh_pe {
 	int type;			/* PE type: PHB/Bus/Device	*/
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 8c4429b..230ed5b 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -534,6 +534,10 @@ static void *__eeh_pe_state_mark(void *data, void *flag)
 			pdev->error_state = pci_channel_io_frozen;
 	}
 
+	/* Block PCI config access if required */
+	if (pe->state & EEH_PE_CFG_RESTRICTED)
+		pe->state |= EEH_PE_CFG_BLOCKED;
+
 	return NULL;
 }
 
@@ -611,6 +615,10 @@ static void *__eeh_pe_state_clear(void *data, void *flag)
 		pdev->error_state = pci_channel_io_normal;
 	}
 
+	/* Unblock PCI config access if required */
+	if (pe->state & EEH_PE_CFG_RESTRICTED)
+		pe->state &= ~EEH_PE_CFG_BLOCKED;
+
 	return NULL;
 }
 
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 04e42f7..443ce96 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -169,6 +169,25 @@ static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 	}
 
 	/*
+	 * If the PE contains any one of following adapters, the
+	 * PCI config space can't be accessed when dumping EEH log.
+	 * Otherwise, we will run into fenced PHB caused by shortage
+	 * of outbound credits in the adapter. The PCI config access
+	 * should be blocked until PE reset. MMIO access is dropped
+	 * by hardware certainly. In order to drop PCI config requests,
+	 * one more flag (EEH_PE_CFG_RESTRICTED) is introduced, which
+	 * will be checked in the backend for PE state retrival. If
+	 * the PE becomes frozen for the first time and the flag has
+	 * been set for the PE, we will set EEH_PE_CFG_BLOCKED for
+	 * that PE to block its config space.
+	 *
+	 * Broadcom Austin 4-ports NICs (14e4:1657)
+	 */
+	if (dev->vendor == PCI_VENDOR_ID_BROADCOM &&
+	    dev->device == 0x1657)
+		edev->pe->state |= EEH_PE_CFG_RESTRICTED;
+
+	/*
 	 * Cache the PE primary bus, which can't be fetched when
 	 * full hotplug is in progress. In that case, all child
 	 * PCI devices of the PE are expected to be removed prior
-- 
1.8.3.2
