Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA51CDE0FA
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 15:52:22 +1100 (EST)
Date: Thu, 13 Dec 2007 22:52:10 -0600 (CST)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/6] use __get_cpu_var in time.c
In-Reply-To: <mm-cpu-0@bga.com>
Message-Id: <mm-cpu-3@bga.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

use __get_cpu_var(x) instead of per_cpu(x, smp_processor_id()), as it
is optimied on ppc64 to access the current cpus per-cpu offset directly.

Its local_paca.offset instead of TOC->paca[local_paca->processor_id].offset.

This is the trivial portion, two functions with one use each.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
Index: kernel/arch/powerpc/kernel/time.c
===================================================================
--- kernel.orig/arch/powerpc/kernel/time.c	2007-12-13 20:37:03.000000000 -0600
+++ kernel/arch/powerpc/kernel/time.c	2007-12-13 20:37:03.000000000 -0600
@@ -327,7 +327,7 @@ void calculate_steal_time(void)
 
 	if (!cpu_has_feature(CPU_FTR_PURR))
 		return;
-	pme = &per_cpu(cpu_purr_data, smp_processor_id());
+	pme = &__get_cpu_var(cpu_purr_data);
 	if (!pme->initialized)
 		return;		/* this can happen in early boot */
 	tb = mftb();
@@ -352,7 +352,7 @@ static void snapshot_purr(void)
 	if (!cpu_has_feature(CPU_FTR_PURR))
 		return;
 	local_irq_save(flags);
-	pme = &per_cpu(cpu_purr_data, smp_processor_id());
+	pme = &__get_cpu_var(cpu_purr_data);
 	pme->tb = mftb();
 	pme->purr = mfspr(SPRN_PURR);
 	pme->initialized = 1;
