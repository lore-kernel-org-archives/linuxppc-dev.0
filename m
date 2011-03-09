Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6199F1007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 18:33:15 +1100 (EST)
Date: Wed, 9 Mar 2011 08:33:09 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 01/28] powerpc: mpic irq_data conversion.
Message-ID: <20110309073309.GL16649@mail.wantstofly.org>
References: <cover.1299541392.git.buytenh@wantstofly.org>
	<20110307235902.GF16649@mail.wantstofly.org>
	<1299640975.22236.263.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299640975.22236.263.camel@pasglop>
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 09, 2011 at 02:22:55PM +1100, Benjamin Herrenschmidt wrote:

> > -static void mpic_unmask_ht_irq(unsigned int irq)
> > +static void mpic_unmask_ht_irq(struct irq_data *d)
> >  {
> > -	struct mpic *mpic = mpic_from_irq(irq);
> > -	unsigned int src = mpic_irq_to_hw(irq);
> > +	struct mpic *mpic = mpic_from_irq(d->irq);
> > +	unsigned int src = mpic_irq_to_hw(d->irq);
> 
> It's a bit sad to have a pointerm turn it back to a irq number,
> look it up just to get back the chip data in there :-)

ACK, how about the below?


> Either we should create an mpic_from_irqdata() which itself uses
> irq_data_get_irq_chip_data() or just change mpic_from_irq() if we
> decide we can always call it with "data" instead of "irq"

There's one site left that needs to go from virq to mpic, so I've
done the former.


> > -	mpic_unmask_irq(irq);
> > +	mpic_unmask_irq(d);
> >  
> > -	if (irq_to_desc(irq)->status & IRQ_LEVEL)
> > +	if (irq_to_desc(d->irq)->status & IRQ_LEVEL)
> >  		mpic_ht_end_irq(mpic, src);
> >  }
> 
> Do we really need that gymnastic to get to desc->status from irq_data ?
> 
> Again, we're going back to a number and then looking it up again... bad.
> 
> I don't see off hand a data -> desc accessor, but it also looks like it
> should be trivial to add. Thomas, what do you reckon ?

It really shouldn't be looking at the desc at all.

This should help, as we only look at IRQ_LEVEL here:

	http://git.kernel.org/?p=linux/kernel/git/x86/linux-2.6-tip.git;a=commitdiff;h=876dbd4cc1b35c1a4cb96a2be1d43ea0eabce3b4


cheers,
Lennert


diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 95712f6..eb70218 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -648,6 +648,12 @@ static inline struct mpic * mpic_from_irq(unsigned int irq)
 	return get_irq_chip_data(irq);
 }
 
+/* Get the mpic structure from the irq data */
+static inline struct mpic * mpic_from_irq_data(struct irq_data *d)
+{
+	return irq_data_get_irq_chip_data(d);
+}
+
 /* Send an EOI */
 static inline void mpic_eoi(struct mpic *mpic)
 {
@@ -663,7 +669,7 @@ static inline void mpic_eoi(struct mpic *mpic)
 void mpic_unmask_irq(struct irq_data *d)
 {
 	unsigned int loops = 100000;
-	struct mpic *mpic = mpic_from_irq(d->irq);
+	struct mpic *mpic = mpic_from_irq_data(d);
 	unsigned int src = mpic_irq_to_hw(d->irq);
 
 	DBG("%p: %s: enable_irq: %d (src %d)\n", mpic, mpic->name, d->irq, src);
@@ -684,7 +690,7 @@ void mpic_unmask_irq(struct irq_data *d)
 void mpic_mask_irq(struct irq_data *d)
 {
 	unsigned int loops = 100000;
-	struct mpic *mpic = mpic_from_irq(d->irq);
+	struct mpic *mpic = mpic_from_irq_data(d);
 	unsigned int src = mpic_irq_to_hw(d->irq);
 
 	DBG("%s: disable_irq: %d (src %d)\n", mpic->name, d->irq, src);
@@ -705,7 +711,7 @@ void mpic_mask_irq(struct irq_data *d)
 
 void mpic_end_irq(struct irq_data *d)
 {
-	struct mpic *mpic = mpic_from_irq(d->irq);
+	struct mpic *mpic = mpic_from_irq_data(d);
 
 #ifdef DEBUG_IRQ
 	DBG("%s: end_irq: %d\n", mpic->name, d->irq);
@@ -722,7 +728,7 @@ void mpic_end_irq(struct irq_data *d)
 
 static void mpic_unmask_ht_irq(struct irq_data *d)
 {
-	struct mpic *mpic = mpic_from_irq(d->irq);
+	struct mpic *mpic = mpic_from_irq_data(d);
 	unsigned int src = mpic_irq_to_hw(d->irq);
 
 	mpic_unmask_irq(d);
@@ -733,7 +739,7 @@ static void mpic_unmask_ht_irq(struct irq_data *d)
 
 static unsigned int mpic_startup_ht_irq(struct irq_data *d)
 {
-	struct mpic *mpic = mpic_from_irq(d->irq);
+	struct mpic *mpic = mpic_from_irq_data(d);
 	unsigned int src = mpic_irq_to_hw(d->irq);
 
 	mpic_unmask_irq(d);
@@ -744,7 +750,7 @@ static unsigned int mpic_startup_ht_irq(struct irq_data *d)
 
 static void mpic_shutdown_ht_irq(struct irq_data *d)
 {
-	struct mpic *mpic = mpic_from_irq(d->irq);
+	struct mpic *mpic = mpic_from_irq_data(d);
 	unsigned int src = mpic_irq_to_hw(d->irq);
 
 	mpic_shutdown_ht_interrupt(mpic, src, irq_to_desc(d->irq)->status);
@@ -753,7 +759,7 @@ static void mpic_shutdown_ht_irq(struct irq_data *d)
 
 static void mpic_end_ht_irq(struct irq_data *d)
 {
-	struct mpic *mpic = mpic_from_irq(d->irq);
+	struct mpic *mpic = mpic_from_irq_data(d);
 	unsigned int src = mpic_irq_to_hw(d->irq);
 
 #ifdef DEBUG_IRQ
@@ -805,7 +811,7 @@ static void mpic_end_ipi(struct irq_data *d)
 int mpic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 		      bool force)
 {
-	struct mpic *mpic = mpic_from_irq(d->irq);
+	struct mpic *mpic = mpic_from_irq_data(d);
 	unsigned int src = mpic_irq_to_hw(d->irq);
 
 	if (mpic->flags & MPIC_SINGLE_DEST_CPU) {
@@ -851,7 +857,7 @@ static unsigned int mpic_type_to_vecpri(struct mpic *mpic, unsigned int type)
 
 int mpic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct mpic *mpic = mpic_from_irq(d->irq);
+	struct mpic *mpic = mpic_from_irq_data(d);
 	unsigned int src = mpic_irq_to_hw(d->irq);
 	struct irq_desc *desc = irq_to_desc(d->irq);
 	unsigned int vecpri, vold, vnew;
