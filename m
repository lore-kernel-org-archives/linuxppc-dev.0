Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN1TN6G5hzDvZs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 08:10:16 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uALL8R7U049562
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 16:10:14 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26v3wa771t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 16:10:14 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Mon, 21 Nov 2016 14:10:13 -0700
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Subject: [PATCH 2/2] cxl: Set VPD timeout to avoid access failures
Date: Mon, 21 Nov 2016 15:10:06 -0600
In-Reply-To: <1479762225-51440-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1479762225-51440-1-git-send-email-mrochs@linux.vnet.ibm.com>
Message-Id: <1479762606-51632-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some IBM CXL devices can take up to ~120ms to complete a VPD access
transaction when under heavy load. With an existing default VPD timeout
of 50ms, reads/writes can fail despite there not being an issue with the
underlying hardware.

To avoid these false failures, increase the VPD wait timeout for certain
CXL devices to a value that allows appropriate VPD access delay when faced
with a worst-case scenario.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/misc/cxl/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index e96be9c..56a67cf 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1675,6 +1675,10 @@ bool cxl_slot_is_supported(struct pci_dev *dev, int flags)
 }
 EXPORT_SYMBOL_GPL(cxl_slot_is_supported);
 
+static bool cxl_pci_is_slow_vpd_device(struct pci_dev *dev)
+{
+	return dev->device == 0x0601;
+}
 
 static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
@@ -1692,6 +1696,9 @@ static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENODEV;
 	}
 
+	if (cxl_pci_is_slow_vpd_device(dev))
+		pci_set_vpd_timeout(dev, msecs_to_jiffies(125));
+
 	if (cxl_verbose)
 		dump_cxl_config_space(dev);
 
-- 
2.1.0
