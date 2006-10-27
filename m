Return-Path: <nd@bplan-gmbh.de>
Message-ID: <45421FFD.8070407@bplan-gmbh.de>
Date: Fri, 27 Oct 2006 17:04:29 +0200
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Nicolas DET <nd@bplan-gmbh.de>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
References: <453FB582.20802@bplan-gmbh.de>		<1161816783.22582.132.camel@localhost.localdomain>		<45409760.7030902@bplan-gmbh.de>		<1161866964.27827.2.camel@localhost.localdomain>		<4540B0A9.6070404@bplan-gmbh.de>		<528646bc0610260902o4d4996a4i3dcf2a9b874037c7@mail.gmail.com>		<4541118F.60002@bplan-gmbh.de>		<528646bc0610261300s3e93e53fk5732990089b68d35@mail.gmail.com>	<1161919709.25682.61.camel@localhost.localdomain>
	<45421C97.80501@bplan-gmbh.de>
In-Reply-To: <45421C97.80501@bplan-gmbh.de>
Content-Type: multipart/mixed; boundary="------------090405080409060703070805"
Cc: akpm@osdl.org, sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090405080409060703070805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nicolas DET wrote:
> Benjamin Herrenschmidt wrote:
>> On Thu, 2006-10-26 at 14:00 -0600, Grant Likely wrote:
>>> My comments are satisfied
>>>
>>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>>
>> Nack.
>>
>> The irq code doesn't properly use the genirq infrastructure. It's not
>> setting flow handlers, not implementing set_irq_type, not using the new
>> mask/unmask instead of the toplevel enable/disable...
>>
>>
> 
> Done.
> 
> We agree on IRC last night to postpone this implementation later on. 
> However, here it is.
> 
> This patch compiles fine when applied to the kernel 2.6.19-rc3. I also 
> tested gcc 3.3.5 and 4.1.2.
> 
> I made some tests and did not found any issue. However, more 
> testing/stressing/torturing and also with on others platforms is 
> required to fully validate the driver.
> 
>
>  	/* Pegasos has no MPIC, those ops would make it crash. It might be an
> diff -uprN a/include/asm-powerpc/mpc52xx.h b/include/asm-powerpc/mpc52xx.h
> --- a/include/asm-powerpc/mpc52xx.h	1970-01-01 01:00:00.000000000 +0100
> +++ b/include/asm-powerpc/mpc52xx.h	2006-10-27 15:51:55.000000000 +0200
> @@ -0,0 +1,414 @@
> +/*
> + * include/asm-ppc/mpc52xx.h
> + * 


Fixed to powerpc


> +#endif /* __ASSEMBLY__ */
> +
> +
> +#ifdef CONFIG_PCI
> +#define _IO_BASE	isa_io_base
> +#define _ISA_MEM_BASE	isa_mem_base
> +#define PCI_DRAM_OFFSET	pci_dram_offset
> +#else
> +#define _IO_BASE	0
> +#define _ISA_MEM_BASE	0
> +#define PCI_DRAM_OFFSET	0
> +#endif
> +
> +
> +/* ======================================================================== */
> +/* PPC Sys devices definition                                               */
> +/* ======================================================================== */
> +
> +enum ppc_sys_devices {
> +	MPC52xx_MSCAN1,
> +	MPC52xx_MSCAN2,
> +	MPC52xx_SPI,
> +	MPC52xx_USB,
> +	MPC52xx_BDLC,
> +	MPC52xx_PSC1,
> +	MPC52xx_PSC2,
> +	MPC52xx_PSC3,
> +	MPC52xx_PSC4,
> +	MPC52xx_PSC5,
> +	MPC52xx_PSC6,
> +	MPC52xx_FEC,
> +	MPC52xx_ATA,
> +	MPC52xx_I2C1,
> +	MPC52xx_I2C2,
> +	NUM_PPC_SYS_DEVS,
> +};
> +
> +

Removed


--------------090405080409060703070805
Content-Type: text/plain;
 name="chrpmpc52xx_2.6.19-rc3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="chrpmpc52xx_2.6.19-rc3.patch"

