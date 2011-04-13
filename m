Return-Path: <nacc@us.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AB5C1B6EF2
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Apr 2011 00:52:59 +1000 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3DEP20b004577
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2011 10:25:02 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 761C338C8039
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2011 10:52:46 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3DEquSx214880
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2011 10:52:56 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p3DEqtu6022757
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2011 10:52:55 -0400
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Ben Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: align DTL buffer to AMS boundary
Date: Wed, 13 Apr 2011 07:52:53 -0700
Message-Id: <1302706373-11653-1-git-send-email-nacc@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PAPR specifies that DTL buffers can not cross AMS environments (aka CMO
in the PAPR) and can not cross a memory entitlement granule boundary
(4k). This is found in section 14.11.3.2 H_REGISTER_VPA of the PAPR.
kmalloc does not guarantee an alignment of the allocation, though,
beyond 8 bytes (at least in my understanding). Over-allocate and align
the resulting address. Tested both with and without AMS on a p7
partition.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---
Note, I initially put this in a firmware check if-block, but we have
also seen some issues with alignment with non-AMS partitions. The wasted
memory is unfortunate, though.

Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@ozlabs.org

 arch/powerpc/platforms/pseries/setup.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 0007241..7df5ddb 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -39,6 +39,7 @@
 #include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
+#include <linux/memblock.h>
 
 #include <asm/mmu.h>
 #include <asm/processor.h>
@@ -293,14 +294,15 @@ static int alloc_dispatch_logs(void)
 
 	for_each_possible_cpu(cpu) {
 		pp = &paca[cpu];
-		dtl = kmalloc_node(DISPATCH_LOG_BYTES, GFP_KERNEL,
-				   cpu_to_node(cpu));
+		dtl = kmalloc_node(DISPATCH_LOG_BYTES + DISPATCH_LOG_BYTES - 1,
+				   GFP_KERNEL, cpu_to_node(cpu));
 		if (!dtl) {
 			pr_warn("Failed to allocate dispatch trace log for cpu %d\n",
 				cpu);
 			pr_warn("Stolen time statistics will be unreliable\n");
 			break;
 		}
+		dtl = PTR_ALIGN(dtl, DISPATCH_LOG_BYTES);
 
 		pp->dtl_ridx = 0;
 		pp->dispatch_log = dtl;
-- 
1.7.4.1
