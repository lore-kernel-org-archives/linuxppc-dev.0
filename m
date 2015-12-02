Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BF0B1A0BC0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 16:25:44 +1100 (AEDT)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 2 Dec 2015 10:55:42 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id D1534125805B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 10:55:56 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB25Pau454526068
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2015 10:55:37 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB25Pahc010869
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2015 10:55:36 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/eeh: Fix PE location code
Date: Wed,  2 Dec 2015 16:25:32 +1100
Message-Id: <1449033932-27307-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In eeh_pe_loc_get(), the PE location code is retrieved from the
"ibm,loc-code" property of the device node for the bridge of the
PE's primary bus. It's not correct because the property indicates
the parent PE's location code.

This reads the correct PE location code from "ibm,io-base-loc-code"
or "ibm,slot-location-code" property of PE parent bus's device node.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_pe.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 8654cb1..ca9e537 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -883,32 +883,29 @@ void eeh_pe_restore_bars(struct eeh_pe *pe)
 const char *eeh_pe_loc_get(struct eeh_pe *pe)
 {
 	struct pci_bus *bus = eeh_pe_bus_get(pe);
-	struct device_node *dn = pci_bus_to_OF_node(bus);
+	struct device_node *dn;
 	const char *loc = NULL;
 
-	if (!dn)
-		goto out;
+	while (bus) {
+		dn = pci_bus_to_OF_node(bus);
+		if (!dn) {
+			bus = bus->parent;
+			continue;
+		}
 
-	/* PHB PE or root PE ? */
-	if (pci_is_root_bus(bus)) {
-		loc = of_get_property(dn, "ibm,loc-code", NULL);
-		if (!loc)
+		if (pci_is_root_bus(bus))
 			loc = of_get_property(dn, "ibm,io-base-loc-code", NULL);
+		else
+			loc = of_get_property(dn, "ibm,slot-location-code",
+					      NULL);
+
 		if (loc)
-			goto out;
+			return loc;
 
-		/* Check the root port */
-		dn = dn->child;
-		if (!dn)
-			goto out;
+		bus = bus->parent;
 	}
 
-	loc = of_get_property(dn, "ibm,loc-code", NULL);
-	if (!loc)
-		loc = of_get_property(dn, "ibm,slot-location-code", NULL);
-
-out:
-	return loc ? loc : "N/A";
+	return "N/A";
 }
 
 /**
-- 
2.1.0
