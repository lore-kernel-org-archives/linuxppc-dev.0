Return-Path: <nd@bplan-gmbh.de>
Message-ID: <45409760.7030902@bplan-gmbh.de>
Date: Thu, 26 Oct 2006 13:09:20 +0200
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
References: <453FB582.20802@bplan-gmbh.de>
	<1161816783.22582.132.camel@localhost.localdomain>
In-Reply-To: <1161816783.22582.132.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------070101010600020600040400"
Cc: akpm@osdl.org, Sylvain Munaut <tnt@246tNt.com>, sl@bplan-gmbh.de,
	linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070101010600020600040400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
> On Wed, 2006-10-25 at 21:05 +0200, Nicolas DET wrote:
> 
> In addition to various whitespace damage in the patch...
> 
>> +	if (_chrp_type ==  _CHRP_E5K2) {
>> +		ppc_md.get_irq = mpc52xx_get_irq;
>> +		mpc52xx_init_irq();
>> +		return;
>> +	}
> 
> As I wrote, the above should be unnecessary.
> 
>>  	chrp_find_openpic();
>>  	chrp_find_8259();
> 
> Just add a
> 
> 	chrp_find_mpc5200pic();
> 
> Which will set itself as the default controller and set ppc_md.get_irq
> if none have done it before.
>  
>> @@ -530,6 +540,9 @@ chrp_init2(void)
>>  	chrp_nvram_init();
>>  #endif
>>  
>> +	if (_chrp_type == _CHRP_E5K2)
>> +		return;
> 

Done.


>> +static void
>> +mpc52xx_ic_disable(unsigned int virq)
>> +{
>> +        u32 val;
>> +	int irq;
>> +
>> +	irq = irq_map[virq].hwirq;
> 
> You should test if the result is valid just in case you were called with
> [...]
> I'm surprised the revmap is working at all... considering the issues you
> have above. You are lucky but things should be fixed anyway.
> 

As said in the mail. I'm waiting for the opinion of the original authors 
and the mainteners. What's why I did not made much change in this file.
In the current patch, I know do:
mpc52xx_irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR, NR_IRQS, 
&mpc52xx_irqhost_ops, -1);

Which should be ok.

>> --- a/arch/powerpc/sysdev/Makefile	2006-10-25 19:07:24.000000000 +0200
>> +++ b/arch/powerpc/sysdev/Makefile	2006-10-25 20:33:32.000000000 +0200
>> @@ -13,6 +13,7 @@ obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
>>  obj-$(CONFIG_PPC_TODC)		+= todc.o
>>  obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
>>  obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
>> +obj-$(CONFIG_PPC_CHRP)		+= mpc52xx_pic.o
> 

Done.

Regards

--------------070101010600020600040400
Content-Type: text/plain;
 name="chrpmpc52xx_2.6.19-rc3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="chrpmpc52xx_2.6.19-rc3.patch"

