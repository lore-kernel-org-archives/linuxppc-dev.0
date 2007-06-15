Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 07E90DDFE3
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 04:54:51 +1000 (EST)
Date: Fri, 15 Jun 2007 12:33:08 -0500
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org,
Subject: [PATCH] numa: enforce iommu-off memory address limit
Message-Id: <111819287886b8b45671.846930886.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Don't short circuit the lmb_end_of_DRAM if iommu_is_off.

If linux,iommu-off is in /chosen (because iommu=off was on the command
line), we limit the memory when adding it to the lmbs and page tables,
but not when numa parses the device tree for numa affinity.  When we
free bootmem, we then try to use these pages without mapping them or
allocating supporting data structures resulting in bad_page and/or data
storage interrupts.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
Paul, I think this can wait for 2.6.23 although its small enough
if you want to send it for 2.6.22.

Index: kernel/arch/powerpc/mm/numa.c
===================================================================
--- kernel.orig/arch/powerpc/mm/numa.c	2007-06-15 01:10:19.000000000 -0500
+++ kernel/arch/powerpc/mm/numa.c	2007-06-15 01:41:32.000000000 -0500
@@ -21,6 +21,7 @@
 #include <asm/lmb.h>
 #include <asm/system.h>
 #include <asm/smp.h>
+#include <asm/iommu.h>
 
 static int numa_enabled = 1;
 
@@ -286,7 +287,7 @@ static unsigned long __init numa_enforce
 	 * having memory holes below the limit.
 	 */
 
-	if (! memory_limit)
+	if (!memory_limit && !iommu_is_off)
 		return size;
 
 	if (start + size <= lmb_end_of_DRAM())
