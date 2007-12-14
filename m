Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B0FA7DE0D5
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 15:52:23 +1100 (EST)
Date: Thu, 13 Dec 2007 22:52:19 -0600 (CST)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 5/6] depend on ->initialized in calc_steal_time
In-Reply-To: <mm-cpu-0@bga.com>
Message-Id: <mm-cpu-5@bga.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If CPU_FTR_PURR is not set, we will never set cpu_purr_data->initialized.
Checking via __get_cpu_var on 64 bit avoids one dependent load compared
to cpu_has_feature in the not present case, and is always required when
it is present.  The code is under CONFIG_VIRT_CPU_ACCOUNTING so 32 bit
will not be affected.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
Index: kernel/arch/powerpc/kernel/time.c
===================================================================
--- kernel.orig/arch/powerpc/kernel/time.c	2007-12-13 18:16:10.000000000 -0600
+++ kernel/arch/powerpc/kernel/time.c	2007-12-13 18:23:55.000000000 -0600
@@ -329,11 +329,9 @@ void calculate_steal_time(void)
 	s64 stolen;
 	struct cpu_purr_data *pme;
 
-	if (!cpu_has_feature(CPU_FTR_PURR))
-		return;
 	pme = &__get_cpu_var(cpu_purr_data);
 	if (!pme->initialized)
-		return;		/* this can happen in early boot */
+		return;		/* !CPU_FTR_PURR or early in early boot */
 	tb = mftb();
 	purr = mfspr(SPRN_PURR);
 	stolen = (tb - pme->tb) - (purr - pme->purr);
