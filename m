Return-Path: <nacc@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 72375B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Mar 2011 06:39:33 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p23JFAcX000844
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2011 14:15:13 -0500
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D89C36E803E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Mar 2011 14:39:29 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p23JdTRc279274
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2011 14:39:29 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p23JdTCl025529
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2011 14:39:29 -0500
Received: from arkanoid.localdomain (sig-9-65-41-162.mts.ibm.com [9.65.41.162])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p23JdRrV025361
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2011 14:39:28 -0500
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: disable MSI using new interface if possible
Date: Thu,  3 Mar 2011 11:39:23 -0800
Message-Id: <1299181164-28432-1-git-send-email-nacc@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On upcoming hardware, we have a PCI adapter with two functions, one of
which uses MSI and the other uses MSI-X. This adapter, when MSI is
disabled using the "old" firmware interface (RTAS_CHANGE_FN), still
signals an MSI-X interrupt and triggers an EEH. We are working with the
vendor to ensure that the hardware is not at fault, but if we use the
"new" interface (RTAS_CHANGE_MSI_FN) to disable MSI, we also
automatically disable MSI-X and the adapter does not appear to signal
any stray MSI-X interrupt.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Milton Miller <miltonm@bga.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---

This is effectively a PCI quirk, but I'm not sure how to do a
architecture-specific quirk (looking through the code now). If anyone
has any pointers, I'd appreciate it!

 arch/powerpc/platforms/pseries/msi.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 1164c34..9434576 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -93,8 +93,18 @@ static void rtas_disable_msi(struct pci_dev *pdev)
 	if (!pdn)
 		return;
 
-	if (rtas_change_msi(pdn, RTAS_CHANGE_FN, 0) != 0)
-		pr_debug("rtas_msi: Setting MSIs to 0 failed!\n");
+	/*
+	 * disabling MSI with the explicit interface also disables MSI-X
+	 */
+	if (rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, 0) != 0) {
+		/* 
+		 * may have failed due to lacking
+		 * "ibm,change-msix-capable" property
+		 */
+		if (rtas_change_msi(pdn, RTAS_CHANGE_FN, 0) != 0) {
+			pr_debug("rtas_msi: Setting MSIs to 0 failed!\n");
+		}
+	}
 }
 
 static int rtas_query_irq_number(struct pci_dn *pdn, int offset)
-- 
1.7.1
