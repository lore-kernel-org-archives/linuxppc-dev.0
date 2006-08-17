Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id F30D367B5C
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 05:33:48 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k7HJXlZH022568
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 12:33:47 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k7HJXkb9027556
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 14:33:46 -0500 (CDT)
Subject: [PATCH] Use mpc8641hpcn PIC base address from dev tree.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1155842877.10054.149.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 17 Aug 2006 14:27:57 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


After going through the trouble of setting up the PIC base
address in the pic@40000 device tree node, use it instead
of the obsolete hard-coded value.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   19 +++++++++----------
 include/asm-powerpc/mpc86xx.h              |    1 -
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 496cc7c..8e43310 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -68,37 +68,36 @@ mpc86xx_hpcn_init_irq(void)
 {
 	struct mpic *mpic1;
 	struct device_node *np;
-	phys_addr_t openpic_paddr;
+	struct resource res;
 #ifdef CONFIG_PCI
 	struct device_node *cascade_node = NULL;
 	int cascade_irq;
 #endif
 
+	/* Determine PIC address. */
 	np = of_find_node_by_type(NULL, "open-pic");
 	if (np == NULL)
 		return;
-
-	/* Determine the Physical Address of the OpenPIC regs */
-	openpic_paddr = get_immrbase() + MPC86xx_OPENPIC_OFFSET;
+	of_address_to_resource(np, 0, &res);
 
 	/* Alloc mpic structure and per isu has 16 INT entries. */
-	mpic1 = mpic_alloc(np, openpic_paddr,
+	mpic1 = mpic_alloc(np, res.start,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
 			16, NR_IRQS - 4,
 			" MPIC     ");
 	BUG_ON(mpic1 == NULL);
 
-	mpic_assign_isu(mpic1, 0, openpic_paddr + 0x10000);
+	mpic_assign_isu(mpic1, 0, res.start + 0x10000);
 
 	/* 48 Internal Interrupts */
-	mpic_assign_isu(mpic1, 1, openpic_paddr + 0x10200);
-	mpic_assign_isu(mpic1, 2, openpic_paddr + 0x10400);
-	mpic_assign_isu(mpic1, 3, openpic_paddr + 0x10600);
+	mpic_assign_isu(mpic1, 1, res.start + 0x10200);
+	mpic_assign_isu(mpic1, 2, res.start + 0x10400);
+	mpic_assign_isu(mpic1, 3, res.start + 0x10600);
 
 	/* 16 External interrupts
 	 * Moving them from [0 - 15] to [64 - 79]
 	 */
-	mpic_assign_isu(mpic1, 4, openpic_paddr + 0x10000);
+	mpic_assign_isu(mpic1, 4, res.start + 0x10000);
 
 	mpic_init(mpic1);
 
diff --git a/include/asm-powerpc/mpc86xx.h b/include/asm-powerpc/mpc86xx.h
index 2d6ad85..b85df45 100644
--- a/include/asm-powerpc/mpc86xx.h
+++ b/include/asm-powerpc/mpc86xx.h
@@ -31,7 +31,6 @@ #define CPU_ALL_RELEASED (CPU0_BOOT_RELE
 #define MCM_PORT_CONFIG_OFFSET 0x1010
 
 /* Offset from CCSRBAR */
-#define MPC86xx_OPENPIC_OFFSET	(0x40000)
 #define MPC86xx_MCM_OFFSET      (0x00000)
 #define MPC86xx_MCM_SIZE        (0x02000)
 
-- 
2006_06_07.01.gittree_pull-dirty
