Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 840D3DE73E
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 07:45:28 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id C0EA38816
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 01:45:26 +0400 (SAMT)
Date: Mon, 10 Dec 2007 23:48:45 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH RFC 3/7] [POWERPC] CPM2: implement GPIO API
Message-ID: <20071210204845.GC32278@localhost.localdomain>
References: <20071210204705.GA31263@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071210204705.GA31263@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/Kconfig    |    1 +
 arch/powerpc/sysdev/cpm2_common.c |  142 +++++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 3d9ff27..cc2d54e 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -277,6 +277,7 @@ config CPM2
 	default n
 	select CPM
 	select PPC_LIB_RHEAP
+	select GENERIC_GPIO
 	help
 	  The CPM2 (Communications Processor Module) is a coprocessor on
 	  embedded CPUs made by Freescale.  Selecting this option means that
diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index 859362f..33b99d4 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -31,12 +31,14 @@
 #include <linux/param.h>
 #include <linux/string.h>
 #include <linux/mm.h>
+#include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
+#include <asm/gpio.h>
 #include <asm/mpc8260.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -61,9 +63,62 @@ cpm2_map_t __iomem *cpm2_immr;
 					   of space for CPM as it is larger
 					   than on PQ2 */
 
+static spinlock_t *cpm2_port_locks;
+static int cpm2_num_ports;
+
+static int par_io_xlate(struct device_node *np, int index)
+{
+	return __of_parse_gpio_bank_pin(np, index, 32, cpm2_num_ports);
+}
+
+static struct of_gpio_chip of_gpio_chip = {
+	.xlate = par_io_xlate,
+};
+
+int cpm2_init_par_io(void)
+{
+	int ret;
+	struct device_node *np;
+	const u32 *num_ports;
+	int i;
+
+	np = of_find_node_by_name(NULL, "par_io");
+	if (!np) {
+		ret = -ENOENT;
+		goto err0;
+	}
+
+	num_ports = of_get_property(np, "num-ports", NULL);
+	if (!num_ports) {
+		ret = -ENOENT;
+		goto err1;
+	}
+
+	cpm2_num_ports = *num_ports;
+	cpm2_port_locks = kzalloc(sizeof(*cpm2_port_locks) * cpm2_num_ports,
+				  GFP_KERNEL);
+	if (!cpm2_port_locks) {
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	for (i = 0; i < cpm2_num_ports; i++)
+		spin_lock_init(&cpm2_port_locks[i]);
+
+	np->data = &of_gpio_chip;
+
+	return 0;
+err1:
+	of_node_put(np);
+err0:
+	return ret;
+}
+
 void
 cpm2_reset(void)
 {
+	int ret;
+
 #ifdef CONFIG_PPC_85xx
 	cpm2_immr = ioremap(CPM_MAP_ADDR, CPM_MAP_SIZE);
 #else
@@ -81,6 +136,10 @@ cpm2_reset(void)
 	/* Tell everyone where the comm processor resides.
 	 */
 	cpmp = &cpm2_immr->im_cpm;
+
+	ret = cpm2_init_par_io();
+	if (ret)
+		pr_warning("CPM2 PIO not initialized!\n");
 }
 
 /* Set a baud rate generator.  This needs lots of work.  There are
@@ -444,3 +503,86 @@ void cpm2_set_pin(int port, int pin, int flags)
 	else
 		clrbits32(&iop[port].odr, pin);
 }
+
+int gpio_request(unsigned int gpio, const char *label)
+{
+	if (!cpm2_port_locks)
+		return -ENODEV;
+
+	if (gpio / 32 > cpm2_num_ports)
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gpio_request);
+
+int gpio_direction_input(unsigned int gpio)
+{
+	unsigned long flags;
+	int port = gpio / 32;
+	int pin = gpio % 32;
+
+	spin_lock_irqsave(&cpm2_port_locks[port], flags);
+
+	cpm2_set_pin(port, pin, CPM_PIN_INPUT | CPM_PIN_GPIO);
+
+	spin_unlock_irqrestore(&cpm2_port_locks[port], flags);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gpio_direction_input);
+
+int gpio_direction_output(unsigned int gpio, int value)
+{
+	struct cpm2_ioports __iomem *iop =
+		(struct cpm2_ioports __iomem *)&cpm2_immr->im_ioport;
+	int port = gpio / 32;
+	int pin = gpio % 32;
+	unsigned long flags;
+
+	pin = 1 << (31 - pin);
+
+	spin_lock_irqsave(&cpm2_port_locks[port], flags);
+
+	cpm2_set_pin(port, pin, CPM_PIN_OUTPUT | CPM_PIN_GPIO);
+	if (value)
+		setbits32(&iop[port].dat, pin);
+	else
+		clrbits32(&iop[port].dat, pin);
+
+	spin_unlock_irqrestore(&cpm2_port_locks[port], flags);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gpio_direction_output);
+
+int gpio_get_value(unsigned int gpio)
+{
+	struct cpm2_ioports __iomem *iop =
+		(struct cpm2_ioports __iomem *)&cpm2_immr->im_ioport;
+	int port = gpio / 32;
+	int pin = gpio % 32;
+
+	pin = 1 << (31 - pin);
+
+	return !!(in_be32(&iop[port].dat) & pin);
+}
+EXPORT_SYMBOL_GPL(gpio_get_value);
+
+int gpio_set_value(unsigned int gpio, int value)
+{
+	struct cpm2_ioports __iomem *iop =
+		(struct cpm2_ioports __iomem *)&cpm2_immr->im_ioport;
+	int port = gpio / 32;
+	int pin = gpio % 32;
+	unsigned long flags;
+
+	pin = 1 << (31 - pin);
+
+	spin_lock_irqsave(&cpm2_port_locks[port], flags);
+	if (value)
+		setbits32(&iop[port].dat, pin);
+	else
+		clrbits32(&iop[port].dat, pin);
+	spin_unlock_irqrestore(&cpm2_port_locks[port], flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gpio_set_value);
-- 
1.5.2.2
