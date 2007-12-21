Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9F2BFDDE43
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 07:32:34 +1100 (EST)
Date: Fri, 21 Dec 2007 23:34:31 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 4/4] [POWERPC] CPM1: implement GPIO API
Message-ID: <20071221203431.GD4633@localhost.localdomain>
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

From: Jochen Friedrich <jochen@scram.de>

Signed-off-by: Jochen Friedrich <jochen@scram.de>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Jochen, I kept your Signed-off-by, though this isn't your original
patch. Hope you're okay with it. I also hope you'll test it. ;-)

 arch/powerpc/platforms/8xx/Kconfig |    1 +
 arch/powerpc/sysdev/commproc.c     |  178 +++++++++++++++++++++++++++++++++++-
 2 files changed, 178 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index 91fbe42..6962914 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -4,6 +4,7 @@ config FADS
 config CPM1
 	bool
 	select CPM
+	select GENERIC_GPIO
 
 choice
 	prompt "8xx Machine Type"
diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index 621bc6c..8aea29c 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -27,6 +27,7 @@
 #include <linux/param.h>
 #include <linux/string.h>
 #include <linux/mm.h>
+#include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -36,6 +37,7 @@
 #include <asm/8xx_immap.h>
 #include <asm/commproc.h>
 #include <asm/io.h>
+#include <asm/gpio.h>
 #include <asm/tlbflush.h>
 #include <asm/rheap.h>
 #include <asm/prom.h>
@@ -56,6 +58,39 @@ static cpic8xx_t __iomem *cpic_reg;
 
 static struct irq_host *cpm_pic_host;
 
+static spinlock_t cpm1_port_lock = __SPIN_LOCK_UNLOCKED(cpm1_port_lock);
+static int cpm1_num_ports;
+
+static int par_io_xlate(struct device_node *np, int index)
+{
+	return __of_parse_gpio_bank_pin(np, index, 32, cpm1_num_ports);
+}
+
+static struct of_gpio_chip of_gpio_chip = {
+	.xlate = par_io_xlate,
+};
+
+int cpm_init_par_io(void)
+{
+	struct device_node *np;
+	const u32 *num_ports;
+
+	np = of_find_node_by_name(NULL, "fsl,cpm1-pario");
+	if (!np)
+		return -ENOENT;
+
+	num_ports = of_get_property(np, "num-ports", NULL);
+	if (!num_ports) {
+		of_node_put(np);
+		return -ENOENT;
+	}
+	cpm1_num_ports = *num_ports;
+
+	np->data = &of_gpio_chip;
+
+	return 0;
+}
+
 static void cpm_mask_irq(unsigned int irq)
 {
 	unsigned int cpm_vec = (unsigned int)irq_map[irq].hwirq;
@@ -199,6 +234,7 @@ end:
 void __init cpm_reset(void)
 {
 	sysconf8xx_t __iomem *siu_conf;
+	int ret;
 
 	mpc8xx_immr = ioremap(get_immrbase(), 0x4000);
 	if (!mpc8xx_immr) {
@@ -238,6 +274,10 @@ void __init cpm_reset(void)
 	/* Reclaim the DP memory for our use. */
 	m8xx_cpm_dpinit();
 #endif
+
+	ret = cpm_init_par_io();
+	if (ret)
+		pr_warning("CPM PIO not initialized!\n");
 }
 
 static DEFINE_SPINLOCK(cmd_lock);
@@ -441,7 +481,7 @@ struct cpm_ioport16 {
 };
 
 struct cpm_ioport32 {
-	__be32 dir, par, sor;
+	__be32 dir, par, sor, dat;
 };
 
 static void cpm1_set_pin32(int port, int pin, int flags)
@@ -486,6 +526,39 @@ static void cpm1_set_pin32(int port, int pin, int flags)
 	}
 }
 