--- a/arch/powerpc/sysdev/Makefile	2006-10-25 19:07:24.000000000 +0200
+++ b/arch/powerpc/sysdev/Makefile	2006-10-26 11:38:02.000000000 +0200
@@ -13,6 +13,7 @@ obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_PPC_TODC)		+= todc.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
+obj-$(CONFIG_PPC_MPC52xx_PIC)	+= mpc52xx_pic.o
 
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
--- a/arch/powerpc/sysdev/mpc52xx_pic.c	2006-10-25 19:07:24.000000000 +0200
+++ b/arch/powerpc/sysdev/mpc52xx_pic.c	2006-10-26 10:55:44.000000000 +0200
@@ -0,0 +1,371 @@
+/*
+ * arch/powerpc/sysdev/mpc52xx_pic.c
+ *
+ * Programmable Interrupt Controller functions for the Freescale MPC52xx 
+ * embedded CPU.
+ * Modified for CHRP Efika 5K2
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
+//#define DEBUG
+
+#include <linux/stddef.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/stddef.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+
+#include <asm/io.h>
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+
+#include <asm/mpc52xx.h>
+
+static struct mpc52xx_intr __iomem *intr;
+static struct mpc52xx_sdma __iomem *sdma;
+
+static struct irq_host *mpc52xx_irqhost = NULL;
+
+static void
+mpc52xx_ic_disable(unsigned int virq)
+{
+        u32 val;
+	int irq;
+
+	irq = irq_map[virq].hwirq;
+
+	pr_debug("%s: irq=%d\n", __func__, irq);
+
+        if (irq == MPC52xx_IRQ0) {
+                val = in_be32(&intr->ctrl);
+                val &= ~(1 << 11);
+                out_be32(&intr->ctrl, val);
+        } else if (irq < MPC52xx_IRQ1) {
+                BUG();
+        } else if (irq <= MPC52xx_IRQ3) {
+                val = in_be32(&intr->ctrl);
+                val &= ~(1 << (10 - (irq - MPC52xx_IRQ1)));
+                out_be32(&intr->ctrl, val);
+        } else if (irq < MPC52xx_SDMA_IRQ_BASE) {
+                val = in_be32(&intr->main_mask);
+                val |= 1 << (16 - (irq - MPC52xx_MAIN_IRQ_BASE));
+                out_be32(&intr->main_mask, val);
+        } else if (irq < MPC52xx_PERP_IRQ_BASE) {
+                val = in_be32(&sdma->IntMask);
+                val |= 1 << (irq - MPC52xx_SDMA_IRQ_BASE);
+                out_be32(&sdma->IntMask, val);
+        } else {
+                val = in_be32(&intr->per_mask);
+                val |= 1 << (31 - (irq - MPC52xx_PERP_IRQ_BASE));
+                out_be32(&intr->per_mask, val);
+        }
+}
+
+static void
+mpc52xx_ic_enable(unsigned int virq)
+{
+        u32 val;
+	int irq;
+
+	irq = irq_map[virq].hwirq;
+
+	pr_debug("%s: irq=%d\n", __func__, irq);
+
+        if (irq == MPC52xx_IRQ0) {
+                val = in_be32(&intr->ctrl);
+                val |= 1 << 11;
+                out_be32(&intr->ctrl, val);
+        } else if (irq < MPC52xx_IRQ1) {
+                BUG();
+        } else if (irq <= MPC52xx_IRQ3) {
+                val = in_be32(&intr->ctrl);
+                val |= 1 << (10 - (irq - MPC52xx_IRQ1));
+                out_be32(&intr->ctrl, val);
+        } else if (irq < MPC52xx_SDMA_IRQ_BASE) {
+                val = in_be32(&intr->main_mask);
+                val &= ~(1 << (16 - (irq - MPC52xx_MAIN_IRQ_BASE)));
+                out_be32(&intr->main_mask, val);
+        } else if (irq < MPC52xx_PERP_IRQ_BASE) {
+                val = in_be32(&sdma->IntMask);
+                val &= ~(1 << (irq - MPC52xx_SDMA_IRQ_BASE));
+                out_be32(&sdma->IntMask, val);
+        } else {
+                val = in_be32(&intr->per_mask);
+                val &= ~(1 << (31 - (irq - MPC52xx_PERP_IRQ_BASE)));
+                out_be32(&intr->per_mask, val);
+        }
+}
+
+static void
+mpc52xx_ic_ack(unsigned int virq)
+{
+        u32 val;
+	int irq;
+
+	irq = irq_map[virq].hwirq;
+
+	pr_debug("%s: irq=%d\n", __func__, irq);
+
+        /*
+         * Only some irqs are reset here, others in interrupting hardware.
+         */
+
+        switch (irq) {
+        case MPC52xx_IRQ0:
+                val = in_be32(&intr->ctrl);
+                val |= 0x08000000;
+                out_be32(&intr->ctrl, val);
+                break;
+        case MPC52xx_CCS_IRQ:
+                val = in_be32(&intr->enc_status);
+                val |= 0x00000400;
+                out_be32(&intr->enc_status, val);
+                break;
+        case MPC52xx_IRQ1:
+                val = in_be32(&intr->ctrl);
+                val |= 0x04000000;
+                out_be32(&intr->ctrl, val);
+                break;
+        case MPC52xx_IRQ2:
+                val = in_be32(&intr->ctrl);
+                val |= 0x02000000;
+                out_be32(&intr->ctrl, val);
+                break;
+        case MPC52xx_IRQ3:
+                val = in_be32(&intr->ctrl);
+                val |= 0x01000000;
+                out_be32(&intr->ctrl, val);
+                break;
+        default:
+                if (irq >= MPC52xx_SDMA_IRQ_BASE
+                                && irq < (MPC52xx_SDMA_IRQ_BASE + MPC52xx_SDMA_IRQ_NUM)) {
+                        out_be32(&sdma->IntPend,
+                                 1 << (irq - MPC52xx_SDMA_IRQ_BASE));
+                }
+
+                break;
+        }
+
+}
+
+static void
+mpc52xx_ic_disable_and_ack(unsigned int irq)
+{
+        mpc52xx_ic_disable(irq);
+        mpc52xx_ic_ack(irq);
+}
+
+static void
+mpc52xx_ic_end(unsigned int irq)
+{
+        if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
+                mpc52xx_ic_enable(irq);
+}
+
+static struct irq_chip mpc52xx_irqchip = {
+	.name	= " MPC52xx  ",
+	.enable		= mpc52xx_ic_enable,
+	.disable	= mpc52xx_ic_disable,
+	.ack		= mpc52xx_ic_disable_and_ack,
+	.end		= mpc52xx_ic_end,
+};
+
+
+extern struct device_node *find_mpc52xx_pic(void);
+static int mpc52xx_irqhost_match(struct irq_host *h, struct device_node *node)
+{
+	pr_debug("%s: %p vs %p\n", __func__, find_mpc52xx_pic(),  node);
+	return find_mpc52xx_pic() == node;
+}
+
+static int mpc52xx_irqhost_xlate(struct irq_host *h, struct device_node *ct,
+                            u32 *intspec, unsigned int intsize,
+                            irq_hw_number_t *out_hwirq, unsigned int *out_flags)
+{
+        static unsigned char map_senses[4] = {
+                IRQ_TYPE_LEVEL_HIGH,
+                IRQ_TYPE_EDGE_FALLING,
+                IRQ_TYPE_EDGE_RISING,
+		IRQ_TYPE_LEVEL_LOW,
+        };
+
+        int intrvect_l1;
+        int intrvect_l2;
+	int intrvect_type;
+        int intrvect_linux;
+
+        pr_debug("%s:\n", __func__);
+
+	if (intsize!=3)
+		return -1;
+
+        intrvect_l1 = (int) intspec[0];
+        intrvect_l2 = (int) intspec[1];
+	intrvect_type = (int) intspec[2];
+
+        pr_debug("l1=%d, l2=%d, type=%d\n", intrvect_l1, intrvect_l2, intrvect_type );
+
+        switch(intrvect_l1) {
+        case 0: /* Critical */
+                intrvect_linux = MPC52xx_CRIT_IRQ_BASE;
+                break;
+
+        case 1: /* Main */
+                intrvect_linux = MPC52xx_MAIN_IRQ_BASE;
+                break;
+
+        case 2: /* Periph */
+                intrvect_linux = MPC52xx_PERP_IRQ_BASE;
+                break;
+
+        case 3: /* Bestcomm */
+                intrvect_linux = MPC52xx_SDMA_IRQ_BASE;
+                break;
+
+        default:
+                if ( printk_ratelimit() )
+			printk(KERN_ERR "Wrong L1 interrupt vector (%d)\n", intrvect_l1);
+
+                return -1;
+        }
+
+        intrvect_linux += intrvect_l2;
+
+        pr_debug("return %d\n", intrvect_linux);
+
+	*out_hwirq = intrvect_linux;
+	*out_flags = map_senses[intrvect_type];
+
+        return 0;
+
+}
+
+int mpc52xx_irqhost_map(struct irq_host *h, unsigned int virq, irq_hw_number_t hw)
+{
+	pr_debug("%s: v=%d, hw=%d\n", __func__, virq, (int) hw);
+
+	return 0;
+}
+
+void mpc52xx_irqhost_unmap(struct irq_host *h, unsigned int virq)
+{
+	pr_debug("%s: v=%d\n", __func__, virq);
+}
+
+static struct irq_host_ops mpc52xx_irqhost_ops = {
+        .match = mpc52xx_irqhost_match,
+        .xlate = mpc52xx_irqhost_xlate,
+	.map   = mpc52xx_irqhost_map,
+	.unmap = mpc52xx_irqhost_unmap,
+};
+
+void __init
+mpc52xx_init_irq(void)
+{
+	int i;
+        u32 intr_ctrl;
+	
+
+        /* Remap the necessary zones */
+        intr = ioremap(MPC52xx_PA(MPC52xx_INTR_OFFSET), MPC52xx_INTR_SIZE);
+        sdma = ioremap(MPC52xx_PA(MPC52xx_SDMA_OFFSET), MPC52xx_SDMA_SIZE);
+
+        if ((intr==NULL) || (sdma==NULL))
+                panic("Can't ioremap PIC/SDMA register or init_irq !");
+
+        /* Disable all interrupt sources. */
+        out_be32(&sdma->IntPend, 0xffffffff);	/* 1 means clear pending */
+        out_be32(&sdma->IntMask, 0xffffffff);	/* 1 means disabled */
+        out_be32(&intr->per_mask, 0x7ffffc00);	/* 1 means disabled */
+        out_be32(&intr->main_mask, 0x00010fff);	/* 1 means disabled */
+        intr_ctrl = in_be32(&intr->ctrl);
+        intr_ctrl &=    0x00ff0000;	/* Keeps IRQ[0-3] config */
+        intr_ctrl |=	0x0f000000 |	/* clear IRQ 0-3 */
+                     0x00001000 |	/* MEE master external enable */
+                     0x00000000 |	/* 0 means disable IRQ 0-3 */
+                     0x00000001;	/* CEb route critical normally */
+        out_be32(&intr->ctrl, intr_ctrl);
+
+        /* Zero a bunch of the priority settings.  */
+        out_be32(&intr->per_pri1, 0);
+        out_be32(&intr->per_pri2, 0);
+        out_be32(&intr->per_pri3, 0);
+        out_be32(&intr->main_pri1, 0);
+        out_be32(&intr->main_pri2, 0);
+        /* Initialize irq_desc[i].handler's with mpc52xx_ic. */
+        for (i = 0; i < NR_IRQS; i++) {
+                irq_desc[i].chip = &mpc52xx_irqchip;
+                irq_desc[i].status = IRQ_LEVEL;
+		
+        }
+
+#define IRQn_MODE(intr_ctrl,irq) (((intr_ctrl) >> (22-(i<<1))) & 0x03)
+        for (i=0 ; i<4 ; i++) {
+                int mode;
+                mode = IRQn_MODE(intr_ctrl,i);
+                if ((mode == 0x1) || (mode == 0x2))
+                        irq_desc[i?MPC52xx_IRQ1+i-1:MPC52xx_IRQ0].status = 0;
+        }
+
+	/*
+	 * As last step, add an irq host to translate the real
+	 * hw irq information provided by the ofw to linux virq
+	*/
+
+	mpc52xx_irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR, NR_IRQS, &mpc52xx_irqhost_ops, -1);
+	pr_debug("%s: mpc52xx_irqhost =%p\n", __func__, mpc52xx_irqhost );
+}
+
+unsigned int
+mpc52xx_get_irq(void)
+{
+        u32 status;
+	int virq;
+        int irq = NO_IRQ_IGNORE;
+
+        status = in_be32(&intr->enc_status);
+        if (status & 0x00000400)
+        {		/* critical */
+                irq = (status >> 8) & 0x3;
+                if (irq == 2)			/* high priority peripheral */
+                        goto peripheral;
+                irq += MPC52xx_CRIT_IRQ_BASE;
+        } else if (status & 0x00200000)
+        {		/* main */
+                irq = (status >> 16) & 0x1f;
+                if (irq == 4)			/* low priority peripheral */
+                        goto peripheral;
+                irq += MPC52xx_MAIN_IRQ_BASE;
+        } else if (status & 0x20000000)
+        {		/* peripheral */
+peripheral:
+                irq = (status >> 24) & 0x1f;
+                if (irq == 0) {			/* bestcomm */
+                        status = in_be32(&sdma->IntPend);
+                        irq = ffs(status) + MPC52xx_SDMA_IRQ_BASE-1;
+                } else
+                        irq += MPC52xx_PERP_IRQ_BASE;
+
+        }
+
+	virq = irq_linear_revmap(mpc52xx_irqhost, irq);
+	pr_debug("%s: irq=%d -> %d\n", __func__, irq, virq);
+
+        return virq;
+}
+
--- a/arch/powerpc/Kconfig	2006-10-25 19:07:23.000000000 +0200
+++ b/arch/powerpc/Kconfig	2006-10-26 11:32:54.000000000 +0200
@@ -384,6 +384,12 @@ config PPC_CHRP
 	select PPC_RTAS
 	select PPC_MPC106
 	select PPC_UDBG_16550
