Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 54ED3DE28F
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 13:40:15 +1100 (EST)
Message-ID: <45B81886.5040203@am.sony.com>
Date: Wed, 24 Jan 2007 18:40:06 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH 7/14] ps3: cleanup interrupt bmp routines
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Change the PS3 interrupt bitmask routines to be lockless.


From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/platforms/ps3/interrupt.c |   85 ++++++++++++++-------------------
 1 files changed, 38 insertions(+), 47 deletions(-)

--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/interrupt.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/interrupt.c
@@ -380,34 +380,50 @@ static void dump_bmp(struct ps3_private*
 
 static void ps3_chip_mask(unsigned int virq)
 {
-	unsigned long flags;
 	struct ps3_private *pd = get_irq_chip_data(virq);
+	unsigned long bit = 0x8000000000000000UL >> virq;
+	unsigned long *p = &pd->bmp.mask;
+	unsigned long old;
+	unsigned long flags;
 
 	pr_debug("%s:%d: cpu %u, virq %d\n", __func__, __LINE__, pd->cpu, virq);
 
-	BUG_ON(virq < NUM_ISA_INTERRUPTS);
-	BUG_ON(virq > PS3_PLUG_MAX);
+	local_irq_save(flags);
+	asm volatile(
+		     "1:	ldarx %0,0,%3\n"
+		     "andc	%0,%0,%2\n"
+		     "stdcx.	%0,0,%3\n"
+		     "bne-	1b"
+		     : "=&r" (old), "+m" (*p)
+		     : "r" (bit), "r" (p)
+		     : "cc" );
 
-	spin_lock_irqsave(&pd->bmp.lock, flags);
-	pd->bmp.mask &= ~(0x8000000000000000UL >> virq);
 	lv1_did_update_interrupt_mask(pd->node, pd->cpu);
-	spin_unlock_irqrestore(&pd->bmp.lock, flags);
+	local_irq_restore(flags);
 }
 
 static void ps3_chip_unmask(unsigned int virq)
 {
-	unsigned long flags;
 	struct ps3_private *pd = get_irq_chip_data(virq);
+	unsigned long bit = 0x8000000000000000UL >> virq;
+	unsigned long *p = &pd->bmp.mask;
+	unsigned long old;
+	unsigned long flags;
 
 	pr_debug("%s:%d: cpu %u, virq %d\n", __func__, __LINE__, pd->cpu, virq);
 
-	BUG_ON(virq < NUM_ISA_INTERRUPTS);
-	BUG_ON(virq > PS3_PLUG_MAX);
+	local_irq_save(flags);
+	asm volatile(
+		     "1:	ldarx %0,0,%3\n"
+		     "or	%0,%0,%2\n"
+		     "stdcx.	%0,0,%3\n"
+		     "bne-	1b"
+		     : "=&r" (old), "+m" (*p)
+		     : "r" (bit), "r" (p)
+		     : "cc" );
 
-	spin_lock_irqsave(&pd->bmp.lock, flags);
-	pd->bmp.mask |= (0x8000000000000000UL >> virq);
 	lv1_did_update_interrupt_mask(pd->node, pd->cpu);
-	spin_unlock_irqrestore(&pd->bmp.lock, flags);
+	local_irq_restore(flags);
 }
 
 static void ps3_chip_eoi(unsigned int virq)
@@ -481,46 +497,21 @@ void __init ps3_register_ipi_debug_brk(u
 		cpu, virq, pd->bmp.ipi_debug_brk_mask);
 }
 
-static int bmp_get_and_clear_status_bit(struct ps3_bmp *m)
+unsigned int ps3_get_irq(void)
 {
-	unsigned long flags;
-	unsigned int bit;
-	unsigned long x;
-
-	spin_lock_irqsave(&m->lock, flags);
+	struct ps3_private *pd = &__get_cpu_var(ps3_private);
+	unsigned long x = (pd->bmp.status & pd->bmp.mask);
+	unsigned int plug;
 
 	/* check for ipi break first to stop this cpu ASAP */
 
-	if (m->status & m->ipi_debug_brk_mask) {
-		m->status &= ~m->ipi_debug_brk_mask;
-		spin_unlock_irqrestore(&m->lock, flags);
-		return __ilog2(m->ipi_debug_brk_mask);
-	}
-
-	x = (m->status & m->mask);
-
-	for (bit = NUM_ISA_INTERRUPTS, x <<= bit; x; bit++, x <<= 1)
-		if (x & 0x8000000000000000UL) {
-			m->status &= ~(0x8000000000000000UL >> bit);
-			spin_unlock_irqrestore(&m->lock, flags);
-			return bit;
-		}
-
-	spin_unlock_irqrestore(&m->lock, flags);
-
-	pr_debug("%s:%d: not found\n", __func__, __LINE__);
-	return -1;
-}
-
-unsigned int ps3_get_irq(void)
-{
-	int plug;
-
-	struct ps3_private *pd = &__get_cpu_var(ps3_private);
+	if (x & pd->bmp.ipi_debug_brk_mask)
+		x &= pd->bmp.ipi_debug_brk_mask;
 
-	plug = bmp_get_and_clear_status_bit(&pd->bmp);
+	asm volatile("cntlzd %0,%1" : "=r" (plug) : "r" (x));
+	plug &= 0x3f;
 
-	if (plug < 1) {
+	if (unlikely(plug) == NO_IRQ) {
 		pr_debug("%s:%d: no plug found: cpu %u\n", __func__, __LINE__,
 			pd->cpu);
 		dump_bmp(&per_cpu(ps3_private, 0));
@@ -529,7 +520,7 @@ unsigned int ps3_get_irq(void)
 	}
 
 #if defined(DEBUG)
-	if (plug < NUM_ISA_INTERRUPTS || plug > PS3_PLUG_MAX) {
+	if (unlikely(plug < NUM_ISA_INTERRUPTS || plug > PS3_PLUG_MAX)) {
 		dump_bmp(&per_cpu(ps3_private, 0));
 		dump_bmp(&per_cpu(ps3_private, 1));
 		BUG();
