Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sl3c03lLhzDsfg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:44 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8T5m5O3022210
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 01:51:43 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25ruyvt20w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 01:51:42 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 29 Sep 2016 15:51:40 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AB61F2BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:38 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8T5pcJA6553938
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:38 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8T5pcWG032688
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:38 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v4 6/7] drivers/pci/hotplug: Use of_property_read_u32() in
 powernv driver
Date: Thu, 29 Sep 2016 15:52:04 +1000
In-Reply-To: <1475128325-5367-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1475128325-5367-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1475128325-5367-7-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This replaces of_get_property() with of_property_read_u32() or
of_property_read_string() so that we needn't consider the endian
issue, the returned value always is in CPU-endian.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/hotplug/pnv_php.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 182f218..96ccb7f 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -513,9 +513,10 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
 	struct pci_bus *bus;
 	const char *label;
 	uint64_t id;
+	int ret;
 
-	label = of_get_property(dn, "ibm,slot-label", NULL);
-	if (!label)
+	ret = of_property_read_string(dn, "ibm,slot-label", &label);
+	if (ret)
 		return NULL;
 
 	if (pnv_pci_get_slot_id(dn, &id))
@@ -612,16 +613,16 @@ static int pnv_php_register_slot(struct pnv_php_slot *php_slot)
 static int pnv_php_register_one(struct device_node *dn)
 {
 	struct pnv_php_slot *php_slot;
-	const __be32 *prop32;
+	u32 prop32;
 	int ret;
 
 	/* Check if it's hotpluggable slot */
-	prop32 = of_get_property(dn, "ibm,slot-pluggable", NULL);
-	if (!prop32 || !of_read_number(prop32, 1))
+	ret = of_property_read_u32(dn, "ibm,slot-pluggable", &prop32);
+	if (ret || !prop32)
 		return -ENXIO;
 
-	prop32 = of_get_property(dn, "ibm,reset-by-firmware", NULL);
-	if (!prop32 || !of_read_number(prop32, 1))
+	ret = of_property_read_u32(dn, "ibm,reset-by-firmware", &prop32);
+	if (ret || !prop32)
 		return -ENXIO;
 
 	php_slot = pnv_php_alloc_slot(dn);
-- 
2.1.0
