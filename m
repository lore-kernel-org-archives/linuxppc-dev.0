Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgGcK06xYzDqnF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 20:53:36 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UArY8Y101073
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 06:53:35 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23uuhuvkvq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 06:53:34 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 16:23:23 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id F3BE4E005F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:27:11 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5UAqO7p13500908
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:22:24 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5UArIVM023107
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:23:20 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 corbet@lwn.net, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH v3 3/7] PCI: Do not disable memory decoding in
 pci_reassigndev_resource_alignment()
Date: Thu, 30 Jun 2016 18:53:09 +0800
In-Reply-To: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <1467283993-3185-4-git-send-email-xyjxie@linux.vnet.ibm.com>
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
have some side effect. For example, some fixup functions such as
quirk_e100_interrupt() read PCI_COMMAND_MEMORY to know whether
the devices has been initialized by the firmware or not. If we
disable memory decoding here, these functions will get a wrong
information that the devices was not initialized by the firmware
which may cause a wrong fixup. Besides, disabling memory decoding
may also break some devices that need to have memory decoding
always-on during probing.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/pci.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6ae02de..6241cfc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4820,7 +4820,6 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	int i;
 	struct resource *r;
 	resource_size_t align, size;
-	u16 command;
 
 	/* We should never try to reassign VF's alignment */
 	if (dev->is_virtfn)
@@ -4838,12 +4837,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
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
