Return-Path: <dvhltc@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B0A15B742C
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 14:29:36 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o754KvTF003225
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 22:20:57 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o754TXsP134298
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 22:29:33 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o754TWkK002127
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 22:29:33 -0600
From: Darren Hart <dvhltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] powerpc-silence-xics_migrate_irqs_away-during-cpu-offline
Date: Wed,  4 Aug 2010 21:28:35 -0700
Message-Id: <1280982515-18231-4-git-send-email-dvhltc@us.ibm.com>
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

All IRQs are migrated away from a CPU that is being offlined so the
following messages suggest a problem when the system is behaving as
designed:

IRQ 262 affinity broken off cpu 1
IRQ 17 affinity broken off cpu 0
IRQ 18 affinity broken off cpu 0
IRQ 19 affinity broken off cpu 0
IRQ 256 affinity broken off cpu 0
IRQ 261 affinity broken off cpu 0
IRQ 262 affinity broken off cpu 0

Don't print these messages when the CPU is not online.

Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
Acked-by: Will Schmidt <will_schmidt@vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Nathan Fontenot <nfont@austin.ibm.com>
Cc: Robert Jennings <rcj@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/xics.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index f19d194..8d0b0b1 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -930,8 +930,10 @@ void xics_migrate_irqs_away(void)
 		if (xics_status[0] != hw_cpu)
 			goto unlock;
 
-		printk(KERN_WARNING "IRQ %u affinity broken off cpu %u\n",
-		       virq, cpu);
+		/* This is expected during cpu offline. */
+		if (cpu_online(cpu))
+			printk(KERN_WARNING "IRQ %u affinity broken off cpu %u\n",
+			       virq, cpu);
 
 		/* Reset affinity to all cpus */
 		cpumask_setall(irq_to_desc(virq)->affinity);
-- 
1.7.0.4
