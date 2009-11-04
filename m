Return-Path: <adetsch@br.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AF0D4B7B75
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2009 02:12:26 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA4F9ppP011237
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 08:09:51 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA4F5aIC141574
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 08:12:23 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nA4F3USI025598
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Nov 2009 08:03:31 -0700
To: linuxppc-dev@ozlabs.org, michael@ellerman.id.au
Subject: [PATCH] PCI: Fix regression in powerpc MSI-X
From: Andre Detsch <adetsch@br.ibm.com>
Date: Wed, 4 Nov 2009 13:03:19 -0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911041303.19695.adetsch@br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch f598282f5145036312d90875d0ed5c14b49fd8a7 exposed a problem in
powerpc MSI-X functionality, making network interfaces such as ixgbe
and cxgb3 stop to work when MSI-X is enabled. RX interrupts were not
being generated.

The problem was caused because MSI irq was not being effectively
unmasked after device initialization.

Signed-off-by: Andre Detsch <adetsch@br.ibm.com>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Index: linux-2.6/arch/powerpc/platforms/pseries/msi.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/msi.c	2009-11-04 
06:35:39.000000000 -0700
+++ linux-2.6/arch/powerpc/platforms/pseries/msi.c	2009-11-04 
07:23:27.000000000 -0700
@@ -432,8 +432,6 @@ static int rtas_setup_msi_irqs(struct pc
 		/* Read config space back so we can restore after reset */
 		read_msi_msg(virq, &msg);
 		entry->msg = msg;
-
-		unmask_msi_irq(virq);
 	}
 
 	return 0;
Index: linux-2.6/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/xics.c	2009-11-04 
06:35:39.000000000 -0700
+++ linux-2.6/arch/powerpc/platforms/pseries/xics.c	2009-11-04 
07:23:27.000000000 -0700
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/radix-tree.h>
 #include <linux/cpu.h>
+#include <linux/msi.h>
 #include <linux/of.h>
 
 #include <asm/firmware.h>
@@ -219,6 +220,14 @@ static void xics_unmask_irq(unsigned int
 
 static unsigned int xics_startup(unsigned int virq)
 {
+	/*
+	 * The generic MSI code returns with the interrupt disabled on the
+	 * card, using the MSI mask bits. Firmware doesn't appear to unmask
+	 * at that level, so we do it here by hand.
+	 */
+	if (irq_to_desc(virq)->msi_desc)
+		unmask_msi_irq(virq);
+
 	/* unmask it */
 	xics_unmask_irq(virq);
 	return 0;
