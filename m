Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8616A1A0771
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:18 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 30 Sep 2014 12:39:17 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 66C1A2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8U2f1YQ34930812
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:41:01 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8U2dDVn007807
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:14 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/21] powerpc/eeh: Clear frozen device state in time
Date: Tue, 30 Sep 2014 12:38:59 +1000
Message-Id: <1412044750-24460-10-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
