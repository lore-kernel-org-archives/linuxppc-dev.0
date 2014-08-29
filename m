Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7003F1A0021
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Aug 2014 17:09:50 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 29 Aug 2014 12:39:46 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 00BBD125804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Aug 2014 12:40:02 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7T7C4l966191478
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Aug 2014 12:42:04 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7T79fJD021057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Aug 2014 12:39:41 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/eeh: Clear frozen device state in time
Date: Fri, 29 Aug 2014 17:09:35 +1000
Message-Id: <1409296175-5600-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The problem was reported by Carol: In the scenario of passing mlx4
adapter to guest, EEH error could be recovered successfully. When
returning the device back to host, the driver (mlx4_core.ko)
couldn't be loaded successfully because of error number -5 (-EIO)
returned from mlx4_get_ownership(), which hits offlined PCI device.
The root cause is that we missed to put the affected devices into
normal state on clearing PE isolated state right after PE reset.

The patch fixes above issue by putting the affected devices to
normal state when clearing PE isolated state in eeh_pe_state_clear().

Cc: stable@vger.kernel.org
Reported-by: Carol L. Soto <clsoto@us.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_pe.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 00e3844..eef08f0 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -584,6 +584,8 @@ static void *__eeh_pe_state_clear(void *data, void *flag)
 {
 	struct eeh_pe *pe = (struct eeh_pe *)data;
 	int state = *((int *)flag);
+	struct eeh_dev *edev, *tmp;
+	struct pci_dev *pdev;
 
 	/* Keep the state of permanently removed PE intact */
 	if ((pe->freeze_count > EEH_MAX_ALLOWED_FREEZES) &&
@@ -592,9 +594,22 @@ static void *__eeh_pe_state_clear(void *data, void *flag)
 
 	pe->state &= ~state;
 
-	/* Clear check count since last isolation */
-	if (state & EEH_PE_ISOLATED)
-		pe->check_count = 0;
+	/*
+	 * Special treatment on clearing isolated state. Clear
+	 * check count since last isolation and put all affected
+	 * devices to normal state.
+	 */
+	if (!(state & EEH_PE_ISOLATED))
+		return NULL;
+
+	pe->check_count = 0;
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		pdev = eeh_dev_to_pci_dev(edev);
+		if (!pdev)
+			continue;
+
+		pdev->error_state = pci_channel_io_normal;
+	}
 
 	return NULL;
 }
-- 
1.8.3.2
