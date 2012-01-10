Return-Path: <B25806@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 12AE3B6FB9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 21:25:26 +1100 (EST)
Received: from mail52-tx2 (localhost [127.0.0.1])	by mail52-tx2-R.bigfish.com
 (Postfix) with ESMTP id 39520100598	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 10 Jan 2012 10:25:21 +0000 (UTC)
Received: from TX2EHSMHS042.bigfish.com (unknown [10.9.14.236])	by
 mail52-tx2.bigfish.com (Postfix) with ESMTP id 258396C0049	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 10:25:20 +0000 (UTC)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/3] driver/misc: Add Pulse Width Modulator (PWM) driver for
 freescale
Date: Tue, 10 Jan 2012 18:26:42 +0800
Message-ID: <1326191203-11207-2-git-send-email-Chunhe.Lan@freescale.com>
In-Reply-To: <1326191203-11207-1-git-send-email-Chunhe.Lan@freescale.com>
References: <1326191203-11207-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PSC913x PWM with the following features:

  * 12-bit prescaler for division of clock
  * Active-high or active-low configured output
  * Interrupts at compare and roll-over
  * Programmable pulse width (duty cycle) and interval (period cycle)

A sysfs interface is provided to control the PWM output:

  * Set duty cycle and period cycle
        echo 1000 > /sys/devices/soc.0/e500.2/ff713000.pwm/duty_ns
        echo 5000 > /sys/devices/soc.0/e500.2/ff713000.pwm/period_ns
  * Show duty cycle and period cycle
        cat /sys/devices/soc.0/e500.2/ff713000.pwm/duty_ns
        cat /sys/devices/soc.0/e500.2/ff713000.pwm/period_ns

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
---
 arch/powerpc/include/asm/fsl_pwm.h |  111 +++++++++
 drivers/misc/Kconfig               |   11 +
 drivers/misc/Makefile              |    1 +
 drivers/misc/fsl_pwm.c             |  471 ++++++++++++++++++++++++++++++++++++
 4 files changed, 594 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/include/asm/fsl_pwm.h
 create mode 100644 drivers/misc/fsl_pwm.c

