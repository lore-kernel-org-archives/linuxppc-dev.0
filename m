Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3gj12X5dzDt2G
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 17:53:41 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9Q6mUeE047478
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 02:53:39 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26aq8ms2te-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 02:53:38 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Wed, 26 Oct 2016 00:53:37 -0600
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alex.williamson@redhat.com, paulus@samba.org, aik@ozlabs.ru,
 gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, zhong@linux.vnet.ibm.com
Subject: [RFC PATCH v7 1/3] PCI: Ignore requested alignment for IOV BARs
Date: Wed, 26 Oct 2016 14:53:31 +0800
In-Reply-To: <1477464813-2499-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1477464813-2499-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <1477464813-2499-2-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We would call pci_reassigndev_resource_alignment() before
pci_init_capabilities(). So the requested alignment would
never work for IOV BARs. And it's also meaningless to do
so.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ba34907..9a30832 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5118,7 +5118,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	command &= ~PCI_COMMAND_MEMORY;
 	pci_write_config_word(dev, PCI_COMMAND, command);
 
-	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
 		r = &dev->resource[i];
 		if (!(r->flags & IORESOURCE_MEM))
 			continue;
-- 
1.7.9.5
