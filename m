Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9YgY34BdzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 15:42:33 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7C5XcMv032988
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 01:42:32 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9v99dv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 01:42:31 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 23:42:31 -0600
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alex.williamson@redhat.com, paulus@samba.org, aik@ozlabs.ru,
 gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, zhong@linux.vnet.ibm.com
Subject: [PATCH v4 3/5] PCI: Do not disable memory decoding in
 pci_reassigndev_resource_alignment()
Date: Fri, 12 Aug 2016 13:42:24 +0800
In-Reply-To: <1470980546-2918-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1470980546-2918-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <1470980546-2918-4-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We should not disable memory decoding when we reassign alignment
in pci_reassigndev_resource_alignment(). It's meaningless and
have some side effects. For example, we found it would break
this kind of P2P bridge:

0001:02:02.0 PCI bridge: PLX Technology, Inc. PEX 8718 16-Lane,
5-Port PCI Express Gen 3 (8.0 GT/s) Switch (rev aa)

And it may also potentially break the PCI devices with mmio_always_on
bit set.

Besides, disabling memory decoding is not expected in some fixup
function such as fixup_vga(). The fixup_vga() read PCI_COMMAND_MEMORY
to know whether the devices has been initialized by the firmware or
not. Disabling memory decoding would cause the one initialized by
firmware may not be set as the default VGA device when more than one
graphics adapter is present.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/pci.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b8357d7..caa0894 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5046,7 +5046,6 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	int i;
 	struct resource *r;
 	resource_size_t align, size;
-	u16 command;
 
 	/*
 	 * VF BARs are RO zero according to SR-IOV spec 3.4.1.11. Their
@@ -5069,12 +5068,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 		return;
 	}
 
-	dev_info(&dev->dev,
-		"Disabling memory decoding and releasing memory resources.\n");
-	pci_read_config_word(dev, PCI_COMMAND, &command);
-	command &= ~PCI_COMMAND_MEMORY;
-	pci_write_config_word(dev, PCI_COMMAND, command);
-
+	dev_info(&dev->dev, "Releasing memory resources.\n");
 	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
 		r = &dev->resource[i];
 		if (!(r->flags & IORESOURCE_MEM))
-- 
1.7.9.5
