Return-Path: <nfont@austin.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E70D11007D9
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 01:48:43 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6CFWgth031067
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 11:32:42 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6CFmeOw1376426
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 11:48:40 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6CFmdQZ015959
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 11:48:39 -0400
Message-ID: <4C3B3956.3020205@austin.ibm.com>
Date: Mon, 12 Jul 2010 10:48:38 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] Enable multiple memory sections per sysfs memory directory
	for powerpc/pseries
References: <4C3B3446.5090302@austin.ibm.com>
In-Reply-To: <4C3B3446.5090302@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch updates the powerpc/pseries code to initialize
the memory sysfs directory creation to create sysfs directories
that each cover an LMB's worth of memory.

Signed-off-by; Nathan Fontenot <nfont@austin.ibm.ocm>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |   66 +++++++++++++++++++-----
 1 file changed, 53 insertions(+), 13 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/pseries/hotplug-memory.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/hotplug-memory.c	2010-07-09 14:36:52.000000000 -0500
+++ linux-2.6/arch/powerpc/platforms/pseries/hotplug-memory.c	2010-07-09 14:38:25.000000000 -0500
@@ -17,6 +17,54 @@
 #include <asm/pSeries_reconfig.h>
 #include <asm/sparsemem.h>
 
+static u32 get_lmb_size(void)
+{
+	struct device_node *np;
+	unsigned int lmb_size = 0;
+
+	np = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (np) {
+		const unsigned int *size;
+
+		size = of_get_property(np, "ibm,lmb-size", NULL);
+		lmb_size = size ? *size : 0;
+
+		of_node_put(np);
+	} else {
+		const unsigned int *regs;
+
+		np = of_find_node_by_path("/memory@0");
+		if (np) {
+			regs = of_get_property(np, "reg", NULL);
+			lmb_size = regs ? regs[3] : 0;
+			of_node_put(np);
+		}
+
+		if (lmb_size) {
+			/* We now know the size of memory@0, use this to find
+			 * the first lmb and get its size.
+			 */
+			char buf[64];
+
+			sprintf(buf, "/memory@%x", lmb_size);
+			np = of_find_node_by_path(buf);
+			if (np) {
+				regs = of_get_property(np, "reg", NULL);
+				lmb_size = regs ? regs[3] : 0;
+				of_node_put(np);
+			} else
+				lmb_size = 0;
+		}
+	}
+
+	return lmb_size;
+}
+
+u32 memory_block_size(void)
+{
+	return get_lmb_size();
+}
+
 static int pseries_remove_lmb(unsigned long base, unsigned int lmb_size)
 {
 	unsigned long start, start_pfn;
@@ -127,30 +175,22 @@
 
 static int pseries_drconf_memory(unsigned long *base, unsigned int action)
 {
-	struct device_node *np;
-	const unsigned long *lmb_size;
+	unsigned long lmb_size;
 	int rc;
 
-	np = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
-	if (!np)
+	lmb_size = get_lmb_size();
+	if (!lmb_size)
 		return -EINVAL;
 
-	lmb_size = of_get_property(np, "ibm,lmb-size", NULL);
-	if (!lmb_size) {
-		of_node_put(np);
-		return -EINVAL;
-	}
-
 	if (action == PSERIES_DRCONF_MEM_ADD) {
-		rc = lmb_add(*base, *lmb_size);
+		rc = lmb_add(*base, lmb_size);
 		rc = (rc < 0) ? -EINVAL : 0;
 	} else if (action == PSERIES_DRCONF_MEM_REMOVE) {
-		rc = pseries_remove_lmb(*base, *lmb_size);
+		rc = pseries_remove_lmb(*base, lmb_size);
 	} else {
 		rc = -EINVAL;
 	}
 
-	of_node_put(np);
 	return rc;
 }
