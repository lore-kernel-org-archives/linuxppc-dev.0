Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx2.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D0D7CDE26B
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 19:31:54 +1000 (EST)
Sender: kou.ishizaki@toshiba.co.jp
Date: Thu, 24 Apr 2008 18:31:40 +0900 (JST)
Message-Id: <20080424.183140.63051774.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
From: kou.ishizaki@toshiba.co.jp, Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: [PATCH 8/9] celleb: move miscellaneous files for Beat
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch moves miscellaneous files for Beat into platforms/cell/.
All files in this patch are used by celleb-beat only.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/Makefile              |    1 
 arch/powerpc/platforms/cell/Makefile         |    6 
 arch/powerpc/platforms/cell/beat.c           |  264 +++++++++++++++++++++++++
 arch/powerpc/platforms/cell/beat.h           |   39 +++
 arch/powerpc/platforms/cell/beat_interrupt.c |  283 +++++++++++++++++++++++++++
 arch/powerpc/platforms/cell/beat_interrupt.h |   33 +++
 arch/powerpc/platforms/cell/beat_smp.c       |  124 +++++++++++
 arch/powerpc/platforms/cell/beat_udbg.c      |   98 +++++++++
 arch/powerpc/platforms/cell/celleb_setup.c   |    4 
 arch/powerpc/platforms/celleb/Makefile       |    5 
 arch/powerpc/platforms/celleb/beat.c         |  264 -------------------------
 arch/powerpc/platforms/celleb/beat.h         |   39 ---
 arch/powerpc/platforms/celleb/interrupt.c    |  283 ---------------------------
 arch/powerpc/platforms/celleb/interrupt.h    |   33 ---
 arch/powerpc/platforms/celleb/smp.c          |  124 -----------
 arch/powerpc/platforms/celleb/udbg_beat.c    |   98 ---------
 16 files changed, 847 insertions(+), 851 deletions(-)