--- a/arch/powerpc/sysdev/Makefile	2006-10-25 19:07:24.000000000 +0200
+++ b/arch/powerpc/sysdev/Makefile	2006-10-27 15:31:41.000000000 +0200
@@ -13,6 +13,7 @@ obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_PPC_TODC)		+= todc.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
+obj-$(CONFIG_PPC_MPC52xx_PIC)	+= mpc52xx_pic.o
 
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
--- a/arch/powerpc/sysdev/mpc52xx_pic.c	1970-01-01 01:00:00.000000000 +0100
+++ b/arch/powerpc/sysdev/mpc52xx_pic.c	2006-10-27 15:58:29.000000000 +0200
@@ -0,0 +1,414 @@
+/*
+ * arch/powerpc/sysdev/mpc52xx_pic.c
+ *
+ * Programmable Interrupt Controller functions for the Freescale MPC52xx 
+ * embedded CPU.
+ * 
+ * Maintainer : Sylvain Munaut <tnt@246tNt.com>
+ *
+ * Based on (well, mostly copied from) the code from the 2.4 kernel by
+ * Dale Farnsworth <dfarnsworth@mvista.com> and Kent Borg.
+ * 
+ * Copyright (C) 2004 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2003 Montavista Software, Inc
+ * 
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#undef DEBUG
+
+#include <linux/stddef.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/stddef.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/hardirq.h>
+
+#include <asm/io.h>
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+#include <asm/mpc52xx.h>
+
+static struct mpc52xx_intr __iomem *intr;
+static struct mpc52xx_sdma __iomem *sdma;
+static struct irq_host *mpc52xx_irqhost = NULL;
+
+static void mpc52xx_ic_mask(unsigned int virq)
+{
+	u32 val;
+	int irq;
+	int l1irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l1irq = (irq & MPC52xx_IRQ_L1_MASK) >> MPC52xx_IRQ_L1_OFFSET;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l1=%d, l2=%d\n", __func__, irq, l1irq, l2irq);
+
+	switch (l1irq) {
+	case MPC52xx_IRQ_L1_CRIT:
+		if (l2irq != 0)
+			BUG();
+
+		val = in_be32(&intr->ctrl);
+		val &= ~(1 << 11);
+		out_be32(&intr->ctrl, val);
+		break;
+
+	case MPC52xx_IRQ_L1_MAIN:
+		if ( (l2irq >= 1) && (l2irq <= 3) ) {
+			val = in_be32(&intr->ctrl);
+			val &= ~(1 << (11 - l2irq));
+			out_be32(&intr->ctrl, val);
+		} else {
+			val = in_be32(&intr->main_mask);
+			val |= 1 << (16 - l2irq);
+			out_be32(&intr->main_mask, val);
+		}
+		break;
+
+	case MPC52xx_IRQ_L1_PERP:
+		val = in_be32(&intr->per_mask);
+		val |= 1 << (31 - l2irq);
+		out_be32(&intr->per_mask, val);
+		break;
+
+	case MPC52xx_IRQ_L1_SDMA:
+		val = in_be32(&sdma->IntMask);
+		val |= 1 << l2irq;
+		out_be32(&sdma->IntMask, val);
+		break;
+
+	default:
+		printk(KERN_ERR "MPC52xx PIC: Wrong interrupt\n");
+	}
+}
+
+static void mpc52xx_ic_unmask(unsigned int virq)
+{
+	u32 val;
+	int irq;
+	int l1irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l1irq = (irq & MPC52xx_IRQ_L1_MASK) >> MPC52xx_IRQ_L1_OFFSET;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l1=%d, l2=%d\n", __func__, irq, l1irq, l2irq);
+
+	switch (l1irq) {
+	case MPC52xx_IRQ_L1_CRIT:
+		if (l2irq != 0)
+			BUG();
+
+		val = in_be32(&intr->ctrl);
+		val |= 1 << 11;
+		out_be32(&intr->ctrl, val);
+		break;
+
+	case MPC52xx_IRQ_L1_MAIN:
+		if ( (l2irq >= 1) && (l2irq <= 3) ) {
+			val = in_be32(&intr->ctrl);
+			val |= 1 << (11 - l2irq);
+			out_be32(&intr->ctrl, val);
+		} else {
+			val = in_be32(&intr->main_mask);
+			val &= ~(1 << (16 - l2irq));
+			out_be32(&intr->main_mask, val);
+		}
+		break;
+
+	case MPC52xx_IRQ_L1_PERP:
+		val = in_be32(&intr->per_mask);
+		val &= ~(1 << (31 - l2irq));
+		out_be32(&intr->per_mask, val);
+		break;
+
+	case MPC52xx_IRQ_L1_SDMA:
+		val = in_be32(&sdma->IntMask);
+		val &= ~(1 << l2irq);
+		out_be32(&sdma->IntMask, val);
+		break;
+
+	default:
+		printk(KERN_ERR "MPC52xx PIC: Wrong interrupt\n");
+	}
+}
+
+static void mpc52xx_ic_ack(unsigned int virq)
+{
+	u32 val;
+	int irq;
+	int l1irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l1irq = (irq & MPC52xx_IRQ_L1_MASK) >> MPC52xx_IRQ_L1_OFFSET;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l1=%d, l2=%d\n", __func__, irq, l1irq, l2irq);
+
+	switch (l1irq) {
+	case MPC52xx_IRQ_L1_CRIT:
+		if (l2irq != 0)
+			BUG();
+
+		val = in_be32(&intr->ctrl);
+		val |= 0x08000000;
+		out_be32(&intr->ctrl, val);
+		break;
+
+	case MPC52xx_IRQ_L1_MAIN:
+		if ( (l2irq >= 1) && (l2irq <= 3) ) {
+			val = in_be32(&intr->ctrl);
+			val |= 0x08000000 >> l2irq;
+			out_be32(&intr->ctrl, val);
+		}
+		break;
+
+	case MPC52xx_IRQ_L1_PERP:
+		val = in_be32(&intr->per_mask);
+		val &= ~(1 << (31 - l2irq));
+		out_be32(&intr->per_mask, val);
+		break;
+
+	case MPC52xx_IRQ_L1_SDMA:
+		out_be32(&sdma->IntPend, 1 << l2irq);
+		break;
+
+	default:
+		printk(KERN_ERR "MPC52xx PIC: Wrong interrupt\n");
+	}
+}
+
+static void mpc52xx_ic_mask_and_ack(unsigned int irq)
+{
+	mpc52xx_ic_mask(irq);
+	mpc52xx_ic_ack(irq);
+}
+
+static struct irq_chip mpc52xx_irqchip = {
+	.typename = " MPC52xx  ",
+	.mask = mpc52xx_ic_mask,
+	.unmask = mpc52xx_ic_unmask,
+	.mask_ack = mpc52xx_ic_mask_and_ack,
+};
+
+static int mpc52xx_irqhost_match(struct irq_host *h, struct device_node *node)
+{
+	pr_debug("%s: %p vs %p\n", __func__, find_mpc52xx_picnode(), node);
+	return find_mpc52xx_picnode() == node;
+}
+
+static int mpc52xx_irqhost_xlate(struct irq_host *h, struct device_node *ct,
+				 u32 * intspec, unsigned int intsize,
+				 irq_hw_number_t * out_hwirq,
+				 unsigned int *out_flags)
+{
+	static unsigned char map_senses[4] = {
+		IRQ_TYPE_LEVEL_HIGH,
+		IRQ_TYPE_EDGE_FALLING,
+		IRQ_TYPE_EDGE_RISING,
+		IRQ_TYPE_LEVEL_LOW,
+	};
+
+	int intrvect_l1;
+	int intrvect_l2;
+	int intrvect_type;
+	int intrvect_linux;
+
+	if (intsize != 3)
+		return -1;
+
+	intrvect_l1 = (int)intspec[0];
+	intrvect_l2 = (int)intspec[1];
+	intrvect_type = (int)intspec[2];
+
+	pr_debug("l1=%d, l2=%d, type=%d\n", intrvect_l1, intrvect_l2,
+		 intrvect_type);
+
+	intrvect_linux =
+	    (intrvect_l1 << MPC52xx_IRQ_L1_OFFSET) & MPC52xx_IRQ_L1_MASK;
+	intrvect_linux |=
+	    (intrvect_l2 << MPC52xx_IRQ_L2_OFFSET) & MPC52xx_IRQ_L2_MASK;
+
+	pr_debug("return %x\n", intrvect_linux);
+
+	*out_hwirq = intrvect_linux;
+	*out_flags = map_senses[intrvect_type];
+
+	return 0;
+
+}
+
+static int mpc52xx_islevel(int num)
+{
+	u32 ictl_req;
+	int ictl_type;
+
+	ictl_req = in_be32(&intr->ctrl);
+	ictl_type = (ictl_req >> 16) & 0x3;
+
+	switch (ictl_type) {
+	case 0:
+	case 3:
+		return 1;
+	}
+
+	return 0;
+}
+
+static int mpc52xx_irqhost_map(struct irq_host *h, unsigned int virq,
+			       irq_hw_number_t irq)
+{
+	int l1irq;
+	int l2irq;
+	unsigned int status;
+
+	l1irq = (irq & MPC52xx_IRQ_L1_MASK) >> MPC52xx_IRQ_L1_OFFSET;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	status = get_irq_desc(virq)->status;
+
+	switch (l1irq) {
+	case MPC52xx_IRQ_L1_CRIT:
+		if (l2irq != 0)
+			BUG();
+		if (mpc52xx_islevel(0))
+			status |= IRQ_LEVEL;
+		break;
+
+	case MPC52xx_IRQ_L1_MAIN:
+		if (mpc52xx_islevel(l2irq))
+			status |= IRQ_LEVEL;
+		break;
+
+	default:
+		status |= IRQ_LEVEL;
+	}
+
+	get_irq_desc(virq)->status = status;
+	set_irq_chip_and_handler(virq, &mpc52xx_irqchip,
+				 (status & IRQ_LEVEL) ? handle_level_irq :
+				 handle_edge_irq);
+
+	pr_debug("%s: virq=%x, hw=%x. desc status=%x\n", __func__, virq,
+		 (int)irq, status);
+
+	return 0;
+}
+
+void mpc52xx_irqhost_unmap(struct irq_host *h, unsigned int virq)
+{
+	pr_debug("%s: v=%x\n", __func__, virq);
+
+	mpc52xx_ic_mask(virq);
+	set_irq_chip_and_handler(virq, NULL, NULL);
+	synchronize_irq(virq);
+}
+
+static struct irq_host_ops mpc52xx_irqhost_ops = {
+	.match = mpc52xx_irqhost_match,
+	.xlate = mpc52xx_irqhost_xlate,
+	.map = mpc52xx_irqhost_map,
+	.unmap = mpc52xx_irqhost_unmap,
+};
+
+void __init mpc52xx_init_irq(void)
+{
+	int i;
+	u32 intr_ctrl;
+
+	/* Remap the necessary zones */
+	intr = ioremap(MPC52xx_PA(MPC52xx_INTR_OFFSET), MPC52xx_INTR_SIZE);
+	sdma = ioremap(MPC52xx_PA(MPC52xx_SDMA_OFFSET), MPC52xx_SDMA_SIZE);
+
+	if ((intr == NULL) || (sdma == NULL))
+		panic("Can't ioremap PIC/SDMA register or init_irq !");
+
+	/* Disable all interrupt sources. */
+	out_be32(&sdma->IntPend, 0xffffffff);	/* 1 means clear pending */
+	out_be32(&sdma->IntMask, 0xffffffff);	/* 1 means disabled */
+	out_be32(&intr->per_mask, 0x7ffffc00);	/* 1 means disabled */
+	out_be32(&intr->main_mask, 0x00010fff);	/* 1 means disabled */
+	intr_ctrl = in_be32(&intr->ctrl);
+	intr_ctrl &= 0x00ff0000;	/* Keeps IRQ[0-3] config */
+	intr_ctrl |= 0x0f000000 |	/* clear IRQ 0-3 */
+	    0x00001000 |	/* MEE master external enable */
+	    0x00000000 |	/* 0 means disable IRQ 0-3 */
+	    0x00000001;		/* CEb route critical normally */
+	out_be32(&intr->ctrl, intr_ctrl);
+
+	/* Zero a bunch of the priority settings.  */
+	out_be32(&intr->per_pri1, 0);
+	out_be32(&intr->per_pri2, 0);
+	out_be32(&intr->per_pri3, 0);
+	out_be32(&intr->main_pri1, 0);
+	out_be32(&intr->main_pri2, 0);
+	/* Initialize irq_desc[i].handler's with mpc52xx_ic. */
+	for (i = 0; i < NR_IRQS; i++) {
+		irq_desc[i].chip = &mpc52xx_irqchip;
+		irq_desc[i].status = IRQ_LEVEL;
+
+	}
+
+	/*
+	 * As last step, add an irq host to translate the real
+	 * hw irq information provided by the ofw to linux virq
+	 */
+
+	mpc52xx_irqhost =
+	    irq_alloc_host(IRQ_HOST_MAP_LINEAR, NR_IRQS, &mpc52xx_irqhost_ops,
+			   -1);
+}
+
+unsigned int mpc52xx_get_irq(void)
+{
+	u32 status;
+	int irq = NO_IRQ_IGNORE;
+
+	status = in_be32(&intr->enc_status);
+	if (status & 0x00000400) {	/* critical */
+		irq = (status >> 8) & 0x3;
+		if (irq == 2)	/* high priority peripheral */
+			goto peripheral;
+		irq |=
+		    (MPC52xx_IRQ_L1_CRIT << MPC52xx_IRQ_L1_OFFSET) &
+		    MPC52xx_IRQ_L1_MASK;
+	} else if (status & 0x00200000) {	/* main */
+		irq = (status >> 16) & 0x1f;
+		if (irq == 4)	/* low priority peripheral */
+			goto peripheral;
+		irq |=
+		    (MPC52xx_IRQ_L1_MAIN << MPC52xx_IRQ_L1_OFFSET) &
+		    MPC52xx_IRQ_L1_MASK;
+	} else if (status & 0x20000000) {	/* peripheral */
+	      peripheral:
+		irq = (status >> 24) & 0x1f;
+		if (irq == 0) {	/* bestcomm */
+			status = in_be32(&sdma->IntPend);
+			irq = ffs(status) - 1;
+			irq |=
+			    (MPC52xx_IRQ_L1_SDMA << MPC52xx_IRQ_L1_OFFSET) &
+			    MPC52xx_IRQ_L1_MASK;
+		} else
+			irq |=
+			    (MPC52xx_IRQ_L1_PERP << MPC52xx_IRQ_L1_OFFSET) &
+			    MPC52xx_IRQ_L1_MASK;
+
+	}
+
+	pr_debug("%s: irq=%x. virq=%d\n", __func__, irq,
+		 irq_linear_revmap(mpc52xx_irqhost, irq));
+
+	return irq_linear_revmap(mpc52xx_irqhost, irq);
+}
--- a/arch/powerpc/Kconfig	2006-10-25 19:07:23.000000000 +0200
+++ b/arch/powerpc/Kconfig	2006-10-27 15:50:21.000000000 +0200
@@ -384,6 +384,11 @@ config PPC_CHRP
 	select PPC_RTAS
 	select PPC_MPC106
 	select PPC_UDBG_16550