+	select PPC_MPC52xx_PIC
+	default y
+
+config PPC_MPC52xx_PIC
+        bool
+	depends on PPC_CHRP
 	default y
 
 config PPC_PMAC
--- a/arch/powerpc/platforms/chrp/setup.c	2006-10-25 19:07:23.000000000 +0200
+++ b/arch/powerpc/platforms/chrp/setup.c	2006-10-26 10:59:39.000000000 +0200
@@ -51,6 +51,7 @@
 #include <asm/mpic.h>
 #include <asm/rtas.h>
 #include <asm/xmon.h>
+#include <asm/mpc52xx.h>
 
 #include "chrp.h"
 
@@ -435,6 +436,51 @@ static struct irqaction xmon_irqaction =
 };
 #endif
 
+
+struct device_node *find_mpc52xx_pic(void)
+{
+	struct device_node *dev;
+	const char *piccompatible_list[] =
+	{
+		"mpc5200-interrupt-controller",
+		"mpc52xx-interrupt-controller",
+		"mpc52xx-pic",
+		"mpc5200-pic",
+		"5200-interrupt-controller",
+		"52xx-interrupt-controller",
+		"52xx-pic",
+		"5200-pic",
+		NULL
+	};
+
+	/* Look for an MPC52xx interrupt controller */
+	for_each_node_by_type(dev, "interrupt-controller")
+	{
+		const char **piccompatible_entry = piccompatible_list;
+
+		for(piccompatible_entry = piccompatible_list; *piccompatible_entry; piccompatible_entry++ )
+		{
+			if (device_is_compatible(dev, *piccompatible_entry ))
+				return dev;
+		}
+	}
+
+	return NULL;
+}
+
+static int  __init chrp_find_mpc52xx_pic(void)
+{
+	if (find_mpc52xx_pic())
+	{
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
@@ -494,8 +540,12 @@ void __init chrp_init_IRQ(void)
 #if defined(CONFIG_VT) && defined(CONFIG_INPUT_ADBHID) && defined(XMON)
 	struct device_node *kbd;
 #endif
-	chrp_find_openpic();
-	chrp_find_8259();
+
+	if ( chrp_find_mpc52xx_pic() < 0)
+	{
+		chrp_find_openpic();
+		chrp_find_8259();
+	}
 
 #ifdef CONFIG_SMP
 	/* Pegasos has no MPIC, those ops would make it crash. It might be an
diff -uprN a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
--- a/include/asm-ppc/mpc52xx.h	2006-10-25 19:07:48.000000000 +0200
+++ b/include/asm-ppc/mpc52xx.h	2006-10-25 19:11:55.000000000 +0200
@@ -119,7 +119,7 @@ enum ppc_sys_devices {
 #define MPC52xx_SDMA_IRQ_NUM	17
 #define MPC52xx_PERP_IRQ_NUM	23
 
-#define MPC52xx_CRIT_IRQ_BASE	1
+#define MPC52xx_CRIT_IRQ_BASE	0
 #define MPC52xx_MAIN_IRQ_BASE	(MPC52xx_CRIT_IRQ_BASE + MPC52xx_CRIT_IRQ_NUM)
 #define MPC52xx_SDMA_IRQ_BASE	(MPC52xx_MAIN_IRQ_BASE + MPC52xx_MAIN_IRQ_NUM)
 #define MPC52xx_PERP_IRQ_BASE	(MPC52xx_SDMA_IRQ_BASE + MPC52xx_SDMA_IRQ_NUM)
@@ -415,7 +415,7 @@ struct mpc52xx_cdm {
 #ifndef __ASSEMBLY__
 
 extern void mpc52xx_init_irq(void);
-extern int mpc52xx_get_irq(void);
+extern unsigned int mpc52xx_get_irq(void);
 
 extern unsigned long mpc52xx_find_end_of_memory(void);
 extern void mpc52xx_set_bat(void);

--------------070101010600020600040400
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


--------------070101010600020600040400--
