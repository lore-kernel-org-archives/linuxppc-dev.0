Return-Path: <B38951@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe002.messaging.microsoft.com [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C21092C0145
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 13:40:56 +1100 (EST)
From: Jia Hongtao <hongtao.jia@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH V3 1/2] powerpc/MPIC: Add get_version API both for internal
 and external use
Date: Wed, 3 Apr 2013 10:03:17 +0800
Message-ID: <1364954598-31914-1-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B07421@freescale.com, hongtao.jia@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPIC version is useful information for both mpic_alloc() and mpic_init().
The patch provide an API to get MPIC version for reusing the code.
Also, some other IP block may need MPIC version for their own use.
The API for external use is also provided.

Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
Changes for V3:
* change the name of function from mpic_primary_get_version() to
  fsl_mpic_primary_get_version().
* return 0 if mpic_primary is null.

 arch/powerpc/include/asm/mpic.h |  3 +++
 arch/powerpc/sysdev/mpic.c      | 29 ++++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index c0f9ef9..ea6bf72 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -393,6 +393,9 @@ struct mpic
 #define	MPIC_REGSET_STANDARD		MPIC_REGSET(0)	/* Original MPIC */
 #define	MPIC_REGSET_TSI108		MPIC_REGSET(1)	/* Tsi108/109 PIC */
 
+/* Get the version of primary MPIC */
+extern u32 fsl_mpic_primary_get_version(void);
+
 /* Allocate the controller structure and setup the linux irq descs
  * for the range if interrupts passed in. No HW initialization is
  * actually performed.
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index d30e6a6..e793337 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1165,10 +1165,30 @@ static struct irq_domain_ops mpic_host_ops = {
 	.xlate = mpic_host_xlate,
 };
 
+static u32 mpic_get_version(struct mpic *mpic)
+{
+	u32 brr1;
+
+	brr1 = _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
+			MPIC_FSL_BRR1);
+
+	return brr1 & MPIC_FSL_BRR1_VER;
+}
+
 /*
  * Exported functions
  */
 
+u32 fsl_mpic_primary_get_version(void)
+{
+	struct mpic *mpic = mpic_primary;
+
+	if (mpic)
+		return mpic_get_version(mpic);
+
+	return 0;
+}
+
 struct mpic * __init mpic_alloc(struct device_node *node,
 				phys_addr_t phys_addr,
 				unsigned int flags,
@@ -1315,7 +1335,6 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	mpic_map(mpic, mpic->paddr, &mpic->tmregs, MPIC_INFO(TIMER_BASE), 0x1000);
 
 	if (mpic->flags & MPIC_FSL) {
-		u32 brr1;
 		int ret;
 
 		/*
@@ -1326,9 +1345,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 		mpic_map(mpic, mpic->paddr, &mpic->thiscpuregs,
 			 MPIC_CPU_THISBASE, 0x1000);
 
-		brr1 = _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
-				MPIC_FSL_BRR1);
-		fsl_version = brr1 & MPIC_FSL_BRR1_VER;
+		fsl_version = mpic_get_version(mpic);
 
 		/* Error interrupt mask register (EIMR) is required for
 		 * handling individual device error interrupts. EIMR
@@ -1518,9 +1535,7 @@ void __init mpic_init(struct mpic *mpic)
 	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0xf);
 
 	if (mpic->flags & MPIC_FSL) {
-		u32 brr1 = _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
-				      MPIC_FSL_BRR1);
-		u32 version = brr1 & MPIC_FSL_BRR1_VER;
+		u32 version = mpic_get_version(mpic);
 
 		/*
 		 * Timer group B is present at the latest in MPIC 3.1 (e.g.
-- 
1.8.0