Index: b/arch/powerpc/platforms/cell/beat.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/beat.c	2008-04-23 21:38:50.000000000 +0900
@@ -0,0 +1,264 @@
+/*
+ * Simple routines for Celleb/Beat
+ *
+ * (C) Copyright 2006-2007 TOSHIBA CORPORATION
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/rtc.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/reboot.h>
+
+#include <asm/hvconsole.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/firmware.h>
+
+#include "beat_wrapper.h"
+#include "beat.h"
+#include "beat_interrupt.h"
+
+static int beat_pm_poweroff_flag;
+
+void beat_restart(char *cmd)
+{
+	beat_shutdown_logical_partition(!beat_pm_poweroff_flag);
+}
+
+void beat_power_off(void)
+{
+	beat_shutdown_logical_partition(0);
+}
+
+u64 beat_halt_code = 0x1000000000000000UL;
+EXPORT_SYMBOL(beat_halt_code);
+
+void beat_halt(void)
+{
+	beat_shutdown_logical_partition(beat_halt_code);
+}
+
+int beat_set_rtc_time(struct rtc_time *rtc_time)
+{
+	u64 tim;
+	tim = mktime(rtc_time->tm_year+1900,
+		     rtc_time->tm_mon+1, rtc_time->tm_mday,
+		     rtc_time->tm_hour, rtc_time->tm_min, rtc_time->tm_sec);
+	if (beat_rtc_write(tim))
+		return -1;
+	return 0;
+}
+
+void beat_get_rtc_time(struct rtc_time *rtc_time)
+{
+	u64 tim;
+
+	if (beat_rtc_read(&tim))
+		tim = 0;
+	to_tm(tim, rtc_time);
+	rtc_time->tm_year -= 1900;
+	rtc_time->tm_mon -= 1;
+}
+
+#define	BEAT_NVRAM_SIZE	4096
+
+ssize_t beat_nvram_read(char *buf, size_t count, loff_t *index)
+{
+	unsigned int i;
+	unsigned long len;
+	char *p = buf;
+
+	if (*index >= BEAT_NVRAM_SIZE)
+		return -ENODEV;
+	i = *index;
+	if (i + count > BEAT_NVRAM_SIZE)
+		count = BEAT_NVRAM_SIZE - i;
+
+	for (; count != 0; count -= len) {
+		len = count;
+		if (len > BEAT_NVRW_CNT)
+			len = BEAT_NVRW_CNT;
+		if (beat_eeprom_read(i, len, p))
+			return -EIO;
+
+		p += len;
+		i += len;
+	}
+	*index = i;
+	return p - buf;
+}
+
+ssize_t beat_nvram_write(char *buf, size_t count, loff_t *index)
+{
+	unsigned int i;
+	unsigned long len;
+	char *p = buf;
+
+	if (*index >= BEAT_NVRAM_SIZE)
+		return -ENODEV;
+	i = *index;
+	if (i + count > BEAT_NVRAM_SIZE)
+		count = BEAT_NVRAM_SIZE - i;
+
+	for (; count != 0; count -= len) {
+		len = count;
+		if (len > BEAT_NVRW_CNT)
+			len = BEAT_NVRW_CNT;
+		if (beat_eeprom_write(i, len, p))
+			return -EIO;
+
+		p += len;
+		i += len;
+	}
+	*index = i;
+	return p - buf;
+}
+
+ssize_t beat_nvram_get_size(void)
+{
+	return BEAT_NVRAM_SIZE;
+}
+
+int beat_set_xdabr(unsigned long dabr)
+{
+	if (beat_set_dabr(dabr, DABRX_KERNEL | DABRX_USER))
+		return -1;
+	return 0;
+}
+
+int64_t beat_get_term_char(u64 vterm, u64 *len, u64 *t1, u64 *t2)
+{
+	u64 db[2];
+	s64 ret;
+
+	ret = beat_get_characters_from_console(vterm, len, (u8 *)db);
+	if (ret == 0) {
+		*t1 = db[0];
+		*t2 = db[1];
+	}
+	return ret;
+}
+EXPORT_SYMBOL(beat_get_term_char);
+
+int64_t beat_put_term_char(u64 vterm, u64 len, u64 t1, u64 t2)
+{
+	u64 db[2];
+
+	db[0] = t1;
+	db[1] = t2;
+	return beat_put_characters_to_console(vterm, len, (u8 *)db);
+}
+EXPORT_SYMBOL(beat_put_term_char);
+
+void beat_power_save(void)
+{
+	beat_pause(0);
+}
+
+#ifdef CONFIG_KEXEC
+void beat_kexec_cpu_down(int crash, int secondary)
+{
+	beatic_deinit_IRQ();
+}
+#endif
+
+static irqreturn_t beat_power_event(int virq, void *arg)
+{
+	printk(KERN_DEBUG "Beat: power button pressed\n");
+	beat_pm_poweroff_flag = 1;
+	ctrl_alt_del();
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t beat_reset_event(int virq, void *arg)
+{
+	printk(KERN_DEBUG "Beat: reset button pressed\n");
+	beat_pm_poweroff_flag = 0;
+	ctrl_alt_del();
+	return IRQ_HANDLED;
+}
+
+static struct beat_event_list {
+	const char *typecode;
+	irq_handler_t handler;
+	unsigned int virq;
+} beat_event_list[] = {
+	{ "power", beat_power_event, 0 },
+	{ "reset", beat_reset_event, 0 },
+};
+
+static int __init beat_register_event(void)
+{
+	u64 path[4], data[2];
+	int rc, i;
+	unsigned int virq;
+
+	for (i = 0; i < ARRAY_SIZE(beat_event_list); i++) {
+		struct beat_event_list *ev = &beat_event_list[i];
+
+		if (beat_construct_event_receive_port(data) != 0) {
+			printk(KERN_ERR "Beat: "
+			       "cannot construct event receive port for %s\n",
+			       ev->typecode);
+			return -EINVAL;
+		}
+
+		virq = irq_create_mapping(NULL, data[0]);
+		if (virq == NO_IRQ) {
+			printk(KERN_ERR "Beat: failed to get virtual IRQ"
+			       " for event receive port for %s\n",
+			       ev->typecode);
+			beat_destruct_event_receive_port(data[0]);
+			return -EIO;
+		}
+		ev->virq = virq;
+
+		rc = request_irq(virq, ev->handler, IRQF_DISABLED,
+				      ev->typecode, NULL);
+		if (rc != 0) {
+			printk(KERN_ERR "Beat: failed to request virtual IRQ"
+			       " for event receive port for %s\n",
+			       ev->typecode);
+			beat_destruct_event_receive_port(data[0]);
+			return rc;
+		}
+
+		path[0] = 0x1000000065780000ul;	/* 1,ex */
+		path[1] = 0x627574746f6e0000ul;	/* button */
+		path[2] = 0;
+		strncpy((char *)&path[2], ev->typecode, 8);
+		path[3] = 0;
+		data[1] = 0;
+
+		beat_create_repository_node(path, data);
+	}
+	return 0;
+}
+
+static int __init beat_event_init(void)
+{
+	if (!firmware_has_feature(FW_FEATURE_BEAT))
+		return -EINVAL;
+
+	beat_pm_poweroff_flag = 0;
+	return beat_register_event();
+}
+
+device_initcall(beat_event_init);
Index: b/arch/powerpc/platforms/cell/beat.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/beat.h	2008-04-23 21:38:50.000000000 +0900
@@ -0,0 +1,39 @@
+/*
+ * Guest OS Interfaces.
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef _CELLEB_BEAT_H
+#define _CELLEB_BEAT_H
+
+int64_t beat_get_term_char(uint64_t, uint64_t *, uint64_t *, uint64_t *);
+int64_t beat_put_term_char(uint64_t, uint64_t, uint64_t, uint64_t);
+int64_t beat_repository_encode(int, const char *, uint64_t[4]);
+void beat_restart(char *);
+void beat_power_off(void);
+void beat_halt(void);
+int beat_set_rtc_time(struct rtc_time *);
+void beat_get_rtc_time(struct rtc_time *);
+ssize_t beat_nvram_get_size(void);
+ssize_t beat_nvram_read(char *, size_t, loff_t *);
+ssize_t beat_nvram_write(char *, size_t, loff_t *);
+int beat_set_xdabr(unsigned long);
+void beat_power_save(void);
+void beat_kexec_cpu_down(int, int);
+
+#endif /* _CELLEB_BEAT_H */
Index: b/arch/powerpc/platforms/cell/beat_interrupt.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/beat_interrupt.c	2008-04-23 21:38:50.000000000 +0900
@@ -0,0 +1,283 @@
+/*
+ * Celleb/Beat Interrupt controller
+ *
+ * (C) Copyright 2006-2007 TOSHIBA CORPORATION
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/percpu.h>
+#include <linux/types.h>
+
+#include <asm/machdep.h>
+
+#include "beat_interrupt.h"
+#include "beat_wrapper.h"
+
+#define	MAX_IRQS	NR_IRQS
+static DEFINE_SPINLOCK(beatic_irq_mask_lock);
+static uint64_t	beatic_irq_mask_enable[(MAX_IRQS+255)/64];
+static uint64_t	beatic_irq_mask_ack[(MAX_IRQS+255)/64];
+
+static struct irq_host *beatic_host;
+
+/*
+ * In this implementation, "virq" == "IRQ plug number",
+ * "(irq_hw_number_t)hwirq" == "IRQ outlet number".
+ */
+
+/* assumption: locked */
+static inline void beatic_update_irq_mask(unsigned int irq_plug)
+{
+	int off;
+	unsigned long masks[4];
+
+	off = (irq_plug / 256) * 4;
+	masks[0] = beatic_irq_mask_enable[off + 0]
+		& beatic_irq_mask_ack[off + 0];
+	masks[1] = beatic_irq_mask_enable[off + 1]
+		& beatic_irq_mask_ack[off + 1];
+	masks[2] = beatic_irq_mask_enable[off + 2]
+		& beatic_irq_mask_ack[off + 2];
+	masks[3] = beatic_irq_mask_enable[off + 3]
+		& beatic_irq_mask_ack[off + 3];
+	if (beat_set_interrupt_mask(irq_plug&~255UL,
+		masks[0], masks[1], masks[2], masks[3]) != 0)
+		panic("Failed to set mask IRQ!");
+}
+
+static void beatic_mask_irq(unsigned int irq_plug)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&beatic_irq_mask_lock, flags);
+	beatic_irq_mask_enable[irq_plug/64] &= ~(1UL << (63 - (irq_plug%64)));
+	beatic_update_irq_mask(irq_plug);
+	spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
+}
+
+static void beatic_unmask_irq(unsigned int irq_plug)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&beatic_irq_mask_lock, flags);
+	beatic_irq_mask_enable[irq_plug/64] |= 1UL << (63 - (irq_plug%64));
+	beatic_update_irq_mask(irq_plug);
+	spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
+}
+
+static void beatic_ack_irq(unsigned int irq_plug)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&beatic_irq_mask_lock, flags);
+	beatic_irq_mask_ack[irq_plug/64] &= ~(1UL << (63 - (irq_plug%64)));
+	beatic_update_irq_mask(irq_plug);
+	spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
+}
+
+static void beatic_end_irq(unsigned int irq_plug)
+{
+	s64 err;
+	unsigned long flags;
+
+	err = beat_downcount_of_interrupt(irq_plug);
+	if (err != 0) {
+		if ((err & 0xFFFFFFFF) != 0xFFFFFFF5) /* -11: wrong state */
+			panic("Failed to downcount IRQ! Error = %16lx", err);
+
+		printk(KERN_ERR "IRQ over-downcounted, plug %d\n", irq_plug);
+	}
+	spin_lock_irqsave(&beatic_irq_mask_lock, flags);
+	beatic_irq_mask_ack[irq_plug/64] |= 1UL << (63 - (irq_plug%64));
+	beatic_update_irq_mask(irq_plug);
+	spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
+}
+
+static struct irq_chip beatic_pic = {
+	.typename = " CELL-BEAT ",
+	.unmask = beatic_unmask_irq,
+	.mask = beatic_mask_irq,
+	.eoi = beatic_end_irq,
+};
+
+/*
+ * Dispose binding hardware IRQ number (hw) and Virtuql IRQ number (virq),
+ * update flags.
+ *
+ * Note that the number (virq) is already assigned at upper layer.
+ */
+static void beatic_pic_host_unmap(struct irq_host *h, unsigned int virq)
+{
+	beat_destruct_irq_plug(virq);
+}
+
+/*
+ * Create or update binding hardware IRQ number (hw) and Virtuql
+ * IRQ number (virq). This is called only once for a given mapping.
+ *
+ * Note that the number (virq) is already assigned at upper layer.
+ */
+static int beatic_pic_host_map(struct irq_host *h, unsigned int virq,
+			       irq_hw_number_t hw)
+{
+	struct irq_desc *desc = get_irq_desc(virq);
+	int64_t	err;
+
+	err = beat_construct_and_connect_irq_plug(virq, hw);
+	if (err < 0)
+		return -EIO;
+
+	desc->status |= IRQ_LEVEL;
+	set_irq_chip_and_handler(virq, &beatic_pic, handle_fasteoi_irq);
+	return 0;
+}
+
+/*
+ * Update binding hardware IRQ number (hw) and Virtuql
+ * IRQ number (virq). This is called only once for a given mapping.
+ */
+static void beatic_pic_host_remap(struct irq_host *h, unsigned int virq,
+			       irq_hw_number_t hw)
+{
+	beat_construct_and_connect_irq_plug(virq, hw);
+}
+
+/*
+ * Translate device-tree interrupt spec to irq_hw_number_t style (ulong),
+ * to pass away to irq_create_mapping().
+ *
+ * Called from irq_create_of_mapping() only.
+ * Note: We have only 1 entry to translate.
+ */
+static int beatic_pic_host_xlate(struct irq_host *h, struct device_node *ct,
+				 u32 *intspec, unsigned int intsize,
+				 irq_hw_number_t *out_hwirq,
+				 unsigned int *out_flags)
+{
+	u64 *intspec2 = (u64 *)intspec;
+
+	*out_hwirq = *intspec2;
+	*out_flags |= IRQ_TYPE_LEVEL_LOW;
+	return 0;
+}
+
+static int beatic_pic_host_match(struct irq_host *h, struct device_node *np)
+{
+	/* Match all */
+	return 1;
+}
+
+static struct irq_host_ops beatic_pic_host_ops = {
+	.map = beatic_pic_host_map,
+	.remap = beatic_pic_host_remap,
+	.unmap = beatic_pic_host_unmap,
+	.xlate = beatic_pic_host_xlate,
+	.match = beatic_pic_host_match,
+};
+
+/*
+ * Get an IRQ number
+ * Note: returns VIRQ
+ */
+static inline unsigned int beatic_get_irq_plug(void)
+{
+	int i;
+	uint64_t	pending[4], ub;
+
+	for (i = 0; i < MAX_IRQS; i += 256) {
+		beat_detect_pending_interrupts(i, pending);
+		__asm__ ("cntlzd %0,%1":"=r"(ub):
+			"r"(pending[0] & beatic_irq_mask_enable[i/64+0]
+				       & beatic_irq_mask_ack[i/64+0]));
+		if (ub != 64)
+			return i + ub + 0;
+		__asm__ ("cntlzd %0,%1":"=r"(ub):
+			"r"(pending[1] & beatic_irq_mask_enable[i/64+1]
+				       & beatic_irq_mask_ack[i/64+1]));
+		if (ub != 64)
+			return i + ub + 64;
+		__asm__ ("cntlzd %0,%1":"=r"(ub):
+			"r"(pending[2] & beatic_irq_mask_enable[i/64+2]
+				       & beatic_irq_mask_ack[i/64+2]));
+		if (ub != 64)
+			return i + ub + 128;
+		__asm__ ("cntlzd %0,%1":"=r"(ub):
+			"r"(pending[3] & beatic_irq_mask_enable[i/64+3]
+				       & beatic_irq_mask_ack[i/64+3]));
+		if (ub != 64)
+			return i + ub + 192;
+	}
+
+	return NO_IRQ;
+}
+unsigned int beatic_get_irq(void)
+{
+	unsigned int ret;
+
+	ret = beatic_get_irq_plug();
+	if (ret != NO_IRQ)
+		beatic_ack_irq(ret);
+	return ret;
+}
+
+/*
+ */
+void __init beatic_init_IRQ(void)
+{
+	int	i;
+
+	memset(beatic_irq_mask_enable, 0, sizeof(beatic_irq_mask_enable));
+	memset(beatic_irq_mask_ack, 255, sizeof(beatic_irq_mask_ack));
+	for (i = 0; i < MAX_IRQS; i += 256)
+		beat_set_interrupt_mask(i, 0L, 0L, 0L, 0L);
+
+	/* Set out get_irq function */
+	ppc_md.get_irq = beatic_get_irq;
+
+	/* Allocate an irq host */
+	beatic_host = irq_alloc_host(NULL, IRQ_HOST_MAP_NOMAP, 0,
+				     &beatic_pic_host_ops,
+					 0);
+	BUG_ON(beatic_host == NULL);
+	irq_set_default_host(beatic_host);
+}
+
+#ifdef CONFIG_SMP
+
+/* Nullified to compile with SMP mode */
+void beatic_setup_cpu(int cpu)
+{
+}
+
+void beatic_cause_IPI(int cpu, int mesg)
+{
+}
+
+void beatic_request_IPIs(void)
+{
+}
+#endif /* CONFIG_SMP */
+
+void beatic_deinit_IRQ(void)
+{
+	int	i;
+
+	for (i = 1; i < NR_IRQS; i++)
+		beat_destruct_irq_plug(i);
+}
Index: b/arch/powerpc/platforms/cell/beat_interrupt.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/beat_interrupt.h	2008-04-23 21:38:50.000000000 +0900
@@ -0,0 +1,33 @@
+/*
+ * Celleb/Beat Interrupt controller
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef ASM_BEAT_PIC_H
+#define ASM_BEAT_PIC_H
+#ifdef __KERNEL__
+
+extern void beatic_init_IRQ(void);
+extern unsigned int beatic_get_irq(void);
+extern void beatic_cause_IPI(int cpu, int mesg);
+extern void beatic_request_IPIs(void);
+extern void beatic_setup_cpu(int);
+extern void beatic_deinit_IRQ(void);
+
+#endif
+#endif /* ASM_BEAT_PIC_H */
Index: b/arch/powerpc/platforms/cell/beat_smp.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/beat_smp.c	2008-04-23 21:38:50.000000000 +0900
@@ -0,0 +1,124 @@
+/*
+ * SMP support for Celleb platform. (Incomplete)
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
+ *
+ * This code is based on arch/powerpc/platforms/cell/smp.c:
+ * Dave Engebretsen, Peter Bergner, and
+ * Mike Corrigan {engebret|bergner|mikec}@us.ibm.com
+ * Plus various changes from other IBM teams...
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/threads.h>
+#include <linux/cpu.h>
+
+#include <asm/irq.h>
+#include <asm/smp.h>
+#include <asm/machdep.h>
+#include <asm/udbg.h>
+
+#include "beat_interrupt.h"
+
+#ifdef DEBUG
+#define DBG(fmt...) udbg_printf(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
+/*
+ * The primary thread of each non-boot processor is recorded here before
+ * smp init.
+ */
+/* static cpumask_t of_spin_map; */
+
+/**
+ * smp_startup_cpu() - start the given cpu
+ *
+ * At boot time, there is nothing to do for primary threads which were
+ * started from Open Firmware.  For anything else, call RTAS with the
+ * appropriate start location.
+ *
+ * Returns:
+ *	0	- failure
+ *	1	- success
+ */
+static inline int __devinit smp_startup_cpu(unsigned int lcpu)
+{
+	return 0;
+}
+
+static void smp_beatic_message_pass(int target, int msg)
+{
+	unsigned int i;
+
+	if (target < NR_CPUS) {
+		beatic_cause_IPI(target, msg);
+	} else {
+		for_each_online_cpu(i) {
+			if (target == MSG_ALL_BUT_SELF
+			    && i == smp_processor_id())
+				continue;
+			beatic_cause_IPI(i, msg);
+		}
+	}
+}
+
+static int __init smp_beatic_probe(void)
+{
+	return cpus_weight(cpu_possible_map);
+}
+
+static void __devinit smp_beatic_setup_cpu(int cpu)
+{
+	beatic_setup_cpu(cpu);
+}
+
+static void __devinit smp_celleb_kick_cpu(int nr)
+{
+	BUG_ON(nr < 0 || nr >= NR_CPUS);
+
+	if (!smp_startup_cpu(nr))
+		return;
+}
+
+static int smp_celleb_cpu_bootable(unsigned int nr)
+{
+	return 1;
+}
+static struct smp_ops_t bpa_beatic_smp_ops = {
+	.message_pass	= smp_beatic_message_pass,
+	.probe		= smp_beatic_probe,
+	.kick_cpu	= smp_celleb_kick_cpu,
+	.setup_cpu	= smp_beatic_setup_cpu,
+	.cpu_bootable	= smp_celleb_cpu_bootable,
+};
+
+/* This is called very early */
+void __init smp_init_celleb(void)
+{
+	DBG(" -> smp_init_celleb()\n");
+
+	smp_ops = &bpa_beatic_smp_ops;
+
+	DBG(" <- smp_init_celleb()\n");
+}
Index: b/arch/powerpc/platforms/cell/beat_udbg.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/beat_udbg.c	2008-04-23 21:38:50.000000000 +0900
@@ -0,0 +1,98 @@
+/*
+ * udbg function for Beat
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/console.h>
+
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+
+#include "beat.h"
+
+#define	celleb_vtermno	0
+
+static void udbg_putc_beat(char c)
+{
+	unsigned long rc;
+
+	if (c == '\n')
+		udbg_putc_beat('\r');
+
+	rc = beat_put_term_char(celleb_vtermno, 1, (uint64_t)c << 56, 0);
+}
+
+/* Buffered chars getc */
+static long inbuflen;
+static long inbuf[2];	/* must be 2 longs */
+
+static int udbg_getc_poll_beat(void)
+{
+	/* The interface is tricky because it may return up to 16 chars.
+	 * We save them statically for future calls to udbg_getc().
+	 */
+	char ch, *buf = (char *)inbuf;
+	int i;
+	long rc;
+	if (inbuflen == 0) {
+		/* get some more chars. */
+		inbuflen = 0;
+		rc = beat_get_term_char(celleb_vtermno, &inbuflen,
+					inbuf+0, inbuf+1);
+		if (rc != 0)
+			inbuflen = 0;	/* otherwise inbuflen is garbage */
+	}
+	if (inbuflen <= 0 || inbuflen > 16) {
+		/* Catch error case as well as other oddities (corruption) */
+		inbuflen = 0;
+		return -1;
+	}
+	ch = buf[0];
+	for (i = 1; i < inbuflen; i++)	/* shuffle them down. */
+		buf[i-1] = buf[i];
+	inbuflen--;
+	return ch;
+}
+
+static int udbg_getc_beat(void)
+{
+	int ch;
+	for (;;) {
+		ch = udbg_getc_poll_beat();
+		if (ch == -1) {
+			/* This shouldn't be needed...but... */
+			volatile unsigned long delay;
+			for (delay = 0; delay < 2000000; delay++)
+				;
+		} else {
+			return ch;
+		}
+	}
+}
+
+/* call this from early_init() for a working debug console on
+ * vterm capable LPAR machines
+ */
+void __init udbg_init_debug_beat(void)
+{
+	udbg_putc = udbg_putc_beat;
+	udbg_getc = udbg_getc_beat;
+	udbg_getc_poll = udbg_getc_poll_beat;
+}
Index: b/arch/powerpc/platforms/celleb/beat.c
===================================================================
--- a/arch/powerpc/platforms/celleb/beat.c	2008-04-23 21:38:14.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,264 +0,0 @@
-/*
- * Simple routines for Celleb/Beat
- *
- * (C) Copyright 2006-2007 TOSHIBA CORPORATION
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/rtc.h>
-#include <linux/interrupt.h>
-#include <linux/irqreturn.h>
-#include <linux/reboot.h>
-
-#include <asm/hvconsole.h>
-#include <asm/time.h>
-#include <asm/machdep.h>
-#include <asm/firmware.h>
-
-#include "../cell/beat_wrapper.h"
-#include "beat.h"
-#include "interrupt.h"
-
-static int beat_pm_poweroff_flag;
-
-void beat_restart(char *cmd)
-{
-	beat_shutdown_logical_partition(!beat_pm_poweroff_flag);
-}
-
-void beat_power_off(void)
-{
-	beat_shutdown_logical_partition(0);
-}
-
-u64 beat_halt_code = 0x1000000000000000UL;
-EXPORT_SYMBOL(beat_halt_code);
-
-void beat_halt(void)
-{
-	beat_shutdown_logical_partition(beat_halt_code);
-}
-
-int beat_set_rtc_time(struct rtc_time *rtc_time)
-{
-	u64 tim;
-	tim = mktime(rtc_time->tm_year+1900,
-		     rtc_time->tm_mon+1, rtc_time->tm_mday,
-		     rtc_time->tm_hour, rtc_time->tm_min, rtc_time->tm_sec);
-	if (beat_rtc_write(tim))
-		return -1;
-	return 0;
-}
-
-void beat_get_rtc_time(struct rtc_time *rtc_time)
-{
-	u64 tim;
-
-	if (beat_rtc_read(&tim))
-		tim = 0;
-	to_tm(tim, rtc_time);
-	rtc_time->tm_year -= 1900;
-	rtc_time->tm_mon -= 1;
-}
-
-#define	BEAT_NVRAM_SIZE	4096
-
-ssize_t beat_nvram_read(char *buf, size_t count, loff_t *index)
-{
-	unsigned int i;
-	unsigned long len;
-	char *p = buf;
-
-	if (*index >= BEAT_NVRAM_SIZE)
-		return -ENODEV;
-	i = *index;
-	if (i + count > BEAT_NVRAM_SIZE)
-		count = BEAT_NVRAM_SIZE - i;
-
-	for (; count != 0; count -= len) {
-		len = count;
-		if (len > BEAT_NVRW_CNT)
-			len = BEAT_NVRW_CNT;
-		if (beat_eeprom_read(i, len, p))
-			return -EIO;
-
-		p += len;
-		i += len;
-	}
-	*index = i;
-	return p - buf;
-}
-
-ssize_t beat_nvram_write(char *buf, size_t count, loff_t *index)
-{
-	unsigned int i;
-	unsigned long len;
-	char *p = buf;
-
-	if (*index >= BEAT_NVRAM_SIZE)
-		return -ENODEV;
-	i = *index;
-	if (i + count > BEAT_NVRAM_SIZE)
-		count = BEAT_NVRAM_SIZE - i;
-
-	for (; count != 0; count -= len) {
-		len = count;
-		if (len > BEAT_NVRW_CNT)
-			len = BEAT_NVRW_CNT;
-		if (beat_eeprom_write(i, len, p))
-			return -EIO;
-
-		p += len;
-		i += len;
-	}
-	*index = i;
-	return p - buf;
-}
-
-ssize_t beat_nvram_get_size(void)
-{
-	return BEAT_NVRAM_SIZE;
-}
-
-int beat_set_xdabr(unsigned long dabr)
-{
-	if (beat_set_dabr(dabr, DABRX_KERNEL | DABRX_USER))
-		return -1;
-	return 0;
-}
-
-int64_t beat_get_term_char(u64 vterm, u64 *len, u64 *t1, u64 *t2)
-{
-	u64 db[2];
-	s64 ret;
-
-	ret = beat_get_characters_from_console(vterm, len, (u8 *)db);
-	if (ret == 0) {
-		*t1 = db[0];
-		*t2 = db[1];
-	}
-	return ret;
-}
-EXPORT_SYMBOL(beat_get_term_char);
-
-int64_t beat_put_term_char(u64 vterm, u64 len, u64 t1, u64 t2)
-{
-	u64 db[2];
-
-	db[0] = t1;
-	db[1] = t2;
-	return beat_put_characters_to_console(vterm, len, (u8 *)db);
-}
-EXPORT_SYMBOL(beat_put_term_char);
-
-void beat_power_save(void)
-{
-	beat_pause(0);
-}
-
-#ifdef CONFIG_KEXEC
-void beat_kexec_cpu_down(int crash, int secondary)
-{
-	beatic_deinit_IRQ();
-}
-#endif
-
-static irqreturn_t beat_power_event(int virq, void *arg)
-{
-	printk(KERN_DEBUG "Beat: power button pressed\n");
-	beat_pm_poweroff_flag = 1;
-	ctrl_alt_del();
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t beat_reset_event(int virq, void *arg)
-{
-	printk(KERN_DEBUG "Beat: reset button pressed\n");
-	beat_pm_poweroff_flag = 0;
-	ctrl_alt_del();
-	return IRQ_HANDLED;
-}
-
-static struct beat_event_list {
-	const char *typecode;
-	irq_handler_t handler;
-	unsigned int virq;
-} beat_event_list[] = {
-	{ "power", beat_power_event, 0 },
-	{ "reset", beat_reset_event, 0 },
-};
-
-static int __init beat_register_event(void)
-{
-	u64 path[4], data[2];
-	int rc, i;
-	unsigned int virq;
-
-	for (i = 0; i < ARRAY_SIZE(beat_event_list); i++) {
-		struct beat_event_list *ev = &beat_event_list[i];
-
-		if (beat_construct_event_receive_port(data) != 0) {
-			printk(KERN_ERR "Beat: "
-			       "cannot construct event receive port for %s\n",
-			       ev->typecode);
-			return -EINVAL;
-		}
-
-		virq = irq_create_mapping(NULL, data[0]);
-		if (virq == NO_IRQ) {
-			printk(KERN_ERR "Beat: failed to get virtual IRQ"
-			       " for event receive port for %s\n",
-			       ev->typecode);
-			beat_destruct_event_receive_port(data[0]);
-			return -EIO;
-		}
-		ev->virq = virq;
-
-		rc = request_irq(virq, ev->handler, IRQF_DISABLED,
-				      ev->typecode, NULL);
-		if (rc != 0) {
-			printk(KERN_ERR "Beat: failed to request virtual IRQ"
-			       " for event receive port for %s\n",
-			       ev->typecode);
-			beat_destruct_event_receive_port(data[0]);
-			return rc;
-		}
-
-		path[0] = 0x1000000065780000ul;	/* 1,ex */
-		path[1] = 0x627574746f6e0000ul;	/* button */
-		path[2] = 0;
-		strncpy((char *)&path[2], ev->typecode, 8);
-		path[3] = 0;
-		data[1] = 0;
-
-		beat_create_repository_node(path, data);
-	}
-	return 0;
-}
-
-static int __init beat_event_init(void)
-{
-	if (!firmware_has_feature(FW_FEATURE_BEAT))
-		return -EINVAL;
-
-	beat_pm_poweroff_flag = 0;
-	return beat_register_event();
-}
-
-device_initcall(beat_event_init);
Index: b/arch/powerpc/platforms/celleb/beat.h
===================================================================
--- a/arch/powerpc/platforms/celleb/beat.h	2008-04-23 21:10:12.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,39 +0,0 @@
-/*
- * Guest OS Interfaces.
- *
- * (C) Copyright 2006 TOSHIBA CORPORATION
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#ifndef _CELLEB_BEAT_H
-#define _CELLEB_BEAT_H
-
-int64_t beat_get_term_char(uint64_t, uint64_t *, uint64_t *, uint64_t *);
-int64_t beat_put_term_char(uint64_t, uint64_t, uint64_t, uint64_t);
-int64_t beat_repository_encode(int, const char *, uint64_t[4]);
-void beat_restart(char *);
-void beat_power_off(void);
-void beat_halt(void);
-int beat_set_rtc_time(struct rtc_time *);
-void beat_get_rtc_time(struct rtc_time *);
-ssize_t beat_nvram_get_size(void);
-ssize_t beat_nvram_read(char *, size_t, loff_t *);
-ssize_t beat_nvram_write(char *, size_t, loff_t *);
-int beat_set_xdabr(unsigned long);
-void beat_power_save(void);
-void beat_kexec_cpu_down(int, int);
-
-#endif /* _CELLEB_BEAT_H */
Index: b/arch/powerpc/platforms/celleb/interrupt.c
===================================================================
--- a/arch/powerpc/platforms/celleb/interrupt.c	2008-04-23 21:38:14.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,283 +0,0 @@
-/*
- * Celleb/Beat Interrupt controller
- *
- * (C) Copyright 2006-2007 TOSHIBA CORPORATION
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/percpu.h>
-#include <linux/types.h>
-
-#include <asm/machdep.h>
-
-#include "interrupt.h"
-#include "../cell/beat_wrapper.h"
-
-#define	MAX_IRQS	NR_IRQS
-static DEFINE_SPINLOCK(beatic_irq_mask_lock);
-static uint64_t	beatic_irq_mask_enable[(MAX_IRQS+255)/64];
-static uint64_t	beatic_irq_mask_ack[(MAX_IRQS+255)/64];
-
-static struct irq_host *beatic_host;
-
-/*
- * In this implementation, "virq" == "IRQ plug number",
- * "(irq_hw_number_t)hwirq" == "IRQ outlet number".
- */
-
-/* assumption: locked */
-static inline void beatic_update_irq_mask(unsigned int irq_plug)
-{
-	int off;
-	unsigned long masks[4];
-
-	off = (irq_plug / 256) * 4;
-	masks[0] = beatic_irq_mask_enable[off + 0]
-		& beatic_irq_mask_ack[off + 0];
-	masks[1] = beatic_irq_mask_enable[off + 1]
-		& beatic_irq_mask_ack[off + 1];
-	masks[2] = beatic_irq_mask_enable[off + 2]
-		& beatic_irq_mask_ack[off + 2];
-	masks[3] = beatic_irq_mask_enable[off + 3]
-		& beatic_irq_mask_ack[off + 3];
-	if (beat_set_interrupt_mask(irq_plug&~255UL,
-		masks[0], masks[1], masks[2], masks[3]) != 0)
-		panic("Failed to set mask IRQ!");
-}
-
-static void beatic_mask_irq(unsigned int irq_plug)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&beatic_irq_mask_lock, flags);
-	beatic_irq_mask_enable[irq_plug/64] &= ~(1UL << (63 - (irq_plug%64)));
-	beatic_update_irq_mask(irq_plug);
-	spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
-}
-
-static void beatic_unmask_irq(unsigned int irq_plug)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&beatic_irq_mask_lock, flags);
-	beatic_irq_mask_enable[irq_plug/64] |= 1UL << (63 - (irq_plug%64));
-	beatic_update_irq_mask(irq_plug);
-	spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
-}
-
-static void beatic_ack_irq(unsigned int irq_plug)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&beatic_irq_mask_lock, flags);
-	beatic_irq_mask_ack[irq_plug/64] &= ~(1UL << (63 - (irq_plug%64)));
-	beatic_update_irq_mask(irq_plug);
-	spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
-}
-
-static void beatic_end_irq(unsigned int irq_plug)
-{
-	s64 err;
-	unsigned long flags;
-
-	err = beat_downcount_of_interrupt(irq_plug);
-	if (err != 0) {
-		if ((err & 0xFFFFFFFF) != 0xFFFFFFF5) /* -11: wrong state */
-			panic("Failed to downcount IRQ! Error = %16lx", err);
-
-		printk(KERN_ERR "IRQ over-downcounted, plug %d\n", irq_plug);
-	}
-	spin_lock_irqsave(&beatic_irq_mask_lock, flags);
-	beatic_irq_mask_ack[irq_plug/64] |= 1UL << (63 - (irq_plug%64));
-	beatic_update_irq_mask(irq_plug);
-	spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
-}
-
-static struct irq_chip beatic_pic = {
-	.typename = " CELL-BEAT ",
-	.unmask = beatic_unmask_irq,
-	.mask = beatic_mask_irq,
-	.eoi = beatic_end_irq,
-};
-
-/*
- * Dispose binding hardware IRQ number (hw) and Virtuql IRQ number (virq),
- * update flags.
- *
- * Note that the number (virq) is already assigned at upper layer.
- */
-static void beatic_pic_host_unmap(struct irq_host *h, unsigned int virq)
-{
-	beat_destruct_irq_plug(virq);
-}
-
-/*
- * Create or update binding hardware IRQ number (hw) and Virtuql
- * IRQ number (virq). This is called only once for a given mapping.
- *
- * Note that the number (virq) is already assigned at upper layer.
- */
-static int beatic_pic_host_map(struct irq_host *h, unsigned int virq,
-			       irq_hw_number_t hw)
-{
-	struct irq_desc *desc = get_irq_desc(virq);
-	int64_t	err;
-
-	err = beat_construct_and_connect_irq_plug(virq, hw);
-	if (err < 0)
-		return -EIO;
-
-	desc->status |= IRQ_LEVEL;
-	set_irq_chip_and_handler(virq, &beatic_pic, handle_fasteoi_irq);
-	return 0;
-}
-
-/*
- * Update binding hardware IRQ number (hw) and Virtuql
- * IRQ number (virq). This is called only once for a given mapping.
- */
-static void beatic_pic_host_remap(struct irq_host *h, unsigned int virq,
-			       irq_hw_number_t hw)
-{
-	beat_construct_and_connect_irq_plug(virq, hw);
-}
-
-/*
- * Translate device-tree interrupt spec to irq_hw_number_t style (ulong),
- * to pass away to irq_create_mapping().
- *
- * Called from irq_create_of_mapping() only.
- * Note: We have only 1 entry to translate.
- */
-static int beatic_pic_host_xlate(struct irq_host *h, struct device_node *ct,
-				 u32 *intspec, unsigned int intsize,
-				 irq_hw_number_t *out_hwirq,
-				 unsigned int *out_flags)
-{
-	u64 *intspec2 = (u64 *)intspec;
-
-	*out_hwirq = *intspec2;
-	*out_flags |= IRQ_TYPE_LEVEL_LOW;
-	return 0;
-}
-
-static int beatic_pic_host_match(struct irq_host *h, struct device_node *np)
-{
-	/* Match all */
-	return 1;
-}
-
-static struct irq_host_ops beatic_pic_host_ops = {
-	.map = beatic_pic_host_map,
-	.remap = beatic_pic_host_remap,
-	.unmap = beatic_pic_host_unmap,
-	.xlate = beatic_pic_host_xlate,
-	.match = beatic_pic_host_match,
-};
-
-/*
- * Get an IRQ number
- * Note: returns VIRQ
- */
-static inline unsigned int beatic_get_irq_plug(void)
-{
-	int i;
-	uint64_t	pending[4], ub;
-
-	for (i = 0; i < MAX_IRQS; i += 256) {
-		beat_detect_pending_interrupts(i, pending);
-		__asm__ ("cntlzd %0,%1":"=r"(ub):
-			"r"(pending[0] & beatic_irq_mask_enable[i/64+0]
-				       & beatic_irq_mask_ack[i/64+0]));
-		if (ub != 64)
-			return i + ub + 0;
-		__asm__ ("cntlzd %0,%1":"=r"(ub):
-			"r"(pending[1] & beatic_irq_mask_enable[i/64+1]
-				       & beatic_irq_mask_ack[i/64+1]));
-		if (ub != 64)
-			return i + ub + 64;
-		__asm__ ("cntlzd %0,%1":"=r"(ub):
-			"r"(pending[2] & beatic_irq_mask_enable[i/64+2]
-				       & beatic_irq_mask_ack[i/64+2]));
-		if (ub != 64)
-			return i + ub + 128;
-		__asm__ ("cntlzd %0,%1":"=r"(ub):
-			"r"(pending[3] & beatic_irq_mask_enable[i/64+3]
-				       & beatic_irq_mask_ack[i/64+3]));
-		if (ub != 64)
-			return i + ub + 192;
-	}
-
-	return NO_IRQ;
-}
-unsigned int beatic_get_irq(void)
-{
-	unsigned int ret;
-
-	ret = beatic_get_irq_plug();
-	if (ret != NO_IRQ)
-		beatic_ack_irq(ret);
-	return ret;
-}
-
-/*
- */
-void __init beatic_init_IRQ(void)
-{
-	int	i;
-
-	memset(beatic_irq_mask_enable, 0, sizeof(beatic_irq_mask_enable));
-	memset(beatic_irq_mask_ack, 255, sizeof(beatic_irq_mask_ack));
-	for (i = 0; i < MAX_IRQS; i += 256)
-		beat_set_interrupt_mask(i, 0L, 0L, 0L, 0L);
-
-	/* Set out get_irq function */
-	ppc_md.get_irq = beatic_get_irq;
-
-	/* Allocate an irq host */
-	beatic_host = irq_alloc_host(NULL, IRQ_HOST_MAP_NOMAP, 0,
-				     &beatic_pic_host_ops,
-					 0);
-	BUG_ON(beatic_host == NULL);
-	irq_set_default_host(beatic_host);
-}
-
-#ifdef CONFIG_SMP
-
-/* Nullified to compile with SMP mode */
-void beatic_setup_cpu(int cpu)
-{
-}
-
-void beatic_cause_IPI(int cpu, int mesg)
-{
-}
-
-void beatic_request_IPIs(void)
-{
-}
-#endif /* CONFIG_SMP */
-
-void beatic_deinit_IRQ(void)
-{
-	int	i;
-
-	for (i = 1; i < NR_IRQS; i++)
-		beat_destruct_irq_plug(i);
-}
Index: b/arch/powerpc/platforms/celleb/interrupt.h
===================================================================
--- a/arch/powerpc/platforms/celleb/interrupt.h	2008-04-23 21:10:12.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,33 +0,0 @@
-/*
- * Celleb/Beat Interrupt controller
- *
- * (C) Copyright 2006 TOSHIBA CORPORATION
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#ifndef ASM_BEAT_PIC_H
-#define ASM_BEAT_PIC_H
-#ifdef __KERNEL__
-
-extern void beatic_init_IRQ(void);
-extern unsigned int beatic_get_irq(void);
-extern void beatic_cause_IPI(int cpu, int mesg);
-extern void beatic_request_IPIs(void);
-extern void beatic_setup_cpu(int);
-extern void beatic_deinit_IRQ(void);
-
-#endif
-#endif /* ASM_BEAT_PIC_H */
Index: b/arch/powerpc/platforms/celleb/smp.c
===================================================================
--- a/arch/powerpc/platforms/celleb/smp.c	2008-04-23 21:10:12.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,124 +0,0 @@
-/*
- * SMP support for Celleb platform. (Incomplete)
- *
- * (C) Copyright 2006 TOSHIBA CORPORATION
- *
- * This code is based on arch/powerpc/platforms/cell/smp.c:
- * Dave Engebretsen, Peter Bergner, and
- * Mike Corrigan {engebret|bergner|mikec}@us.ibm.com
- * Plus various changes from other IBM teams...
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#undef DEBUG
-
-#include <linux/kernel.h>
-#include <linux/smp.h>
-#include <linux/interrupt.h>
-#include <linux/init.h>
-#include <linux/threads.h>
-#include <linux/cpu.h>
-
-#include <asm/irq.h>
-#include <asm/smp.h>
-#include <asm/machdep.h>
-#include <asm/udbg.h>
-
-#include "interrupt.h"
-
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
-/*
- * The primary thread of each non-boot processor is recorded here before
- * smp init.
- */
-/* static cpumask_t of_spin_map; */
-
-/**
- * smp_startup_cpu() - start the given cpu
- *
- * At boot time, there is nothing to do for primary threads which were
- * started from Open Firmware.  For anything else, call RTAS with the
- * appropriate start location.
- *
- * Returns:
- *	0	- failure
- *	1	- success
- */
-static inline int __devinit smp_startup_cpu(unsigned int lcpu)
-{
-	return 0;
-}
-
-static void smp_beatic_message_pass(int target, int msg)
-{
-	unsigned int i;
-
-	if (target < NR_CPUS) {
-		beatic_cause_IPI(target, msg);
-	} else {
-		for_each_online_cpu(i) {
-			if (target == MSG_ALL_BUT_SELF
-			    && i == smp_processor_id())
-				continue;
-			beatic_cause_IPI(i, msg);
-		}
-	}
-}
-
-static int __init smp_beatic_probe(void)
-{
-	return cpus_weight(cpu_possible_map);
-}
-
-static void __devinit smp_beatic_setup_cpu(int cpu)
-{
-	beatic_setup_cpu(cpu);
-}
-
-static void __devinit smp_celleb_kick_cpu(int nr)
-{
-	BUG_ON(nr < 0 || nr >= NR_CPUS);
-
-	if (!smp_startup_cpu(nr))
-		return;
-}
-
-static int smp_celleb_cpu_bootable(unsigned int nr)
-{
-	return 1;
-}
-static struct smp_ops_t bpa_beatic_smp_ops = {
-	.message_pass	= smp_beatic_message_pass,
-	.probe		= smp_beatic_probe,
-	.kick_cpu	= smp_celleb_kick_cpu,
-	.setup_cpu	= smp_beatic_setup_cpu,
-	.cpu_bootable	= smp_celleb_cpu_bootable,
-};
-
-/* This is called very early */
-void __init smp_init_celleb(void)
-{
-	DBG(" -> smp_init_celleb()\n");
-
-	smp_ops = &bpa_beatic_smp_ops;
-
-	DBG(" <- smp_init_celleb()\n");
-}
Index: b/arch/powerpc/platforms/celleb/udbg_beat.c
===================================================================
--- a/arch/powerpc/platforms/celleb/udbg_beat.c	2008-04-23 21:10:12.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,98 +0,0 @@
-/*
- * udbg function for Beat
- *
- * (C) Copyright 2006 TOSHIBA CORPORATION
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <linux/kernel.h>
-#include <linux/console.h>
-
-#include <asm/machdep.h>
-#include <asm/prom.h>
-#include <asm/udbg.h>
-
-#include "beat.h"
-
-#define	celleb_vtermno	0
-
-static void udbg_putc_beat(char c)
-{
-	unsigned long rc;
-
-	if (c == '\n')
-		udbg_putc_beat('\r');
-
-	rc = beat_put_term_char(celleb_vtermno, 1, (uint64_t)c << 56, 0);
-}
-
-/* Buffered chars getc */
-static long inbuflen;
-static long inbuf[2];	/* must be 2 longs */
-
-static int udbg_getc_poll_beat(void)
-{
-	/* The interface is tricky because it may return up to 16 chars.
-	 * We save them statically for future calls to udbg_getc().
-	 */
-	char ch, *buf = (char *)inbuf;
-	int i;
-	long rc;
-	if (inbuflen == 0) {
-		/* get some more chars. */
-		inbuflen = 0;
-		rc = beat_get_term_char(celleb_vtermno, &inbuflen,
-					inbuf+0, inbuf+1);
-		if (rc != 0)
-			inbuflen = 0;	/* otherwise inbuflen is garbage */
-	}
-	if (inbuflen <= 0 || inbuflen > 16) {
-		/* Catch error case as well as other oddities (corruption) */
-		inbuflen = 0;
-		return -1;
-	}
-	ch = buf[0];
-	for (i = 1; i < inbuflen; i++)	/* shuffle them down. */
-		buf[i-1] = buf[i];
-	inbuflen--;
-	return ch;
-}
-
-static int udbg_getc_beat(void)
-{
-	int ch;
-	for (;;) {
-		ch = udbg_getc_poll_beat();
-		if (ch == -1) {
-			/* This shouldn't be needed...but... */
-			volatile unsigned long delay;
-			for (delay = 0; delay < 2000000; delay++)
-				;
-		} else {
-			return ch;
-		}
-	}
-}
-
-/* call this from early_init() for a working debug console on
- * vterm capable LPAR machines
- */
-void __init udbg_init_debug_beat(void)
-{
-	udbg_putc = udbg_putc_beat;
-	udbg_getc = udbg_getc_beat;
-	udbg_getc_poll = udbg_getc_poll_beat;
-}
Index: b/arch/powerpc/platforms/Makefile
===================================================================
--- a/arch/powerpc/platforms/Makefile	2008-04-23 21:10:12.000000000 +0900
+++ b/arch/powerpc/platforms/Makefile	2008-04-23 21:38:50.000000000 +0900
@@ -24,5 +24,4 @@
 obj-$(CONFIG_PPC_PASEMI)	+= pasemi/
 obj-$(CONFIG_PPC_CELL)		+= cell/
 obj-$(CONFIG_PPC_PS3)		+= ps3/
