Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyr0D579szDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 11:50:20 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0B0jHVM006107
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 19:50:18 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27w6u882uj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 19:50:18 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 11 Jan 2017 10:50:15 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3171D2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 11:50:13 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0B0oDh14325700
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 11:50:13 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0B0oCh7029667
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 11:50:12 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, hankmax0000@gmail.com, williel@supermicro.com.tw,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, stable@vger.kernel.org,
 #v4.9+@gwshan.ozlabs.ibm.com
Subject: [PATCH 2/3] drivers/pci/hotplug: Fix initial state for empty slot
Date: Wed, 11 Jan 2017 11:50:07 +1100
In-Reply-To: <1484095808-24777-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1484095808-24777-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1484095808-24777-3-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In PowerNV PCI hotplug driver, the initial PCI slot's state is set
to PNV_PHP_STATE_POPULATED if no PCI devices are connected to the
slot. The PCI devices that are hot added to the slot won't be probed
and populated because of the check in pnv_php_enable():

        /* Check if the slot has been configured */
        if (php_slot->state != PNV_PHP_STATE_REGISTERED)
                return 0;

This fixes the issue by leaving the slot in PNV_PHP_STATE_REGISTERED
state initially if nothing is connected to the slot.

Fixes: 360aebd85a4 ("drivers/pci/hotplug: Support surprise hotplug in powernv driver")
Cc: stable@vger.kernel.org #v4.9+
Reported-by: Hank Chang <hankmax0000@gmail.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Tested-by: Willie Liauw <williel@supermicro.com.tw>
---
 drivers/pci/hotplug/pnv_php.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 306728c..41304b3 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -430,9 +430,21 @@ static int pnv_php_enable(struct pnv_php_slot *php_slot, bool rescan)
 	if (ret)
 		return ret;
 
-	/* Proceed if there have nothing behind the slot */
-	if (presence == OPAL_PCI_SLOT_EMPTY)
+	/*
+	 * Proceed if there have nothing behind the slot. However,
+	 * we should leave the slot in registered state at the
+	 * beginning. Otherwise, the PCI devices inserted afterwards
+	 * won't be probed and populated.
+	 */
+	if (presence == OPAL_PCI_SLOT_EMPTY) {
+		if (!php_slot->power_state_check) {
+			php_slot->power_state_check = true;
+
+			return 0;
+		}
+
 		goto scan;
+	}
 
 	/*
 	 * If the power supply to the slot is off, we can't detect
-- 
2.7.4
