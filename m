Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 0B273B6F74
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Mar 2011 05:28:39 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Milton Miller <miltonm@bga.com>
Message-id: <patches-for-39-rc1@mdm.bga.com>
Subject: [PATCH 0/3] xics mask_irq fix and other patches
Date: Mon, 21 Mar 2011 12:12:13 -0600
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben.

I've submitted the fix for the xics mask real irq I mentioned.
During testing I realized current code is passing rtas a linux irq,
which means no interrupt (at least those above NR_IRQs) is being disabled.

I also created a patch to rename irq to hwirq in xics to try to make
the distiction more clear.  For your consideration, I don't care if you
don't merge it especially with the upcoming rewrite.

Also, I am sending a printk to printk_once patch that affects BML.

Thanks,
milton


MAIL FROM: <miltonm@bga.com>
RCPT TO: <miltonm@bga.com>
RCPT TO: <linuxppc-dev@lists.ozlabs.org>
RCPT TO: <buytenh@secretlab.ca>
DATA
From: Milton Miller <miltonm@bga.com>
Subject: [PATCH 1/2] powerpc: xics: fix numberspace mismatch from irq_desc conversion
To: linuxppc-dev@lists.ozlabs.org
Cc: Lennert Buytenhek <buytenh@secretlab.ca>
Message-id: <xics-mask-irq-desc-fix@mdm.bga.com>
In-Reply-To: <patches-for-39-rc1@mdm.bga.com>
References: <patches-for-39-rc1@mdm.bga.com>

commit 79f26c268ebad29bd75d078cfc09d3d82b30ccbd (powerpc:
platforms/pseries irq_data conversion) pushed irq_desc down into many
functions, dererencing the descriptor irq field as late as possible.

But it incorrectly passed a linix virtural irq number to RTAS,
resulting in the interrupt not being disabled and possibly
other bad things, such as another interrupt being disabled and/or
a checkstop.  

In addition this missed the point of xics_mask_unknown_vec and
the seperation of xics_mask_real_irq from xics_mask_irq.  When
xics_mask_unknown_vec is called it's because the hardware delivered an
irq source for which we have no linux irq allocated, and thefore we can
not have an irq_desc allocated.

Revert xics_mask_real_irq to its prior version, naming the argument
hwirq to highlight the difference.

Signed-off-by: Milton Miller <miltonm@bga.com>


--

Lennert can you please review the other patches for similar problems?

Any reference to irq_map[x].hwirq is in a different number domain.

I initially saw the problem pushing irq_desc through unknown_vec
found this due to my knowledge of the split (I added that function)
and only realized the wrong number space when preparing to test the fix.
In fact I tried without the patch and my firmware checkstops the machine
(hardware stops executing instructions)!


diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index 01fea46..5686db9 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -250,26 +250,26 @@ static unsigned int xics_startup(struct irq_data *d)
 	return 0;
 }
 
-static void xics_mask_real_irq(struct irq_data *d)
+static void xics_mask_real_irq(unsigned int hwirq)
 {
 	int call_status;
 
-	if (d->irq == XICS_IPI)
+	if (hwirq == XICS_IPI)
 		return;
 
-	call_status = rtas_call(ibm_int_off, 1, 1, NULL, d->irq);
+	call_status = rtas_call(ibm_int_off, 1, 1, NULL, hwirq);
 	if (call_status != 0) {
 		printk(KERN_ERR "%s: ibm_int_off irq=%u returned %d\n",
-			__func__, d->irq, call_status);
+			__func__, hwirq, call_status);
 		return;
 	}
 
 	/* Have to set XIVE to 0xff to be able to remove a slot */
-	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, d->irq,
+	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, hwirq,
 				default_server, 0xff);
 	if (call_status != 0) {
 		printk(KERN_ERR "%s: ibm_set_xive(0xff) irq=%u returned %d\n",
-			__func__, d->irq, call_status);
+			__func__, hwirq, call_status);
 		return;
 	}
 }
@@ -283,13 +283,13 @@ static void xics_mask_irq(struct irq_data *d)
 	irq = (unsigned int)irq_map[d->irq].hwirq;
 	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
 		return;
-	xics_mask_real_irq(d);
+	xics_mask_real_irq(irq);
 }
 
 static void xics_mask_unknown_vec(unsigned int vec)
 {
 	printk(KERN_ERR "Interrupt %u (real) is invalid, disabling it.\n", vec);
-	xics_mask_real_irq(irq_get_irq_data(vec));
+	xics_mask_real_irq(vec);
 }
 
 static inline unsigned int xics_xirr_vector(unsigned int xirr)
