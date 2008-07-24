Return-Path: <markn@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (E23SMTP01.au.ibm.com [202.81.18.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0D2D8DDEE3
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 10:22:22 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id m6O0MjIX027027
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 10:22:45 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6O0MKFT304466
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 10:22:20 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6O0MK5v027786
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 10:22:20 +1000
From: Mark Nelson <markn@au1.ibm.com>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH] powerpc/cell: set fixed mapping to weak if we find a
	pcie-endpoint
Date: Thu, 24 Jul 2008 10:22:44 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200807241022.44903.markn@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark Nelson <markn@au1.ibm.com>

At the moment the fixed mapping is by default strongly ordered (the
iommu_fixed=weak boot option must be used to make the fixed mapping weakly
ordered). If we're on a setup where the southbridge is being used in
endpoint mode (triblade and CAB boards) the default should be a weakly
ordered fixed mapping.

This adds a check so that if a node of type pcie-endpoint can be found in
the device tree the fixed mapping is set to be weak by default (but can be
overridden using iommu_fixed=strong).

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/iommu.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

Index: upstream/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- upstream.orig/arch/powerpc/platforms/cell/iommu.c
+++ upstream/arch/powerpc/platforms/cell/iommu.c
@@ -1150,12 +1150,23 @@ static int iommu_fixed_disabled;
 
 static int __init setup_iommu_fixed(char *str)
 {
+	struct device_node *pciep = NULL;
+
 	if (strcmp(str, "off") == 0)
 		iommu_fixed_disabled = 1;
 
-	else if (strcmp(str, "weak") == 0)
+	/* If we can find a pcie-endpoint in the device tree assume that
+	 * we're on a triblade or a CAB so by default the fixed mapping
+	 * should be set to be weakly ordered; but only if the boot
+	 * option WASN'T set for strong ordering
+	 */
+	pciep = of_find_node_by_type(NULL, "pcie-endpoint");
+
+	if (strcmp(str, "weak") == 0 || (pciep && strcmp(str, "strong") != 0))
 		iommu_fixed_is_weak = 1;
 
+	of_node_put(pciep);
+
 	return 1;
 }
 __setup("iommu_fixed=", setup_iommu_fixed);