-obj-$(CONFIG_PPC_CELLEB)	+= celleb/
 obj-$(CONFIG_EMBEDDED6xx)	+= embedded6xx/
Index: b/arch/powerpc/platforms/cell/Makefile
===================================================================
--- a/arch/powerpc/platforms/cell/Makefile	2008-04-23 21:38:40.000000000 +0900
+++ b/arch/powerpc/platforms/cell/Makefile	2008-04-23 21:38:50.000000000 +0900
@@ -35,9 +35,11 @@
 					   celleb_pci.o celleb_scc_epci.o \
 					   celleb_scc_uhc.o \
 					   io-workarounds.o spider-pci.o \
-					   beat_htab.o beat_hvCall.o \
-					   beat_iommu.o
+					   beat.o beat_htab.o beat_hvCall.o \
+					   beat_interrupt.o beat_iommu.o
 
+obj-$(CONFIG_SMP)			+= beat_smp.o
+obj-$(CONFIG_PPC_UDBG_BEAT)		+= beat_udbg.o
 obj-$(CONFIG_SERIAL_TXX9)		+= celleb_scc_sio.o
 obj-$(CONFIG_SPU_BASE)			+= beat_spu_priv1.o
 endif
Index: b/arch/powerpc/platforms/celleb/Makefile
===================================================================
--- a/arch/powerpc/platforms/celleb/Makefile	2008-04-23 21:38:40.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,5 +0,0 @@
-obj-y				+= interrupt.o \
-				   beat.o
-
-obj-$(CONFIG_SMP)		+= smp.o
-obj-$(CONFIG_PPC_UDBG_BEAT)	+= udbg_beat.o
Index: b/arch/powerpc/platforms/cell/celleb_setup.c
===================================================================
--- a/arch/powerpc/platforms/cell/celleb_setup.c	2008-04-23 21:38:14.000000000 +0900
+++ b/arch/powerpc/platforms/cell/celleb_setup.c	2008-04-23 21:38:50.000000000 +0900
@@ -56,9 +56,9 @@
 #include <asm/rtas.h>
 #include <asm/cell-regs.h>
 
-#include "../celleb/interrupt.h"
+#include "beat_interrupt.h"
 #include "beat_wrapper.h"
-#include "../celleb/beat.h"
+#include "beat.h"
 #include "celleb_pci.h"
 #include "interrupt.h"
 #include "pervasive.h"
