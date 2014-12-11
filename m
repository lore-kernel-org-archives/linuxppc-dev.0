Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B4131A0A07
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 14:29:03 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 11 Dec 2014 13:29:02 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DBEC42BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 14:28:59 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBB3SxSG30277786
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 14:28:59 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBB3Swol020710
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 14:28:58 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/eeh: Introduce flag EEH_PE_REMOVED
Date: Thu, 11 Dec 2014 14:28:55 +1100
Message-Id: <1418268536-15002-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: grimm@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The conditions that one specific PE's frozen count exceeds the maximal
allowed times (EEH_MAX_ALLOWED_FREEZES) and it's in isolated or recovery
state indicate the PE was removed permanently implicitly. The patch
introduces flag EEH_PE_REMOVED to indicate that explicitly so that we
don't depend on the fixed maximal allowed times, which can be varied as
we do in subsequent patch.

Flag EEH_PE_REMOVED is expected to be marked for the PE whose frozen
count exceeds the maximal allowed times, or just failed from recovery.

Requested-by: Ryan Grimm <grimm@linux.vnet.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h   | 1 +
 arch/powerpc/kernel/eeh_driver.c | 2 +-
 arch/powerpc/kernel/eeh_pe.c     | 6 ++----
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 9c11d1e..3e4dd34 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -78,6 +78,7 @@ struct device_node;
 
 #define EEH_PE_KEEP		(1 << 8)	/* Keep PE on hotplug	*/
 #define EEH_PE_CFG_RESTRICTED	(1 << 9)	/* Block config on error */
+#define EEH_PE_REMOVED		(1 << 10)	/* Removed permanently	*/
 
 struct eeh_pe {
 	int type;			/* PE type: PHB/Bus/Device	*/
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index b17e793..ac00672 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -806,7 +806,7 @@ perm_error:
 	eeh_pe_dev_traverse(pe, eeh_report_failure, NULL);
 
 	/* Mark the PE to be removed permanently */
-	pe->freeze_count = EEH_MAX_ALLOWED_FREEZES + 1;
+	eeh_pe_state_mark(pe, EEH_PE_REMOVED);
 
 	/*
 	 * Shut down the device drivers for good. We mark
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index fa950fb..1e4946c 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -526,8 +526,7 @@ static void *__eeh_pe_state_mark(void *data, void *flag)
 	struct pci_dev *pdev;
 
 	/* Keep the state of permanently removed PE intact */
-	if ((pe->freeze_count > EEH_MAX_ALLOWED_FREEZES) &&
-	    (state & (EEH_PE_ISOLATED | EEH_PE_RECOVERING)))
+	if (pe->state & EEH_PE_REMOVED)
 		return NULL;
 
 	pe->state |= state;
@@ -600,8 +599,7 @@ static void *__eeh_pe_state_clear(void *data, void *flag)
 	struct pci_dev *pdev;
 
 	/* Keep the state of permanently removed PE intact */
-	if ((pe->freeze_count > EEH_MAX_ALLOWED_FREEZES) &&
-	    (state & EEH_PE_ISOLATED))
+	if (pe->state & EEH_PE_REMOVED)
 		return NULL;
 
 	pe->state &= ~state;
-- 
1.8.3.2
