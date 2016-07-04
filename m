Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjnkf47RdzDqp9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 23:22:50 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u64DIdFW111604
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 09:22:48 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23x7xefr7d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jul 2016 09:22:48 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 4 Jul 2016 23:22:46 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6A4872BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 23:22:40 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u64DMeQ43277254
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 23:22:40 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u64DMdq5009232
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 23:22:40 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 03/14] cxl: Enable bus mastering for devices using CAPP DMA
 mode
Date: Mon,  4 Jul 2016 23:22:01 +1000
In-Reply-To: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1467638532-9250-4-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

Devices that use CAPP DMA mode (such as the Mellanox CX4) require bus
master to be enabled in order for the CAPI traffic to flow. This should
be harmless to enable for other cxl devices, so unconditionally enable
it in the adapter init flow.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 9530280..6c0597d 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1264,6 +1264,9 @@ static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
 	if ((rc = adapter->native->sl_ops->adapter_regs_init(adapter, dev)))
 		goto err;
 
+	/* Required for devices using CAPP DMA mode, harmless for others */
+	pci_set_master(dev);
+
 	if ((rc = pnv_phb_to_cxl_mode(dev, adapter->native->sl_ops->capi_mode)))
 		goto err;
 
-- 
2.8.1
