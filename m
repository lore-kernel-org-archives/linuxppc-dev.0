Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (unknown [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id CA286DDE04
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jun 2008 01:58:59 +1000 (EST)
Subject: Re: PPC to PowerPC Migration
From: Darcy Watkins <dwatkins@tranzeo.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080611135618.001db94d@zod.rchland.ibm.com>
References: <c443b0db0806101048t1df8c11ag456fbc352709966b@mail.gmail.com>
	<161B3BAD77161449A144FF054231C3D6022A3E4A@uss-am-xch-01.am.trimblecorp.net>
	<f608b67d0806110655v19dac162wc3adfc8939b5c40a@mail.gmail.com>
	<D61182AC8012EA4EBC531B3AF23BE10960355D@tranzeo-mail2.12stewart.tranzeo.com>
	<20080611123254.64fabf64@vader.jdub.homelinux.org>
	<D61182AC8012EA4EBC531B3AF23BE109603578@tranzeo-mail2.12stewart.tranzeo.com>
	<20080611133247.0ac8b7c6@zod.rchland.ibm.com>
	<D61182AC8012EA4EBC531B3AF23BE109603587@tranzeo-mail2.12stewart.tranzeo.com>
	<20080611135618.001db94d@zod.rchland.ibm.com>
Content-Type: text/plain; charset=utf8
Date: Thu, 12 Jun 2008 08:58:57 -0700
Message-Id: <1213286337.32716.32.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I am posting these patches mainly to test that my Linux email client can
handle preformat properly (without breaking the lines), but it may be of
use to anyone using 2.6.24 or 2.6.25 kernel with RT-Preemption on a 4xx
processor that has a UIC (just so I don't clutter the list with a
useless test post).  This is all that was left to carry forward from
some much larger patches I received a while back for use with 2.6.23.

Use this patch with kernel 2.6.24

Index: linux-2.6.24.4/arch/powerpc/sysdev/uic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24.4.orig/arch/powerpc/sysdev/uic.c
+++ linux-2.6.24.4/arch/powerpc/sysdev/uic.c
@@ -49,7 +49,7 @@ struct uic {
 	int index;
 	int dcrbase;
=20
-	spinlock_t lock;
+	raw_spinlock_t lock;
=20
 	/* The remapper for this UIC */
 	struct irq_host	*irqhost;
@@ -60,14 +60,19 @@ struct uic {
=20
 static void uic_unmask_irq(unsigned int virq)
 {
+	struct irq_desc *desc =3D get_irq_desc(virq);
 	struct uic *uic =3D get_irq_chip_data(virq);
 	unsigned int src =3D uic_irq_to_hw(virq);
 	unsigned long flags;
-	u32 er;
+	u32 er, sr;
=20
+	sr =3D 1 << (31-src);
 	spin_lock_irqsave(&uic->lock, flags);
+	/* ack level-triggered interrupts here */
+	if (desc->status & IRQ_LEVEL)
+		mtdcr(uic->dcrbase + UIC_SR, sr);
 	er =3D mfdcr(uic->dcrbase + UIC_ER);
-	er |=3D 1 << (31 - src);
+	er |=3D sr;
 	mtdcr(uic->dcrbase + UIC_ER, er);
 	spin_unlock_irqrestore(&uic->lock, flags);
 }
@@ -99,6 +104,7 @@ static void uic_ack_irq(unsigned int vir
=20
 static void uic_mask_ack_irq(unsigned int virq)
 {
+	struct irq_desc *desc =3D get_irq_desc(virq);
 	struct uic *uic =3D get_irq_chip_data(virq);
 	unsigned int src =3D uic_irq_to_hw(virq);
 	unsigned long flags;
@@ -109,7 +115,16 @@ static void uic_mask_ack_irq(unsigned in
 	er =3D mfdcr(uic->dcrbase + UIC_ER);
 	er &=3D ~sr;
 	mtdcr(uic->dcrbase + UIC_ER, er);
-	mtdcr(uic->dcrbase + UIC_SR, sr);
+	/* On the UIC, acking (i.e. clearing the SR bit)
+	 * a level irq will have no effect if the interrupt
+	 * is still asserted by the device, even if
+	 * the interrupt is already masked. Therefore
+	 * we only ack the egde interrupts here, while
+	 * level interrupts are ack'ed after the actual
+	 * isr call in the uic_unmask_irq()
+	 */
+	if (!(desc->status & IRQ_LEVEL))
+		mtdcr(uic->dcrbase + UIC_SR, sr);
 	spin_unlock_irqrestore(&uic->lock, flags);
 }
=20
@@ -173,6 +188,7 @@ static struct irq_chip uic_irq_chip =3D {
 	.set_type	=3D uic_set_irq_type,
 };
=20
+#if 0
 /**
  *	handle_uic_irq - irq flow handler for UIC
  *	@irq:	the interrupt number
@@ -230,6 +246,7 @@ void fastcall handle_uic_irq(unsigned in
 out_unlock:
 	spin_unlock(&desc->lock);
 }
+#endif
=20
 static int uic_host_map(struct irq_host *h, unsigned int virq,
 			irq_hw_number_t hw)
@@ -239,7 +256,7 @@ static int uic_host_map(struct irq_host=20
 	set_irq_chip_data(virq, uic);
 	/* Despite the name, handle_level_irq() works for both level
 	 * and edge irqs on UIC.  FIXME: check this is correct */
-	set_irq_chip_and_handler(virq, &uic_irq_chip, handle_uic_irq);
+	set_irq_chip_and_handler(virq, &uic_irq_chip, handle_level_irq);
=20
 	/* Set default irq type */
 	set_irq_type(virq, IRQ_TYPE_NONE);


Use this patch if using kernel 2.6.25


--- linux-2.6.25.4/arch/powerpc/sysdev/uic.c.theorig	2008-05-15 08:00:12.00=
0000000 -0700
+++ linux-2.6.25.4/arch/powerpc/sysdev/uic.c	2008-05-20 12:37:39.000000000 =
-0700
@@ -49,7 +49,7 @@ struct uic {
 	int index;
 	int dcrbase;
=20
-	spinlock_t lock;
+	raw_spinlock_t lock;
=20
 	/* The remapper for this UIC */
 	struct irq_host	*irqhost;

=EF=BB=BFApply the selected patch after applying the RT-Preemption patch to=
 your
kernel.

In terms of upstream projects - the 2.6.25 patch should eventually make
its way up into the RT preemption project patches (if not done already
for next release) but should not go to kernel.org since I don't know how
it would affect the kernel without RT-Preemption.  Why the change above
didn't make it with the rest of the changes, I don't know - perhaps the
kernel oops it solves affected only a narrow range of processors (e.g.
PPC405EP).

--=20


Regards,

Darcy

--------------
Darcy L. Watkins - Senior Software Developer
Tranzeo Wireless Technologies, Inc.
19273 Fraser Way, Pitt Meadows, BC, Canada V3Y 2V4
T:604-460-6002 ext:410
http://www.tranzeo.com
