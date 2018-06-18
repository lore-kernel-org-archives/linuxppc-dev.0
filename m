Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418llR57yQzF0pl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 08:15:15 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5IMEYlA079149
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 18:15:12 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jphn501xk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 18:15:12 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Mon, 18 Jun 2018 16:15:09 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Subject: [PATCH] powerpc/pci: Remove legacy debug code
Date: Mon, 18 Jun 2018 19:15:02 -0300
Message-Id: <1529360102-8206-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 59f47eff03a0 ("powerpc/pci: Use of_irq_parse_and_map_pci() helper")
removed the 'oirq' variable, but kept memsetting it when the DEBUG macro is
defined.

When setting DEBUG macro for debugging purpose, the kernel fails to build since
'oirq' is not defined anymore.

This patch simply remove the debug block, since it does not seem to sense
now.

Fixes: 59f47eff03a08c ("powerpc/pci: Use of_irq_parse_and_map_pci() helper")

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/pci-common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index fe9733ffffaa..f9352167e619 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -366,9 +366,6 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
 
 	pr_debug("PCI: Try to map irq for %s...\n", pci_name(pci_dev));
 
-#ifdef DEBUG
-	memset(&oirq, 0xff, sizeof(oirq));
-#endif
 	/* Try to get a mapping from the device-tree */
 	virq = of_irq_parse_and_map_pci(pci_dev, 0, 0);
 	if (virq <= 0) {
-- 
2.16.3
