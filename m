Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjT181LwczDwPL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 17:49:47 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBK6mj72075222
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 01:49:45 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27erfj7773-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 01:49:45 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 20 Dec 2016 16:49:42 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5C35C2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 17:49:40 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBK6neVj25427968
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 17:49:40 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBK6nddx029036
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 17:49:40 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, stable@vger.kernel.org,
 #v4.9+@gwshan.ozlabs.ibm.com
Subject: [PATCH] drivers/pci/hotplug: Handle presence detection change properly
Date: Tue, 20 Dec 2016 17:49:33 +1100
Message-Id: <1482216573-21487-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The surprise hotplug is driven by interrupt in PowerNV PCI hotplug
driver. In the interrupt handler, pnv_php_interrupt(), we bail when
pnv_pci_get_presence_state() returns zero wrongly. It causes the
presence change event is always ignored incorrectly.

This fixes the issue by bailing on error (non-zero value) returned
from pnv_pci_get_presence_state().

Fixes: 360aebd85a4 ("drivers/pci/hotplug: Support surprise hotplug in powernv driver")
Cc: stable@vger.kernel.org #v4.9+
Reported-by: Hank Chang <hankmax0000@gmail.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Tested-by: Willie Liauw <williel@supermicro.com.tw>
---
 drivers/pci/hotplug/pnv_php.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 56efaf7..38a2309 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -707,8 +707,12 @@ static irqreturn_t pnv_php_interrupt(int irq, void *data)
 		added = !!(lsts & PCI_EXP_LNKSTA_DLLLA);
 	} else if (sts & PCI_EXP_SLTSTA_PDC) {
 		ret = pnv_pci_get_presence_state(php_slot->id, &presence);
-		if (!ret)
+		if (ret) {
+			dev_warn(&pdev->dev, "PCI slot [%s] error %d handling PDC event (0x%04x)\n",
+				php_slot->name, ret, sts);
 			return IRQ_HANDLED;
+		}
+
 		added = !!(presence == OPAL_PCI_SLOT_PRESENT);
 	} else {
 		return IRQ_NONE;
-- 
2.7.4
