Return-Path: <bgill@freescale.com>
Date: Tue, 7 Feb 2006 23:06:44 -0600 (CST)
From: Becky Bruce <bgill@freescale.com>
To: linuxppc-dev@ozlabs.com
Subject: [PATCH] powerpc: revised lindent 85xx platform
Message-ID: <Pine.LNX.4.61.0602072305050.19452@cde-tx32-ldt329.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Run lindent on platforms/85xx; realign comments per Kumar's
request.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>

---
commit fc0f97844613540b621709581b77d917d9a5a773
tree 68c3dbfd7445c8cf9273a0d931deb60730fd3439
parent 50474eaccb537d65525f43d832fb4196d592e670
author Becky Bruce <becky.bruce@freescale.com> Tue, 07 Feb 2006 23:01:59 -0600
committer Becky Bruce <becky.bruce@freescale.com> Tue, 07 Feb 2006 23:01:59 -0600

 arch/powerpc/platforms/85xx/mpc8540_ads.h |    2 +
 arch/powerpc/platforms/85xx/mpc85xx_ads.c |   48 +++++++++++------------------
 2 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc8540_ads.h b/arch/powerpc/platforms/85xx/mpc8540_ads.h
index 47609c9..b3ec88c 100644
--- a/arch/powerpc/platforms/85xx/mpc8540_ads.h
+++ b/arch/powerpc/platforms/85xx/mpc8540_ads.h
@@ -57,4 +57,4 @@
 /* Offset of CPM register space */
 #define CPM_MAP_ADDR	(CCSRBAR + MPC85xx_CPM_OFFSET)
 
-#endif /* __MACH_MPC8540ADS_H__ */
+#endif				/* __MACH_MPC8540ADS_H__ */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 9e8a91b..e14cd20 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -38,7 +38,6 @@ unsigned long isa_io_base = 0;
 unsigned long isa_mem_base = 0;
 #endif
 
-
 /*
  * Internal interrupts are all Level Sensitive, and Positive Polarity
  *
@@ -54,21 +53,20 @@ static u_char mpc85xx_ads_openpic_initse
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 3: PCI slot 2 */
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 4: PCI slot 3 */
 #else
-	0x0,				/* External  1: */
-	0x0,				/* External  2: */
-	0x0,				/* External  3: */
-	0x0,				/* External  4: */
+	0x0,						/* External  1: */
+	0x0,						/* External  2: */
+	0x0,						/* External  3: */
+	0x0,						/* External  4: */
 #endif
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 5: PHY */
-	0x0,				/* External  6: */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 7: PHY */
-	0x0,				/* External  8: */
-	0x0,				/* External  9: */
-	0x0,				/* External 10: */
-	0x0,				/* External 11: */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External  5: PHY */
+	0x0,						/* External  6: */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External  7: PHY */
+	0x0,						/* External  8: */
+	0x0,						/* External  9: */
+	0x0,						/* External 10: */
+	0x0,						/* External 11: */
 };
 
-
 void __init mpc85xx_ads_pic_init(void)
 {
 	struct mpic *mpic1;
@@ -78,10 +76,11 @@ void __init mpc85xx_ads_pic_init(void)
 	OpenPIC_PAddr = get_immrbase() + MPC85xx_OPENPIC_OFFSET;
 
 	mpic1 = mpic_alloc(OpenPIC_PAddr,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			4, MPC85xx_OPENPIC_IRQ_OFFSET, 0, 250,
-			mpc85xx_ads_openpic_initsenses,
-			sizeof(mpc85xx_ads_openpic_initsenses), " OpenPIC  ");
+			   MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			   4, MPC85xx_OPENPIC_IRQ_OFFSET, 0, 250,
+			   mpc85xx_ads_openpic_initsenses,
+			   sizeof(mpc85xx_ads_openpic_initsenses),
+			   " OpenPIC  ");
 	BUG_ON(mpic1 == NULL);
 	mpic_assign_isu(mpic1, 0, OpenPIC_PAddr + 0x10200);
 	mpic_assign_isu(mpic1, 1, OpenPIC_PAddr + 0x10280);
@@ -105,12 +104,10 @@ void __init mpc85xx_ads_pic_init(void)
 	mpic_init(mpic1);
 }
 
-
 /*
  * Setup the architecture
  */
-static void __init
-mpc85xx_ads_setup_arch(void)
+static void __init mpc85xx_ads_setup_arch(void)
 {
 	struct device_node *cpu;
 
@@ -128,7 +125,6 @@ mpc85xx_ads_setup_arch(void)
 			loops_per_jiffy = 50000000 / HZ;
 		of_node_put(cpu);
 	}
-
 #ifdef  CONFIG_ROOT_NFS
 	ROOT_DEV = Root_NFS;
 #else
@@ -136,9 +132,7 @@ mpc85xx_ads_setup_arch(void)
 #endif
 }
 
-
-void
-mpc85xx_ads_show_cpuinfo(struct seq_file *m)
+void mpc85xx_ads_show_cpuinfo(struct seq_file *m)
 {
 	uint pvid, svid, phid1;
 	uint memsize = total_memory;
@@ -159,9 +153,7 @@ mpc85xx_ads_show_cpuinfo(struct seq_file
 	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
 
-
-void __init
-platform_init(void)
+void __init platform_init(void)
 {
 	ppc_md.setup_arch = mpc85xx_ads_setup_arch;
 	ppc_md.show_cpuinfo = mpc85xx_ads_show_cpuinfo;
@@ -183,5 +175,3 @@ platform_init(void)
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_ads platform_init(): exit", 0);
 }
-
-
