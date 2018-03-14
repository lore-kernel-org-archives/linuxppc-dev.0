Return-Path: <desnesn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401clq2rWczF15w
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 03:35:35 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2EGXiJJ007753
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 12:35:32 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gq446296g-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 12:35:32 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <desnesn@linux.vnet.ibm.com>;
 Wed, 14 Mar 2018 10:35:31 -0600
From: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, ruscur@russell.cc, aik@ozlabs.ru,
 david@gibson.dropbear.id.au, fbarrat@linux.vnet.ibm.com,
 brking@linux.vnet.ibm.com
Subject: [PATCH 1/2,
 pci] pci: Addition of PCI_DEV_FLAGS_QUIET_PCI_REALIGN attribute to
 the PCI subsystem
Date: Wed, 14 Mar 2018 13:34:54 -0300
In-Reply-To: <20180314163455.15854-1-desnesn@linux.vnet.ibm.com>
References: <20180314163455.15854-1-desnesn@linux.vnet.ibm.com>
Message-Id: <20180314163455.15854-2-desnesn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add PCI_DEV_FLAGS_QUIET_PCI_REALIGN to pci_dev_flags and use it to
silent PCI realignment messages if the flag is turned on by a driver.

Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
---
 drivers/pci/pci.c       | 3 ++-
 drivers/pci/setup-res.c | 3 ++-
 include/linux/pci.h     | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8c71d1a66cdd..be197c944e5f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5505,7 +5505,8 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 		return;
 	}
 
-	pci_info(dev, "Disabling memory decoding and releasing memory resources\n");
+	if (!(dev->dev_flags & PCI_DEV_FLAGS_QUIET_PCI_REALIGN))
+		pci_info(dev, "Disabling memory decoding and releasing memory resources\n");
 	pci_read_config_word(dev, PCI_COMMAND, &command);
 	command &= ~PCI_COMMAND_MEMORY;
 	pci_write_config_word(dev, PCI_COMMAND, command);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 369d48d6c6f1..00a538def763 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -172,7 +172,8 @@ EXPORT_SYMBOL(pci_claim_resource);
 
 void pci_disable_bridge_window(struct pci_dev *dev)
 {
-	pci_info(dev, "disabling bridge mem windows\n");
+	if (!(dev->dev_flags & PCI_DEV_FLAGS_QUIET_PCI_REALIGN))
+		pci_info(dev, "disabling bridge mem windows\n");
 
 	/* MMIO Base/Limit */
 	pci_write_config_dword(dev, PCI_MEMORY_BASE, 0x0000fff0);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e057e8cc63e7..993f9c7dcc00 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -205,6 +205,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
 	/* Don't use Relaxed Ordering for TLPs directed at this device */
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
+	/* Silent PCI resource realignment messages */
+	PCI_DEV_FLAGS_QUIET_PCI_REALIGN = (__force pci_dev_flags_t) (1 << 12),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.14.3
