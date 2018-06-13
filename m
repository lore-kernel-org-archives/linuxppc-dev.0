Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 415NWM0G7pzDrp0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 20:38:06 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>
Message-Id: <8b3777adb821c94785c6627c103e4d1e0e9e1b76.1528885172.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1528885172.git.fthain@telegraphics.com.au>
References: <cover.1528885172.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v3 06/12] macintosh/via-pmu: Add support for m68k PowerBooks
Date: Wed, 13 Jun 2018 06:38:01 -0400 (EDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Put #ifdefs around the Open Firmware, xmon, interrupt dispatch,
battery and suspend code. Add the necessary interrupt handling to
support m68k PowerBooks.

The pmu_kind value is available to userspace using the
PMU_IOC_GET_MODEL ioctl. It is not clear yet what hardware classes
are be needed to describe m68k PowerBook models, so pmu_kind is given
the provisional value PMU_UNKNOWN.

To find out about the hardware, user programs can use /proc/bootinfo
or /proc/hardware, or send the PMU_GET_VERSION command using /dev/adb.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/Kconfig   |   2 +-
 drivers/macintosh/via-pmu.c | 101 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 91 insertions(+), 12 deletions(-)

diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 97a420c11eed..9c6452b38c36 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -65,7 +65,7 @@ config ADB_CUDA
 	  If unsure say Y.
 
 config ADB_PMU
-	bool "Support for PMU  based PowerMacs"
+	bool "Support for PMU based PowerMacs and PowerBooks"
 	depends on PPC_PMAC
 	help
 	  On PowerBooks, iBooks, and recent iMacs and Power Macintoshes, the
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 2e09137410f6..22cb7d94e3ce 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device driver for the via-pmu on Apple Powermacs.
+ * Device driver for the PMU in Apple PowerBooks and PowerMacs.
  *
  * The VIA (versatile interface adapter) interfaces to the PMU,
  * a 6805 microprocessor core whose primary function is to control
@@ -49,20 +49,26 @@
 #include <linux/compat.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <asm/prom.h>
+#include <linux/uaccess.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/sections.h>
 #include <asm/irq.h>
+#ifdef CONFIG_PPC_PMAC
 #include <asm/pmac_feature.h>
 #include <asm/pmac_pfunc.h>
 #include <asm/pmac_low_i2c.h>
-#include <linux/uaccess.h>
+#include <asm/prom.h>
 #include <asm/mmu_context.h>
 #include <asm/cputable.h>
 #include <asm/time.h>
 #include <asm/backlight.h>
+#else
+#include <asm/macintosh.h>
+#include <asm/macints.h>
+#include <asm/mac_via.h>
+#endif
 
 #include "via-pmu-event.h"
 
@@ -97,8 +103,13 @@ static DEFINE_MUTEX(pmu_info_proc_mutex);
 #define ANH		(15*RS)		/* A-side data, no handshake */
 
 /* Bits in B data register: both active low */
+#ifdef CONFIG_PPC_PMAC
 #define TACK		0x08		/* Transfer acknowledge (input) */
 #define TREQ		0x10		/* Transfer request (output) */
+#else
+#define TACK		0x02
+#define TREQ		0x04
+#endif
 
 /* Bits in ACR */
 #define SR_CTRL		0x1c		/* Shift register control bits */
@@ -140,13 +151,15 @@ static int data_index;
 static int data_len;
 static volatile int adb_int_pending;
 static volatile int disable_poll;
-static struct device_node *vias;
 static int pmu_kind = PMU_UNKNOWN;
 static int pmu_fully_inited;
 static int pmu_has_adb;
+#ifdef CONFIG_PPC_PMAC
 static volatile unsigned char __iomem *via1;
 static volatile unsigned char __iomem *via2;
+static struct device_node *vias;
 static struct device_node *gpio_node;
+#endif
 static unsigned char __iomem *gpio_reg;
 static int gpio_irq = 0;
 static int gpio_irq_enabled = -1;
@@ -273,6 +286,7 @@ static char *pbook_type[] = {
 
 int __init find_via_pmu(void)
 {
+#ifdef CONFIG_PPC_PMAC
 	u64 taddr;
 	const u32 *reg;
 
@@ -355,9 +369,6 @@ int __init find_via_pmu(void)
 	if (!init_pmu())
 		goto fail_init;
 
-	printk(KERN_INFO "PMU driver v%d initialized for %s, firmware: %02x\n",
-	       PMU_DRIVER_VERSION, pbook_type[pmu_kind], pmu_version);
-	       
 	sys_ctrler = SYS_CTRLER_PMU;
 	
 	return 1;
@@ -373,6 +384,30 @@ int __init find_via_pmu(void)
 	vias = NULL;
 	pmu_state = uninitialized;
 	return 0;
+#else
+	if (macintosh_config->adb_type != MAC_ADB_PB2)
+		return 0;
+
+	pmu_kind = PMU_UNKNOWN;
+
+	spin_lock_init(&pmu_lock);
+
+	pmu_has_adb = 1;
+
+	pmu_intr_mask =	PMU_INT_PCEJECT |
+			PMU_INT_SNDBRT |
+			PMU_INT_ADB |
+			PMU_INT_TICK;
+
+	pmu_state = idle;
+
+	if (!init_pmu()) {
+		pmu_state = uninitialized;
+		return 0;
+	}
+
+	return 1;
+#endif /* !CONFIG_PPC_PMAC */
 }
 
 #ifdef CONFIG_ADB
@@ -396,13 +431,14 @@ static int pmu_init(void)
  */
 static int __init via_pmu_start(void)
 {
-	unsigned int irq;
+	unsigned int __maybe_unused irq;
 
 	if (pmu_state == uninitialized)
 		return -ENODEV;
 
 	batt_req.complete = 1;
 
+#ifdef CONFIG_PPC_PMAC
 	irq = irq_of_parse_and_map(vias, 0);
 	if (!irq) {
 		printk(KERN_ERR "via-pmu: can't map interrupt\n");
@@ -439,6 +475,19 @@ static int __init via_pmu_start(void)
 
 	/* Enable interrupts */
 	out_8(&via1[IER], IER_SET | SR_INT | CB1_INT);
+#else
+	if (request_irq(IRQ_MAC_ADB_SR, via_pmu_interrupt, IRQF_NO_SUSPEND,
+			"VIA-PMU-SR", NULL)) {
+		pr_err("%s: couldn't get SR irq\n", __func__);
+		return -ENODEV;
+	}
+	if (request_irq(IRQ_MAC_ADB_CL, via_pmu_interrupt, IRQF_NO_SUSPEND,
+			"VIA-PMU-CL", NULL)) {
+		pr_err("%s: couldn't get CL irq\n", __func__);
+		free_irq(IRQ_MAC_ADB_SR, NULL);
+		return -ENODEV;
+	}
+#endif /* !CONFIG_PPC_PMAC */
 
 	pmu_fully_inited = 1;
 
@@ -587,6 +636,10 @@ init_pmu(void)
 			       option_server_mode ? "enabled" : "disabled");
 		}
 	}
+
+	printk(KERN_INFO "PMU driver v%d initialized for %s, firmware: %02x\n",
+	       PMU_DRIVER_VERSION, pbook_type[pmu_kind], pmu_version);
+
 	return 1;
 }
 
