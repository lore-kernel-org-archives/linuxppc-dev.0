Return-Path: <galak@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 303BD67A67
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Feb 2005 07:22:47 +1100 (EST)
Date: Thu, 24 Feb 2005 14:22:32 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0502241338280.13477@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: Move from using #define SVR_ to cur_ppc_sys_spec name
 for 85xx platform
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

This patch is for post 2.6.11 and supercedes previous patches on this 
subject (excluding the proper final whitespace patch)

Removes explicit defines for SVR_85xx and use the information in the 
ppc_sys_specs table in platform code.  Changed the ppc_sys_name strings to 
be a bit more generic so we have a bit more flexilibity when we display 
them.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c	2005-02-24 10:57:54 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c	2005-02-24 10:57:54 -06:00
@@ -43,6 +43,7 @@
 #include <asm/mpc85xx.h>
 #include <asm/irq.h>
 #include <asm/immap_85xx.h>
+#include <asm/ppc_sys.h>
 
 #include <mm/mmu_decl.h>
 
@@ -128,19 +129,9 @@
 	pvid = mfspr(PVR);
 	svid = mfspr(SVR);
 
+	seq_printf(m, "chip\t\t: MPC%s\n", cur_ppc_sys_spec->ppc_sys_name);
 	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
-
-	switch (svid & 0xffff0000) {
-	case SVR_8540:
-		seq_printf(m, "Machine\t\t: mpc8540ads\n");
-		break;
-	case SVR_8560:
-		seq_printf(m, "Machine\t\t: mpc8560ads\n");
-		break;
-	default:
-		seq_printf(m, "Machine\t\t: unknown\n");
-		break;
-	}
+	seq_printf(m, "Machine\t\t: mpc%sads\n", cur_ppc_sys_spec->ppc_sys_name);
 	seq_printf(m, "clock\t\t: %dMHz\n", freq / 1000000);
 	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
 	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-02-24 10:57:54 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-02-24 10:57:54 -06:00
@@ -145,8 +145,9 @@
 	pvid = mfspr(PVR);
 	svid = mfspr(SVR);
 
+	seq_printf(m, "chip\t\t: MPC%s\n", cur_ppc_sys_spec->ppc_sys_name);
 	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
-	seq_printf(m, "Machine\t\t: CDS (%x)\n", cadmus[CM_VER]);
+	seq_printf(m, "Machine\t\t: CDS - MPC%s (%x)\n", cur_ppc_sys_spec->ppc_sys_name, cadmus[CM_VER]);
 	seq_printf(m, "clock\t\t: %dMHz\n", freq / 1000000);
 	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
 	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_sys.c b/arch/ppc/platforms/85xx/mpc85xx_sys.c
