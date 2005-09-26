Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C29DE68363
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Sep 2005 13:42:45 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 13:42:12 +1000
Message-Id: <1127706133.15882.23.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] ppc: fix stupid thinko in oprofile fix
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I did something stupid in my oprofile fix, here's the obvious fix:

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/kernel/perfmon.c
===================================================================
--- linux-work.orig/arch/ppc/kernel/perfmon.c	2005-09-26 09:53:19.000000000 +1000
+++ linux-work/arch/ppc/kernel/perfmon.c	2005-09-26 13:40:16.000000000 +1000
@@ -45,9 +45,8 @@
 	mtpmr(PMRN_PMGC0, pmgc0);
 }
 
-#elif CONFIG_6xx
+#elif defined(CONFIG_6xx)
 /* Ensure exceptions are disabled */
-
 static void dummy_perf(struct pt_regs *regs)
 {
 	unsigned int mmcr0 = mfspr(SPRN_MMCR0);
