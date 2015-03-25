Return-Path: <dja@axtens.net>
Received: from mail-pd0-x229.google.com (mail-pd0-x229.google.com
 [IPv6:2607:f8b0:400e:c02::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BDB021A0736
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:36:27 +1100 (AEDT)
Received: by pdbcz9 with SMTP id cz9so16988100pdb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:36:26 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/27] powerpc: Create the pci_controller_ops struct.
Date: Wed, 25 Mar 2015 16:35:40 +1100
Message-Id: <1427261761-22952-7-git-send-email-dja@axtens.net>
In-Reply-To: <1427261761-22952-1-git-send-email-dja@axtens.net>
References: <1427261761-22952-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/include/asm/pci-bridge.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 546d036..3ab8a2d 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -15,6 +15,12 @@
 struct device_node;
 
 /*
+ * PCI controller operations
+ */
+struct pci_controller_ops {
+};
+
+/*
  * Structure of a PCI controller (host bridge)
  */
 struct pci_controller {
@@ -46,6 +52,7 @@ struct pci_controller {
 	resource_size_t	isa_mem_phys;
 	resource_size_t	isa_mem_size;
 
+	struct pci_controller_ops controller_ops;
 	struct pci_ops *ops;
 	unsigned int __iomem *cfg_addr;
 	void __iomem *cfg_data;
-- 
2.1.4
