Return-Path: <minyard@acm.org>
Received: from vms173003pub.verizon.net (vms173003pub.verizon.net
	[206.46.173.3]) by ozlabs.org (Postfix) with ESMTP id B27CDB7D24
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Feb 2010 02:08:49 +1100 (EST)
Received: from wf-rch.minyard.local ([unknown] [173.57.145.237])
	by vms173003.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0KX9000HSU1V6KLC@vms173003.mailsrvcs.net> for
	linuxppc-dev@ozlabs.org; Wed, 03 Feb 2010 09:08:19 -0600 (CST)
Date: Wed, 03 Feb 2010 09:08:17 -0600
From: Corey Minyard <minyard@acm.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add coherent_dma_mask to mv64x60 devices
Message-id: <20100203150817.GA13461@minyard.local>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Reply-To: minyard@acm.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Corey Minyard <cminyard@mvista.com>

DMA ops requires that coherent_dma_mask be set properly for a device,
but this was not being done for devices on the MV64x60 that use DMA.
Both the serial and ethernet devices need this or they won't be able
to allocate memory.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
Mark Greer pointed me to the right place, I believe this is the
correct way to handle the problem.

Index: linux-2.6/arch/powerpc/sysdev/mv64x60_dev.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/mv64x60_dev.c
+++ linux-2.6/arch/powerpc/sysdev/mv64x60_dev.c
@@ -16,6 +16,7 @@
 #include <linux/mv643xx.h>
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/prom.h>
 
@@ -189,6 +190,7 @@ static int __init mv64x60_mpsc_device_se
 	pdev = platform_device_alloc(MPSC_CTLR_NAME, port_number);
 	if (!pdev)
 		return -ENOMEM;
+	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 
 	err = platform_device_add_resources(pdev, r, 5);
 	if (err)
@@ -302,6 +304,7 @@ static int __init mv64x60_eth_device_set
 	if (!pdev)
 		return -ENOMEM;
 
+	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 	err = platform_device_add_resources(pdev, r, 1);
 	if (err)
 		goto error;
