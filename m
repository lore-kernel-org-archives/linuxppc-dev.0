Return-Path: <galak@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id BDC4567A65
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Mar 2005 11:26:59 +1100 (EST)
Date: Fri, 18 Mar 2005 18:26:52 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <Pine.LNX.4.61.0503181818330.26408@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [RFC] ppc32: Report chip version in common /proc/cpuinfo handling
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Tom,

You asked me to look at doing the following.  I just want to make sure 
this is what we want to do (and call it).  I'm a little concerned that 
'chip' is not necessary the right name in light of TSI10x and MV64x60 
being described by ppc_sys in the future.

- kumar

--

Moved reporting of chip revision from board specific to common handing of 
/proc/cpuinfo.  In light of numerous PPC system-on-chip devices, we report 
both the cpu version (reflects the core version) and the chip version 
(reflects the system-on-chip version).

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
--- a/arch/ppc/kernel/setup.c	2005-03-18 18:17:16 -06:00
+++ b/arch/ppc/kernel/setup.c	2005-03-18 18:17:16 -06:00
@@ -40,6 +40,7 @@
 #include <asm/nvram.h>
 #include <asm/xmon.h>
 #include <asm/ocp.h>
+#include <asm/ppc_sys.h>
 
 #if defined CONFIG_KGDB
 #include <asm/kgdb.h>
@@ -245,6 +246,11 @@
 
 	seq_printf(m, "bogomips\t: %lu.%02lu\n",
 		   lpj / (500000/HZ), (lpj / (5000/HZ)) % 100);
+
+#if defined (CONFIG_85xx) || defined (CONFIG_83xx)
+	if (cur_ppc_sys_spec->ppc_sys_name)
+		seq_printf(m, "chip\t\t: %s\n", cur_ppc_sys_spec->ppc_sys_name);
+#endif
 
 #ifdef CONFIG_SMP
 	seq_printf(m, "\n");
diff -Nru a/arch/ppc/platforms/83xx/mpc834x_sys.c b/arch/ppc/platforms/83xx/mpc834x_sys.c
--- a/arch/ppc/platforms/83xx/mpc834x_sys.c	2005-03-18 18:17:16 -06:00
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.c	2005-03-18 18:17:16 -06:00
@@ -143,7 +143,6 @@
 	pvid = mfspr(SPRN_PVR);
 	svid = mfspr(SPRN_SVR);
 
-	seq_printf(m, "chip\t\t: MPC%s\n", cur_ppc_sys_spec->ppc_sys_name);
 	seq_printf(m, "Vendor\t\t: Freescale Inc.\n");
 	seq_printf(m, "Machine\t\t: mpc%s sys\n", cur_ppc_sys_spec->ppc_sys_name);
 	seq_printf(m, "core clock\t: %d MHz\n"
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c	2005-03-18 18:17:16 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c	2005-03-18 18:17:16 -06:00
@@ -129,7 +129,6 @@
 	pvid = mfspr(SPRN_PVR);
 	svid = mfspr(SPRN_SVR);
 
-	seq_printf(m, "chip\t\t: MPC%s\n", cur_ppc_sys_spec->ppc_sys_name);
 	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
 	seq_printf(m, "Machine\t\t: mpc%sads\n", cur_ppc_sys_spec->ppc_sys_name);
 	seq_printf(m, "clock\t\t: %dMHz\n", freq / 1000000);
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-03-18 18:17:16 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-03-18 18:17:16 -06:00
@@ -146,7 +146,6 @@
 	pvid = mfspr(SPRN_PVR);
 	svid = mfspr(SPRN_SVR);
 
-	seq_printf(m, "chip\t\t: MPC%s\n", cur_ppc_sys_spec->ppc_sys_name);
 	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
 	seq_printf(m, "Machine\t\t: CDS - MPC%s (%x)\n", cur_ppc_sys_spec->ppc_sys_name, cadmus[CM_VER]);
 	seq_printf(m, "clock\t\t: %dMHz\n", freq / 1000000);
diff -Nru a/arch/ppc/platforms/85xx/sbc85xx.c b/arch/ppc/platforms/85xx/sbc85xx.c
--- a/arch/ppc/platforms/85xx/sbc85xx.c	2005-03-18 18:17:16 -06:00
+++ b/arch/ppc/platforms/85xx/sbc85xx.c	2005-03-18 18:17:16 -06:00
@@ -129,7 +129,6 @@
 	pvid = mfspr(SPRN_PVR);
 	svid = mfspr(SPRN_SVR);
 
-	seq_printf(m, "chip\t\t: MPC%s\n", cur_ppc_sys_spec->ppc_sys_name);
 	seq_printf(m, "Vendor\t\t: Wind River\n");
 	seq_printf(m, "Machine\t\t: SBC%s\n", cur_ppc_sys_spec->ppc_sys_name);
 	seq_printf(m, "clock\t\t: %dMHz\n", freq / 1000000);
diff -Nru a/arch/ppc/platforms/85xx/stx_gp3.c b/arch/ppc/platforms/85xx/stx_gp3.c
--- a/arch/ppc/platforms/85xx/stx_gp3.c	2005-03-18 18:17:16 -06:00
+++ b/arch/ppc/platforms/85xx/stx_gp3.c	2005-03-18 18:17:16 -06:00
@@ -268,7 +268,6 @@
 
 	memsize = total_memory;
 
-	seq_printf(m, "chip\t\t: MPC%s\n", cur_ppc_sys_spec->ppc_sys_name);
 	seq_printf(m, "Vendor\t\t: RPC Electronics STx \n");
 	seq_printf(m, "Machine\t\t: GP3 - MPC%s\n", cur_ppc_sys_spec->ppc_sys_name);
 	seq_printf(m, "bus freq\t: %u.%.6u MHz\n", freq / 1000000,
