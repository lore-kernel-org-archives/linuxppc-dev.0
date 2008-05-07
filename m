Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 07 May 2008 10:25:34 +1000
Subject: [PATCH] [POWERPC] Initialize lockdep earlier
Message-Id: <20080507002714.B2FEFDDECA@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This moves lockdep_init() to before udbg_early_init() as the later
can call things that acquire spinlocks etc... This also makes printk
safer to use earlier.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/setup_64.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/setup_64.c	2008-05-07 10:23:35.000000000 +1000
+++ linux-work/arch/powerpc/kernel/setup_64.c	2008-05-07 10:23:45.000000000 +1000
@@ -181,14 +181,14 @@ void __init early_setup(unsigned long dt
 	/* Assume we're on cpu 0 for now. Don't write to the paca yet! */
 	setup_paca(0);
 
-	/* Enable early debugging if any specified (see udbg.h) */
-	udbg_early_init();
-
 	/* Initialize lockdep early or else spinlocks will blow */
 	lockdep_init();
 
 	/* -------- printk is now safe to use ------- */
 
+	/* Enable early debugging if any specified (see udbg.h) */
+	udbg_early_init();
+
  	DBG(" -> early_setup(), dt_ptr: 0x%lx\n", dt_ptr);
 
 	/*
