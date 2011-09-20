Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6CE6A100FBB
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Sep 2011 13:46:16 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/20] powerpc/powernv: Support for OPAL console
Date: Tue, 20 Sep 2011 13:44:59 +1000
Message-Id: <1316490307-28030-12-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
References: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a udbg and an hvc console backend for supporting a console
using the OPAL console interfaces.

On OPAL v1 we have hvc0 mapped to whatever console the system was
configured for (network or hvsi serial port) via the service
processor.

On OPAL v2 we have hvcN mapped to the Nth console provided by OPAL
which generally corresponds to:

	hvc0 : network console (raw protocol)
	hvc1 : serial port S1 (hvsi)
	hvc2 : serial port S2 (hvsi)

Note: At this point, early debug console only works with OPAL v1
and shouldn't be enabled in a normal kernel.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/Kconfig.debug             |   31 +++
 arch/powerpc/include/asm/opal.h        |    5 +
 arch/powerpc/include/asm/udbg.h        |    2 +
 arch/powerpc/kernel/head_64.S          |   14 +-
 arch/powerpc/kernel/udbg.c             |    4 +
 arch/powerpc/platforms/powernv/opal.c  |   31 ++-
 arch/powerpc/platforms/powernv/setup.c |   14 +-
 drivers/tty/hvc/Kconfig                |    9 +
 drivers/tty/hvc/Makefile               |    1 +
 drivers/tty/hvc/hvc_opal.c             |  424 ++++++++++++++++++++++++++++++++
 drivers/tty/hvc/hvsi_lib.c             |    4 +-
 11 files changed, 517 insertions(+), 22 deletions(-)
 create mode 100644 drivers/tty/hvc/hvc_opal.c

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index cc01f1d..e61830f 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -257,8 +257,27 @@ config PPC_EARLY_DEBUG_WSP
 	depends on PPC_WSP
 	select PPC_UDBG_16550
 
+config PPC_EARLY_DEBUG_OPAL_RAW
+	bool "OPAL raw console"
+	depends on HVC_OPAL
+	help
+	  Select this to enable early debugging for the PowerNV platform
+	  using a "raw" console
+
+config PPC_EARLY_DEBUG_OPAL_HVSI
+	bool "OPAL hvsi console"
+	depends on HVC_OPAL
+	help
+	  Select this to enable early debugging for the PowerNV platform
+	  using an "hvsi" console
+
 endchoice
 
+config PPC_EARLY_DEBUG_OPAL
+	def_bool y
+	depends on PPC_EARLY_DEBUG_OPAL_RAW || PPC_EARLY_DEBUG_OPAL_HVSI
+
+
 config PPC_EARLY_DEBUG_HVSI_VTERMNO
 	hex "vterm number to use with early debug HVSI"
 	depends on PPC_EARLY_DEBUG_LPAR_HVSI
@@ -267,6 +286,18 @@ config PPC_EARLY_DEBUG_HVSI_VTERMNO
 	  You probably want 0x30000000 for your first serial port and
 	  0x30000001 for your second one
 
+config PPC_EARLY_DEBUG_OPAL_VTERMNO
+	hex "vterm number to use with OPAL early debug"
+	depends on PPC_EARLY_DEBUG_OPAL
+	default "0"
+	help
+	  This correspond to which /dev/hvcN you want to use for early
+	  debug.
+
+	  On OPAL v1 (takeover) this should always be 0
+	  On OPAL v2, this will be 0 for network console and 1 or 2 for
+	  the machine built-in serial ports.
+
 config PPC_EARLY_DEBUG_44x_PHYSLOW
 	hex "Low 32 bits of early debug UART physical address"
 	depends on PPC_EARLY_DEBUG_44x
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 53cda41..dbeabea 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -425,6 +425,11 @@ extern void hvc_opal_init_early(void);
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
 
+extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
+extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
+
+extern void hvc_opal_init_early(void);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_H */
diff --git a/arch/powerpc/include/asm/udbg.h b/arch/powerpc/include/asm/udbg.h
index 93e05d1..2ac1753 100644
--- a/arch/powerpc/include/asm/udbg.h
+++ b/arch/powerpc/include/asm/udbg.h
@@ -54,6 +54,8 @@ extern void __init udbg_init_40x_realmode(void);
 extern void __init udbg_init_cpm(void);
 extern void __init udbg_init_usbgecko(void);
 extern void __init udbg_init_wsp(void);
+extern void __init udbg_init_debug_opal_raw(void);
+extern void __init udbg_init_debug_opal_hvsi(void);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_UDBG_H */
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index dea8191..06c7251 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -53,7 +53,8 @@
  *   2. The kernel is entered at __start
  * -or- For OPAL entry:
  *   1. The MMU is off, processor in HV mode, primary CPU enters at 0
- *      with device-tree in gpr3
+ *      with device-tree in gpr3. We also get OPAL base in r8 and
+ *	entry in r9 for debugging purposes
  *   2. Secondary processors enter at 0x60 with PIR in gpr3
  *
  *  For iSeries:
@@ -335,6 +336,11 @@ _GLOBAL(__start_initialization_multiplatform)
 	/* Save parameters */
 	mr	r31,r3
 	mr	r30,r4
+#ifdef CONFIG_PPC_EARLY_DEBUG_OPAL
+	/* Save OPAL entry */
+	mr	r28,r8
+	mr	r29,r9
+#endif
 
 #ifdef CONFIG_PPC_BOOK3E
 	bl	.start_initialization_book3e
@@ -711,6 +717,12 @@ _INIT_STATIC(start_here_multiplatform)
 	bdnz	3b
 4:
 
+#ifdef CONFIG_PPC_EARLY_DEBUG_OPAL
+	/* Setup OPAL entry */
+	std	r28,0(r11);
+	std	r29,8(r11);
+#endif
+
 #ifndef CONFIG_PPC_BOOK3E
 	mfmsr	r6
 	ori	r6,r6,MSR_RI
diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index faa82c1..ea82faf 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -67,6 +67,10 @@ void __init udbg_early_init(void)
 	udbg_init_usbgecko();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_WSP)
 	udbg_init_wsp();
+#elif defined(CONFIG_PPC_EARLY_DEBUG_OPAL_RAW)
+	udbg_init_debug_opal_raw();
+#elif defined(CONFIG_PPC_EARLY_DEBUG_OPAL_HVSI)
+	udbg_init_debug_opal_hvsi();
 #endif
 
 #ifdef CONFIG_PPC_EARLY_DEBUG
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 8d55107..7887733 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -67,7 +67,7 @@ int opal_get_chars(uint32_t vtermno, char *buf, int count)
 	u64 evt;
 
 	if (!opal.entry)
-		return 0;
+		return -ENODEV;
 	opal_poll_events(&evt);
 	if ((evt & OPAL_EVENT_CONSOLE_INPUT) == 0)
 		return 0;
