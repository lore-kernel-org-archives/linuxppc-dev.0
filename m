Return-Path: <srs0=sulk=af=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xm0Vp0DrSzDqkh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2017 16:36:34 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xm0Vn6YDRz8snT
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2017 16:36:33 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xm0Vn1lvRz9s72
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Sep 2017 16:36:32 +1000 (AEST)
Message-ID: <1504506982.2250.21.camel@kernel.crashing.org>
Subject: [RFC/PATCH] powerpc/eeh: Create PHB PEs after EEH is initialized
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Cc: Russell Currey <ruscur@russell.cc>, Michael Neuling
 <michael.neuling@au1.ibm.com>
Date: Mon, 04 Sep 2017 16:36:22 +1000
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

Russell, what do you think ? The end result is that the PEs
for the PHBs are created much later. I suppose that might cause
changes of behaviour if, for example, we hit EEH while probing
before we call eeh_init() again. Hopefully we have all the
appropriate NULL checks to deal with it though...

Another option would be to break up eeh_init() between calling
the backend init, which we would unconditionally do early (ie
removing the special powernv test) and a new eeh_create_pe()'s
which would explicitely be called by the backend at the "right"
time...

Without either fix, we are currently corrupting kernel memory
when hitting EEH on a PHB PE (fences for example).

If this ends up being the right approach, then we need a CC
stable as well.

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
