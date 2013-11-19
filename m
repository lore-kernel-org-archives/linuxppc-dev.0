Return-Path: <Bharat.Bhushan@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1D6352C042D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 16:23:48 +1100 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <alex.williamson@redhat.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
 <agraf@suse.de>, <scottwood@freescale.com>, <stuart.yoder@freescale.com>,
 <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/9 v2] powerpc: pci: Add arch specific msi region interface
Date: Tue, 19 Nov 2013 10:47:07 +0530
Message-ID: <1384838233-24847-4-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the interface to get the msi region information from arch
specific code. The machine spicific code is not yet defined.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
v1->v2
 - None

 arch/powerpc/include/asm/machdep.h |    8 ++++++++
 arch/powerpc/kernel/msi.c          |   18 ++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 8b48090..8d1b787 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -30,6 +30,7 @@ struct file;
 struct pci_controller;
 struct kimage;
 struct pci_host_bridge;
+struct msi_region;
 
 struct machdep_calls {
 	char		*name;
@@ -124,6 +125,13 @@ struct machdep_calls {
 	int		(*setup_msi_irqs)(struct pci_dev *dev,
 					  int nvec, int type);
 	void		(*teardown_msi_irqs)(struct pci_dev *dev);
+
+	/* Returns the number of MSI regions (banks) */
+	int		(*msi_get_region_count)(void);
+
+	/* Returns the requested region's address and size */
+	int		(*msi_get_region)(int region_num,
+					  struct msi_region *region);
 #endif
 
 	void		(*restart)(char *cmd);
diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
index 8bbc12d..1a67787 100644
--- a/arch/powerpc/kernel/msi.c
+++ b/arch/powerpc/kernel/msi.c
@@ -13,6 +13,24 @@
 
 #include <asm/machdep.h>
 
+int arch_msi_get_region_count(void)
+{
+	if (ppc_md.msi_get_region_count) {
+		pr_debug("msi: Using platform get_region_count routine.\n");
+		return ppc_md.msi_get_region_count();
+	}
+	return 0;
+}
+
+int arch_msi_get_region(int region_num, struct msi_region *region)
+{
+	if (ppc_md.msi_get_region) {
+		pr_debug("msi: Using platform get_region routine.\n");
+		return ppc_md.msi_get_region(region_num, region);
+	}
+	return 0;
+}
+
 int arch_msi_check_device(struct pci_dev* dev, int nvec, int type)
 {
 	if (!ppc_md.setup_msi_irqs || !ppc_md.teardown_msi_irqs) {
-- 
1.7.0.4
