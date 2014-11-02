Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B8B431A0B01
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 02:41:58 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 3 Nov 2014 01:41:58 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A488C2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 02:41:55 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sA2Ffhbq37355574
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 02:41:44 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sA2FfsgS028185
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 02:41:55 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V9 07/18] powerpc/pci: Define pcibios_disable_device() on
 powerpc
Date: Sun,  2 Nov 2014 23:41:23 +0800
Message-Id: <1414942894-17034-8-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When driver remove a pci_dev, it will call pcibios_disable_device() which is
platform dependent. This gives flexibility to platforms.

This patch defines this weak function on powerpc architecture.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h |    5 ++++-
 arch/powerpc/kernel/pci-common.c   |    8 ++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 307347f..8242262 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -240,7 +240,10 @@ struct machdep_calls {
 
 	/* Called when pci_enable_device() is called. Returns 0 to
 	 * allow assignment/enabling of the device. */
-	int  (*pcibios_enable_device_hook)(struct pci_dev *);
+	int (*pcibios_enable_device_hook)(struct pci_dev *);
+
+	/* Called when pci_disable_device() is called. */
+	void (*pcibios_disable_device_hook)(struct pci_dev *);
 
 	/* Called after scan and before resource survey */
 	void (*pcibios_fixup_phb)(struct pci_controller *hose);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 399d813..17acfa7 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1452,6 +1452,14 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return pci_enable_resources(dev, mask);
 }
 
+void pcibios_disable_device(struct pci_dev *dev)
+{
+	if (ppc_md.pcibios_disable_device_hook)
+		ppc_md.pcibios_disable_device_hook(dev);
+
+	return;
+}
+
 resource_size_t pcibios_io_space_offset(struct pci_controller *hose)
 {
 	return (unsigned long) hose->io_base_virt - _IO_BASE;
-- 
1.7.9.5
