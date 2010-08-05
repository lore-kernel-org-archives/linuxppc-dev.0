Return-Path: <dvhltc@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0E3CD1007EB
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 14:29:22 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o754KgtN001522
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 22:20:42 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o754TK1n135056
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 22:29:20 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o754TJll005604
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 22:29:20 -0600
From: Darren Hart <dvhltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] powerpc-silence-__cpu_up-under-normal-operation
Date: Wed,  4 Aug 2010 21:28:34 -0700
Message-Id: <1280982515-18231-3-git-send-email-dvhltc@us.ibm.com>
In-Reply-To: <1280982515-18231-1-git-send-email-dvhltc@us.ibm.com>
References: <1280982515-18231-1-git-send-email-dvhltc@us.ibm.com>
Cc: dvhltc@us.ibm.com, brking@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	will_schmidt@vnet.ibm.com, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Signed-off-by: Darren Hart <dvhltc@us.ibm.com>

During CPU offline/online tests __cpu_up would flood the logs with
the following message:

Processor 0 found.

This provides no useful information to the user as there is no context
provided, and since the operation was a success (to this point) it is expected
that the CPU will come back online, providing all the feedback necessary.

Change the "Processor found" message to DBG() similar to other such messages in
the same function. Also, add an appropriate log level for the "Processor is
stuck" message.

Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
Acked-by: Will Schmidt <will_schmidt@vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Nathan Fontenot <nfont@austin.ibm.com>
Cc: Robert Jennings <rcj@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/smp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5c196d1..cc05792 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -429,11 +429,11 @@ int __cpuinit __cpu_up(unsigned int cpu)
 #endif
 
 	if (!cpu_callin_map[cpu]) {
-		printk("Processor %u is stuck.\n", cpu);
+		printk(KERN_ERR "Processor %u is stuck.\n", cpu);
 		return -ENOENT;
 	}
 
-	printk("Processor %u found.\n", cpu);
+	DBG("Processor %u found.\n", cpu);
 
 	if (smp_ops->give_timebase)
 		smp_ops->give_timebase();
-- 
1.7.0.4
