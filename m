Return-Path: <srs0=nllt=ai=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnrLh310BzDrVy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 16:35:56 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xnrLh2JBXz8sfq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 16:35:56 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xnrLf6y4dz9s82
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2017 16:35:54 +1000 (AEST)
Message-ID: <1504766140.12628.14.camel@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/eeh: Create PHB PEs after EEH is initialized
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Cc: Russell Currey <ruscur@au1.ibm.com>
Date: Thu, 07 Sep 2017 16:35:40 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Otherwise we end up not yet having computed the right
diag data size on powernv where EEH initialization
is delayed, thus causing memory corruption later on
when calling OPAL.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/eeh.c     |  4 ++++
 arch/powerpc/kernel/eeh_dev.c | 18 ------------------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 63992b2d8e15..f27eecd5ec7f 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1018,6 +1018,10 @@ int eeh_init(void)
 	} else if ((ret = eeh_ops->init()))
 		return ret;
 
+	/* Initialize PHB PEs */
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
+		eeh_dev_phb_init_dynamic(hose);
+
 	/* Initialize EEH event */
 	ret = eeh_event_init();
 	if (ret)
diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
index d6b2ca70d14d..0820b73288c0 100644
--- a/arch/powerpc/kernel/eeh_dev.c
+++ b/arch/powerpc/kernel/eeh_dev.c
@@ -83,21 +83,3 @@ void eeh_dev_phb_init_dynamic(struct pci_controller *phb)
 	/* EEH PE for PHB */
 	eeh_phb_pe_create(phb);
 }
-
-/**
- * eeh_dev_phb_init - Create EEH devices for devices included in existing PHBs
- *
- * Scan all the existing PHBs and create EEH devices for their OF
- * nodes and their children OF nodes
- */
-static int __init eeh_dev_phb_init(void)
-{
-	struct pci_controller *phb, *tmp;
-
-	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
-		eeh_dev_phb_init_dynamic(phb);
-
-	return 0;
-}
-
-core_initcall(eeh_dev_phb_init);