@@ -81,31 +81,38 @@ int opal_get_chars(uint32_t vtermno, char *buf, int count)
 int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 {
 	int written = 0;
-	s64 len, rc = OPAL_BUSY;
+	s64 len, rc;
 	unsigned long flags;
 	u64 evt;
 
 	if (!opal.entry)
-		return 0;
+		return -ENODEV;
 
 	/* We want put_chars to be atomic to avoid mangling of hvsi
 	 * packets. To do that, we first test for room and return
-	 * -EAGAIN if there isn't enough
+	 * -EAGAIN if there isn't enough.
+	 *
+	 * Unfortunately, opal_console_write_buffer_space() doesn't
+	 * appear to work on opal v1, so we just assume there is
+	 * enough room and be done with it
 	 */
 	spin_lock_irqsave(&opal_write_lock, flags);
-	rc = opal_console_write_buffer_space(vtermno, &len);
-	if (rc || len < total_len) {
-		spin_unlock_irqrestore(&opal_write_lock, flags);
-		/* Closed -> drop characters */
-		if (rc)
-			return total_len;
-		opal_poll_events(&evt);
-		return -EAGAIN;
+	if (firmware_has_feature(FW_FEATURE_OPALv2)) {
+		rc = opal_console_write_buffer_space(vtermno, &len);
+		if (rc || len < total_len) {
+			spin_unlock_irqrestore(&opal_write_lock, flags);
+			/* Closed -> drop characters */
+			if (rc)
+				return total_len;
+			opal_poll_events(&evt);
+			return -EAGAIN;
+		}
 	}
 
 	/* We still try to handle partial completions, though they
 	 * should no longer happen.
 	 */
+	rc = OPAL_BUSY;
 	while(total_len > 0 && (rc == OPAL_BUSY ||
 				rc == OPAL_BUSY_EVENT || rc == OPAL_SUCCESS)) {
 		len = total_len;
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index b6e5ff8..07ba1ec 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -29,17 +29,12 @@
 #include <asm/machdep.h>
 #include <asm/firmware.h>
 #include <asm/xics.h>
+#include <asm/opal.h>
 
 #include "powernv.h"
 
 static void __init pnv_setup_arch(void)
 {
-	/* Force console to hvc for now until we have sorted out the
-	 * real console situation for the platform. This will make
-	 * hvc_udbg work at least.
-	 */
-	add_preferred_console("hvc", 0, NULL);
-
 	/* Initialize SMP */
 	pnv_smp_init();
 
@@ -55,7 +50,12 @@ static void __init pnv_setup_arch(void)
 
 static void __init pnv_init_early(void)
 {
-	/* XXX IOMMU */
+#ifdef CONFIG_HVC_OPAL
+	if (firmware_has_feature(FW_FEATURE_OPAL))
+		hvc_opal_init_early();
+	else
+#endif
+		add_preferred_console("hvc", 0, NULL);
 }
 
 static void __init pnv_init_IRQ(void)
diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index e371753..4222035 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -34,6 +34,15 @@ config HVC_ISERIES
 	help
 	  iSeries machines support a hypervisor virtual console.
 
+config HVC_OPAL
+	bool "OPAL Console support"
+	depends on PPC_POWERNV
+	select HVC_DRIVER
+	select HVC_IRQ
+	default y
+	help
+	  PowerNV machines running under OPAL need that driver to get a console
+
 config HVC_RTAS
 	bool "IBM RTAS Console support"
 	depends on PPC_RTAS
diff --git a/drivers/tty/hvc/Makefile b/drivers/tty/hvc/Makefile
index e292053..89abf40b 100644
--- a/drivers/tty/hvc/Makefile
+++ b/drivers/tty/hvc/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_HVC_CONSOLE)	+= hvc_vio.o hvsi_lib.o
+obj-$(CONFIG_HVC_OPAL)		+= hvc_opal.o hvsi_lib.o
 obj-$(CONFIG_HVC_OLD_HVSI)	+= hvsi.o
 obj-$(CONFIG_HVC_ISERIES)	+= hvc_iseries.o
 obj-$(CONFIG_HVC_RTAS)		+= hvc_rtas.o
diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
new file mode 100644
index 0000000..7b38512
--- /dev/null
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -0,0 +1,424 @@
+/*
+ * opal driver interface to hvc_console.c
+ *
+ * Copyright 2011 Benjamin Herrenschmidt <benh@kernel.crashing.org>, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#undef DEBUG
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/console.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+
+#include <asm/hvconsole.h>
+#include <asm/prom.h>
+#include <asm/firmware.h>
+#include <asm/hvsi.h>
+#include <asm/udbg.h>
+#include <asm/opal.h>
+
+#include "hvc_console.h"
+
+static const char hvc_opal_name[] = "hvc_opal";
+
+static struct of_device_id hvc_opal_match[] __devinitdata = {
+	{ .name = "serial", .compatible = "ibm,opal-console-raw" },
+	{ .name = "serial", .compatible = "ibm,opal-console-hvsi" },
+	{ },
+};
+
+typedef enum hv_protocol {
+	HV_PROTOCOL_RAW,
+	HV_PROTOCOL_HVSI
+} hv_protocol_t;
+
+struct hvc_opal_priv {
+	hv_protocol_t		proto;	/* Raw data or HVSI packets */
+	struct hvsi_priv	hvsi;	/* HVSI specific data */
+};
+static struct hvc_opal_priv *hvc_opal_privs[MAX_NR_HVC_CONSOLES];
+
+/* For early boot console */
+static struct hvc_opal_priv hvc_opal_boot_priv;
+static u32 hvc_opal_boot_termno;
+
+static const struct hv_ops hvc_opal_raw_ops = {
+	.get_chars = opal_get_chars,
+	.put_chars = opal_put_chars,
+	.notifier_add = notifier_add_irq,
+	.notifier_del = notifier_del_irq,
+	.notifier_hangup = notifier_hangup_irq,
+};
+
+static int hvc_opal_hvsi_get_chars(uint32_t vtermno, char *buf, int count)
+{
+	struct hvc_opal_priv *pv = hvc_opal_privs[vtermno];
+
+	if (WARN_ON(!pv))
+		return -ENODEV;
+
+	return hvsilib_get_chars(&pv->hvsi, buf, count);
+}
+
+static int hvc_opal_hvsi_put_chars(uint32_t vtermno, const char *buf, int count)
+{
+	struct hvc_opal_priv *pv = hvc_opal_privs[vtermno];
+
+	if (WARN_ON(!pv))
+		return -ENODEV;
+
+	return hvsilib_put_chars(&pv->hvsi, buf, count);
+}
+
+static int hvc_opal_hvsi_open(struct hvc_struct *hp, int data)
+{
+	struct hvc_opal_priv *pv = hvc_opal_privs[hp->vtermno];
+	int rc;
+
+	pr_devel("HVSI@%x: do open !\n", hp->vtermno);
+
+	rc = notifier_add_irq(hp, data);
+	if (rc)
+		return rc;
+
+	return hvsilib_open(&pv->hvsi, hp);
+}
+
+static void hvc_opal_hvsi_close(struct hvc_struct *hp, int data)
+{
+	struct hvc_opal_priv *pv = hvc_opal_privs[hp->vtermno];
+
+	pr_devel("HVSI@%x: do close !\n", hp->vtermno);
+
+	hvsilib_close(&pv->hvsi, hp);
+
+	notifier_del_irq(hp, data);
+}
+
+void hvc_opal_hvsi_hangup(struct hvc_struct *hp, int data)
+{
+	struct hvc_opal_priv *pv = hvc_opal_privs[hp->vtermno];
+
+	pr_devel("HVSI@%x: do hangup !\n", hp->vtermno);
+
+	hvsilib_close(&pv->hvsi, hp);
+
+	notifier_hangup_irq(hp, data);
+}
+
+static int hvc_opal_hvsi_tiocmget(struct hvc_struct *hp)
+{
+	struct hvc_opal_priv *pv = hvc_opal_privs[hp->vtermno];
+
+	if (!pv)
+		return -EINVAL;
+	return pv->hvsi.mctrl;
+}
+
+static int hvc_opal_hvsi_tiocmset(struct hvc_struct *hp, unsigned int set,
+				unsigned int clear)
+{
+	struct hvc_opal_priv *pv = hvc_opal_privs[hp->vtermno];
+
+	pr_devel("HVSI@%x: Set modem control, set=%x,clr=%x\n",
+		 hp->vtermno, set, clear);
+
+	if (set & TIOCM_DTR)
+		hvsilib_write_mctrl(&pv->hvsi, 1);
+	else if (clear & TIOCM_DTR)
+		hvsilib_write_mctrl(&pv->hvsi, 0);
+
+	return 0;
+}
+
+static const struct hv_ops hvc_opal_hvsi_ops = {
+	.get_chars = hvc_opal_hvsi_get_chars,
+	.put_chars = hvc_opal_hvsi_put_chars,
+	.notifier_add = hvc_opal_hvsi_open,
+	.notifier_del = hvc_opal_hvsi_close,
+	.notifier_hangup = hvc_opal_hvsi_hangup,
+	.tiocmget = hvc_opal_hvsi_tiocmget,
+	.tiocmset = hvc_opal_hvsi_tiocmset,
+};
+
+static int __devinit hvc_opal_probe(struct platform_device *dev)
+{
+	const struct hv_ops *ops;
+	struct hvc_struct *hp;
+	struct hvc_opal_priv *pv;
+	hv_protocol_t proto;
+	unsigned int termno, boot = 0;
+	const __be32 *reg;
+
+	if (of_device_is_compatible(dev->dev.of_node, "ibm,opal-console-raw")) {
+		proto = HV_PROTOCOL_RAW;
+		ops = &hvc_opal_raw_ops;
+	} else if (of_device_is_compatible(dev->dev.of_node,
+					   "ibm,opal-console-hvsi")) {
+		proto = HV_PROTOCOL_HVSI;
+		ops = &hvc_opal_hvsi_ops;
+	} else {
+		pr_err("hvc_opal: Unkown protocol for %s\n",
+		       dev->dev.of_node->full_name);
+		return -ENXIO;
+	}
+
+	reg = of_get_property(dev->dev.of_node, "reg", NULL);
+	termno = reg ? be32_to_cpup(reg) : 0;
+
+	/* Is it our boot one ? */
+	if (hvc_opal_privs[termno] == &hvc_opal_boot_priv) {
+		pv = hvc_opal_privs[termno];
+		boot = 1;
+	} else if (hvc_opal_privs[termno] == NULL) {
+		pv = kzalloc(sizeof(struct hvc_opal_priv), GFP_KERNEL);
+		if (!pv)
+			return -ENOMEM;
+		pv->proto = proto;
+		hvc_opal_privs[termno] = pv;
+		if (proto == HV_PROTOCOL_HVSI)
+			hvsilib_init(&pv->hvsi, opal_get_chars, opal_put_chars,
+				     termno, 0);
+
+		/* Instanciate now to establish a mapping index==vtermno */
+		hvc_instantiate(termno, termno, ops);
+	} else {
+		pr_err("hvc_opal: Device %s has duplicate terminal number #%d\n",
+		       dev->dev.of_node->full_name, termno);
+		return -ENXIO;
+	}
+
+	pr_info("hvc%d: %s protocol on %s%s\n", termno,
+		proto == HV_PROTOCOL_RAW ? "raw" : "hvsi",
+		dev->dev.of_node->full_name,
+		boot ? " (boot console)" : "");
+
+	/* We don't do IRQ yet */
+	hp = hvc_alloc(termno, 0, ops, MAX_VIO_PUT_CHARS);
+	if (IS_ERR(hp))
+		return PTR_ERR(hp);
+	dev_set_drvdata(&dev->dev, hp);
+
+	return 0;
+}
+
+static int __devexit hvc_opal_remove(struct platform_device *dev)
+{
+	struct hvc_struct *hp = dev_get_drvdata(&dev->dev);
+	int rc, termno;
+
+	termno = hp->vtermno;
+	rc = hvc_remove(hp);
+	if (rc == 0) {
+		if (hvc_opal_privs[termno] != &hvc_opal_boot_priv)
+			kfree(hvc_opal_privs[termno]);
+		hvc_opal_privs[termno] = NULL;
+	}
+	return rc;
+}
+
+static struct platform_driver hvc_opal_driver = {
+	.probe		= hvc_opal_probe,
+	.remove		= __devexit_p(hvc_opal_remove),
+	.driver		= {
+		.name	= hvc_opal_name,
+		.owner	= THIS_MODULE,
+		.of_match_table	= hvc_opal_match,
+	}
+};
+
+static int __init hvc_opal_init(void)
+{
+	if (!firmware_has_feature(FW_FEATURE_OPAL))
+		return -ENODEV;
+
+	/* Register as a vio device to receive callbacks */
+	return platform_driver_register(&hvc_opal_driver);
+}
+module_init(hvc_opal_init);
+
+static void __exit hvc_opal_exit(void)
+{
+	platform_driver_unregister(&hvc_opal_driver);
+}
+module_exit(hvc_opal_exit);
+
+static void udbg_opal_putc(char c)
+{
+	unsigned int termno = hvc_opal_boot_termno;
+	int count = -1;
+
+	if (c == '\n')
+		udbg_opal_putc('\r');
+
+	do {
+		switch(hvc_opal_boot_priv.proto) {
+		case HV_PROTOCOL_RAW:
+			count = opal_put_chars(termno, &c, 1);
+			break;
+		case HV_PROTOCOL_HVSI:
+			count = hvc_opal_hvsi_put_chars(termno, &c, 1);
+			break;
+		}
+	} while(count == 0 || count == -EAGAIN);
+}
+
+static int udbg_opal_getc_poll(void)
+{
+	unsigned int termno = hvc_opal_boot_termno;
+	int rc = 0;
+	char c;
+
+	switch(hvc_opal_boot_priv.proto) {
+	case HV_PROTOCOL_RAW:
+		rc = opal_get_chars(termno, &c, 1);
+		break;
+	case HV_PROTOCOL_HVSI:
+		rc = hvc_opal_hvsi_get_chars(termno, &c, 1);
+		break;
+	}
+	if (!rc)
+		return -1;
+	return c;
+}
+
+static int udbg_opal_getc(void)
+{
+	int ch;
+	for (;;) {
+		ch = udbg_opal_getc_poll();
+		if (ch == -1) {
+			/* This shouldn't be needed...but... */
+			volatile unsigned long delay;
+			for (delay=0; delay < 2000000; delay++)
+				;
+		} else {
+			return ch;
+		}
+	}
+}
+
+static void udbg_init_opal_common(void)
+{
+	udbg_putc = udbg_opal_putc;
+	udbg_getc = udbg_opal_getc;
+	udbg_getc_poll = udbg_opal_getc_poll;
+	tb_ticks_per_usec = 0x200; /* Make udelay not suck */
+}
+
+void __init hvc_opal_init_early(void)
+{
+	struct device_node *stdout_node = NULL;
+	const u32 *termno;
+	const char *name = NULL;
+	const struct hv_ops *ops;
+	u32 index;
+
+	/* find the boot console from /chosen/stdout */
+	if (of_chosen)
+		name = of_get_property(of_chosen, "linux,stdout-path", NULL);
+	if (name) {
+		stdout_node = of_find_node_by_path(name);
+		if (!stdout_node) {
+			pr_err("hvc_opal: Failed to locate default console!\n");
+			return;
+		}
+	} else {
+		struct device_node *opal, *np;
+
+		/* Current OPAL takeover doesn't provide the stdout
+		 * path, so we hard wire it
+		 */
+		opal = of_find_node_by_path("/ibm,opal/consoles");
+		if (opal)
+			pr_devel("hvc_opal: Found consoles in new location\n");
+		if (!opal) {
+			opal = of_find_node_by_path("/ibm,opal");
+			if (opal)
+				pr_devel("hvc_opal: "
+					 "Found consoles in old location\n");
+		}
+		if (!opal)
+			return;
+		for_each_child_of_node(opal, np) {
+			if (!strcmp(np->name, "serial")) {
+				stdout_node = np;
+				break;
+			}
+		}
+		of_node_put(opal);
+	}
+	if (!stdout_node)
+		return;
+	termno = of_get_property(stdout_node, "reg", NULL);
+	index = termno ? *termno : 0;
+	if (index >= MAX_NR_HVC_CONSOLES)
+		return;
+	hvc_opal_privs[index] = &hvc_opal_boot_priv;
+
+	/* Check the protocol */
+	if (of_device_is_compatible(stdout_node, "ibm,opal-console-raw")) {
+		hvc_opal_boot_priv.proto = HV_PROTOCOL_RAW;
+		ops = &hvc_opal_raw_ops;
+		pr_devel("hvc_opal: Found RAW console\n");
+	}
+	else if (of_device_is_compatible(stdout_node,"ibm,opal-console-hvsi")) {
+		hvc_opal_boot_priv.proto = HV_PROTOCOL_HVSI;
+		ops = &hvc_opal_hvsi_ops;
+		hvsilib_init(&hvc_opal_boot_priv.hvsi, opal_get_chars,
+			     opal_put_chars, index, 1);
+		/* HVSI, perform the handshake now */
+		hvsilib_establish(&hvc_opal_boot_priv.hvsi);
+		pr_devel("hvc_opal: Found HVSI console\n");
+	} else
+		goto out;
+	hvc_opal_boot_termno = index;
+	udbg_init_opal_common();
+	add_preferred_console("hvc", index, NULL);
+	hvc_instantiate(index, index, ops);
+out:
+	of_node_put(stdout_node);
+}
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_OPAL_RAW
+void __init udbg_init_debug_opal(void)
+{
+	u32 index = CONFIG_PPC_EARLY_DEBUG_OPAL_VTERMNO;
+	hvc_opal_privs[index] = &hvc_opal_boot_priv;
+	hvc_opal_boot_priv.proto = HV_PROTOCOL_RAW;
+	hvc_opal_boot_termno = index;
+	udbg_init_opal_common();
+}
+#endif /* CONFIG_PPC_EARLY_DEBUG_OPAL_RAW */
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_OPAL_HVSI
+void __init udbg_init_debug_opal_hvsi(void)
+{
+	u32 index = CONFIG_PPC_EARLY_DEBUG_OPAL_VTERMNO;
+	hvc_opal_privs[index] = &hvc_opal_boot_priv;
+	hvc_opal_boot_termno = index;
+	udbg_init_opal_common();
+	hvsilib_init(&hvc_opal_boot_priv.hvsi, opal_get_chars, opal_put_chars,
+		     index, 1);
+	hvsilib_establish(&hvc_opal_boot_priv.hvsi);
+}
+#endif /* CONFIG_PPC_EARLY_DEBUG_OPAL_HVSI */
diff --git a/drivers/tty/hvc/hvsi_lib.c b/drivers/tty/hvc/hvsi_lib.c
index bd9b098..6f4dd83 100644
--- a/drivers/tty/hvc/hvsi_lib.c
+++ b/drivers/tty/hvc/hvsi_lib.c
@@ -183,7 +183,7 @@ int hvsilib_get_chars(struct hvsi_priv *pv, char *buf, int count)
 	unsigned int tries, read = 0;
 
 	if (WARN_ON(!pv))
-		return 0;
+		return -ENXIO;
 
 	/* If we aren't open, don't do anything in order to avoid races
 	 * with connection establishment. The hvc core will call this
@@ -234,7 +234,7 @@ int hvsilib_put_chars(struct hvsi_priv *pv, const char *buf, int count)
 	int rc, adjcount = min(count, HVSI_MAX_OUTGOING_DATA);
 
 	if (WARN_ON(!pv))
-		return 0;
+		return -ENODEV;
 
 	dp.hdr.type = VS_DATA_PACKET_HEADER;
 	dp.hdr.len = adjcount + sizeof(struct hvsi_header);
-- 
1.7.4.1