diff --git a/arch/powerpc/include/asm/fsl_pwm.h b/arch/powerpc/include/asm/fsl_pwm.h
new file mode 100644
index 0000000..a6d3bf5
--- /dev/null
+++ b/arch/powerpc/include/asm/fsl_pwm.h
@@ -0,0 +1,111 @@
+/*
+ * Freescale PWM Register Definitions
+ *
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ *
+ * Author: Chunhe Lan <Chunhe.Lan@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ARCH_FSL_PWM_H
+#define __ARCH_FSL_PWM_H
+
+#define FSL_PWMCR_STOPEN			(1 << 25)
+#define FSL_PWMCR_DOZEEN			(1 << 24)
+#define FSL_PWMCR_WAITEN			(1 << 23)
+#define FSL_PWMCR_DEBUGEN		        (1 << 22)
+#define FSL_PWMCR_BCTR				(1 << 21)
+#define FSL_PWMCR_HCTR				(1 << 20)
+#define FSL_PWMCR_POUTC_HIGHT			(0 << 18)
+#define FSL_PWMCR_POUTC_LOW			(1 << 18)
+#define FSL_PWMCR_CLKSRC			(1 << 16)
+#define FSL_PWMCR_PRESCALER(x)			(((x - 1) & 0xFFF) << 4)
+#define FSL_MAX_PRESCALER			0x00000FFF
+#define FSL_PWMCR_SWR				(1 << 3)
+#define FSL_PWMCR_REPEAT_ONE			(0 << 1)
+#define FSL_PWMCR_REPEAT_TWO			(1 << 1)
+#define FSL_PWMCR_REPEAT_FOUR			(2 << 1)
+#define FSL_PWMCR_REPEAT_EIGHT			(3 << 1)
+#define FSL_PWMCR_EN				(1 << 0)
+
+#define FSL_PWMSR_ALL_MASK			0x0000007F
+#define FSL_PWMSR_FWE_CMP_ROV_MASK		0x00000070
+#define FSL_PWMSR_FWE				(1 << 6)
+#define FSL_PWMSR_CMP				(1 << 5)
+#define FSL_PWMSR_ROV				(1 << 4)
+#define FSL_PWMSR_FE				(1 << 3)
+#define FSL_PWMSR_FIFOAV			(7 << 0)
+
+#define FSL_PWMIR				(7 << 0)
+#define FSL_PWMIR_CIE				(1 << 2)
+#define FSL_PWMIR_RIE				(1 << 1)
+#define FSL_PWMIR_FIE				(1 << 0)
+
+#define FSL_PMUXCR1_SPI1_ANT_TCXO_PWM_GPIO	(3 << 0)
+#define FSL_PMUXCR1_ANT_TCXO_PWM_GPIO		(1 << 0)
+#define FSL_PMUXCR2_UART_PWM_GPIO		(3 << 28)
+#define FSL_PMUXCR2_PWM_GPIO			(1 << 28)
+
+#define FSL_DEVDISR2_PWM1			(1 << 23)
+#define FSL_DEVDISR2_PWM1_EN			(0 << 23)
+#define FSL_DEVDISR2_PWM2			(1 << 22)
+#define FSL_DEVDISR2_PWM2_EN			(0 << 22)
+
+#define FSL_DEFAULT_IPG_CLK			500000000 /* 500MHz */
+
+struct pwm_reg {
+	u32 pwmcr;	    /* PWM Control Register */
+	u32 pwmsr;	    /* PWM Status Register */
+	u32 pwmir;	    /* PWM Interrupt Register */
+	u32 pwmsar;         /* PWM Sample Register */
+	u32 pwmpr;          /* PWM Period Register */
+	u32 pwmcnr;         /* PWM Counter Register */
+};
+
+struct pwm_device {
+	struct list_head node;
+	struct device dev;
+
+	const char *label;
+	struct clk *clk;
+	int clk_enabled;
+	struct pwm_reg __iomem *regs;
+	int irq;
+
+	unsigned int use_count;
+	unsigned int pwm_id;
+	int duty;
+	int period;
+	int pwmo_invert;
+	void (*enable_pwm_pad)(void);
+	void (*disable_pwm_pad)(void);
+};
+
+struct gubr {
+	u32 res24[0x18];
+	u32 pmuxcr1;
+	u32 pmuxcr2;
+	u32 res3[0x03];
+	u32 devdisr2;
+};
+
+extern int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns);
+extern int pwm_enable(struct pwm_device *pwm);
+extern void pwm_disable(struct pwm_device *pwm);
+extern struct pwm_device *pwm_request(int pwm_id, const char *label);
+extern void pwm_free(struct pwm_device *pwm);
+
+#endif /* __ARCH_FSL_PWM_H */
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 5664696..fbb72df 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -509,4 +509,15 @@ source "drivers/misc/lis3lv02d/Kconfig"
 source "drivers/misc/carma/Kconfig"
 source "drivers/misc/altera-stapl/Kconfig"
 
+ config FSL_PWM
+	bool "Freescale PWM support"
+	select PPC_CLOCK
+	default n
+	help
+	  This option enables device driver support for the PWM channels
+	  on certain Freescale processors(e.g. PSC9131RDB). Pulse Width
+	  Modulation is used for purposes including software controlled
+	  power-efficient backlights on LCD displays, motor control, and
+	  waveform generation and so on.
+
 endif # MISC_DEVICES
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index b26495a..b3e0dd4 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_AD525X_DPOT_I2C)	+= ad525x_dpot-i2c.o
 obj-$(CONFIG_AD525X_DPOT_SPI)	+= ad525x_dpot-spi.o
 obj-$(CONFIG_INTEL_MID_PTI)	+= pti.o
 obj-$(CONFIG_ATMEL_PWM)		+= atmel_pwm.o
+obj-$(CONFIG_FSL_PWM)		+= fsl_pwm.o
 obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
 obj-$(CONFIG_ATMEL_TCLIB)	+= atmel_tclib.o
 obj-$(CONFIG_BMP085)		+= bmp085.o
