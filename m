Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9CD5DDDFE6
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:56:42 +1100 (EST)
Date: Fri, 10 Oct 2008 06:56:23 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Message-id: <patch-xics-1@bga.com>
In-Reply-To: <patch-xics-0@bga.com>
Subject: [PATCH 1/16] powerpc pseries: eoi unmapped xics irqs after disable
Cc: Michael Ellerman <michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When reciving an irq vector that does not have a linux mapping, the kernel
prints a message and calls RTAS to disable the irq source.   Previously
the kernel did not EOI the interrupt, causing the source to think it is
still being processed by software.  While this does add an additional
layer of protection against interrupt storms had RTAS failed to disable
the source, it also prevents the interrupt from working when a driver
later enables it.  (We could alternatively send an EOI on startup, but
that strategy would likely fail on an emulated xics.)

All interrupts should be disabled when the kernel starts, but this can
be observed if a driver does not shutdown an interrupt in its reboot
hook before starting a new kernel with kexec.

Michael reports this can be reproduced trivially by banging the keyboard
while kexec'ing on a P5 LPAR: even though the hvc_console driver request's
the console irq later in boot, the console is non-functional because
we're receiving no console interrupts.

Reported-By: Michael Ellerman
Signed-off-by: Milton Miller <miltonm@bga.com>

---
This version is for 2.6.28 based on benh's next branch.  For prior
kernels, s/irq_radix_revmap_lookup/irq_radix_revmap/ before applying.

Index: next.git/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- next.git.orig/arch/powerpc/platforms/pseries/xics.c	2008-10-04 16:34:45.000000000 -0500
+++ next.git/arch/powerpc/platforms/pseries/xics.c	2008-10-05 01:49:59.000000000 -0500
@@ -332,32 +332,61 @@ static void xics_eoi_lpar(unsigned int v
 	lpar_xirr_info_set((0xff << 24) | irq);
 }
 
-static inline unsigned int xics_remap_irq(unsigned int vec)
+static inline unsigned int xics_xirr_vector(unsigned int xirr)
 {
-	unsigned int irq;
+	/*
+	 * The top byte is the old cppr, to be restored on EOI.
+	 * The remaining 24 bits are the vector.
+	 */
+	return xirr & 0x00ffffff;
+}
 
-	vec &= 0x00ffffff;
+static void xics_mask_unknown_vec(unsigned int vec)
+{
+	printk(KERN_ERR "Interrupt %u (real) is invalid, disabling it.\n", vec);
+	xics_mask_real_irq(vec);
+}
+
+static unsigned int xics_get_irq_direct(void)
+{
+	unsigned int xirr = direct_xirr_info_get();
+	unsigned int vec = xics_xirr_vector(xirr);
+	unsigned int irq;
 
 	if (vec == XICS_IRQ_SPURIOUS)
 		return NO_IRQ;
+
 	irq = irq_radix_revmap_lookup(xics_host, vec);
 	if (likely(irq != NO_IRQ))
 		return irq;
 
-	printk(KERN_ERR "Interrupt %u (real) is invalid,"
-	       " disabling it.\n", vec);
-	xics_mask_real_irq(vec);
-	return NO_IRQ;
-}
+	/* We don't have a linux mapping, so have rtas mask it. */
+	xics_mask_unknown_vec(vec);
 
-static unsigned int xics_get_irq_direct(void)
-{
-	return xics_remap_irq(direct_xirr_info_get());
+	/* We might learn about it later, so EOI it */
+	direct_xirr_info_set(xirr);
+	return NO_IRQ;
 }
 
 static unsigned int xics_get_irq_lpar(void)
 {
-	return xics_remap_irq(lpar_xirr_info_get());
+	unsigned int xirr = lpar_xirr_info_get();
+	unsigned int vec = xics_xirr_vector(xirr);
+	unsigned int irq;
+
+	if (vec == XICS_IRQ_SPURIOUS)
+		return NO_IRQ;
+
+	irq = irq_radix_revmap_lookup(xics_host, vec);
+	if (likely(irq != NO_IRQ))
+		return irq;
+
+	/* We don't have a linux mapping, so have RTAS mask it. */
+	xics_mask_unknown_vec(vec);
+
+	/* We might learn about it later, so EOI it */
+	lpar_xirr_info_set(xirr);
+	return NO_IRQ;
 }
 
 #ifdef CONFIG_SMP
