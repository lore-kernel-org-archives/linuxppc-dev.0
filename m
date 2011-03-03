Return-Path: <nacc@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8286DB70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Mar 2011 06:39:33 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p23JL9tj007774
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2011 14:21:11 -0500
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id C5E356E8038
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Mar 2011 14:39:29 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p23JdTx9210298
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2011 14:39:29 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p23JdTfj012644
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2011 14:39:29 -0500
Received: from arkanoid.localdomain (sig-9-65-41-162.mts.ibm.com [9.65.41.162])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p23JdRQ0012416
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2011 14:39:28 -0500
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/msi: clarify call to check_req_msi{,x}
Date: Thu,  3 Mar 2011 11:39:24 -0800
Message-Id: <1299181164-28432-2-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1299181164-28432-1-git-send-email-nacc@us.ibm.com>
References: <1299181164-28432-1-git-send-email-nacc@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The RTAS IRQ fixup code relies on a less-than-clear edge condition for
verifying a given device is not using MSI or MSI-X. Make that more clear
with a comment.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Milton Miller <miltonm@bga.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>

---
 arch/powerpc/platforms/pseries/msi.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 9434576..8c6dbbc 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -455,7 +455,12 @@ static void rtas_msi_pci_irq_fixup(struct pci_dev *pdev)
 		return;
 	}
 
-	/* No MSI -> MSIs can't have been assigned by fw, leave LSI */
+	/* 
+	 * No MSI -> MSIs can't have been assigned by fw, leave LSI
+	 * The calls below can only provide one of two responses:
+	 *   < 0: if the device doesn't request MSI or MSI-X
+	 *   0: if the device requests at least 1 MSI/MSI-X vector
+	 */
 	if (check_req_msi(pdev, 1) && check_req_msix(pdev, 1)) {
 		dev_dbg(&pdev->dev, "rtas_msi: no req#msi/x, nothing to do.\n");
 		return;
-- 
1.7.1
