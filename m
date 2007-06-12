Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BE5D3DDECC
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 04:55:41 +1000 (EST)
Message-ID: <466EEBD0.9080609@am.sony.com>
Date: Tue, 12 Jun 2007 11:54:08 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 21/30] PS3: Use clear_bit
References: <20070612181825.730300780@am.sony.com>>
In-Reply-To: <20070612181825.730300780@am.sony.com>>
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

Replace inline asm to bitops routines in the PS3 interrupt
chip mask routines.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/interrupt.c |   26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -101,24 +101,13 @@ static DEFINE_PER_CPU(struct ps3_private
 static void ps3_chip_mask(unsigned int virq)
 {
 	struct ps3_private *pd = get_irq_chip_data(virq);
-	u64 bit = 0x8000000000000000UL >> virq;
-	u64 *p = &pd->bmp.mask;
-	u64 old;
 	unsigned long flags;
 
 	pr_debug("%s:%d: thread_id %lu, virq %d\n", __func__, __LINE__,
 		pd->thread_id, virq);
 
 	local_irq_save(flags);
-	asm volatile(
-		     "1:	ldarx %0,0,%3\n"
-		     "andc	%0,%0,%2\n"
-		     "stdcx.	%0,0,%3\n"
-		     "bne-	1b"
-		     : "=&r" (old), "+m" (*p)
-		     : "r" (bit), "r" (p)
-		     : "cc" );
-
+	clear_bit(63 - virq, &pd->bmp.mask);
 	lv1_did_update_interrupt_mask(pd->ppe_id, pd->thread_id);
 	local_irq_restore(flags);
 }
@@ -133,24 +122,13 @@ static void ps3_chip_mask(unsigned int v
 static void ps3_chip_unmask(unsigned int virq)
 {
 	struct ps3_private *pd = get_irq_chip_data(virq);
-	u64 bit = 0x8000000000000000UL >> virq;
-	u64 *p = &pd->bmp.mask;
-	u64 old;
 	unsigned long flags;
 
 	pr_debug("%s:%d: thread_id %lu, virq %d\n", __func__, __LINE__,
 		pd->thread_id, virq);
 
 	local_irq_save(flags);
-	asm volatile(
-		     "1:	ldarx %0,0,%3\n"
-		     "or	%0,%0,%2\n"
-		     "stdcx.	%0,0,%3\n"
-		     "bne-	1b"
-		     : "=&r" (old), "+m" (*p)
-		     : "r" (bit), "r" (p)
-		     : "cc" );
-
+	set_bit(63 - virq, &pd->bmp.mask);
 	lv1_did_update_interrupt_mask(pd->ppe_id, pd->thread_id);
 	local_irq_restore(flags);
 }

-- 
