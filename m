Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E7A3CDE860
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 05:42:21 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id DE6848810
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 23:42:33 +0400 (SAMT)
Date: Tue, 11 Mar 2008 21:42:20 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] [POWERPC] Implement support for the GPIO LIB API
Message-ID: <20080311184220.GB32164@localhost.localdomain>
References: <20080311184012.GA28466@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080311184012.GA28466@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch implements support for the GPIO LIB API. Two calls
unimplemented though: irq_to_gpio and gpio_to_irq.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |   52 ++++++++++++++++++++++++
 arch/powerpc/Kconfig                         |    5 ++
 include/asm-powerpc/gpio.h                   |   55 ++++++++++++++++++++++++++
 3 files changed, 112 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-powerpc/gpio.h

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index b506245..e9e0c2f 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -66,6 +66,10 @@ Table of Contents
     3) OpenPIC Interrupt Controllers
     4) ISA Interrupt Controllers
 
+  VIII - Specifying GPIO information for devices
+    1) gpios property
+    2) gpio-controller nodes
+
   Appendix A - Sample SOC node for MPC8540
 
 
@@ -2925,6 +2929,54 @@ encodings listed below:
 	2 =  high to low edge sensitive type enabled
 	3 =  low to high edge sensitive type enabled
 
+VIII - Specifying GPIO information for devices
+==============================================
+
+1) gpios property
+-----------------
+
+Nodes that makes use of GPIOs should define them using `gpios' property,
+format of which is: <&gpio-controller1-phandle gpio1-specifier
+		     &gpio-controller2-phandle gpio2-specifier
+		     0 /* holes are permitted, means no GPIO 3 */
+		     &gpio-controller4-phandle gpio4-specifier
+		     ...>;
+
+Note that gpio-specifier length is controller dependent.
+
+gpio-specifier may encode: bank, pin position inside the bank,
+whether pin is open-drain and whether pin is logically inverted.
+
+Example of the node using GPIOs:
+
+	node {
+		gpios = <&qe_pio_e 18 0>;
+	};
+
+In this example gpio-specifier is "18 0" and encodes GPIO pin number,
+and empty GPIO flags as accepted by the "qe_pio_e" gpio-controller.
+
+2) gpio-controller nodes
+------------------------
+
+Every GPIO controller node must have #gpio-cells property defined,
+this information will be used to translate gpio-specifiers.
+
+Example of two SOC GPIO banks defined as gpio-controller nodes:
+
+	qe_pio_a: gpio-controller@1400 {
+		#gpio-cells = <2>;
+		compatible = "fsl,qe-pario-bank-a", "fsl,qe-pario-bank";
+		reg = <0x1400 0x18>;
+		gpio-controller;
+	};
+
+	qe_pio_e: gpio-controller@1460 {
+		#gpio-cells = <2>;
+		compatible = "fsl,qe-pario-bank-e", "fsl,qe-pario-bank";
+		reg = <0x1460 0x18>;
+		gpio-controller;
+	};
 
 Appendix A - Sample SOC node for MPC8540
 ========================================
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0b27cbd..f328509 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -81,6 +81,11 @@ config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
 
+config GENERIC_GPIO
+	bool
+	help
+	  Generic GPIO API support
+
 config ARCH_NO_VIRT_TO_BUS
 	def_bool PPC64
 
diff --git a/include/asm-powerpc/gpio.h b/include/asm-powerpc/gpio.h
new file mode 100644
index 0000000..057840d
--- /dev/null
+++ b/include/asm-powerpc/gpio.h
@@ -0,0 +1,55 @@
+/*
+ * Generic GPIO API implementation for PowerPC.
+ *
+ * Copyright (c) 2007-2008  MontaVista Software, Inc.
+ *
+ * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __ASM_POWERPC_GPIO_H
+#define __ASM_POWERPC_GPIO_H
+
+#include <asm-generic/gpio.h>
+
+#ifdef CONFIG_HAVE_GPIO_LIB
+
+/*
+ * We don't (yet) implement inlined/rapid versions for on-chip gpios.
+ * Just call gpiolib.
+ */
+static inline int gpio_get_value(unsigned int gpio)
+{
+	return __gpio_get_value(gpio);
+}
+
+static inline void gpio_set_value(unsigned int gpio, int value)
+{
+	__gpio_set_value(gpio, value);
+}
+
+static inline int gpio_cansleep(unsigned int gpio)
+{
+	return __gpio_cansleep(gpio);
+}
+
+/*
+ * Not implemented, yet.
+ */
+static inline int gpio_to_irq(unsigned int gpio)
+{
+	return -ENOSYS;
+}
+
+static inline int irq_to_gpio(unsigned int irq)
+{
+	return -EINVAL;
+}
+
+#endif /* CONFIG_HAVE_GPIO_LIB */
+
+#endif /* __ASM_POWERPC_GPIO_H */
-- 
1.5.2.2
