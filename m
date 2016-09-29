Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sl4qG68XqzDsj5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 16:46:34 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8T6gvfD074807
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 02:46:33 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25rw1gstq4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 02:46:32 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Thu, 29 Sep 2016 00:46:32 -0600
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alex.williamson@redhat.com, paulus@samba.org, aik@ozlabs.ru,
 gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, zhong@linux.vnet.ibm.com
Subject: [PATCH v6 3/4] PCI: Don't change resources' size when using
 resource_alignment
Date: Thu, 29 Sep 2016 14:46:20 +0800
In-Reply-To: <1475131581-4373-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1475131581-4373-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <1475131581-4373-4-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When using resource_alignment kernel parameter, the current
implement reassigns the alignment by changing resources' size
which can potentially break some drivers. For example, the driver
uses the size to locate some register whose length is related
to the size.

This patch tries to use IORESOURCE_STARTALIGN to specify the
alignment instead of IORESOURCE_SIZEALIGN. Thus, we can
reassign the alignment without changing resources's size.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/pci.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b8357d7..d867c90 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5086,15 +5086,10 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 		}
 
 		size = resource_size(r);
-		if (size < align) {
-			size = align;
-			dev_info(&dev->dev,
-				"Rounding up size of resource #%d to %#llx.\n",
-				i, (unsigned long long)size);
-		}
-		r->flags |= IORESOURCE_UNSET;
-		r->end = size - 1;
-		r->start = 0;
+		r->flags &= ~IORESOURCE_SIZEALIGN;
+		r->flags |= IORESOURCE_STARTALIGN | IORESOURCE_UNSET;
+		r->start = max(align, size);
+		r->end = r->start + size - 1;
 	}
 	/* Need to disable bridge's resource window,
 	 * to enable the kernel to reassign new resource
-- 
1.7.9.5
