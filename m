Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qx7575jgVzDr3R
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 19:02:51 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 Apr 2016 19:02:50 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DEF202BB0119
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 19:00:00 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3T8xc0V50003980
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 19:00:00 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3T8wksE027869
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 18:58:46 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Daniel Axtens <dja@axtens.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Russell Currey <ruscur@russell.cc>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel v4 08/11] powerpc/powernv/ioda2: Export debug helper
 pe_level_printk()
Date: Fri, 29 Apr 2016 18:55:21 +1000
Message-Id: <1461920124-21719-9-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1461920124-21719-1-git-send-email-aik@ozlabs.ru>
References: <1461920124-21719-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This exports debugging helper pe_level_printk() and corresponding macroses
so they can be used in npu-dma.c.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 9 +--------
 arch/powerpc/platforms/powernv/pci.h      | 9 +++++++++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 272521e..db7695f 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -56,7 +56,7 @@
 
 static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl);
 
-static void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
+void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 			    const char *fmt, ...)
 {
 	struct va_format vaf;
@@ -87,13 +87,6 @@ static void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 	va_end(args);
 }
 
-#define pe_err(pe, fmt, ...)					\
-	pe_level_printk(pe, KERN_ERR, fmt, ##__VA_ARGS__)
-#define pe_warn(pe, fmt, ...)					\
-	pe_level_printk(pe, KERN_WARNING, fmt, ##__VA_ARGS__)
-#define pe_info(pe, fmt, ...)					\
-	pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
-
 static bool pnv_iommu_bypass_disabled __read_mostly;
 
 static int __init iommu_setup(char *str)
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index d574a9d..485e5b1 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -236,6 +236,15 @@ extern void pnv_pci_dma_bus_setup(struct pci_bus *bus);
 extern int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type);
 extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
 
+extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
+			    const char *fmt, ...);
+#define pe_err(pe, fmt, ...)					\
+	pe_level_printk(pe, KERN_ERR, fmt, ##__VA_ARGS__)
+#define pe_warn(pe, fmt, ...)					\
+	pe_level_printk(pe, KERN_WARNING, fmt, ##__VA_ARGS__)
+#define pe_info(pe, fmt, ...)					\
+	pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
+
 /* Nvlink functions */
 extern void pnv_npu_init_dma_pe(struct pnv_ioda_pe *npe);
 extern void pnv_npu_setup_dma_pe(struct pnv_ioda_pe *npe);
-- 
2.5.0.rc3
