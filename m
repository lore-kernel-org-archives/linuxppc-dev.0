Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 65017DDFC3
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 16:14:49 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n0C5EcPK027453
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jan 2009 23:14:39 -0600
Subject: [PATCH] powermac: Fix occasional SMP boot failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 12 Jan 2009 16:03:45 +1100
Message-Id: <1231736625.22571.16.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PowerMac kernel occasionally fails to bring up the secondary CPUs on
SMP, the trigger factor seem to be fairly random and related to location
of code and data.

This appears to be due to the initial loading of the TOC value by the
secondary processor which now happens before we clear HID4:RM_CI (Real
Mode Cache Invalidate). This bit should really be cleared before we do
any load or store other than fetching code.

This fix works based on the assumption that all SMP 64-bit PowerMacs use
variants of the 970, which fortunately is true, by explicitely clearing
that bit, adding an slbia for good measure as RM_CI mode is known to
create bogus ERAT entries.

I also removed some spurrious debug output that was left enabled by
mistake while at it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index b4bcf5a..ebaedaf 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -1518,6 +1518,15 @@ _GLOBAL(pmac_secondary_start)
 	/* turn on 64-bit mode */
 	bl	.enable_64b_mode
 
+	li	r0,0
+	mfspr	r3,SPRN_HID4
+	rldimi	r3,r0,40,23	/* clear bit 23 (rm_ci) */
+	sync
+	mtspr	SPRN_HID4,r3
+	isync
+	sync
+	slbia
+
 	/* get TOC pointer (real address) */
 	bl	.relative_toc
 
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 6b0711c..bd8817b 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -53,7 +53,7 @@
 #include <asm/pmac_low_i2c.h>
 #include <asm/pmac_pfunc.h>
 
-#define DEBUG
+#undef DEBUG
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
