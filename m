Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp3PL0k4bzDr0j
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 21:52:37 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6BBnI5L127421
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 07:52:36 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 242we0hfy5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 07:52:35 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 11 Jul 2016 21:52:33 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 387462BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 21:52:30 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6BBqUYU15073456
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 21:52:30 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6BBqT7s018030
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 21:52:29 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 14/15] PCI/hotplug: pnv_php: handle OPAL_PCI_SLOT_OFFLINE
 power state
Date: Mon, 11 Jul 2016 21:50:21 +1000
In-Reply-To: <1468237822-26276-1-git-send-email-imunsie@au.ibm.com>
References: <1468237822-26276-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1468237822-26276-15-git-send-email-imunsie@au.ibm.com>
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
