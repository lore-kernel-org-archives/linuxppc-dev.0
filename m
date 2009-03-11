Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C864BDE1F3
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 22:48:52 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n2BBmmCX023497
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 06:48:48 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: 
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add support for CoreInt delivery of interrupts on
	MPIC
Date: Wed, 11 Mar 2009 06:48:47 -0500
Message-Id: <1236772127-28543-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

CoreInt provides a mechansim to deliver the IRQ vector directly
into the core on an interrupt (via the SPR EPR) rather than having
to go IACK on the PIC.  This is suppose to provide an improvment
in interrupt latency by reducing the time to get the IRQ vector.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/mpic.h |    5 +++++
 arch/powerpc/sysdev/mpic.c      |   30 ++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index c2ccca5..41f8fce 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -22,6 +22,7 @@
 #define MPIC_GREG_FEATURE_1		0x00010
 #define MPIC_GREG_GLOBAL_CONF_0		0x00020
 #define		MPIC_GREG_GCONF_RESET			0x80000000
+#define		MPIC_GREG_GCONF_COREINT			0x40000000
 #define		MPIC_GREG_GCONF_8259_PTHROU_DIS		0x20000000
 #define		MPIC_GREG_GCONF_NO_BIAS			0x10000000
 #define		MPIC_GREG_GCONF_BASE_MASK		0x000fffff
@@ -357,6 +358,8 @@ struct mpic
 #define MPIC_BROKEN_FRR_NIRQS		0x00000800
 /* Destination only supports a single CPU at a time */
 #define MPIC_SINGLE_DEST_CPU		0x00001000
+/* Enable CoreInt delivery of interrupts */
+#define MPIC_ENABLE_COREINT		0x00002000
 
 /* MPIC HW modification ID */
 #define MPIC_REGSET_MASK		0xf0000000
@@ -470,6 +473,8 @@ extern void mpic_end_irq(unsigned int irq);
 extern unsigned int mpic_get_one_irq(struct mpic *mpic);
 /* This one gets from the primary mpic */
 extern unsigned int mpic_get_irq(void);
+/* This one gets from the primary mpic via CoreInt*/
+extern unsigned int mpic_get_coreint_irq(void);
 /* Fetch Machine Check interrupt from primary mpic */
 extern unsigned int mpic_get_mcirq(void);
 
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index a35297d..6fca4f1 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1169,6 +1169,12 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 			mb();
 	}
 
+	/* CoreInt */
+	if (flags & MPIC_ENABLE_COREINT)
+		mpic_write(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0),
+			   mpic_read(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0))
+			   | MPIC_GREG_GCONF_COREINT);
+
 	if (flags & MPIC_ENABLE_MCK)
 		mpic_write(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0),
 			   mpic_read(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0))
@@ -1524,6 +1530,30 @@ unsigned int mpic_get_irq(void)
 	return mpic_get_one_irq(mpic);
 }
 
+unsigned int mpic_get_coreint_irq(void)
+{
+	struct mpic *mpic = mpic_primary;
+	u32 src;
+
+	BUG_ON(mpic == NULL);
+
+	src = mfspr(SPRN_EPR);
+
+	if (unlikely(src == mpic->spurious_vec)) {
+		if (mpic->flags & MPIC_SPV_EOI)
+			mpic_eoi(mpic);
+		return NO_IRQ;
+	}
+	if (unlikely(mpic->protected && test_bit(src, mpic->protected))) {
+		if (printk_ratelimit())
+			printk(KERN_WARNING "%s: Got protected source %d !\n",
+			       mpic->name, (int)src);
+		return NO_IRQ;
+	}
+
+	return irq_linear_revmap(mpic->irqhost, src);
+}
+
 unsigned int mpic_get_mcirq(void)
 {
 	struct mpic *mpic = mpic_primary;
-- 
1.5.6.6
