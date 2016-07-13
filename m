Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqWs741HlzDqFd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:19 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6DL9jqO016444
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:18:17 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2455fde8tk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:18:16 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 14 Jul 2016 07:18:14 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C85472BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:11 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6DLIBg720775148
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:11 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6DLIAtp023578
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:11 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 14/15] PCI/hotplug: pnv_php: handle OPAL_PCI_SLOT_OFFLINE
 power state
Date: Thu, 14 Jul 2016 07:17:13 +1000
In-Reply-To: <1468444634-1866-1-git-send-email-imunsie@au.ibm.com>
References: <1468444634-1866-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1468444634-1866-15-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

When calling pnv_php_set_slot_power_state() with state ==
OPAL_PCI_SLOT_OFFLINE, remove devices from the device tree as if we're
dealing with OPAL_PCI_SLOT_POWER_OFF.

Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/hotplug/pnv_php.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 2d2f704..e6245b0 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -317,7 +317,7 @@ int pnv_php_set_slot_power_state(struct hotplug_slot *slot,
 		return ret;
 	}
 
-	if (state == OPAL_PCI_SLOT_POWER_OFF)
+	if (state == OPAL_PCI_SLOT_POWER_OFF || state == OPAL_PCI_SLOT_OFFLINE)
 		pnv_php_rmv_devtree(php_slot);
 	else
 		ret = pnv_php_add_devtree(php_slot);
-- 
2.8.1