+static void cpm1_set_value32(int port, int pin, int value)
+{
+	struct cpm_ioport32 __iomem *iop;
+	pin = 1 << (31 - pin);
+
+	if (port == CPM_PORTB)
+		iop = (struct cpm_ioport32 __iomem *)
+		      &mpc8xx_immr->im_cpm.cp_pbdir;
+	else
+		iop = (struct cpm_ioport32 __iomem *)
+		      &mpc8xx_immr->im_cpm.cp_pedir;
+
+	if (value)
+		setbits32(&iop->dat, pin);
+	else
+		clrbits32(&iop->dat, pin);
+}
+
+static int cpm1_get_value32(int port, int pin)
+{
+	struct cpm_ioport32 __iomem *iop;
+	pin = 1 << (31 - pin);
+
+	if (port == CPM_PORTB)
+		iop = (struct cpm_ioport32 __iomem *)
+		      &mpc8xx_immr->im_cpm.cp_pbdir;
+	else
+		iop = (struct cpm_ioport32 __iomem *)
+		      &mpc8xx_immr->im_cpm.cp_pedir;
+
+	return !!(in_be32(&iop->dat) & pin);
+}
+
 static void cpm1_set_pin16(int port, int pin, int flags)
 {
 	struct cpm_ioport16 __iomem *iop =
@@ -520,6 +593,35 @@ static void cpm1_set_pin16(int port, int pin, int flags)
 	}
 }
 
+static void cpm1_set_value16(int port, int pin, int value)
+{
+	struct cpm_ioport16 __iomem *iop =
+		(struct cpm_ioport16 __iomem *)&mpc8xx_immr->im_ioport;
+
+	pin = 1 << (15 - pin);
+
+	if (port != 0)
+		iop += port - 1;
+
+	if (value)
+		setbits16(&iop->dat, pin);
+	else
+		clrbits16(&iop->dat, pin);
+}
+
+static int cpm1_get_value16(int port, int pin)
+{
+	struct cpm_ioport16 __iomem *iop =
+		(struct cpm_ioport16 __iomem *)&mpc8xx_immr->im_ioport;
+
+	pin = 1 << (15 - pin);
+
+	if (port != 0)
+		iop += port - 1;
+
+	return !!(in_be16(&iop->dat) & pin);
+}
+
 void cpm1_set_pin(enum cpm_port port, int pin, int flags)
 {
 	if (port == CPM_PORTB || port == CPM_PORTE)
@@ -648,3 +750,77 @@ int cpm1_clk_setup(enum cpm_clk_target target, int clock, int mode)
 
 	return 0;
 }
+
+int gpio_request(unsigned int gpio, const char *label)
+{
+	if (gpio / 32 >= cpm1_num_ports)
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
+	spin_lock_irqsave(&cpm1_port_lock, flags);
+
+	cpm1_set_pin(port, pin, CPM_PIN_INPUT | CPM_PIN_GPIO);
+
+	spin_unlock_irqrestore(&cpm1_port_lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gpio_direction_input);
+
+int gpio_direction_output(unsigned int gpio, int value)
+{
+	int port = gpio / 32;
+	int pin = gpio % 32;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpm1_port_lock, flags);
+
+	cpm1_set_pin(port, pin, CPM_PIN_OUTPUT | CPM_PIN_GPIO);
+
+	if (port == CPM_PORTB || port == CPM_PORTE)
+		cpm1_set_value32(port, pin, value);
+	else
+		cpm1_set_value16(port, pin, value);
+
+	spin_unlock_irqrestore(&cpm1_port_lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gpio_direction_output);
+
+int gpio_get_value(unsigned int gpio)
+{
+	int port = gpio / 32;
+	int pin = gpio % 32;
+
+	if (port == CPM_PORTB || port == CPM_PORTE)
+		return cpm1_get_value32(port, pin);
+	else
+		return cpm1_get_value16(port, pin);
+}
+EXPORT_SYMBOL_GPL(gpio_get_value);
+
+int gpio_set_value(unsigned int gpio, int value)
+{
+	int port = gpio / 32;
+	int pin = gpio % 32;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpm1_port_lock, flags);
+
+	if (port == CPM_PORTB || port == CPM_PORTE)
+		cpm1_set_value32(port, pin, value);
+	else
+		cpm1_set_value16(port, pin, value);
+
+	spin_unlock_irqrestore(&cpm1_port_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gpio_set_value);
-- 
1.5.2.2
