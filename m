Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound7-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F1FDEDE3D5
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 08:11:56 +1000 (EST)
Message-ID: <46730D51.1060709@am.sony.com>
Date: Fri, 15 Jun 2007 15:06:09 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 21/33] PS3: Use clear_bit
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

Replace the inline asm with bitops in the PS3 interrupt
chip mask routines.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/interrupt.c |   26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -100,24 +100,13 @@ static DEFINE_PER_CPU(struct ps3_private
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
@@ -132,24 +121,13 @@ static void ps3_chip_mask(unsigned int v
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