@@ -625,6 +678,7 @@ static void pmu_set_server_mode(int server_mode)
 static void
 done_battery_state_ohare(struct adb_request* req)
 {
+#ifdef CONFIG_PPC_PMAC
 	/* format:
 	 *  [0]    :  flags
 	 *    0x01 :  AC indicator
@@ -706,6 +760,7 @@ done_battery_state_ohare(struct adb_request* req)
 	pmu_batteries[pmu_cur_battery].amperage = amperage;
 	pmu_batteries[pmu_cur_battery].voltage = voltage;
 	pmu_batteries[pmu_cur_battery].time_remaining = time;
+#endif /* CONFIG_PPC_PMAC */
 
 	clear_bit(0, &async_req_locks);
 }
@@ -1393,6 +1448,7 @@ pmu_handle_data(unsigned char *data, int len)
 			}
 			pmu_done(req);
 		} else {
+#ifdef CONFIG_XMON
 			if (len == 4 && data[1] == 0x2c) {
 				extern int xmon_wants_key, xmon_adb_keycode;
 				if (xmon_wants_key) {
@@ -1400,6 +1456,7 @@ pmu_handle_data(unsigned char *data, int len)
 					return;
 				}
 			}
+#endif /* CONFIG_XMON */
 #ifdef CONFIG_ADB
 			/*
 			 * XXX On the [23]400 the PMU gives us an up
@@ -1567,7 +1624,25 @@ via_pmu_interrupt(int irq, void *arg)
 	++disable_poll;
 	
 	for (;;) {
-		intr = in_8(&via1[IFR]) & (SR_INT | CB1_INT);
+		/* On 68k Macs, VIA interrupts are dispatched individually.
+		 * Unless we are polling, the relevant IRQ flag has already
+		 * been cleared.
+		 */
+		intr = 0;
+		if (IS_ENABLED(CONFIG_PPC_PMAC) || !irq) {
+			intr = in_8(&via1[IFR]) & (SR_INT | CB1_INT);
+			out_8(&via1[IFR], intr);
+		}
+#ifndef CONFIG_PPC_PMAC
+		switch (irq) {
+		case IRQ_MAC_ADB_CL:
+			intr = CB1_INT;
+			break;
+		case IRQ_MAC_ADB_SR:
+			intr = SR_INT;
+			break;
+		}
+#endif
 		if (intr == 0)
 			break;
 		handled = 1;
@@ -1577,7 +1652,6 @@ via_pmu_interrupt(int irq, void *arg)
 			       intr, in_8(&via1[IER]), pmu_state);
 			break;
 		}
-		out_8(&via1[IFR], intr);
 		if (intr & CB1_INT) {
 			adb_int_pending = 1;
 			pmu_irq_stats[0]++;
@@ -1587,6 +1661,9 @@ via_pmu_interrupt(int irq, void *arg)
 			if (req)
 				break;
 		}
+#ifndef CONFIG_PPC_PMAC
+		break;
+#endif
 	}
 
 recheck:
@@ -1653,7 +1730,7 @@ pmu_unlock(void)
 }
 
 
-static irqreturn_t
+static __maybe_unused irqreturn_t
 gpio1_interrupt(int irq, void *arg)
 {
 	unsigned long flags;
@@ -2287,6 +2364,7 @@ static int pmu_ioctl(struct file *filp,
 	int error = -EINVAL;
 
 	switch (cmd) {
+#ifdef CONFIG_PPC_PMAC
 	case PMU_IOC_SLEEP:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
@@ -2296,6 +2374,7 @@ static int pmu_ioctl(struct file *filp,
 			return put_user(0, argp);
 		else
 			return put_user(1, argp);
+#endif
 
 #ifdef CONFIG_PMAC_BACKLIGHT_LEGACY
 	/* Compatibility ioctl's for backlight */
-- 
2.16.4
