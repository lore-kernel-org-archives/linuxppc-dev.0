Return-Path: <B31939@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F13F02C04E0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 21:42:14 +1100 (EST)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 10/12][v3] pci: fsl: support function fsl_pci_assign_primary
Date: Wed, 23 Oct 2013 18:41:32 +0800
Message-ID: <1382524894-15164-10-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1382524894-15164-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1382524894-15164-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linux-pci@vger.kernel.org,
 Zang Roy-R61911 <r61911@freescale.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change pci_ids to fsl_pci_ids Freescale-specific name and change
static to extern modifier for using in fsl_pci_assign_primary().

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
change log:
v1-v3:
Derived from http://patchwork.ozlabs.org/patch/278965/

Based on upstream master.
Based on the discussion of RFC version here
http://patchwork.ozlabs.org/patch/274487/

 arch/powerpc/sysdev/fsl_pci.c     | 5 +++--
 drivers/pci/host/pci-fsl-common.c | 4 ++--
 include/linux/fsl/pci-common.h    | 2 ++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 0a0c240..40d2e1d 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -735,7 +735,8 @@ void fsl_pci_assign_primary(void)
 		of_node_put(np);
 		np = fsl_pci_primary;
 
-		if (of_match_node(pci_ids, np) && of_device_is_available(np))
+		if (of_match_node(fsl_pci_ids, np) &&
+		    of_device_is_available(np))
 			return;
 	}
 
@@ -744,7 +745,7 @@ void fsl_pci_assign_primary(void)
 	 * designate one as primary.  This can go away once
 	 * various bugs with primary-less systems are fixed.
 	 */
-	for_each_matching_node(np, pci_ids) {
+	for_each_matching_node(np, fsl_pci_ids) {
 		if (of_device_is_available(np)) {
 			fsl_pci_primary = np;
 			of_node_put(np);
diff --git a/drivers/pci/host/pci-fsl-common.c b/drivers/pci/host/pci-fsl-common.c
index 729a5f4..8b4f793 100644
--- a/drivers/pci/host/pci-fsl-common.c
+++ b/drivers/pci/host/pci-fsl-common.c
@@ -634,7 +634,7 @@ no_bridge:
 	return -ENODEV;
 }
 
-static const struct of_device_id pci_ids[] = {
+const struct of_device_id fsl_pci_ids[] = {
 	{ .compatible = "fsl,mpc8540-pci", },
 	{ .compatible = "fsl,mpc8548-pcie", },
 	{ .compatible = "fsl,mpc8610-pci", },
@@ -725,7 +725,7 @@ static struct platform_driver fsl_pci_driver = {
 	.driver = {
 		.name = "fsl-pci",
 		.pm = PCI_PM_OPS,
-		.of_match_table = pci_ids,
+		.of_match_table = fsl_pci_ids,
 	},
 	.probe = fsl_pci_probe,
 	.remove = fsl_pci_remove,
diff --git a/include/linux/fsl/pci-common.h b/include/linux/fsl/pci-common.h
index bfb1f03..84b0801 100644
--- a/include/linux/fsl/pci-common.h
+++ b/include/linux/fsl/pci-common.h
@@ -136,6 +136,8 @@ struct fsl_pci {
 	void *sys;
 };
 
+extern const struct of_device_id fsl_pci_ids[];
+
 /*
  * Convert architecture specific pci controller structure to fsl_pci
  * PowerPC uses structure pci_controller and ARM uses structure pci_sys_data
-- 
1.8.1.2
