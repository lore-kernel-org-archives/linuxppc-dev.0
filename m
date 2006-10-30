Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id ECC3967CED
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 04:47:25 +1100 (EST)
Date: 30 Oct 2006 17:47:24 -0000
Message-ID: <20061030174724.7155.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: nd@bplan-gmbh.de, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller support for
	ARCH=powerpc
In-Reply-To: <200610292310.k9TNAHXZ013852@post.webmailer.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In article <200610292310.k9TNAHXZ013852@post.webmailer.de> Nicolas wrote:
> This patch add MPC52xx Interrupt controller for ARCH=powerpc.
> 
> It includes the main code in arch/powerpc/sysdev/ ad well as an header file in
> include/asm-powerpc.
> 
> Signed-off-by: Nicolas DET <nd@bplan-gmbh.de>

Wow, the source code size sure ballooned in this revision.

I'd like to see us go the other direction, with something like the
following (untested code).

-Dale Farnsworth

(BTW, I sent a patch containing these changes to Nicolas last week.)

-----------------------

static inline void io_be_setbit(u32 __iomem *addr, int bitno)
{
	out_be32(addr, in_be32(addr) | 1 << bitno);
}

static inline void io_be_clrbit(u32 __iomem *addr, int bitno)
{
	out_be32(addr, in_be32(addr) & ~(1 << bitno));
}

static void mpc52xx_ic_mask(unsigned int virq)
{
	u32 val;
	int irq;
	int l1irq;
	int l2irq;

	irq = irq_map[virq].hwirq;
	l1irq = (irq & MPC52xx_IRQ_L1_MASK) >> MPC52xx_IRQ_L1_OFFSET;
	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;

	pr_debug("%s: irq=%x. l1=%d, l2=%d\n", __func__, irq, l1irq, l2irq);

	switch (l1irq) {
	case MPC52xx_IRQ_L1_CRIT:
	case MPC52xx_IRQ_L1_MAIN:
		if (l2irq <= 3)
			io_be_clrbit(&intr->ctrl, 11 - l2irq);
		else
			io_be_setbit(&intr->main_mask, 16 - l2irq);
		break;

	case MPC52xx_IRQ_L1_PERP:
		io_be_setbit(&intr->per_mask, 31 - l2irq);
		break;

	case MPC52xx_IRQ_L1_SDMA:
		io_be_setbit(&sdma->IntMask, l2irq);
		break;
	}
}

static void mpc52xx_ic_unmask(unsigned int virq)
{
	u32 val;
	int irq;
	int l1irq;
	int l2irq;

	irq = irq_map[virq].hwirq;
	l1irq = (irq & MPC52xx_IRQ_L1_MASK) >> MPC52xx_IRQ_L1_OFFSET;
	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;

	pr_debug("%s: irq=%x. l1=%d, l2=%d\n", __func__, irq, l1irq, l2irq);

	switch (l1irq) {
	case MPC52xx_IRQ_L1_CRIT:
	case MPC52xx_IRQ_L1_MAIN:
		if (l2irq <= 3)
			io_be_setbit(&intr->ctrl, 11 - l2irq);
		else
			io_be_clrbit(&intr->main, 16 - l2irq);
		break;

	case MPC52xx_IRQ_L1_PERP:
		io_be_setbit(&intr->per_mask, 31 - l2irq);
		break;

	case MPC52xx_IRQ_L1_SDMA:
		io_be_clrbit(&sdma->IntMask, l2irq);
		break;
	}
}

static void mpc52xx_ic_ack(unsigned int virq)
{
	u32 val;
	int irq;
	int l1irq;
	int l2irq;

	irq = irq_map[virq].hwirq;
	l1irq = (irq & MPC52xx_IRQ_L1_MASK) >> MPC52xx_IRQ_L1_OFFSET;
	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;

	pr_debug("%s: irq=%x. l1=%d, l2=%d\n", __func__, irq, l1irq, l2irq);

	switch (l1irq) {
	case MPC52xx_IRQ_L1_CRIT:
	case MPC52xx_IRQ_L1_MAIN:
		if (l2irq <= 3)
			io_be_setbit(&intr->ctrl, 27 - l2irq);
		break;

	case MPC52xx_IRQ_L1_PERP:
		io_be_clrbit(&intr->per_mask, 31 - l2irq);
		break;

	case MPC52xx_IRQ_L1_SDMA:
		out_be32(&sdma->IntPend, 1 << l2irq);
		break;
	}
}