--- a/arch/ppc/platforms/85xx/mpc85xx_sys.c	2005-02-24 10:57:54 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_sys.c	2005-02-24 10:57:54 -06:00
@@ -21,7 +21,7 @@
 struct ppc_sys_spec *cur_ppc_sys_spec;
 struct ppc_sys_spec ppc_sys_specs[] = {
 	{
-		.ppc_sys_name	= "MPC8540",
+		.ppc_sys_name	= "8540",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80300000,
 		.num_devices	= 10,
@@ -33,7 +33,7 @@
 		},
 	},
 	{
-		.ppc_sys_name	= "MPC8560",
+		.ppc_sys_name	= "8560",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80700000,
 		.num_devices	= 19,
@@ -49,7 +49,7 @@
 		},
 	},
 	{
-		.ppc_sys_name	= "MPC8541",
+		.ppc_sys_name	= "8541",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80720000,
 		.num_devices	= 13,
@@ -63,7 +63,7 @@
 		},
 	},
 	{
-		.ppc_sys_name	= "MPC8541E",
+		.ppc_sys_name	= "8541E",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x807A0000,
 		.num_devices	= 14,
@@ -77,7 +77,7 @@
 		},
 	},
 	{
-		.ppc_sys_name	= "MPC8555",
+		.ppc_sys_name	= "8555",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80710000,
 		.num_devices	= 20,
@@ -94,7 +94,7 @@
 		},
 	},
 	{
-		.ppc_sys_name	= "MPC8555E",
+		.ppc_sys_name	= "8555E",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80790000,
 		.num_devices	= 21,
diff -Nru a/arch/ppc/platforms/85xx/sbc85xx.c b/arch/ppc/platforms/85xx/sbc85xx.c
--- a/arch/ppc/platforms/85xx/sbc85xx.c	2005-02-24 10:57:54 -06:00
+++ b/arch/ppc/platforms/85xx/sbc85xx.c	2005-02-24 10:57:54 -06:00
@@ -42,6 +42,7 @@
 #include <asm/mpc85xx.h>
 #include <asm/irq.h>
 #include <asm/immap_85xx.h>
+#include <asm/ppc_sys.h>
 
 #include <mm/mmu_decl.h>
 
@@ -128,19 +129,9 @@
 	pvid = mfspr(PVR);
 	svid = mfspr(SVR);
 
+	seq_printf(m, "chip\t\t: MPC%s\n", cur_ppc_sys_spec->ppc_sys_name);
 	seq_printf(m, "Vendor\t\t: Wind River\n");
-
-	switch (svid & 0xffff0000) {
-	case SVR_8540:
-		seq_printf(m, "Machine\t\t: hhmmm, this board isn't made yet!\n");
-		break;
-	case SVR_8560:
-		seq_printf(m, "Machine\t\t: SBC8560\n");
-		break;
-	default:
-		seq_printf(m, "Machine\t\t: unknown\n");
-		break;
-	}
+	seq_printf(m, "Machine\t\t: SBC%s\n", cur_ppc_sys_spec->ppc_sys_name);
 	seq_printf(m, "clock\t\t: %dMHz\n", freq / 1000000);
 	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
 	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
diff -Nru a/arch/ppc/platforms/85xx/stx_gp3.c b/arch/ppc/platforms/85xx/stx_gp3.c
--- a/arch/ppc/platforms/85xx/stx_gp3.c	2005-02-24 10:57:54 -06:00
+++ b/arch/ppc/platforms/85xx/stx_gp3.c	2005-02-24 10:57:54 -06:00
@@ -34,8 +34,10 @@
 #include <linux/root_dev.h>
 #include <linux/seq_file.h>
 #include <linux/serial.h>
+#include <linux/initrd.h>
 #include <linux/module.h>
 #include <linux/fsl_devices.h>
+#include <linux/interrupt.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -266,19 +268,9 @@
 
 	memsize = total_memory;
 
+	seq_printf(m, "chip\t\t: MPC%s\n", cur_ppc_sys_spec->ppc_sys_name);
 	seq_printf(m, "Vendor\t\t: RPC Electronics STx \n");
-
-	switch (svid & 0xffff0000) {
-	case SVR_8540:
-		seq_printf(m, "Machine\t\t: GP3 - MPC8540\n");
-		break;
-	case SVR_8560:
-		seq_printf(m, "Machine\t\t: GP3 - MPC8560\n");
-		break;
-	default:
-		seq_printf(m, "Machine\t\t: unknown\n");
-		break;
-	}
+	seq_printf(m, "Machine\t\t: GP3 - MPC%s\n", cur_ppc_sys_spec->ppc_sys_name);
 	seq_printf(m, "bus freq\t: %u.%.6u MHz\n", freq / 1000000,
 		   freq % 1000000);
 	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
diff -Nru a/include/asm-ppc/reg.h b/include/asm-ppc/reg.h
--- a/include/asm-ppc/reg.h	2005-02-24 10:57:54 -06:00
+++ b/include/asm-ppc/reg.h	2005-02-24 10:57:54 -06:00
@@ -488,12 +488,6 @@
 #define PVR_8245	0x80811014
 #define PVR_8260	PVR_8240
 
-/* System Version Numbers */
-#define SVR_8540	0x80300000
-#define SVR_8541E	0x807A0000
-#define SVR_8555E	0x80790000
-#define SVR_8560	0x80700000
-
 #if 0
 /* Segment Registers */
 #define SR0	0
