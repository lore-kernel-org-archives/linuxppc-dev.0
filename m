Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 22E83DE206
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 08:23:12 +1000 (EST)
Message-ID: <46730256.4060802@am.sony.com>
Date: Fri, 15 Jun 2007 14:19:18 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 08/33] PS3: Move chip mask defs up
References: <20070615204749.629571012@am.sony.com>>
In-Reply-To: <20070615204749.629571012@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This just moves the definitions of the PS3 chip_mask routines up
above the irq setup routines.  This change is needed for the
kexec updates that follow.  Also adds some inline documentation
to the routines.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/interrupt.c |  147 +++++++++++++++++++--------------
 1 file changed, 86 insertions(+), 61 deletions(-)

--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -91,6 +91,92 @@ struct ps3_private {
 static DEFINE_PER_CPU(struct ps3_private, ps3_private);
 
 /**
+ * ps3_chip_mask - Set an interrupt mask bit in ps3_bmp.
+ * @virq: The assigned Linux virq.
+ *
+ * Sets ps3_bmp.mask and calls lv1_did_update_interrupt_mask().
+ */
+
+static void ps3_chip_mask(unsigned int virq)
+{
+	struct ps3_private *pd = get_irq_chip_data(virq);
+	u64 bit = 0x8000000000000000UL >> virq;
+	u64 *p = &pd->bmp.mask;
+	u64 old;
+	unsigned long flags;
+
+	pr_debug("%s:%d: cpu %u, virq %d\n", __func__, __LINE__, pd->cpu, virq);
+
+	local_irq_save(flags);
+	asm volatile(
+		     "1:	ldarx %0,0,%3\n"
+		     "andc	%0,%0,%2\n"
+		     "stdcx.	%0,0,%3\n"
+		     "bne-	1b"
+		     : "=&r" (old), "+m" (*p)
+		     : "r" (bit), "r" (p)
+		     : "cc" );
+
+	lv1_did_update_interrupt_mask(pd->node, pd->cpu);
+	local_irq_restore(flags);
+}
+
+/**
+ * ps3_chip_unmask - Clear an interrupt mask bit in ps3_bmp.
+ * @virq: The assigned Linux virq.
+ *
+ * Clears ps3_bmp.mask and calls lv1_did_update_interrupt_mask().
+ */
+
+static void ps3_chip_unmask(unsigned int virq)
+{
+	struct ps3_private *pd = get_irq_chip_data(virq);
+	u64 bit = 0x8000000000000000UL >> virq;
+	u64 *p = &pd->bmp.mask;
+	u64 old;
+	unsigned long flags;
+
+	pr_debug("%s:%d: cpu %u, virq %d\n", __func__, __LINE__, pd->cpu, virq);
+
+	local_irq_save(flags);
+	asm volatile(
+		     "1:	ldarx %0,0,%3\n"
+		     "or	%0,%0,%2\n"
+		     "stdcx.	%0,0,%3\n"
+		     "bne-	1b"
+		     : "=&r" (old), "+m" (*p)
+		     : "r" (bit), "r" (p)
+		     : "cc" );
+
+	lv1_did_update_interrupt_mask(pd->node, pd->cpu);
+	local_irq_restore(flags);
+}
+
+/**
+ * ps3_chip_eoi - HV end-of-interrupt.
+ * @virq: The assigned Linux virq.
+ *
+ * Calls lv1_end_of_interrupt_ext().
+ */
+
+static void ps3_chip_eoi(unsigned int virq)
+{
+	const struct ps3_private *pd = get_irq_chip_data(virq);
+	lv1_end_of_interrupt_ext(pd->node, pd->cpu, virq);
+}
+
+/**
+ * ps3_irq_chip - Represents the ps3_bmp as a Linux struct irq_chip.
+ */
+
+static struct irq_chip ps3_irq_chip = {
+	.typename = "ps3",
+	.mask = ps3_chip_mask,
+	.unmask = ps3_chip_unmask,
+	.eoi = ps3_chip_eoi,
+};
+
+/**
  * ps3_virq_setup - virq related setup.
  * @cpu: enum ps3_cpu_binding indicating the cpu the interrupt should be
  * serviced on.
@@ -565,67 +651,6 @@ static void __maybe_unused _dump_mask(st
 static void dump_bmp(struct ps3_private* pd) {};
 #endif /* defined(DEBUG) */
 
-static void ps3_chip_mask(unsigned int virq)
-{
-	struct ps3_private *pd = get_irq_chip_data(virq);
-	u64 bit = 0x8000000000000000UL >> virq;
-	u64 *p = &pd->bmp.mask;
-	u64 old;
-	unsigned long flags;
-
-	pr_debug("%s:%d: cpu %u, virq %d\n", __func__, __LINE__, pd->cpu, virq);
-
-	local_irq_save(flags);
-	asm volatile(
-		     "1:	ldarx %0,0,%3\n"
-		     "andc	%0,%0,%2\n"
-		     "stdcx.	%0,0,%3\n"
-		     "bne-	1b"
-		     : "=&r" (old), "+m" (*p)
-		     : "r" (bit), "r" (p)
-		     : "cc" );
-
-	lv1_did_update_interrupt_mask(pd->node, pd->cpu);
-	local_irq_restore(flags);
-}
-
-static void ps3_chip_unmask(unsigned int virq)
-{
-	struct ps3_private *pd = get_irq_chip_data(virq);
-	u64 bit = 0x8000000000000000UL >> virq;
-	u64 *p = &pd->bmp.mask;
-	u64 old;
-	unsigned long flags;
-
-	pr_debug("%s:%d: cpu %u, virq %d\n", __func__, __LINE__, pd->cpu, virq);
-
-	local_irq_save(flags);
-	asm volatile(
-		     "1:	ldarx %0,0,%3\n"
-		     "or	%0,%0,%2\n"
-		     "stdcx.	%0,0,%3\n"
-		     "bne-	1b"
-		     : "=&r" (old), "+m" (*p)
-		     : "r" (bit), "r" (p)
-		     : "cc" );
-
-	lv1_did_update_interrupt_mask(pd->node, pd->cpu);
-	local_irq_restore(flags);
-}
-
-static void ps3_chip_eoi(unsigned int virq)
-{
-	const struct ps3_private *pd = get_irq_chip_data(virq);
-	lv1_end_of_interrupt_ext(pd->node, pd->cpu, virq);
-}
-
-static struct irq_chip irq_chip = {
-	.typename = "ps3",
-	.mask = ps3_chip_mask,
-	.unmask = ps3_chip_unmask,
-	.eoi = ps3_chip_eoi,
-};
-
 static void ps3_host_unmap(struct irq_host *h, unsigned int virq)
 {
 	set_irq_chip_data(virq, NULL);

-- 
