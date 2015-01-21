Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 939DA1A0DFA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 02:25:21 +1100 (AEDT)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Wed, 21 Jan 2015 13:25:17 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 9D23C352005F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 10:24:16 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0LFOeiA56230074
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 13:24:41 -0200
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0LFPDjv013030
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 13:25:13 -0200
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH resend] powernv/iommu: disable IOMMU bypass with param
 iommu=nobypass
Date: Wed, 21 Jan 2015 13:23:52 -0200
Message-Id: <1421853832-32533-1-git-send-email-cascardo@linux.vnet.ibm.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, gwshan@linux.vnet.ibm.com,
 paulus@samba.org, Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
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
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 Documentation/kernel-parameters.txt       |    2 ++
 arch/powerpc/platforms/powernv/pci-ioda.c |   24 +++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 4df73da..7dedfe5 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1493,6 +1493,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 		forcesac
 		soft
 		pt		[x86, IA-64]
+		nobypass	[PPC/POWERNV]
+			Disable IOMMU bypass, using IOMMU for PCI devices.
 
 
 	io7=		[HW] IO7 for Marvel based alpha systems
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fac88ed..f942a19 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -75,6 +75,27 @@ static void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 #define pe_info(pe, fmt, ...)					\
 	pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
 
+static bool pnv_iommu_bypass_disabled __read_mostly;
+
+static int __init iommu_setup(char *str)
+{
+	if (!str)
+		return -EINVAL;
+	while (*str) {
+		if (!strncmp(str, "nobypass", 8)) {
+			pnv_iommu_bypass_disabled = true;
+			pr_info("PowerNV: IOMMU bypass window disabled.\n");
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
@@ -1348,7 +1369,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
 
 	/* Also create a bypass window */
-	pnv_pci_ioda2_setup_bypass_pe(phb, pe);
+	if (!pnv_iommu_bypass_disabled)
+		pnv_pci_ioda2_setup_bypass_pe(phb, pe);
 	return;
 fail:
 	if (pe->tce32_seg >= 0)
-- 
1.7.10.4
