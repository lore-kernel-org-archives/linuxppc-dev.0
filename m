Return-Path: <galak@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 8B95667A76
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Feb 2005 15:59:26 +1100 (EST)
Date: Tue, 22 Feb 2005 22:59:17 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0502222257230.7799@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: [PPC32][update] Report chip version in /proc/cpuinfo for 85xx boards
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,

Here here is an updated version of the previous patch which fixes a 
build problem.  It is for post 2.6.11.

Report the chip version in /proc/cpuinfo on 85xx ADS and CDS platforms.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

--- a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c	2005-02-22 22:55:17 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c	2005-02-22 22:55:17 -06:00
@@ -43,6 +43,7 @@
 #include <asm/mpc85xx.h>
 #include <asm/irq.h>
 #include <asm/immap_85xx.h>
+#include <asm/ppc_sys.h>
 
 #include <mm/mmu_decl.h>
 
@@ -128,6 +129,7 @@
 	pvid = mfspr(PVR);
 	svid = mfspr(SVR);
 
+	seq_printf(m, "chip\t\t: %s\n", cur_ppc_sys_spec->ppc_sys_name);
 	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
 
 	switch (svid & 0xffff0000) {
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-02-22 13:22:09 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-02-22 13:22:09 -06:00
@@ -145,6 +145,7 @@
         pvid = mfspr(PVR);
         svid = mfspr(SVR);
 
+	seq_printf(m, "chip\t\t: %s\n", cur_ppc_sys_spec->ppc_sys_name);
         seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
 	seq_printf(m, "Machine\t\t: CDS (%x)\n", cadmus[CM_VER]);
 	seq_printf(m, "clock\t\t: %dMHz\n", freq / 1000000);
