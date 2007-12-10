Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BDEDEDE361
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 07:45:22 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id D69318816
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 01:45:20 +0400 (SAMT)
Date: Mon, 10 Dec 2007 23:48:39 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH RFC 2/7] [POWERPC] QE: implement GPIO API
Message-ID: <20071210204839.GB32278@localhost.localdomain>
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
 arch/powerpc/platforms/Kconfig     |    1 +
 arch/powerpc/sysdev/qe_lib/qe_io.c |   93 +++++++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index ea22cad..3d9ff27 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -265,6 +265,7 @@ config TAU_AVERAGE
 config QUICC_ENGINE
 	bool
 	select PPC_LIB_RHEAP
+	select GENERIC_GPIO
 	help
 	  The QUICC Engine (QE) is a new generation of communications
 	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/sysdev/qe_lib/qe_io.c
index e53ea4d..3c9cf65 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_io.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
@@ -23,6 +23,7 @@
 
 #include <asm/io.h>
 #include <asm/prom.h>
+#include <asm/gpio.h>
 #include <sysdev/fsl_soc.h>
 
 #undef DEBUG
@@ -43,12 +44,23 @@ struct port_regs {
 
 static struct port_regs *par_io = NULL;
 static int num_par_io_ports = 0;
+static spinlock_t *qe_pio_locks;
+
+static int par_io_xlate(struct device_node *np, int index)
+{
+	return __of_parse_gpio_bank_pin(np, index, 32, num_par_io_ports);
+}
+
+static struct of_gpio_chip of_gpio_chip = {
+	.xlate = par_io_xlate,
+};
 
 int par_io_init(struct device_node *np)
 {
 	struct resource res;
 	int ret;
 	const u32 *num_ports;
+	int i;
 
 	/* Map Parallel I/O ports registers */
 	ret = of_address_to_resource(np, 0, &res);
@@ -60,6 +72,18 @@ int par_io_init(struct device_node *np)
 	if (num_ports)
 		num_par_io_ports = *num_ports;
 
+	qe_pio_locks = kzalloc(sizeof(*qe_pio_locks) * num_par_io_ports,
+			       GFP_KERNEL);
+	if (!qe_pio_locks) {
+		iounmap(par_io);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_par_io_ports; i++)
+		spin_lock_init(&qe_pio_locks[i]);
+
+	np->data = &of_gpio_chip;
+
 	return 0;
 }
 
@@ -67,9 +91,12 @@ int par_io_config_pin(u8 port, u8 pin, int dir, int open_drain,
 		      int assignment, int has_irq)
 {
 	u32 pin_mask1bit, pin_mask2bits, new_mask2bits, tmp_val;
+	unsigned long flags;
 
-	if (!par_io)
-		return -1;
+	if (!par_io || port > num_par_io_ports)
+		return -EINVAL;
+
+	spin_lock_irqsave(&qe_pio_locks[port], flags);
 
 	/* calculate pin location for single and 2 bits information */
 	pin_mask1bit = (u32) (1 << (NUM_OF_PINS - (pin + 1)));
@@ -126,6 +153,8 @@ int par_io_config_pin(u8 port, u8 pin, int dir, int open_drain,
 		out_be32(&par_io[port].cppar1, new_mask2bits | tmp_val);
 	}
 
+	spin_unlock_irqrestore(&qe_pio_locks[port], flags);
+
 	return 0;
 }
 EXPORT_SYMBOL(par_io_config_pin);
@@ -133,6 +162,7 @@ EXPORT_SYMBOL(par_io_config_pin);
 int par_io_data_set(u8 port, u8 pin, u8 val)
 {
 	u32 pin_mask, tmp_val;
+	unsigned long flags;
 
 	if (port >= num_par_io_ports)
 		return -EINVAL;
@@ -141,6 +171,8 @@ int par_io_data_set(u8 port, u8 pin, u8 val)
 	/* calculate pin location */
 	pin_mask = (u32) (1 << (NUM_OF_PINS - 1 - pin));
 
+	spin_lock_irqsave(&qe_pio_locks[port], flags);
+
 	tmp_val = in_be32(&par_io[port].cpdata);
 
 	if (val == 0)		/* clear */
@@ -148,10 +180,25 @@ int par_io_data_set(u8 port, u8 pin, u8 val)
 	else			/* set */
 		out_be32(&par_io[port].cpdata, pin_mask | tmp_val);
 
+	spin_unlock_irqrestore(&qe_pio_locks[port], flags);
 	return 0;
 }
 EXPORT_SYMBOL(par_io_data_set);
 
+static inline int par_io_data_get(u8 port, u8 pin)
+{
+	u32 pin_mask;
+
+	if (port >= num_par_io_ports)
+		return -EINVAL;
+	if (pin >= NUM_OF_PINS)
+		return -EINVAL;
+	/* calculate pin location */
+	pin_mask = (u32) (1 << (NUM_OF_PINS - 1 - pin));
+
+	return !!(in_be32(&par_io[port].cpdata) & pin_mask);
+}
+
 int par_io_of_config(struct device_node *np)
 {
 	struct device_node *pio;
@@ -195,6 +242,48 @@ int par_io_of_config(struct device_node *np)
 }
 EXPORT_SYMBOL(par_io_of_config);
 
+int gpio_request(unsigned int gpio, const char *label)
+{
+	if (!qe_pio_locks)
+		return -ENODEV;
+
+	if (gpio / 32 > num_par_io_ports)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gpio_request);
+
+int gpio_direction_input(unsigned int gpio)
+{
+	return par_io_config_pin(gpio / 32, gpio % 32, 2, 0, 0, 0);
+}
+EXPORT_SYMBOL_GPL(gpio_direction_input);
+
+int gpio_direction_output(unsigned int gpio, int value)
+{
+	int ret;
+
+	ret = par_io_config_pin(gpio / 32, gpio % 32, 1, 0, 0, 0);
+	if (ret)
+		return ret;
+
+	return par_io_data_set(gpio / 32, gpio % 32, value);
+}
+EXPORT_SYMBOL_GPL(gpio_direction_output);
+
+int gpio_get_value(unsigned int gpio)
+{
+	return par_io_data_get(gpio / 32, gpio % 32);
+}
+EXPORT_SYMBOL_GPL(gpio_get_value);
+
+int gpio_set_value(unsigned int gpio, int value)
+{
+	return par_io_data_set(gpio / 32, gpio % 32, value);
+}
+EXPORT_SYMBOL_GPL(gpio_set_value);
+
 #ifdef DEBUG
 static void dump_par_io(void)
 {
-- 
1.5.2.2
