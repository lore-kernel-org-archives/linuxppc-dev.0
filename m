Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 573B71A0C19
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 14:28:46 +1000 (AEST)
Received: from mail-pd0-x22c.google.com (mail-pd0-x22c.google.com
 [IPv6:2607:f8b0:400e:c02::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CEC36140281
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2015 14:28:45 +1000 (AEST)
Received: by pdbqa5 with SMTP id qa5so130485162pdb.1
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Apr 2015 21:28:44 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au
Subject: [PATCH 09/10] powerpc/mpic_u3msi: Move MSI-related ops to
 pci_controller_ops
Date: Tue, 14 Apr 2015 14:28:02 +1000
Message-Id: <1428985683-24767-10-git-send-email-dja@axtens.net>
In-Reply-To: <1428985683-24767-1-git-send-email-dja@axtens.net>
References: <1428985683-24767-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the u3 MPIC msi subsystem to use the pci_controller_ops structure
rather than ppc_md for MSI related PCI controller operations.

As with fsl_msi, operations are plugged in at the subsys level, after
controller creation. Again, we iterate over all controllers and
populate them with the MSI ops.
---
 arch/powerpc/sysdev/mpic_u3msi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
index b2cef18..fc46ef3 100644
--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -181,6 +181,7 @@ static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 int mpic_u3msi_init(struct mpic *mpic)
 {
 	int rc;
+	struct pci_controller *phb;
 
 	rc = mpic_msi_init_allocator(mpic);
 	if (rc) {
@@ -193,9 +194,11 @@ int mpic_u3msi_init(struct mpic *mpic)
 	BUG_ON(msi_mpic);
 	msi_mpic = mpic;
 
-	WARN_ON(ppc_md.setup_msi_irqs);
-	ppc_md.setup_msi_irqs = u3msi_setup_msi_irqs;
-	ppc_md.teardown_msi_irqs = u3msi_teardown_msi_irqs;
+	list_for_each_entry(phb, &hose_list, list_node) {
+		WARN_ON(phb->controller_ops.setup_msi_irqs);
+		phb->controller_ops.setup_msi_irqs = u3msi_setup_msi_irqs;
+		phb->controller_ops.teardown_msi_irqs = u3msi_teardown_msi_irqs;
+	}
 
 	return 0;
 }
-- 
2.1.4
