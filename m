Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ADC751A0B48
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 13:36:29 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7B6AB140183
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:36:29 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 12 Nov 2014 12:36:28 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5BE202CE8065
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:36:27 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAC2aD6C41418826
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:36:13 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAC2aQLc025393
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:36:27 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 8/8] powerpc/powernv: Fix potential zero devisor
Date: Wed, 12 Nov 2014 13:36:11 +1100
Message-Id: <1415759771-11359-9-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1415759771-11359-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1415759771-11359-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If there're no PHBs under P5IOC2 HUB device tree node, we should
bail early to avoid zero devisor and allocating TCE tables.

Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-p5ioc2.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 94ce348..3336fcb 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -196,6 +196,22 @@ void __init pnv_pci_init_p5ioc2_hub(struct device_node *np)
 	hub_id = be64_to_cpup(prop64);
 	pr_info(" HUB-ID : 0x%016llx\n", hub_id);
 
+	/* Count child PHBs and calculate TCE space per PHB */
+	for_each_child_of_node(np, phbn) {
+		if (of_device_is_compatible(phbn, "ibm,p5ioc2-pcix") ||
+		    of_device_is_compatible(phbn, "ibm,p5ioc2-pciex"))
+			phb_count++;
+	}
+
+	if (phb_count <= 0) {
+		pr_info(" No PHBs for Hub %s\n", np->full_name);
+		return;
+	}
+
+	tce_per_phb = __rounddown_pow_of_two(P5IOC2_TCE_MEMORY / phb_count);
+	pr_info(" Allocating %lld MB of TCE memory per PHB\n",
+		tce_per_phb >> 20);
+
 	/* Currently allocate 16M of TCE memory for every Hub
 	 *
 	 * XXX TODO: Make it chip local if possible
@@ -215,18 +231,6 @@ void __init pnv_pci_init_p5ioc2_hub(struct device_node *np)
 		return;
 	}
 
-	/* Count child PHBs */
-	for_each_child_of_node(np, phbn) {
-		if (of_device_is_compatible(phbn, "ibm,p5ioc2-pcix") ||
-		    of_device_is_compatible(phbn, "ibm,p5ioc2-pciex"))
-			phb_count++;
-	}
-
-	/* Calculate how much TCE space we can give per PHB */
-	tce_per_phb = __rounddown_pow_of_two(P5IOC2_TCE_MEMORY / phb_count);
-	pr_info(" Allocating %lld MB of TCE memory per PHB\n",
-		tce_per_phb >> 20);
-
 	/* Initialize PHBs */
 	for_each_child_of_node(np, phbn) {
 		if (of_device_is_compatible(phbn, "ibm,p5ioc2-pcix") ||
-- 
1.8.3.2
