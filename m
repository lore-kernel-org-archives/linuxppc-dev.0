Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9Ygf4j3xzDr2C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 15:42:38 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7C5XeFx080537
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 01:42:36 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24qm9x7xkb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 01:42:36 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Fri, 12 Aug 2016 01:42:35 -0400
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alex.williamson@redhat.com, paulus@samba.org, aik@ozlabs.ru,
 gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, zhong@linux.vnet.ibm.com
Subject: [PATCH v4 5/5] PCI: Add a macro to set default alignment for all PCI
 devices
Date: Fri, 12 Aug 2016 13:42:26 +0800
In-Reply-To: <1470980546-2918-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1470980546-2918-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <1470980546-2918-6-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When vfio passthroughs a PCI device of which MMIO BARs are
smaller than PAGE_SIZE, guest will not handle the mmio
accesses to the BARs which leads to mmio emulations in host.

This is because vfio will not allow to passthrough one BAR's
mmio page which may be shared with other BARs. Otherwise,
there will be a backdoor that guest can use to access BARs
of other guest.

This patch adds a macro to set default alignment for all
PCI devices. Then we could solve this issue on some platforms
which would easily hit this issue because of their 64K page
such as PowerNV platform by defining this macro as PAGE_SIZE.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci.h |    4 ++++
 drivers/pci/pci.c              |    4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index e9bd6cf..5e31bc2 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -28,6 +28,10 @@
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
+#ifdef CONFIG_PPC_POWERNV
+#define PCIBIOS_DEFAULT_ALIGNMENT	PAGE_SIZE
+#endif
+
 struct pci_dev;
 
 /* Values for the `which' argument to sys_pciconfig_iobase syscall.  */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d895be7..feae59e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4959,6 +4959,10 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 	resource_size_t align = 0;
 	char *p;
 
+#ifdef PCIBIOS_DEFAULT_ALIGNMENT
+	align = PCIBIOS_DEFAULT_ALIGNMENT;
+	*resize = false;
+#endif
 	spin_lock(&resource_alignment_lock);
 	p = resource_alignment_param;
 	if (pci_has_flag(PCI_PROBE_ONLY)) {
-- 
1.7.9.5
