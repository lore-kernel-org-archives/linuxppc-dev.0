Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4743D67AC5
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 06:42:13 +1000 (EST)
Received: from sp1n294en1.watson.ibm.com (sp1n294en1.watson.ibm.com
	[129.34.20.40])
	by igw2.watson.ibm.com (8.12.11.20060308/8.13.1/8.13.1-2005-04-25 igw)
	with ESMTP id k4TKggLb014932
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:42 -0400
Received: from sp1n294en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with
	ESMTP id k4TKg8H370130
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:08 -0400
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with
	ESMTP id k4TKg73372796
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:07 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id
	k4TLZrap002585
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 17:35:53 -0400
Subject: [PATCH 4/8] Avoid use of ppc64_interrupt_controller.
In-Reply-To: <1148935262.25048.31.camel@brick>
Date: Mon, 29 May 2006 16:42:05 -0400
Message-Id: <1148935325431-git-send-email-mostrows@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linuxppc-dev@ozlabs.org
From: mostrows@watson.ibm.com
Reply-To: mostrows@watson.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Existence of "/platform-open-pic" is asserted by pSeries_setup_mpic if
an mpic interrupt controller exists.  Thus pSeries_mpic is non-NULL
only if the opprop value obtained here is good. Hence, no need to
check ppc64_intrerrupt_controller.

--
Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>

---

 arch/powerpc/kernel/rtas_pci.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

3a5eaf5436e0c413e154a933867ff5a09c019e3c
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 57b539a..e1dbd53 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -301,10 +301,8 @@ unsigned long __init find_and_init_phbs(
 	unsigned int *opprop = NULL;
 	struct device_node *root = of_find_node_by_path("/");
 
-	if (ppc64_interrupt_controller == IC_OPEN_PIC) {
-		opprop = (unsigned int *)get_property(root,
-				"platform-open-pic", NULL);
-	}
+	/* If pSeries_mpic is non-NULL, it's because opprop is non-0. */
+	opprop = (unsigned int *)get_property(root, "platform-open-pic", NULL);
 
 	root_size_cells = prom_n_size_cells(root);
 
@@ -324,7 +322,7 @@ unsigned long __init find_and_init_phbs(
 		pci_setup_phb_io(phb, index == 0);
 #ifdef CONFIG_PPC_PSERIES
 		/* XXX This code need serious fixing ... --BenH */
-		if (ppc64_interrupt_controller == IC_OPEN_PIC && pSeries_mpic) {
+		if (pSeries_mpic) {
 			int addr = root_size_cells * (index + 2) - 1;
 			mpic_assign_isu(pSeries_mpic, index, opprop[addr]);
 		}
-- 
1.1.4.g0b63-dirty
