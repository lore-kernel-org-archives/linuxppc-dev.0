Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwH1T1JrzzF19S
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 10:58:52 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w25NnBWK012680
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2018 18:58:50 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ghfqmggqd-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2018 18:58:50 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Mon, 5 Mar 2018 23:58:48 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w25Nwku3197038
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2018 23:58:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D77C11C04A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:51:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 036A611C04C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:51:33 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:51:32 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 3F00AA01E4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 10:58:44 +1100 (AEDT)
Date: Tue, 6 Mar 2018 10:58:43 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/9] powerpc/eeh: Remove eeh_handle_event()
References: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
Message-Id: <d3d01073da02a5eb844cc8998fdac602b8121b62.1520294174.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function eeh_handle_event(pe) does nothing other than switching
between calling eeh_handle_normal_event(pe) and
eeh_handle_special_event(). However it is only called in two places,
one where pe can't be NULL and the other where it must be NULL (see
eeh_event_handler()) so it does nothing but obscure the flow of
control.

So, remove it.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 arch/powerpc/include/asm/eeh_event.h |  3 ++-
 arch/powerpc/kernel/eeh_driver.c     | 42 +++++++++++++-----------------------
 arch/powerpc/kernel/eeh_event.c      |  4 ++--
 3 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh_event.h b/arch/powerpc/include/asm/eeh_event.h
index 1e551a2d6f82..0a168038882d 100644
--- a/arch/powerpc/include/asm/eeh_event.h
+++ b/arch/powerpc/include/asm/eeh_event.h
@@ -34,7 +34,8 @@ struct eeh_event {
 int eeh_event_init(void);
 int eeh_send_failure_event(struct eeh_pe *pe);
 void eeh_remove_event(struct eeh_pe *pe, bool force);
-void eeh_handle_event(struct eeh_pe *pe);
+bool eeh_handle_normal_event(struct eeh_pe *pe);
+void eeh_handle_special_event(void);
 
 #endif /* __KERNEL__ */
 #endif /* ASM_POWERPC_EEH_EVENT_H */
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 0c0b66fc5bfb..51b21c97910f 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -738,9 +738,22 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
  * Attempts to recover the given PE.  If recovery fails or the PE has failed
  * too many times, remove the PE.
  *
+ * While PHB detects address or data parity errors on particular PCI
+ * slot, the associated PE will be frozen. Besides, DMA's occurring
+ * to wild addresses (which usually happen due to bugs in device
+ * drivers or in PCI adapter firmware) can cause EEH error. #SERR,
+ * #PERR or other misc PCI-related errors also can trigger EEH errors.
+ *
+ * Recovery process consists of unplugging the device driver (which
+ * generated hotplug events to userspace), then issuing a PCI #RST to
+ * the device, then reconfiguring the PCI config space for all bridges
+ * & devices under this slot, and then finally restarting the device
+ * drivers (which cause a second set of hotplug events to go out to
+ * userspace).
+ *
  * Returns true if @pe should no longer be used, else false.
  */
-static bool eeh_handle_normal_event(struct eeh_pe *pe)
+bool eeh_handle_normal_event(struct eeh_pe *pe)
 {
 	struct pci_bus *frozen_bus;
 	struct eeh_dev *edev, *tmp;
@@ -942,7 +955,7 @@ static bool eeh_handle_normal_event(struct eeh_pe *pe)
  * specific PE.  Iterates through possible failures and handles them as
  * necessary.
  */
-static void eeh_handle_special_event(void)
+void eeh_handle_special_event(void)
 {
 	struct eeh_pe *pe, *phb_pe;
 	struct pci_bus *bus;
@@ -1049,28 +1062,3 @@ static void eeh_handle_special_event(void)
 			break;
 	} while (rc != EEH_NEXT_ERR_NONE);
 }
-
-/**
- * eeh_handle_event - Reset a PCI device after hard lockup.
- * @pe: EEH PE
- *
- * While PHB detects address or data parity errors on particular PCI
- * slot, the associated PE will be frozen. Besides, DMA's occurring
- * to wild addresses (which usually happen due to bugs in device
- * drivers or in PCI adapter firmware) can cause EEH error. #SERR,
- * #PERR or other misc PCI-related errors also can trigger EEH errors.
- *
- * Recovery process consists of unplugging the device driver (which
- * generated hotplug events to userspace), then issuing a PCI #RST to
- * the device, then reconfiguring the PCI config space for all bridges
- * & devices under this slot, and then finally restarting the device
- * drivers (which cause a second set of hotplug events to go out to
- * userspace).
- */
-void eeh_handle_event(struct eeh_pe *pe)
-{
-	if (pe)
-		eeh_handle_normal_event(pe);
-	else
-		eeh_handle_special_event();
-}
diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
index accbf8b5fd46..872bcfe8f90e 100644
--- a/arch/powerpc/kernel/eeh_event.c
+++ b/arch/powerpc/kernel/eeh_event.c
@@ -81,10 +81,10 @@ static int eeh_event_handler(void * dummy)
 				pr_info("EEH: Detected PCI bus error on "
 					"PHB#%x-PE#%x\n",
 					pe->phb->global_number, pe->addr);
-			eeh_handle_event(pe);
+			eeh_handle_normal_event(pe);
 			eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
 		} else {
-			eeh_handle_event(NULL);
+			eeh_handle_special_event();
 		}
 
 		kfree(event);
-- 
2.16.1.74.g9b0b1f47b