+	select PPC_MPC52xx_PIC
+	default y
+
+config PPC_MPC52xx_PIC
+        bool
 	default y
 
 config PPC_PMAC
--- a/arch/powerpc/platforms/chrp/setup.c	2006-10-25 19:07:23.000000000 +0200
+++ b/arch/powerpc/platforms/chrp/setup.c	2006-10-27 16:08:03.000000000 +0200
@@ -51,6 +51,7 @@
 #include <asm/mpic.h>
 #include <asm/rtas.h>
 #include <asm/xmon.h>
+#include <asm/mpc52xx.h>
 
 #include "chrp.h"
 
@@ -435,6 +436,18 @@ static struct irqaction xmon_irqaction =
 };
 #endif
 
+static int __init chrp_find_mpc52xx_pic(void)
+{
+	if (find_mpc52xx_picnode()) {
+		printk(KERN_INFO "Found MPC52xx Interrupt Controller\n");
+		ppc_md.get_irq = mpc52xx_get_irq;
+		mpc52xx_init_irq();
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
 static void __init chrp_find_8259(void)
 {
 	struct device_node *np, *pic = NULL;
@@ -496,6 +509,7 @@ void __init chrp_init_IRQ(void)
 #endif
 	chrp_find_openpic();
 	chrp_find_8259();
+	chrp_find_mpc52xx_pic();
 
 #ifdef CONFIG_SMP
 	/* Pegasos has no MPIC, those ops would make it crash. It might be an
diff -uprN a/include/asm-powerpc/mpc52xx.h b/include/asm-powerpc/mpc52xx.h
--- a/include/asm-powerpc/mpc52xx.h	1970-01-01 01:00:00.000000000 +0100
+++ b/include/asm-powerpc/mpc52xx.h	2006-10-27 15:51:55.000000000 +0200
@@ -0,0 +1,414 @@
+/*
+ * include/asm-powerpc/mpc52xx.h
+ * 
+ * Prototypes, etc. for the Freescale MPC52xx embedded cpu chips
+ * May need to be cleaned as the port goes on ...
+ *
+ *
+ * Maintainer : Sylvain Munaut <tnt@246tNt.com>
+ *
+ * Originally written by Dale Farnsworth <dfarnsworth@mvista.com> 
+ * for the 2.4 kernel.
+ *
+ * Copyright (C) 2004-2005 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2003 MontaVista, Software, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __ASM_POWERPC_MPC52xx_H__
+#define __ASM_POWERPC_MPC52xx_H__
+
+#ifndef __ASSEMBLY__
+#include <asm/types.h>
+#include <asm/prom.h>
+
+#endif /* __ASSEMBLY__ */
+
+
+#ifdef CONFIG_PCI
+#define _IO_BASE	isa_io_base
+#define _ISA_MEM_BASE	isa_mem_base
+#define PCI_DRAM_OFFSET	pci_dram_offset
+#else
+#define _IO_BASE	0
+#define _ISA_MEM_BASE	0
+#define PCI_DRAM_OFFSET	0
+#endif
+
+/* ======================================================================== */
+/* Main registers/struct addresses                                          */
+/* ======================================================================== */
+
+/* MBAR position */
+#define MPC52xx_MBAR		0xf0000000	/* Phys address */
+#define MPC52xx_MBAR_VIRT	0xf0000000	/* Virt address */
+#define MPC52xx_MBAR_SIZE	0x00010000
+
+#define MPC52xx_PA(x)		((phys_addr_t)(MPC52xx_MBAR + (x)))
+#define MPC52xx_VA(x)		((void __iomem *)(MPC52xx_MBAR_VIRT + (x)))
+
+/* Registers zone offset/size  */
+#define MPC52xx_MMAP_CTL_OFFSET		0x0000
+#define MPC52xx_MMAP_CTL_SIZE		0x068
+#define MPC52xx_SDRAM_OFFSET		0x0100
+#define MPC52xx_SDRAM_SIZE		0x010
+#define MPC52xx_CDM_OFFSET		0x0200
+#define MPC52xx_CDM_SIZE		0x038
+#define MPC52xx_INTR_OFFSET		0x0500
+#define MPC52xx_INTR_SIZE		0x04c
+#define MPC52xx_GPTx_OFFSET(x)		(0x0600 + ((x)<<4))
+#define MPC52xx_GPT_SIZE		0x010
+#define MPC52xx_RTC_OFFSET		0x0800
+#define MPC52xx_RTC_SIZE		0x024
+#define MPC52xx_GPIO_OFFSET		0x0b00
+#define MPC52xx_GPIO_SIZE		0x040
+#define MPC52xx_GPIO_WKUP_OFFSET	0x0c00
+#define MPC52xx_GPIO_WKUP_SIZE		0x028
+#define MPC52xx_PCI_OFFSET		0x0d00
+#define MPC52xx_PCI_SIZE		0x100
+#define MPC52xx_SDMA_OFFSET		0x1200
+#define MPC52xx_SDMA_SIZE		0x100
+#define MPC52xx_XLB_OFFSET		0x1f00
+#define MPC52xx_XLB_SIZE		0x100
+#define MPC52xx_PSCx_OFFSET(x)		(((x)!=6)?(0x1e00+((x)<<9)):0x2c00)
+#define MPC52xx_PSC_SIZE		0x0a0
+
+/* SRAM used for SDMA */
+#define MPC52xx_SRAM_OFFSET		0x8000
+#define MPC52xx_SRAM_SIZE		0x4000
+
+
+/* ======================================================================== */
+/* IRQ mapping                                                              */
+/* ======================================================================== */
+
+#define MPC52xx_IRQ_L1_CRIT	0
+#define MPC52xx_IRQ_L1_MAIN	1
+#define MPC52xx_IRQ_L1_PERP	2
+#define MPC52xx_IRQ_L1_SDMA	3
+
+#define MPC52xx_IRQ_L1_OFFSET  (6)
+#define MPC52xx_IRQ_L1_MASK    (0xc0)
+
+#define MPC52xx_IRQ_L2_OFFSET  (0)
+#define MPC52xx_IRQ_L2_MASK    (0x3f)
+
+
+/* ======================================================================== */
+/* Structures mapping of some unit register set                             */
+/* ======================================================================== */
+
+#ifndef __ASSEMBLY__
+
+/* Memory Mapping Control */
+struct mpc52xx_mmap_ctl {
+	u32	mbar;		/* MMAP_CTRL + 0x00 */
+
+	u32	cs0_start;	/* MMAP_CTRL + 0x04 */
+	u32	cs0_stop;	/* MMAP_CTRL + 0x08 */
+	u32	cs1_start;	/* MMAP_CTRL + 0x0c */
+	u32	cs1_stop;	/* MMAP_CTRL + 0x10 */
+	u32	cs2_start;	/* MMAP_CTRL + 0x14 */
+	u32	cs2_stop;	/* MMAP_CTRL + 0x18 */
+	u32	cs3_start;	/* MMAP_CTRL + 0x1c */
+	u32	cs3_stop;	/* MMAP_CTRL + 0x20 */
+	u32	cs4_start;	/* MMAP_CTRL + 0x24 */
+	u32	cs4_stop;	/* MMAP_CTRL + 0x28 */
+	u32	cs5_start;	/* MMAP_CTRL + 0x2c */
+	u32	cs5_stop;	/* MMAP_CTRL + 0x30 */
+
+	u32	sdram0;		/* MMAP_CTRL + 0x34 */
+	u32	sdram1;		/* MMAP_CTRL + 0X38 */
+
+	u32	reserved[4];	/* MMAP_CTRL + 0x3c .. 0x48 */
+
+	u32	boot_start;	/* MMAP_CTRL + 0x4c */
+	u32	boot_stop;	/* MMAP_CTRL + 0x50 */
+
+	u32	ipbi_ws_ctrl;	/* MMAP_CTRL + 0x54 */
+
+	u32	cs6_start;	/* MMAP_CTRL + 0x58 */
+	u32	cs6_stop;	/* MMAP_CTRL + 0x5c */
+	u32	cs7_start;	/* MMAP_CTRL + 0x60 */
+	u32	cs7_stop;	/* MMAP_CTRL + 0x64 */
+};
+
+/* SDRAM control */
+struct mpc52xx_sdram {
+	u32	mode;		/* SDRAM + 0x00 */
+	u32	ctrl;		/* SDRAM + 0x04 */
+	u32	config1;	/* SDRAM + 0x08 */
+	u32	config2;	/* SDRAM + 0x0c */
+};
+
+/* Interrupt controller */
+struct mpc52xx_intr {
+	u32	per_mask;	/* INTR + 0x00 */
+	u32	per_pri1;	/* INTR + 0x04 */
+	u32	per_pri2;	/* INTR + 0x08 */
+	u32	per_pri3;	/* INTR + 0x0c */
+	u32	ctrl;		/* INTR + 0x10 */
+	u32	main_mask;	/* INTR + 0x14 */
+	u32	main_pri1;	/* INTR + 0x18 */
+	u32	main_pri2;	/* INTR + 0x1c */
+	u32	reserved1;	/* INTR + 0x20 */
+	u32	enc_status;	/* INTR + 0x24 */
+	u32	crit_status;	/* INTR + 0x28 */
+	u32	main_status;	/* INTR + 0x2c */
+	u32	per_status;	/* INTR + 0x30 */
+	u32	reserved2;	/* INTR + 0x34 */
+	u32	per_error;	/* INTR + 0x38 */
+};
+
+/* SDMA */
+struct mpc52xx_sdma {
+	u32	taskBar;	/* SDMA + 0x00 */
+	u32	currentPointer;	/* SDMA + 0x04 */
+	u32	endPointer;	/* SDMA + 0x08 */
+	u32	variablePointer;/* SDMA + 0x0c */
+
+	u8	IntVect1;	/* SDMA + 0x10 */
+	u8	IntVect2;	/* SDMA + 0x11 */
+	u16	PtdCntrl;	/* SDMA + 0x12 */
+
+	u32	IntPend;	/* SDMA + 0x14 */
+	u32	IntMask;	/* SDMA + 0x18 */
+
+	u16	tcr[16];	/* SDMA + 0x1c .. 0x3a */
+
+	u8	ipr[32];	/* SDMA + 0x3c .. 0x5b */
+
+	u32	cReqSelect;	/* SDMA + 0x5c */
+	u32	task_size0;	/* SDMA + 0x60 */
+	u32	task_size1;	/* SDMA + 0x64 */
+	u32	MDEDebug;	/* SDMA + 0x68 */
+	u32	ADSDebug;	/* SDMA + 0x6c */
+	u32	Value1;		/* SDMA + 0x70 */
+	u32	Value2;		/* SDMA + 0x74 */
+	u32	Control;	/* SDMA + 0x78 */
+	u32	Status;		/* SDMA + 0x7c */
+	u32	PTDDebug;	/* SDMA + 0x80 */
+};
+
+/* GPT */
+struct mpc52xx_gpt {
+	u32	mode;		/* GPTx + 0x00 */
+	u32	count;		/* GPTx + 0x04 */
+	u32	pwm;		/* GPTx + 0x08 */
+	u32	status;		/* GPTx + 0X0c */
+};
+
+/* RTC */
+struct mpc52xx_rtc {
+	u32	time_set;	/* RTC + 0x00 */
+	u32	date_set;	/* RTC + 0x04 */
+	u32	stopwatch;	/* RTC + 0x08 */
+	u32	int_enable;	/* RTC + 0x0c */
+	u32	time;		/* RTC + 0x10 */
+	u32	date;		/* RTC + 0x14 */
+	u32	stopwatch_intr;	/* RTC + 0x18 */
+	u32	bus_error;	/* RTC + 0x1c */
+	u32	dividers;	/* RTC + 0x20 */
+};
+
+/* GPIO */
+struct mpc52xx_gpio {
+	u32	port_config;	/* GPIO + 0x00 */
+	u32	simple_gpioe;	/* GPIO + 0x04 */
+	u32	simple_ode;	/* GPIO + 0x08 */
+	u32	simple_ddr;	/* GPIO + 0x0c */
+	u32	simple_dvo;	/* GPIO + 0x10 */
+	u32	simple_ival;	/* GPIO + 0x14 */
+	u8	outo_gpioe;	/* GPIO + 0x18 */
+	u8	reserved1[3];	/* GPIO + 0x19 */
+	u8	outo_dvo;	/* GPIO + 0x1c */
+	u8	reserved2[3];	/* GPIO + 0x1d */
+	u8	sint_gpioe;	/* GPIO + 0x20 */
+	u8	reserved3[3];	/* GPIO + 0x21 */
+	u8	sint_ode;	/* GPIO + 0x24 */
+	u8	reserved4[3];	/* GPIO + 0x25 */
+	u8	sint_ddr;	/* GPIO + 0x28 */
+	u8	reserved5[3];	/* GPIO + 0x29 */
+	u8	sint_dvo;	/* GPIO + 0x2c */
+	u8	reserved6[3];	/* GPIO + 0x2d */
+	u8	sint_inten;	/* GPIO + 0x30 */
+	u8	reserved7[3];	/* GPIO + 0x31 */
+	u16	sint_itype;	/* GPIO + 0x34 */
+	u16	reserved8;	/* GPIO + 0x36 */
+	u8	gpio_control;	/* GPIO + 0x38 */
+	u8	reserved9[3];	/* GPIO + 0x39 */
+	u8	sint_istat;	/* GPIO + 0x3c */
+	u8	sint_ival;	/* GPIO + 0x3d */
+	u8	bus_errs;	/* GPIO + 0x3e */
+	u8	reserved10;	/* GPIO + 0x3f */
+};
+
+#define MPC52xx_GPIO_PSC_CONFIG_UART_WITHOUT_CD	4
+#define MPC52xx_GPIO_PSC_CONFIG_UART_WITH_CD	5
+#define MPC52xx_GPIO_PCI_DIS			(1<<15)
+
+/* GPIO with WakeUp*/
+struct mpc52xx_gpio_wkup {
+	u8	wkup_gpioe;	/* GPIO_WKUP + 0x00 */
+	u8	reserved1[3];	/* GPIO_WKUP + 0x03 */
+	u8	wkup_ode;	/* GPIO_WKUP + 0x04 */
+	u8	reserved2[3];	/* GPIO_WKUP + 0x05 */
+	u8	wkup_ddr;	/* GPIO_WKUP + 0x08 */
+	u8	reserved3[3];	/* GPIO_WKUP + 0x09 */
+	u8	wkup_dvo;	/* GPIO_WKUP + 0x0C */
+	u8	reserved4[3];	/* GPIO_WKUP + 0x0D */
+	u8	wkup_inten;	/* GPIO_WKUP + 0x10 */
+	u8	reserved5[3];	/* GPIO_WKUP + 0x11 */
+	u8	wkup_iinten;	/* GPIO_WKUP + 0x14 */
+	u8	reserved6[3];	/* GPIO_WKUP + 0x15 */
+	u16	wkup_itype;	/* GPIO_WKUP + 0x18 */
+	u8	reserved7[2];	/* GPIO_WKUP + 0x1A */
+	u8	wkup_maste;	/* GPIO_WKUP + 0x1C */
+	u8	reserved8[3];	/* GPIO_WKUP + 0x1D */
+	u8	wkup_ival;	/* GPIO_WKUP + 0x20 */
+	u8	reserved9[3];	/* GPIO_WKUP + 0x21 */
+	u8	wkup_istat;	/* GPIO_WKUP + 0x24 */
+	u8	reserved10[3];	/* GPIO_WKUP + 0x25 */
+};
+
+/* XLB Bus control */
+struct mpc52xx_xlb {
+	u8	reserved[0x40];
+	u32	config;			/* XLB + 0x40 */
+	u32	version;		/* XLB + 0x44 */
+	u32	status;			/* XLB + 0x48 */
+	u32	int_enable;		/* XLB + 0x4c */
+	u32	addr_capture;		/* XLB + 0x50 */
+	u32	bus_sig_capture;	/* XLB + 0x54 */
+	u32	addr_timeout;		/* XLB + 0x58 */
+	u32	data_timeout;		/* XLB + 0x5c */
+	u32	bus_act_timeout;	/* XLB + 0x60 */
+	u32	master_pri_enable;	/* XLB + 0x64 */
+	u32	master_priority;	/* XLB + 0x68 */
+	u32	base_address;		/* XLB + 0x6c */
+	u32	snoop_window;		/* XLB + 0x70 */
+};
+
+#define MPC52xx_XLB_CFG_PLDIS		(1 << 31)
+#define MPC52xx_XLB_CFG_SNOOP		(1 << 15)
+
+/* Clock Distribution control */
+struct mpc52xx_cdm {
+	u32	jtag_id;		/* CDM + 0x00  reg0 read only */
+	u32	rstcfg;			/* CDM + 0x04  reg1 read only */
+	u32	breadcrumb;		/* CDM + 0x08  reg2 */
+
+	u8	mem_clk_sel;		/* CDM + 0x0c  reg3 byte0 */
+	u8	xlb_clk_sel;		/* CDM + 0x0d  reg3 byte1 read only */
+	u8	ipb_clk_sel;		/* CDM + 0x0e  reg3 byte2 */
+	u8	pci_clk_sel;		/* CDM + 0x0f  reg3 byte3 */
+
+	u8	ext_48mhz_en;		/* CDM + 0x10  reg4 byte0 */
+	u8	fd_enable;		/* CDM + 0x11  reg4 byte1 */
+	u16	fd_counters;		/* CDM + 0x12  reg4 byte2,3 */
+
+	u32	clk_enables;		/* CDM + 0x14  reg5 */
+
+	u8	osc_disable;		/* CDM + 0x18  reg6 byte0 */
+	u8	reserved0[3];		/* CDM + 0x19  reg6 byte1,2,3 */
+
+	u8	ccs_sleep_enable;	/* CDM + 0x1c  reg7 byte0 */
+	u8	osc_sleep_enable;	/* CDM + 0x1d  reg7 byte1 */
+	u8	reserved1;		/* CDM + 0x1e  reg7 byte2 */
+	u8	ccs_qreq_test;		/* CDM + 0x1f  reg7 byte3 */
+
+	u8	soft_reset;		/* CDM + 0x20  u8 byte0 */
+	u8	no_ckstp;		/* CDM + 0x21  u8 byte0 */
+	u8	reserved2[2];		/* CDM + 0x22  u8 byte1,2,3 */
+
+	u8	pll_lock;		/* CDM + 0x24  reg9 byte0 */
+	u8	pll_looselock;		/* CDM + 0x25  reg9 byte1 */
+	u8	pll_sm_lockwin;		/* CDM + 0x26  reg9 byte2 */
+	u8	reserved3;		/* CDM + 0x27  reg9 byte3 */
+
+	u16	reserved4;		/* CDM + 0x28  reg10 byte0,1 */
+	u16	mclken_div_psc1;	/* CDM + 0x2a  reg10 byte2,3 */
+
+	u16	reserved5;		/* CDM + 0x2c  reg11 byte0,1 */
+	u16	mclken_div_psc2;	/* CDM + 0x2e  reg11 byte2,3 */
+
+	u16	reserved6;		/* CDM + 0x30  reg12 byte0,1 */
+	u16	mclken_div_psc3;	/* CDM + 0x32  reg12 byte2,3 */
+
+	u16	reserved7;		/* CDM + 0x34  reg13 byte0,1 */
+	u16	mclken_div_psc6;	/* CDM + 0x36  reg13 byte2,3 */
+};
+
+#endif /* __ASSEMBLY__ */
+
+
+/* ========================================================================= */
+/* Prototypes for MPC52xx syslib                                             */
+/* ========================================================================= */
+
+#ifndef __ASSEMBLY__
+
+extern void mpc52xx_init_irq(void);
+extern unsigned int mpc52xx_get_irq(void);
+
+extern unsigned long mpc52xx_find_end_of_memory(void);
+extern void mpc52xx_set_bat(void);
+extern void mpc52xx_map_io(void);
+extern void mpc52xx_restart(char *cmd);
+extern void mpc52xx_halt(void);
+extern void mpc52xx_power_off(void);
+extern void mpc52xx_progress(char *s, unsigned short hex);
+extern void mpc52xx_calibrate_decr(void);
+
+extern void mpc52xx_find_bridges(void);
+
+extern void mpc52xx_setup_cpu(void);
+
+static inline struct device_node *
+find_mpc52xx_picnode(void)
+{
+	return of_find_compatible_node(NULL, "interrupt-controller", "mpc5200-pic");
+}
+
+	/* Matching of PSC function */
+struct mpc52xx_psc_func {
+	int id;
+	char *func;
+};
+
+extern int mpc52xx_match_psc_function(int psc_idx, const char *func);
+extern struct  mpc52xx_psc_func mpc52xx_psc_functions[];
+	/* This array is to be defined in platform file */
+
+#endif /* __ASSEMBLY__ */
+
+
+#endif /* _ASM_POWERPC_MPC52xx_H__ */

--------------090405080409060703070805
Content-Type: text/x-vcard; charset=utf-8;
 name="nd.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nd.vcf"

begin:vcard
fn:Nicolas DET ( bplan GmbH )
n:DET;Nicolas
org:bplan GmbH
adr:;;;;;;Germany
email;internet:nd@bplan-gmbh.de
title:Software Entwicklung
tel;work:+49 6171 9187 - 31
x-mozilla-html:FALSE
url:http://www.bplan-gmbh.de
version:2.1
end:vcard


--------------090405080409060703070805--
