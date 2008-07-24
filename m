Return-Path: <markn@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (E23SMTP05.au.ibm.com [202.81.18.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6359DDDE11
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 14:28:21 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id m6O4RZTN017730
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 14:27:35 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6O4SKKZ275224
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 14:28:20 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6O4SKLT007670
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 14:28:20 +1000
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/cell: set fixed mapping to weak if we find a
	pcie-endpoint
Date: Thu, 24 Jul 2008 14:28:48 +1000
References: <200807241022.44903.markn@au1.ibm.com>
In-Reply-To: <200807241022.44903.markn@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807241428.48202.markn@au1.ibm.com>
Cc: paulus@samba.org
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
Updated thanks to Stephen Rothwell's tip that pciep didn't need to be initialized

Sorry for any confusion

 arch/powerpc/platforms/cell/iommu.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

Index: upstream/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- upstream.orig/arch/powerpc/platforms/cell/iommu.c
+++ upstream/arch/powerpc/platforms/cell/iommu.c
@@ -1150,12 +1150,23 @@ static int iommu_fixed_disabled;
 
 static int __init setup_iommu_fixed(char *str)
 {
+	struct device_node *pciep;
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
