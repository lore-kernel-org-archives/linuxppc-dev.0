Return-Path: <brking@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7551F2C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 07:31:11 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Fri, 3 May 2013 17:31:08 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 49A9A6E8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 17:31:00 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r43LV3af302502
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 17:31:03 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r43LV2EW025891
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 17:31:02 -0400
Message-Id: <201305032131.r43LV0nG025591@d01av04.pok.ibm.com>
Subject: [PATCH 1/1] powerpc: Force 32 bit MSIs for devices that require it
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Fri, 03 May 2013 16:30:59 -0500
Cc: klebers@linux.vnet.ibm.com, brking@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The following patch implements a new PAPR change which allows
the OS to force the use of 32 bit MSIs, regardless of what
the PCI capabilities indicate. This is required for some
devices that advertise support for 64 bit MSIs but don't
actually support them.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/pci-bridge.h |    2 ++
 arch/powerpc/platforms/pseries/msi.c  |   21 ++++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff -puN arch/powerpc/platforms/pseries/msi.c~powerpc_32_bit_msi_papr arch/powerpc/platforms/pseries/msi.c
--- linux/arch/powerpc/platforms/pseries/msi.c~powerpc_32_bit_msi_papr	2013-05-03 11:15:09.000000000 -0500
+++ linux-bjking1/arch/powerpc/platforms/pseries/msi.c	2013-05-03 12:33:11.000000000 -0500
@@ -24,6 +24,7 @@ static int query_token, change_token;
 #define RTAS_RESET_FN		2
 #define RTAS_CHANGE_MSI_FN	3
 #define RTAS_CHANGE_MSIX_FN	4
+#define RTAS_CHANGE_32MSI_FN	5
 
 static struct pci_dn *get_pdn(struct pci_dev *pdev)
 {
@@ -58,7 +59,8 @@ static int rtas_change_msi(struct pci_dn
 
 	seq_num = 1;
 	do {
-		if (func == RTAS_CHANGE_MSI_FN || func == RTAS_CHANGE_MSIX_FN)
+		if (func == RTAS_CHANGE_MSI_FN || func == RTAS_CHANGE_MSIX_FN ||
+		    func == RTAS_CHANGE_32MSI_FN)
 			rc = rtas_call(change_token, 6, 4, rtas_ret, addr,
 					BUID_HI(buid), BUID_LO(buid),
 					func, num_irqs, seq_num);
@@ -426,9 +428,12 @@ static int rtas_setup_msi_irqs(struct pc
 	 */
 again:
 	if (type == PCI_CAP_ID_MSI) {
-		rc = rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, nvec);
+		if (pdn->force_32bit_msi)
+			rc = rtas_change_msi(pdn, RTAS_CHANGE_32MSI_FN, nvec);
+		else
+			rc = rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, nvec);
 
-		if (rc < 0) {
+		if (rc < 0 && !pdn->force_32bit_msi) {
 			pr_debug("rtas_msi: trying the old firmware call.\n");
 			rc = rtas_change_msi(pdn, RTAS_CHANGE_FN, nvec);
 		}
@@ -512,3 +517,13 @@ static int rtas_msi_init(void)
 	return 0;
 }
 arch_initcall(rtas_msi_init);
+
+static void quirk_radeon(struct pci_dev *dev)
+{
+	struct pci_dn *pdn = get_pdn(dev);
+
+	if (pdn)
+		pdn->force_32bit_msi = 1;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x68f2, quirk_radeon);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0xaa68, quirk_radeon);
diff -puN arch/powerpc/include/asm/pci-bridge.h~powerpc_32_bit_msi_papr arch/powerpc/include/asm/pci-bridge.h
--- linux/arch/powerpc/include/asm/pci-bridge.h~powerpc_32_bit_msi_papr	2013-05-03 11:15:09.000000000 -0500
+++ linux-bjking1/arch/powerpc/include/asm/pci-bridge.h	2013-05-03 11:15:09.000000000 -0500
@@ -163,6 +163,8 @@ struct pci_dn {
 
 	int	pci_ext_config_space;	/* for pci devices */
 
+	int	force_32bit_msi:1;
+
 	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
 #ifdef CONFIG_EEH
 	struct eeh_dev *edev;		/* eeh device */
_
