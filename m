Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9YgX0XxqzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 15:42:31 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7C5XdlZ033513
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 01:42:30 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24rmj7rnhf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 01:42:30 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Fri, 12 Aug 2016 01:42:28 -0400
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alex.williamson@redhat.com, paulus@samba.org, aik@ozlabs.ru,
 gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, zhong@linux.vnet.ibm.com
Subject: [PATCH v4 2/5] PCI: Ignore enforced alignment to VF BARs
Date: Fri, 12 Aug 2016 13:42:23 +0800
In-Reply-To: <1470980546-2918-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1470980546-2918-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <1470980546-2918-3-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

VF BARs are read-only zeroes according to SRIOV spec,
the normal way(writing BARs) of allocating resources wouldn't
be applied to VFs. The VFs' resources would be allocated
when we enable SR-IOV capability. So we should not try to
reassign alignment after we enable VFs. It's meaningless
and will release the allocated resources which leads to a bug.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/pci.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2d85a96..b8357d7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5048,6 +5048,15 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	resource_size_t align, size;
 	u16 command;
 
+	/*
+	 * VF BARs are RO zero according to SR-IOV spec 3.4.1.11. Their
+	 * resources would be allocated when we enable them and not be
+	 * re-allocated any more. So we should never try to reassign
+	 * VF's alignment here.
+	 */
+	if (dev->is_virtfn)
+		return;
+
 	/* check if specified PCI is target device to reassign */
 	align = pci_specified_resource_alignment(dev);
 	if (!align)
-- 
1.7.9.5