diff --git a/drivers/misc/fsl_pwm.c b/drivers/misc/fsl_pwm.c
new file mode 100644
index 0000000..cfe2002
--- /dev/null
+++ b/drivers/misc/fsl_pwm.c
@@ -0,0 +1,471 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ *
+ * PWM (Pulse Width Modulator) controller driver
+ *
+ * Author: Chunhe Lan <Chunhe.Lan@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/pwm.h>
+#include <linux/of_platform.h>
+#include <sysdev/fsl_soc.h>
+#include <asm/fsl_pwm.h>
+#include <asm/clock.h>
+#include <asm/prom.h>
+
+static DEFINE_MUTEX(pwm_lock);
+static LIST_HEAD(pwm_list);
+
+static ssize_t show_duty_ns(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct pwm_device *pwm = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", pwm->duty);
+}
+
+static ssize_t show_period_ns(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct pwm_device *pwm = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", pwm->period);
+}
+
+static ssize_t store_duty_ns(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct pwm_device *pwm = dev_get_drvdata(dev);
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	mutex_lock(&pwm_lock);
+
+	pwm->duty = (int)val;
+	if ((pwm->duty < pwm->period) || (pwm->duty == pwm->period)) {
+		pwm_disable(pwm);
+		pwm_config(pwm, pwm->duty, pwm->period);
+		pwm_enable(pwm);
+	}
+
+	mutex_unlock(&pwm_lock);
+
+	return count;
+}
+
+static ssize_t store_period_ns(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct pwm_device *pwm = dev_get_drvdata(dev);
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	mutex_lock(&pwm_lock);
+
+	pwm->period = (int)val;
+	if ((pwm->duty < pwm->period) || (pwm->duty == pwm->period)) {
+		pwm_disable(pwm);
+		pwm_config(pwm, pwm->duty, pwm->period);
+		pwm_enable(pwm);
+	}
+
+	mutex_unlock(&pwm_lock);
+
+	return count;
+}
+
+static DEVICE_ATTR(duty_ns, S_IRUGO | S_IWUSR,
+		   show_duty_ns, store_duty_ns);
+static DEVICE_ATTR(period_ns, S_IRUGO | S_IWUSR,
+		   show_period_ns, store_period_ns);
+
+static struct attribute *pwm_attrs[] = {
+	&dev_attr_duty_ns.attr,
+	&dev_attr_period_ns.attr,
+	NULL
+};
+
+static const struct attribute_group pwm_group = {
+	.attrs = pwm_attrs,
+};
+
+int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+{
+	unsigned long long c;
+	unsigned long period_cycles, duty_cycles, prescale;
+	u32 cr;
+
+	if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
+		return -EINVAL;
+
+	if (pwm->pwmo_invert)
+		duty_ns = period_ns - duty_ns;
+
+	c = clk_get_rate(pwm->clk);
+	c = c * period_ns;
+	do_div(c, 1000000000);
+	period_cycles = c;
+
+	prescale = period_cycles / 0x10000 + 1;
+	if (prescale > FSL_MAX_PRESCALER)
+		return -EINVAL;
+
+	period_cycles /= prescale;
+	c = (unsigned long long)period_cycles * duty_ns;
+	do_div(c, period_ns);
+	duty_cycles = c;
+
+	out_be32(&pwm->regs->pwmsar, duty_cycles);
+	out_be32(&pwm->regs->pwmpr, period_cycles);
+
+	cr = FSL_PWMCR_POUTC_HIGHT | FSL_PWMCR_CLKSRC | FSL_PWMCR_DOZEEN |
+		 FSL_PWMCR_WAITEN | FSL_PWMCR_DEBUGEN | FSL_PWMCR_STOPEN;
+	cr |= FSL_PWMCR_PRESCALER(prescale);
+	out_be32(&pwm->regs->pwmcr, cr);
+
+	return 0;
+}
+EXPORT_SYMBOL(pwm_config);
+
+int pwm_enable(struct pwm_device *pwm)
+{
+	unsigned int reg;
+	int rc = 0;
+
+	if (!pwm->clk_enabled) {
+		rc = clk_enable(pwm->clk);
+		if (!rc)
+			pwm->clk_enabled = 1;
+	}
+
+	reg = in_be32(&pwm->regs->pwmcr);
+	reg |= FSL_PWMCR_EN;
+	out_be32(&pwm->regs->pwmcr, reg);
+
+	if (pwm->enable_pwm_pad)
+		pwm->enable_pwm_pad();
+
+	return rc;
+}
+EXPORT_SYMBOL(pwm_enable);
+
+void pwm_disable(struct pwm_device *pwm)
+{
+	unsigned int reg;
+
+	if (pwm->disable_pwm_pad)
+		pwm->disable_pwm_pad();
+
+	reg = in_be32(&pwm->regs->pwmcr);
+	reg &= ~FSL_PWMCR_EN;
+	out_be32(&pwm->regs->pwmcr, reg);
+
+	if (pwm->clk_enabled) {
+		clk_disable(pwm->clk);
+		pwm->clk_enabled = 0;
+	}
+}
+EXPORT_SYMBOL(pwm_disable);
+
+struct pwm_device *pwm_request(int pwm_id, const char *label)
+{
+	struct pwm_device *pwm;
+	int found = 0;
+
+	mutex_lock(&pwm_lock);
+
+	list_for_each_entry(pwm, &pwm_list, node) {
+		if (pwm->pwm_id == pwm_id) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (found) {
+		if (pwm->use_count == 0) {
+			pwm->use_count++;
+			pwm->label = label;
+		} else
+			pwm = ERR_PTR(-EBUSY);
+	} else
+		pwm = ERR_PTR(-ENOENT);
+
+	mutex_unlock(&pwm_lock);
+	return pwm;
+}
+EXPORT_SYMBOL(pwm_request);
+
+void pwm_free(struct pwm_device *pwm)
+{
+	mutex_lock(&pwm_lock);
+
+	if (pwm->use_count) {
+		pwm->use_count--;
+		pwm->label = NULL;
+	} else
+		pr_warning("PWM device already freed\n");
+
+	mutex_unlock(&pwm_lock);
+}
+EXPORT_SYMBOL(pwm_free);
+
+static irqreturn_t fsl_pwm_irq(int irq, void *context_data)
+{
+	struct pwm_device *fsl_pwm = context_data;
+	u32 status;
+
+	/* Get interrupt events */
+	status = in_be32(&fsl_pwm->regs->pwmsr);
+
+	if (status) {
+		if (status & FSL_PWMSR_FWE)
+			dev_err(&fsl_pwm->dev, "FIFO write error occurred: "
+				"PWMSR 0x%08X\n", status);
+		if (status & FSL_PWMSR_CMP)
+			dev_err(&fsl_pwm->dev, "Compare event occurred: "
+				"PWMSR 0x%08X\n", status);
+		if (status & FSL_PWMSR_ROV)
+			dev_err(&fsl_pwm->dev, "Roll-over event occurred: "
+				"PWMSR 0x%08X\n", status);
+
+		if (status & ~FSL_PWMSR_ALL_MASK)
+			dev_err(&fsl_pwm->dev, "Unknown error: "
+				"PWMSR 0x%08X\n", status);
+
+		/* Clear the events */
+		out_be32(&fsl_pwm->regs->pwmsr, status &
+				 FSL_PWMSR_FWE_CMP_ROV_MASK);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int __devinit fsl_pwm_probe(struct platform_device *dev)
+{
+	struct device_node *np;
+	struct gubr __iomem *gubr;
+	struct pwm_device *fsl_pwm;
+	struct resource res_mem;
+	struct resource res_irq;
+	struct resource *res = &res_mem;
+	struct resource *irq = &res_irq;
+	const u32 *id;
+	int ret = 0;
+	unsigned long rate;
+
+	fsl_pwm = kzalloc(sizeof(struct pwm_device), GFP_KERNEL);
+	if (fsl_pwm == NULL) {
+		dev_err(&dev->dev, "failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	ret = of_address_to_resource(dev->dev.of_node, 0, res);
+	if (ret) {
+		dev_err(&dev->dev, "invalid address\n");
+		goto err_free;
+	}
+
+	if (!request_mem_region(res->start,
+				res->end - res->start + 1, "fsl-pwm")) {
+		dev_err(&dev->dev, "memory request failure\n");
+		ret = -ENXIO;
+		goto err_free;
+	}
+
+	/* IOMAP the entire PWM region */
+	fsl_pwm->regs = ioremap(res->start, res->end - res->start + 1);
+	if (fsl_pwm->regs == NULL) {
+		dev_err(&dev->dev, "failed to ioremap memory region\n");
+		ret = -ENOMEM;
+		goto err_release;
+	}
+
+	fsl_pwm->clk = clk_get(&dev->dev, "pwm-clk");
+	if (IS_ERR(fsl_pwm->clk)) {
+		dev_err(&dev->dev, "failed to get clock\n");
+		ret = PTR_ERR(fsl_pwm->clk);
+		goto err_unmap;
+	}
+
+	rate = fsl_get_sys_freq();
+	if (rate)
+		fsl_pwm->clk->rate_hz = rate;
+	else
+		fsl_pwm->clk->rate_hz = FSL_DEFAULT_IPG_CLK;
+
+	/* Find the id of the pwm */
+	id = of_get_property(dev->dev.of_node, "cell-index", NULL);
+	if (!id) {
+		dev_err(&dev->dev, "failed to get cell-index\n");
+		goto err_unmap;
+	}
+
+	fsl_pwm->pwm_id = *id;
+	fsl_pwm->clk_enabled = 0;
+	fsl_pwm->use_count = 0;
+	fsl_pwm->duty = 0;
+	fsl_pwm->period = 0;
+	fsl_pwm->dev = dev->dev;
+
+	np = of_find_node_by_name(NULL, "global-utilities");
+	if (np) {
+		gubr = of_iomap(np, 0);
+
+		if (fsl_pwm->pwm_id) {
+			clrsetbits_be32(&gubr->pmuxcr2,
+					FSL_PMUXCR2_UART_PWM_GPIO,
+					FSL_PMUXCR2_PWM_GPIO);
+			clrsetbits_be32(&gubr->devdisr2, FSL_DEVDISR2_PWM2,
+					FSL_DEVDISR2_PWM2_EN);
+		} else {
+			clrsetbits_be32(&gubr->pmuxcr1,
+					FSL_PMUXCR1_SPI1_ANT_TCXO_PWM_GPIO,
+					FSL_PMUXCR1_ANT_TCXO_PWM_GPIO);
+			clrsetbits_be32(&gubr->devdisr2, FSL_DEVDISR2_PWM1,
+					FSL_DEVDISR2_PWM1_EN);
+		}
+
+		of_node_put(np);
+	} else {
+		printk(KERN_EMERG "Error: Global Utilities Block Register "
+				  "node is not found!\n");
+		goto err_unmap;
+	}
+
+	ret = of_irq_to_resource(dev->dev.of_node, 0, irq);
+	if (ret == NO_IRQ) {
+		dev_warn(&dev->dev, "no IRQ found\n");
+		goto err_unmap;
+	}
+
+	fsl_pwm->irq = irq->start;
+	if (fsl_pwm->irq < 0) {
+		ret = -ENXIO;
+		goto err_unmap;
+	}
+
+	/* Register for PWM Interrupt */
+	ret = request_irq(fsl_pwm->irq, fsl_pwm_irq, 0, "fsl-pwm", fsl_pwm);
+	if (ret != 0)
+		goto err_unmap;
+	else
+		dev_info(&dev->dev,
+			 "Freescale PWM Controller driver at 0x%p (irq = %d)\n",
+			 fsl_pwm->regs, fsl_pwm->irq);
+
+	/* Register sysfs hooks */
+	ret = sysfs_create_group(&dev->dev.kobj, &pwm_group);
+	if (ret != 0)
+		goto err_unmap;
+
+	dev_set_drvdata(&dev->dev, fsl_pwm);
+
+	mutex_lock(&pwm_lock);
+	list_add_tail(&fsl_pwm->node, &pwm_list);
+	mutex_unlock(&pwm_lock);
+
+	return 0;
+
+err_unmap:
+	iounmap(fsl_pwm->regs);
+err_release:
+	release_mem_region(res->start, res->end - res->start + 1);
+err_free:
+	kfree(fsl_pwm);
+	return ret;
+}
+
+static int __devexit fsl_pwm_remove(struct platform_device *dev)
+{
+	struct pwm_device *fsl_pwm;
+
+	fsl_pwm = dev_get_drvdata(&dev->dev);
+	if (fsl_pwm == NULL)
+		return -ENODEV;
+
+	mutex_lock(&pwm_lock);
+	list_del(&fsl_pwm->node);
+	mutex_unlock(&pwm_lock);
+
+	if (fsl_pwm->regs)
+		iounmap(fsl_pwm->regs);
+
+	dev_set_drvdata(&dev->dev, NULL);
+	clk_put(fsl_pwm->clk);
+	sysfs_remove_group(&dev->dev.kobj, &pwm_group);
+	kfree(fsl_pwm);
+
+	return 0;
+}
+
+static const struct of_device_id fsl_pwm_match[] = {
+	{
+		.compatible = "fsl,psc9131-pwm",
+	},
+	{},
+};
+
+static struct platform_driver fsl_pwm_driver = {
+	.driver		= {
+		.name	= "fsl-pwm",
+		.of_match_table    = fsl_pwm_match,
+	},
+	.probe		= fsl_pwm_probe,
+	.remove		= fsl_pwm_remove,
+};
+
+static int __init fsl_pwm_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&fsl_pwm_driver);
+	if (ret)
+		printk(KERN_ERR "fsl-pwm: Failed to register platform "
+				"driver\n");
+
+	return ret;
+}
+
+static void __exit fsl_pwm_exit(void)
+{
+	platform_driver_unregister(&fsl_pwm_driver);
+}
+
+module_init(fsl_pwm_init);
+module_exit(fsl_pwm_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Chunhe Lan <Chunhe.Lan@freescale.com>");
+MODULE_DESCRIPTION("Freescale PWM Controller driver");
-- 
1.5.6.5
