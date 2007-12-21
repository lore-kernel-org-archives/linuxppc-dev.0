Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 159DBDE036
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 07:29:26 +1100 (EST)
Date: Fri, 21 Dec 2007 23:31:23 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/4] [POWERPC] CPM2: implement GPIO API
Message-ID: <20071221203123.GC4633@localhost.localdomain>
References: <20071221202824.GA4607@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071221202824.GA4607@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
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
 arch/powerpc/sysdev/cpm2_common.c |  121 +++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+), 0 deletions(-)

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
index f7188e2..fe25978 100644
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
@@ -61,8 +63,43 @@ cpm2_map_t __iomem *cpm2_immr;
 					   of space for CPM as it is larger
 					   than on PQ2 */
 
+static spinlock_t cpm2_port_lock = __SPIN_LOCK_UNLOCKED(cpm2_port_lock);
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
+	struct device_node *np;
+	const u32 *num_ports;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,cpm2-pario");
+	if (!np)
+		return -ENOENT;
+
+	num_ports = of_get_property(np, "num-ports", NULL);
+	if (!num_ports) {
+		of_node_put(np);
+		return -ENOENT;
+	}
+	cpm2_num_ports = *num_ports;
+
+	np->data = &of_gpio_chip;
+
+	return 0;
+}
+
 void __init cpm2_reset(void)
 {
+	int ret;
+
 #ifdef CONFIG_PPC_85xx
 	cpm2_immr = ioremap(CPM_MAP_ADDR, CPM_MAP_SIZE);
 #else
@@ -80,6 +117,10 @@ void __init cpm2_reset(void)
 	/* Tell everyone where the comm processor resides.
 	 */
 	cpmp = &cpm2_immr->im_cpm;
+
+	ret = cpm2_init_par_io();
+	if (ret)
+		pr_warning("CPM2 PIO not initialized!\n");
 }
 
 static DEFINE_SPINLOCK(cmd_lock);
@@ -468,3 +509,83 @@ void cpm2_set_pin(int port, int pin, int flags)
 	else
 		clrbits32(&iop[port].odr, pin);
 }
+
+int gpio_request(unsigned int gpio, const char *label)
+{
+	if (gpio / 32 >= cpm2_num_ports)
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
+	spin_lock_irqsave(&cpm2_port_lock, flags);
+
+	cpm2_set_pin(port, pin, CPM_PIN_INPUT | CPM_PIN_GPIO);
+
+	spin_unlock_irqrestore(&cpm2_port_lock, flags);
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
+	spin_lock_irqsave(&cpm2_port_lock, flags);
+
+	cpm2_set_pin(port, pin, CPM_PIN_OUTPUT | CPM_PIN_GPIO);
+
+	pin = 1 << (31 - pin);
+	if (value)
+		setbits32(&iop[port].dat, pin);
+	else
+		clrbits32(&iop[port].dat, pin);
+
+	spin_unlock_irqrestore(&cpm2_port_lock, flags);
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
+	spin_lock_irqsave(&cpm2_port_lock, flags);
+	if (value)
+		setbits32(&iop[port].dat, pin);
+	else
+		clrbits32(&iop[port].dat, pin);
+	spin_unlock_irqrestore(&cpm2_port_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gpio_set_value);
-- 
1.5.2.2
