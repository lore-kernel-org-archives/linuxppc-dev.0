Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2E3E2B70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 19:26:27 +1100 (EST)
Date: Wed, 9 Mar 2011 09:26:22 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 01/28] powerpc: mpic irq_data conversion.
Message-ID: <20110309082622.GA6095@mail.wantstofly.org>
References: <cover.1299541392.git.buytenh@wantstofly.org>
	<20110307235902.GF16649@mail.wantstofly.org>
	<1299640975.22236.263.camel@pasglop>
	<20110309073309.GL16649@mail.wantstofly.org>
	<1299657104.22236.386.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299657104.22236.386.camel@pasglop>
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 09, 2011 at 06:51:44PM +1100, Benjamin Herrenschmidt wrote:

> > > > -static void mpic_unmask_ht_irq(unsigned int irq)
> > > > +static void mpic_unmask_ht_irq(struct irq_data *d)
> > > >  {
> > > > -   struct mpic *mpic = mpic_from_irq(irq);
> > > > -   unsigned int src = mpic_irq_to_hw(irq);
> > > > +   struct mpic *mpic = mpic_from_irq(d->irq);
> > > > +   unsigned int src = mpic_irq_to_hw(d->irq);
> > > 
> > > It's a bit sad to have a pointerm turn it back to a irq number,
> > > look it up just to get back the chip data in there :-)
> > 
> > ACK, how about the below?
> 
> Much better. Do you want to fold it in and re-post only the affected
> patch (es) ?

Sure.  I've fixed the same thing in a couple more files (see
incremental patch below), so there'll be new versions of these coming
up shortly:

	powerpc: mpic irq_data conversion.
	powerpc: platforms/52xx irq_data conversion.
	powerpc: platforms/82xx irq_data conversion.
	powerpc: platforms/embedded6xx irq_data conversion.
	powerpc: platforms/ps3 irq_data conversion.
	powerpc: sysdev/mpc8xxx_gpio irq_data conversion.
	powerpc: sysdev/qe_lib/qe_ic irq_data conversion.
	powerpc: sysdev/uic irq_data conversion.
	powerpc: sysdev/xilinx_intc irq_data conversion.

I've also updated the tree on git.kernel.org with these changes.



diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index fe6cc5d..c9290d8 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -137,7 +137,7 @@ DEFINE_MUTEX(mpc52xx_gpt_list_mutex);
 
 static void mpc52xx_gpt_irq_unmask(struct irq_data *d)
 {
-	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(d->irq);
+	struct mpc52xx_gpt_priv *gpt = irq_data_get_irq_chip_data(d);
 	unsigned long flags;
 
 	spin_lock_irqsave(&gpt->lock, flags);
@@ -147,7 +147,7 @@ static void mpc52xx_gpt_irq_unmask(struct irq_data *d)
 
 static void mpc52xx_gpt_irq_mask(struct irq_data *d)
 {
-	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(d->irq);
+	struct mpc52xx_gpt_priv *gpt = irq_data_get_irq_chip_data(d);
 	unsigned long flags;
 
 	spin_lock_irqsave(&gpt->lock, flags);
@@ -157,14 +157,14 @@ static void mpc52xx_gpt_irq_mask(struct irq_data *d)
 
 static void mpc52xx_gpt_irq_ack(struct irq_data *d)
 {
-	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(d->irq);
+	struct mpc52xx_gpt_priv *gpt = irq_data_get_irq_chip_data(d);
 
 	out_be32(&gpt->regs->status, MPC52xx_GPT_STATUS_IRQMASK);
 }
 
 static int mpc52xx_gpt_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(d->irq);
+	struct mpc52xx_gpt_priv *gpt = irq_data_get_irq_chip_data(d);
 	unsigned long flags;
 	u32 reg;
 
diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
index a0cd8ae..926dfda 100644
--- a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
+++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -41,7 +41,7 @@ struct pq2ads_pci_pic {
 
 static void pq2ads_pci_mask_irq(struct irq_data *d)
 {
-	struct pq2ads_pci_pic *priv = get_irq_chip_data(d->irq);
+	struct pq2ads_pci_pic *priv = irq_data_get_irq_chip_data(d);
 	int irq = NUM_IRQS - virq_to_hw(d->irq) - 1;
 
 	if (irq != -1) {
@@ -57,7 +57,7 @@ static void pq2ads_pci_mask_irq(struct irq_data *d)
 
 static void pq2ads_pci_unmask_irq(struct irq_data *d)
 {
-	struct pq2ads_pci_pic *priv = get_irq_chip_data(d->irq);
+	struct pq2ads_pci_pic *priv = irq_data_get_irq_chip_data(d);
 	int irq = NUM_IRQS - virq_to_hw(d->irq) - 1;
 
 	if (irq != -1) {
diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index d7287e8..0aca0e2 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -49,7 +49,7 @@
 static void flipper_pic_mask_and_ack(struct irq_data *d)
 {
 	int irq = virq_to_hw(d->irq);
-	void __iomem *io_base = get_irq_chip_data(d->irq);
+	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 	u32 mask = 1 << irq;
 
 	clrbits32(io_base + FLIPPER_IMR, mask);
@@ -60,7 +60,7 @@ static void flipper_pic_mask_and_ack(struct irq_data *d)
 static void flipper_pic_ack(struct irq_data *d)
 {
 	int irq = virq_to_hw(d->irq);
-	void __iomem *io_base = get_irq_chip_data(d->irq);
+	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 
 	/* this is at least needed for RSW */
 	out_be32(io_base + FLIPPER_ICR, 1 << irq);
@@ -69,7 +69,7 @@ static void flipper_pic_ack(struct irq_data *d)
 static void flipper_pic_mask(struct irq_data *d)
 {
 	int irq = virq_to_hw(d->irq);
-	void __iomem *io_base = get_irq_chip_data(d->irq);
+	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 
 	clrbits32(io_base + FLIPPER_IMR, 1 << irq);
 }
@@ -77,7 +77,7 @@ static void flipper_pic_mask(struct irq_data *d)
 static void flipper_pic_unmask(struct irq_data *d)
 {
 	int irq = virq_to_hw(d->irq);
-	void __iomem *io_base = get_irq_chip_data(d->irq);
+	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 
 	setbits32(io_base + FLIPPER_IMR, 1 << irq);
 }
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index c6f5fd6..35e448b 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -44,7 +44,7 @@
 static void hlwd_pic_mask_and_ack(struct irq_data *d)
 {
 	int irq = virq_to_hw(d->irq);
-	void __iomem *io_base = get_irq_chip_data(d->irq);
+	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 	u32 mask = 1 << irq;
 
 	clrbits32(io_base + HW_BROADWAY_IMR, mask);
@@ -54,7 +54,7 @@ static void hlwd_pic_mask_and_ack(struct irq_data *d)
 static void hlwd_pic_ack(struct irq_data *d)
 {
 	int irq = virq_to_hw(d->irq);
-	void __iomem *io_base = get_irq_chip_data(d->irq);
+	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 
 	out_be32(io_base + HW_BROADWAY_ICR, 1 << irq);
 }
@@ -62,7 +62,7 @@ static void hlwd_pic_ack(struct irq_data *d)
 static void hlwd_pic_mask(struct irq_data *d)
 {
 	int irq = virq_to_hw(d->irq);
-	void __iomem *io_base = get_irq_chip_data(d->irq);
+	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 
 	clrbits32(io_base + HW_BROADWAY_IMR, 1 << irq);
 }
@@ -70,7 +70,7 @@ static void hlwd_pic_mask(struct irq_data *d)
 static void hlwd_pic_unmask(struct irq_data *d)
 {
 	int irq = virq_to_hw(d->irq);
-	void __iomem *io_base = get_irq_chip_data(d->irq);
+	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 
 	setbits32(io_base + HW_BROADWAY_IMR, 1 << irq);
 }
diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index bc8b59b..3988c86 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -101,7 +101,7 @@ static DEFINE_PER_CPU(struct ps3_private, ps3_private);
 
 static void ps3_chip_mask(struct irq_data *d)
 {
-	struct ps3_private *pd = get_irq_chip_data(d->irq);
+	struct ps3_private *pd = irq_data_get_irq_chip_data(d);
 	unsigned long flags;
 
 	pr_debug("%s:%d: thread_id %llu, virq %d\n", __func__, __LINE__,
@@ -122,7 +122,7 @@ static void ps3_chip_mask(struct irq_data *d)
 
 static void ps3_chip_unmask(struct irq_data *d)
 {
-	struct ps3_private *pd = get_irq_chip_data(d->irq);
+	struct ps3_private *pd = irq_data_get_irq_chip_data(d);
 	unsigned long flags;
 
 	pr_debug("%s:%d: thread_id %llu, virq %d\n", __func__, __LINE__,
@@ -143,7 +143,7 @@ static void ps3_chip_unmask(struct irq_data *d)
 
 static void ps3_chip_eoi(struct irq_data *d)
 {
-	const struct ps3_private *pd = get_irq_chip_data(d->irq);
+	const struct ps3_private *pd = irq_data_get_irq_chip_data(d);
 	lv1_end_of_interrupt_ext(pd->ppe_id, pd->thread_id, d->irq);
 }
 
diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/sysdev/mpc8xxx_gpio.c
index 519a877..11fb518 100644
--- a/arch/powerpc/sysdev/mpc8xxx_gpio.c
+++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c
@@ -157,7 +157,7 @@ static void mpc8xxx_gpio_irq_cascade(unsigned int irq, struct irq_desc *desc)
 
 static void mpc8xxx_irq_unmask(struct irq_data *d)
 {
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(d->irq);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
 	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 	unsigned long flags;
 
@@ -170,7 +170,7 @@ static void mpc8xxx_irq_unmask(struct irq_data *d)
 
 static void mpc8xxx_irq_mask(struct irq_data *d)
 {
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(d->irq);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
 	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 	unsigned long flags;
 
@@ -183,7 +183,7 @@ static void mpc8xxx_irq_mask(struct irq_data *d)
 
 static void mpc8xxx_irq_ack(struct irq_data *d)
 {
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(d->irq);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
 	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 
 	out_be32(mm->regs + GPIO_IER, mpc8xxx_gpio2mask(virq_to_hw(d->irq)));
@@ -191,7 +191,7 @@ static void mpc8xxx_irq_ack(struct irq_data *d)
 
 static int mpc8xxx_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(d->irq);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
 	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 	unsigned long flags;
 
@@ -219,7 +219,7 @@ static int mpc8xxx_irq_set_type(struct irq_data *d, unsigned int flow_type)
 
 static int mpc512x_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(d->irq);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = irq_data_get_irq_chip_data(d);
 	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
 	unsigned long gpio = virq_to_hw(d->irq);
 	void __iomem *reg;
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 24bfc1e..8c9ded8 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -192,11 +192,16 @@ static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
 	return get_irq_chip_data(virq);
 }
 
+static inline struct qe_ic *qe_ic_from_irq_data(struct irq_data *d)
+{
+	return irq_data_get_irq_chip_data(d);
+}
+
 #define virq_to_hw(virq)	((unsigned int)irq_map[virq].hwirq)
 
 static void qe_ic_unmask_irq(struct irq_data *d)
 {
-	struct qe_ic *qe_ic = qe_ic_from_irq(d->irq);
+	struct qe_ic *qe_ic = qe_ic_from_irq_data(d);
 	unsigned int src = virq_to_hw(d->irq);
 	unsigned long flags;
 	u32 temp;
@@ -212,7 +217,7 @@ static void qe_ic_unmask_irq(struct irq_data *d)
 
 static void qe_ic_mask_irq(struct irq_data *d)
 {
-	struct qe_ic *qe_ic = qe_ic_from_irq(d->irq);
+	struct qe_ic *qe_ic = qe_ic_from_irq_data(d);
 	unsigned int src = virq_to_hw(d->irq);
 	unsigned long flags;
 	u32 temp;
diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index 861fb99..835f795 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -58,7 +58,7 @@ struct uic {
 static void uic_unmask_irq(struct irq_data *d)
 {
 	struct irq_desc *desc = irq_to_desc(d->irq);
-	struct uic *uic = get_irq_chip_data(d->irq);
+	struct uic *uic = irq_data_get_irq_chip_data(d);
 	unsigned int src = uic_irq_to_hw(d->irq);
 	unsigned long flags;
 	u32 er, sr;
@@ -76,7 +76,7 @@ static void uic_unmask_irq(struct irq_data *d)
 
 static void uic_mask_irq(struct irq_data *d)
 {
-	struct uic *uic = get_irq_chip_data(d->irq);
+	struct uic *uic = irq_data_get_irq_chip_data(d);
 	unsigned int src = uic_irq_to_hw(d->irq);
 	unsigned long flags;
 	u32 er;
@@ -90,7 +90,7 @@ static void uic_mask_irq(struct irq_data *d)
 
 static void uic_ack_irq(struct irq_data *d)
 {
-	struct uic *uic = get_irq_chip_data(d->irq);
+	struct uic *uic = irq_data_get_irq_chip_data(d);
 	unsigned int src = uic_irq_to_hw(d->irq);
 	unsigned long flags;
 
@@ -102,7 +102,7 @@ static void uic_ack_irq(struct irq_data *d)
 static void uic_mask_ack_irq(struct irq_data *d)
 {
 	struct irq_desc *desc = irq_to_desc(d->irq);
-	struct uic *uic = get_irq_chip_data(d->irq);
+	struct uic *uic = irq_data_get_irq_chip_data(d);
 	unsigned int src = uic_irq_to_hw(d->irq);
 	unsigned long flags;
 	u32 er, sr;
@@ -127,7 +127,7 @@ static void uic_mask_ack_irq(struct irq_data *d)
 
 static int uic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct uic *uic = get_irq_chip_data(d->irq);
+	struct uic *uic = irq_data_get_irq_chip_data(d);
 	unsigned int src = uic_irq_to_hw(d->irq);
 	struct irq_desc *desc = irq_to_desc(d->irq);
 	unsigned long flags;
diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xilinx_intc.c
index 0512f58..7436f3e 100644
--- a/arch/powerpc/sysdev/xilinx_intc.c
+++ b/arch/powerpc/sysdev/xilinx_intc.c
@@ -72,7 +72,7 @@ static unsigned char xilinx_intc_map_senses[] = {
 static void xilinx_intc_mask(struct irq_data *d)
 {
 	int irq = virq_to_hw(d->irq);
-	void * regs = get_irq_chip_data(d->irq);
+	void * regs = irq_data_get_irq_chip_data(d);
 	pr_debug("mask: %d\n", irq);
 	out_be32(regs + XINTC_CIE, 1 << irq);
 }
@@ -94,7 +94,7 @@ static int xilinx_intc_set_type(struct irq_data *d, unsigned int flow_type)
 static void xilinx_intc_level_unmask(struct irq_data *d)
 {
 	int irq = virq_to_hw(d->irq);
-	void * regs = get_irq_chip_data(d->irq);
+	void * regs = irq_data_get_irq_chip_data(d);
 	pr_debug("unmask: %d\n", irq);
 	out_be32(regs + XINTC_SIE, 1 << irq);
 
@@ -119,7 +119,7 @@ static struct irq_chip xilinx_intc_level_irqchip = {
 static void xilinx_intc_edge_unmask(struct irq_data *d)
 {
 	int irq = virq_to_hw(d->irq);
-	void *regs = get_irq_chip_data(d->irq);
+	void *regs = irq_data_get_irq_chip_data(d);
 	pr_debug("unmask: %d\n", irq);
 	out_be32(regs + XINTC_SIE, 1 << irq);
 }
@@ -127,7 +127,7 @@ static void xilinx_intc_edge_unmask(struct irq_data *d)
 static void xilinx_intc_edge_ack(struct irq_data *d)
 {
 	int irq = virq_to_hw(d->irq);
-	void * regs = get_irq_chip_data(d->irq);
+	void * regs = irq_data_get_irq_chip_data(d);
 	pr_debug("ack: %d\n", irq);
 	out_be32(regs + XINTC_IAR, 1 << irq);
 }
