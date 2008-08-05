Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <3d6dc055c5b18a641a5467b7331d935ede87efb2.1217943634.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: EOI spurious irqs during boot so they can be
	reenabled later
Date: Tue,  5 Aug 2008 23:42:40 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In the xics code, if we receive an irq during boot that hasn't been setup
yet - ie. we have no reverse mapping for it - we mask the irq so we don't
hear from it again.

Later on if someone request_irq()'s that irq, we'll unmask it but it will
still never fire. This is because we never EOI'ed the irq when we originally
received it - when it was spurious.

This can be reproduced trivially by banging the keyboard while kexec'ing on
a P5 LPAR, even though the hvc_console driver request's the console irq later
in boot, the console is non-functional because we're receiving no console
interrupts.

So when we receive a spurious irq, EOI it, and then mask it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/xics.c |   29 ++++++++++++++++++++---------
 1 files changed, 20 insertions(+), 9 deletions(-)


Probably 27 material unless there are objections ..


diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index 0fc830f..dc007f4 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -321,21 +321,26 @@ static unsigned int xics_startup(unsigned int virq)
 	return 0;
 }
 
+static void xics_eoi_hwirq_direct(unsigned int hwirq)
+{
+	iosync();
+	direct_xirr_info_set((0xff << 24) | hwirq);
+}
+
 static void xics_eoi_direct(unsigned int virq)
 {
-	unsigned int irq = (unsigned int)irq_map[virq].hwirq;
+	xics_eoi_hwirq_direct((unsigned int)irq_map[virq].hwirq);
+}
 
+static void xics_eoi_hwirq_lpar(unsigned int hwirq)
+{
 	iosync();
-	direct_xirr_info_set((0xff << 24) | irq);
+	lpar_xirr_info_set((0xff << 24) | hwirq);
 }
 
-
 static void xics_eoi_lpar(unsigned int virq)
 {
-	unsigned int irq = (unsigned int)irq_map[virq].hwirq;
-
-	iosync();
-	lpar_xirr_info_set((0xff << 24) | irq);
+	xics_eoi_hwirq_lpar((unsigned int)irq_map[virq].hwirq);
 }
 
 static inline unsigned int xics_remap_irq(unsigned int vec)
@@ -350,9 +355,15 @@ static inline unsigned int xics_remap_irq(unsigned int vec)
 	if (likely(irq != NO_IRQ))
 		return irq;
 
-	printk(KERN_ERR "Interrupt %u (real) is invalid,"
-	       " disabling it.\n", vec);
+	pr_err("%s: no mapping for hwirq %u, disabling it.\n", __func__, vec);
+
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		xics_eoi_hwirq_lpar(vec);
+	else
+		xics_eoi_hwirq_direct(vec);
+
 	xics_mask_real_irq(vec);
+
 	return NO_IRQ;
 }
 
-- 
1.5.5
