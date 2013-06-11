Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x235.google.com (mail-ie0-x235.google.com
 [IPv6:2607:f8b0:4001:c03::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F1F8D2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 05:57:12 +1000 (EST)
Received: by mail-ie0-f181.google.com with SMTP id x12so2673929ief.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 12:57:08 -0700 (PDT)
Subject: [PATCH] powerpc/iommu: Remove unused pci_iommu_init() and
 pci_direct_iommu_init()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 11 Jun 2013 13:57:05 -0600
Message-ID: <20130611195705.17794.68833.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pci_iommu_init() and pci_direct_iommu_init() are not referenced anywhere,
so remove them.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/include/asm/iommu.h |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index cbfe678..e670f73 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -125,13 +125,6 @@ extern void iommu_init_early_pSeries(void);
 extern void iommu_init_early_dart(void);
 extern void iommu_init_early_pasemi(void);
 
-#ifdef CONFIG_PCI
-extern void pci_iommu_init(void);
-extern void pci_direct_iommu_init(void);
-#else
-static inline void pci_iommu_init(void) { }
-#endif
-
 extern void alloc_dart_table(void);
 #if defined(CONFIG_PPC64) && defined(CONFIG_PM)
 static inline void iommu_save(void)
