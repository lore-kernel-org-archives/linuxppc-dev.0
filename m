Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v4Xj81w6gzDqS9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2017 18:42:04 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0K7dICQ101255
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2017 02:42:02 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 283dnrsqgr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2017 02:42:01 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Fri, 20 Jan 2017 00:42:01 -0700
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alex.williamson@redhat.com, gwshan@linux.vnet.ibm.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 zhong@linux.vnet.ibm.com
Subject: [PATCH v8 1/3] PCI: Ignore requested alignment for IOV BARs
Date: Fri, 20 Jan 2017 15:41:51 +0800
In-Reply-To: <1484898113-24939-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1484898113-24939-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <1484898113-24939-2-git-send-email-xyjxie@linux.vnet.ibm.com>
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
never work for IOV BARs.

Furthermore, it's meaningless to request additional alignment
for IOV BARs, the IOV BAR alignment is only determined by the
VF BAR size.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a881c0d..220c31e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5084,7 +5084,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	command &= ~PCI_COMMAND_MEMORY;
 	pci_write_config_word(dev, PCI_COMMAND, command);
 
-	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
 		r = &dev->resource[i];
 		if (!(r->flags & IORESOURCE_MEM))
 			continue;
-- 
1.7.9.5
