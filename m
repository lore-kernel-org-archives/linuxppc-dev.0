Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 90BBD1A0032
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 05:49:56 +1100 (AEDT)
Received: from /spool/local
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Tue, 21 Oct 2014 16:49:50 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id D03A11DC005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 14:48:52 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9LInkhu4698170
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 16:49:46 -0200
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9LIni6i029468
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 16:49:45 -0200
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powernv/iommu: disable IOMMU bypass with param iommu=nobypass
Date: Tue, 21 Oct 2014 16:49:43 -0200
Message-Id: <1413917383-18396-1-git-send-email-cascardo@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>, corbet@lwn.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When IOMMU bypass is enabled, a PCI device can read and write memory
that was not mapped by the driver without causing an EEH. That might
cause memory corruption, for example.

When we disable bypass, DMA reads and writes to addresses not mapped by
the IOMMU will cause an EEH, allowing us to debug such issues.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
---
 Documentation/kernel-parameters.txt       |    2 ++
 arch/powerpc/platforms/powernv/pci-ioda.c |   24 +++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 988160a..b03322a 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1454,6 +1454,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 		forcesac
 		soft
 		pt		[x86, IA-64]
+		nobypass	[PPC/POWERNV]
+			Disable IOMMU bypass, using IOMMU for PCI devices.
 
 
 	io7=		[HW] IO7 for Marvel based alpha systems
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 468a0f2..58a5a27 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -75,6 +75,27 @@ static void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 #define pe_info(pe, fmt, ...)					\
 	pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
 
+static int __read_mostly disable_bypass;
+
+static int __init iommu_setup(char *str)
+{
+	if (!*str)
+		return -EINVAL;
+	while (*str) {
+		if (!strncmp(str, "nobypass", 8)) {
+			disable_bypass = 1;
+			pr_info("ppc iommu: disabling bypass.\n");
+		}
+		str += strcspn(str, ",");
+		if (*str == ',')
+			str++;
+	}
+
+	return 0;
+}
+
+early_param("iommu", iommu_setup);
+
 /*
  * stdcix is only supposed to be used in hypervisor real mode as per
  * the architecture spec
@@ -1243,7 +1264,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
 
 	/* Also create a bypass window */
-	pnv_pci_ioda2_setup_bypass_pe(phb, pe);
+	if (!disable_bypass)
+		pnv_pci_ioda2_setup_bypass_pe(phb, pe);
 	return;
 fail:
 	if (pe->tce32_seg >= 0)
-- 
1.7.1
